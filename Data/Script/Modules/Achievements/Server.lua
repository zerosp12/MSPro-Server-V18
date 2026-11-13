---------------------------------------------------------------------------
-- Achievements - GameServer module
-- Enable in ScriptMain.lua (after Platform\Platform):
--     require("Modules\\Achievements\\Server")
-- Configuration: Modules\Achievements\Config.lua
-- DataServer side: Scripts\DataServer\Modules\Achievements.lua
-- Client side: Encoder\Lua\Achievements.lua (channel "achievements")
--
-- Client -> server
--   { op = "sync", lang, hash }                     definitions (if hash changed) + state
--   { op = "claim", id }                            rewards of the next reached tier
--   { op = "claim_milestone", kind, category, value }   kind 0 = points, 1 = category (%)
--   { op = "ranking" }
-- Server -> client
--   defs, state, update, unlock, claim_result, milestone_result, ranking, loading
---------------------------------------------------------------------------

require("Modules\\Achievements\\Config")

Achievements = Achievements or {}

local CHANNEL = "achievements"
local OWNER = "Achievements"
local OBJECT_USER = 1
local OBJECT_ONLINE = 3
local KIND_POINTS = 0
local KIND_CATEGORY = 1

local Config = AchievementsConfig
local Defs = {}          -- id -> achievement
local CategoryList = {}  -- category id -> achievements
local CategoryDefs = {}  -- id -> category
local CategoryTiers = {} -- category id -> total tiers
local State = {}         -- aIndex -> player state

---------------------------------------------------------------------------
-- Configuration check
---------------------------------------------------------------------------

local function Fail(text)
	error("Achievements config: " .. text, 0)
end

local function Validate()
	for _, category in ipairs(Config.Categories) do
		if CategoryDefs[category.id] ~= nil then
			Fail("duplicated category " .. category.id)
		end

		CategoryDefs[category.id] = category
		CategoryTiers[category.id] = 0
		CategoryList[category.id] = {}
	end

	for _, def in ipairs(Config.List) do
		if type(def.id) ~= "number" or Defs[def.id] ~= nil then
			Fail("invalid or duplicated id " .. tostring(def.id))
		end

		if CategoryDefs[def.category] == nil then
			Fail("achievement " .. def.id .. " uses unknown category " .. tostring(def.category))
		end

		if type(def.tiers) ~= "table" or #def.tiers == 0 or #def.tiers > 255 then
			Fail("achievement " .. def.id .. " needs 1-255 tiers")
		end

		local last = 0

		for i, tier in ipairs(def.tiers) do
			if type(tier.goal) ~= "number" or tier.goal <= last then
				Fail("achievement " .. def.id .. " tier " .. i .. ": goals must increase")
			end

			last = tier.goal
		end

		Defs[def.id] = def
		CategoryTiers[def.category] = CategoryTiers[def.category] + #def.tiers
		table.insert(CategoryList[def.category], def)
	end

	for _, def in ipairs(Config.List) do
		for _, required in ipairs(def.requires or {}) do
			if Defs[required] == nil then
				Fail("achievement " .. def.id .. " requires unknown achievement " .. tostring(required))
			end
		end
	end
end

Validate()

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

-- The game client draws ANSI text: UTF-8 texts (files saved as UTF-8) are
-- converted to Latin-1 (every es/pt/en character). Other text is kept as is.
local function Ansi(text)
	if type(text) ~= "string" or not text:find("[\128-\255]") or utf8.len(text) == nil then
		return text
	end

	local out = {}

	for _, code in utf8.codes(text) do
		out[#out + 1] = (code < 256) and string.char(code) or "?"
	end

	return table.concat(out)
end

local function Text(value, lang)
    if type(value) == "number" then
        local languages = { en = 0, pt = 1, es = 2 }
        return MessageGet(value, languages[lang] or languages[Config.DefaultLang] or 0)
    end
	if type(value) ~= "table" then
		return Ansi(value)
	end

	if value[lang] ~= nil then
		return Ansi(value[lang])
	end

	if value[Config.DefaultLang] ~= nil then
		return Ansi(value[Config.DefaultLang])
	end

	for _, text in pairs(value) do
		return Ansi(text)
	end
end

local function Contains(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end

	return false
end

local function GetRow(st, id, create)
	local row = st.rows[id]

	if row == nil and create then
		row = { tier = 0, claimed = 0, progress = 0 }
		st.rows[id] = row
	end

	return row
end

local function Tier(st, id)
	local row = st.rows[id]
	return row ~= nil and row.tier or 0
end

local function MilestoneKey(kind, category, value)
	return kind .. ":" .. category .. ":" .. value
end

-- Points, completed achievements and tiers reached per category
local function Recount(st)
	local points, completed, categories = 0, 0, {}

	for id, row in pairs(st.rows) do
		local def = Defs[id]

		if def ~= nil then
			for i = 1, row.tier do
				points = points + (def.tiers[i].points or 0)
			end

			if row.tier >= #def.tiers then
				completed = completed + 1
			end

			categories[def.category] = (categories[def.category] or 0) + row.tier
		end
	end

	st.points, st.completed, st.categories = points, completed, categories
end

-- Avance de un logro entre 0 y 1: niveles hechos mas lo que lleva del actual
local function Advance(def, row)
	if row == nil then
		return 0
	end

	local tiers = def.tiers
	local done = row.tier

	if done >= #tiers then
		return 1
	end

	local from = (done > 0) and tiers[done].goal or 0
	local goal = tiers[done + 1].goal
	local partial = 0

	if goal > from then
		partial = math.max(0, math.min((row.progress - from) / (goal - from), 1))
	end

	return (done + partial) / #tiers
end

-- Porcentaje de la categoria (cuenta el progreso parcial, no solo los niveles)
local function CategoryPercent(st, category)
	local list = CategoryList[category]

	if list == nil or #list == 0 then
		return 0
	end

	local sum = 0

	for _, def in ipairs(list) do
		sum = sum + Advance(def, st.rows[def.id])
	end

	return math.floor(sum * 100 / #list)
end

local function FindMilestone(kind, category, value)
	if kind == KIND_POINTS then
		for _, m in ipairs(Config.Milestones or {}) do
			if m.points == value then
				return m
			end
		end
	elseif kind == KIND_CATEGORY and CategoryDefs[category] ~= nil then
		for _, m in ipairs(CategoryDefs[category].milestones or {}) do
			if m.percent == value then
				return m
			end
		end
	end
end

local function PendingClaims(st)
	local count = 0

	for id, row in pairs(st.rows) do
		if Defs[id] ~= nil and row.claimed < row.tier then
			count = count + 1
		end
	end

	for _, m in ipairs(Config.Milestones or {}) do
		if st.points >= m.points and not st.milestones[MilestoneKey(KIND_POINTS, 0, m.points)] then
			count = count + 1
		end
	end

	for _, category in ipairs(Config.Categories) do
		local percent = CategoryPercent(st, category.id)

		for _, m in ipairs(category.milestones or {}) do
			if percent >= m.percent and not st.milestones[MilestoneKey(KIND_CATEGORY, category.id, m.percent)] then
				count = count + 1
			end
		end
	end

	return count
end

---------------------------------------------------------------------------
-- Bonus: reached tiers + claimed milestones
---------------------------------------------------------------------------

local function ApplyBonus(aIndex, st)
	local total = {}

	for id, row in pairs(st.rows) do
		local def = Defs[id]

		if def ~= nil then
			for i = 1, row.tier do
				Bonus.Add(total, def.tiers[i].bonus)
			end
		end
	end

	for key in pairs(st.milestones) do
		local kind, category, value = key:match("^(%d+):(%d+):(%d+)$")
		local m = FindMilestone(tonumber(kind), tonumber(category), tonumber(value))

		if m ~= nil then
			Bonus.Add(total, m.bonus)
		end
	end

	if next(total) == nil then
		Bonus.Clear(aIndex, OWNER)
	else
		Bonus.Set(aIndex, OWNER, total)
	end
end

---------------------------------------------------------------------------
-- Client messages
---------------------------------------------------------------------------

-- Logros por trozo de defs (ver BuildDefs)
local DEFS_CHUNK = 15
local DefsCache = {} -- lang -> { hash, msg, parts }

local function Hash(text)
	local h = 5381

	for i = 1, #text do
		h = (h * 33 + text:byte(i)) % 4294967296
	end

	return string.format("%08x", h)
end

-- Deterministic text of a value (used only for the definitions hash)
local function Serialize(value, out)
	local t = type(value)

	if t ~= "table" then
		out[#out + 1] = t:sub(1, 1) .. tostring(value) .. ";"
		return
	end

	local keys = {}

	for k in pairs(value) do
		keys[#keys + 1] = k
	end

	table.sort(keys, function(a, b)
		if type(a) == type(b) then return a < b end
		return type(a) < type(b)
	end)

	out[#out + 1] = "{"

	for _, k in ipairs(keys) do
		out[#out + 1] = tostring(k) .. "="
		Serialize(value[k], out)
	end

	out[#out + 1] = "}"
end

local function BuildDefs(lang)
	local cached = DefsCache[lang]

	if cached ~= nil then
		return cached
	end

	local msg = { op = "defs", categories = {}, list = {}, milestones = {} }

	for i, category in ipairs(Config.Categories) do
		local milestones = {}

		for j, m in ipairs(category.milestones or {}) do
			milestones[j] = { percent = m.percent, rewards = m.rewards, bonus = m.bonus }
		end

		msg.categories[i] = { id = category.id, name = Text(category.name, lang), icon = category.icon, milestones = milestones }
	end

	for i, m in ipairs(Config.Milestones or {}) do
		msg.milestones[i] = { points = m.points, rewards = m.rewards, bonus = m.bonus }
	end

	for i, def in ipairs(Config.List) do
		local tiers = {}

		for j, tier in ipairs(def.tiers) do
			tiers[j] = { goal = tier.goal, points = tier.points or 0, rewards = tier.rewards, bonus = tier.bonus }
		end

		-- Hidden achievements: name and description are sent only after the first tier
		msg.list[i] = {
			id = def.id,
			category = def.category,
			order = def.order or i,
			icon = def.icon,
			hidden = def.hidden or nil,
			name = (not def.hidden) and Text(def.name, lang) or nil,
			desc = (not def.hidden) and Text(def.desc, lang) or nil,
			requires = def.requires,
			classes = def.classes,
			tiers = tiers,
		}
	end

	local out = {}
	Serialize(msg, out)
	msg.hash = Hash(table.concat(out))

	-- El mensaje entero no se manda de una: el GameServer corta la conexion si
	-- se le encolan mas de 16 KB seguidos para un mismo socket
	-- (MAX_SIDE_PACKET_SIZE en SocketManager). Se parte en trozos y el cliente
	-- pide el siguiente al recibir cada uno, asi nunca hay una rafaga grande.
	local parts = {}
	local total = math.max(1, math.ceil(#msg.list / DEFS_CHUNK))

	for part = 1, total do
		local slice = {}

		for i = (part - 1) * DEFS_CHUNK + 1, math.min(part * DEFS_CHUNK, #msg.list) do
			slice[#slice + 1] = msg.list[i]
		end

		parts[part] = {
			op = "defs",
			hash = msg.hash,
			part = part,
			parts = total,
			list = slice,
			-- lo comun viaja solo en el primero
			categories = (part == 1) and msg.categories or nil,
			milestones = (part == 1) and msg.milestones or nil,
		}
	end

	cached = { hash = msg.hash, msg = msg, parts = parts }
	DefsCache[lang] = cached
	return cached
end

local function RowMessage(id, row)
	return { id, row.tier, row.claimed, row.progress }
end

local function Reveal(def, lang)
	return { name = Text(def.name, lang), desc = Text(def.desc, lang) }
end

local function SendState(aIndex, st)
	local rows, milestones, revealed = {}, {}, {}

	for id, row in pairs(st.rows) do
		local def = Defs[id]

		if def ~= nil then
			rows[#rows + 1] = RowMessage(id, row)

			if def.hidden and row.tier > 0 then
				revealed[id] = Reveal(def, st.lang)
			end
		end
	end

	for key in pairs(st.milestones) do
		milestones[#milestones + 1] = key
	end

	st.changed = {}

	Net.Send(aIndex, CHANNEL, {
		op = "state",
		rows = rows,
		milestones = milestones,
		revealed = revealed,
		points = st.points,
		completed = st.completed,
		pending = PendingClaims(st),
	})
end

local function SendUpdates(aIndex, st)
	if not st.synced or next(st.changed) == nil then
		return
	end

	local rows = {}

	for id in pairs(st.changed) do
		local row = st.rows[id]

		if row ~= nil then
			rows[#rows + 1] = RowMessage(id, row)
		end
	end

	st.changed = {}

	Net.Send(aIndex, CHANNEL, { op = "update", rows = rows, points = st.points, completed = st.completed, pending = PendingClaims(st) })
end

---------------------------------------------------------------------------
-- Progress
---------------------------------------------------------------------------

local function CanProgress(aIndex, def, st)
	if def.classes ~= nil and not Contains(def.classes, GetObjectClass(aIndex)) then
		return false
	end

	for _, required in ipairs(def.requires or {}) do
		if Tier(st, required) == 0 then
			return false
		end
	end

	return true
end

local function AddProgress(aIndex, st, id, amount)
	local def = Defs[id]

	if def == nil or not CanProgress(aIndex, def, st) then
		return
	end

	local row = GetRow(st, id, true)
	local tiers = def.tiers

	if row.tier >= #tiers then
		return
	end

	row.progress = math.min(row.progress + amount, tiers[#tiers].goal)
	st.dirty[id] = true
	st.changed[id] = true

	local unlocked = false

	while row.tier < #tiers and row.progress >= tiers[row.tier + 1].goal do
		row.tier = row.tier + 1
		unlocked = true

		local tier = tiers[row.tier]
		local msg = { op = "unlock", id = id, tier = row.tier, points = tier.points or 0 }

		if def.hidden and row.tier == 1 then
			local reveal = Reveal(def, st.lang)
			msg.name, msg.desc = reveal.name, reveal.desc
		end

		if st.synced then
			Net.Send(aIndex, CHANNEL, msg)
		end

		NoticeSend(aIndex, 1, string.format(Text(3500, st.lang), Text(def.name, st.lang), row.tier, #tiers))
	end

	if unlocked then
		Recount(st)
		ApplyBonus(aIndex, st)
	end
end

-- Objectives callback (key = achievement id)
local function OnObjective(aIndex, id, amount)
	local st = State[aIndex]

	if st == nil or st.failed then
		return
	end

	if not st.loaded then
		st.buffer[#st.buffer + 1] = { id, amount }
		return
	end

	AddProgress(aIndex, st, id, amount)
end

local function RegisterObjectives()
	local list = {}

	for _, def in ipairs(Config.List) do
		local filter = {}

		for k, v in pairs(def.objective) do
			if k ~= "type" then
				filter[k] = v
			end
		end

		list[#list + 1] = { key = def.id, type = def.objective.type, filter = filter }
	end

	Objectives.Register(OWNER, list, OnObjective)
end

RegisterObjectives()

if Config.BonusCaps ~= nil then
	Bonus.SetCaps(Config.BonusCaps)
end

for option, value in pairs(Config.PvP or {}) do
	Objectives.Config.PvP[option] = value
end

if Config.Debug ~= nil then
	Objectives.Config.Debug = Config.Debug
end

---------------------------------------------------------------------------
-- Load / save
---------------------------------------------------------------------------

local function Save(aIndex, st)
	if not st.loaded or next(st.dirty) == nil then
		return
	end

	local rows = {}

	for id in pairs(st.dirty) do
		local row = st.rows[id]

		if row ~= nil then
			rows[#rows + 1] = RowMessage(id, row)
		end
	end

	st.dirty = {}

	-- on failure the rows are marked again (while the player is online) to retry on the next save
	Net.Request(CHANNEL, { op = "save", name = st.name, rows = rows, points = st.points, completed = st.completed }, aIndex, function(reply, err)
		if err == nil and reply.ok then
			return
		end

		Platform.Log(string.format("Achievements: save %s failed (%s)", st.name, tostring(err or "sql")))

		if State[aIndex] == st then
			for _, row in ipairs(rows) do
				st.dirty[row[1]] = true
			end
		end
	end)
end

local function Load(aIndex, st)
	st.loading = true

	Net.Request(CHANNEL, { op = "load", name = st.name }, aIndex, function(reply, err)
		if State[aIndex] ~= st then
			return -- the player left before the answer
		end

		st.loading = false

		if err ~= nil or reply.error ~= nil then
			st.retries = st.retries + 1
			st.retry = os.time() + 10
			Platform.Log(string.format("Achievements: load %s failed (%s), retry %d", st.name, tostring(err or reply.error), st.retries))

			if st.retries >= 5 then
				st.failed = true -- progress is not counted, nothing is saved
			end

			return
		end

		for _, r in ipairs(reply.rows or {}) do
			local def = Defs[r[1]]

			if def ~= nil then
				-- clamp in case the tiers of the achievement were reduced
				local tier = math.min(r[2], #def.tiers)
				st.rows[r[1]] = { tier = tier, claimed = math.min(r[3], tier), progress = r[4] }
			end
		end

		for _, m in ipairs(reply.milestones or {}) do
			st.milestones[MilestoneKey(m[1], m[2], m[3])] = true
		end

		st.loaded = true
		Recount(st)

		-- progress made while the data was loading
		local buffer = st.buffer
		st.buffer = {}

		for _, entry in ipairs(buffer) do
			AddProgress(aIndex, st, entry[1], entry[2])
		end

		ApplyBonus(aIndex, st)

		if st.synced then
			SendState(aIndex, st)
		end
	end)
end

local function Enter(aIndex)
	State[aIndex] = {
		name = GetObjectName(aIndex),
		lang = Config.DefaultLang,
		loaded = false,
		loading = false,
		failed = false,
		retries = 0,
		retry = 0,
		synced = false,
		rows = {},
		dirty = {},
		changed = {},
		milestones = {},
		buffer = {},
		points = 0,
		completed = 0,
		categories = {},
		lastRanking = 0,
	}

	Load(aIndex, State[aIndex])
end

local function Leave(aIndex)
	local st = State[aIndex]

	if st == nil then
		return
	end

	Save(aIndex, st)
	State[aIndex] = nil
end

---------------------------------------------------------------------------
-- Claims
---------------------------------------------------------------------------

local function Claim(aIndex, st, id)
	local def = Defs[id]
	local row = st.rows[id]

	if def == nil or row == nil or row.claimed >= row.tier then
		return false, "invalid"
	end

	local rewards = def.tiers[row.claimed + 1].rewards or {}

	if #rewards > 0 then
		if not Reward.CheckSpace(aIndex, rewards) then
			return false, "no_space"
		end

		local ok, reason = Reward.Give(aIndex, rewards, "Achievements")

		if not ok then
			return false, reason or "failed"
		end
	end

	row.claimed = row.claimed + 1
	st.dirty[id] = true
	Save(aIndex, st) -- rewards were given: save now
	return true
end

local function ClaimMilestone(aIndex, st, kind, category, value)
	local m = FindMilestone(kind, category, value)
	local key = MilestoneKey(kind, category, value)

	if m == nil or st.milestones[key] then
		return false, "invalid"
	end

	if kind == KIND_POINTS and st.points < m.points then
		return false, "invalid"
	end

	if kind == KIND_CATEGORY and CategoryPercent(st, category) < m.percent then
		return false, "invalid"
	end

	local rewards = m.rewards or {}

	if #rewards > 0 then
		if not Reward.CheckSpace(aIndex, rewards) then
			return false, "no_space"
		end

		local ok, reason = Reward.Give(aIndex, rewards, "Achievements")

		if not ok then
			return false, reason or "failed"
		end
	end

	st.milestones[key] = true
	Net.ToData(CHANNEL, { op = "milestone", name = st.name, kind = kind, category = category, value = value }, aIndex)
	ApplyBonus(aIndex, st)
	return true
end

---------------------------------------------------------------------------
-- Ranking (cached, shared by every player)
---------------------------------------------------------------------------

local Ranking = { rows = nil, time = 0, waiting = {} }
local RANKING_CACHE = 30
local RANKING_COOLDOWN = 5

local function SendRanking(aIndex, st)
	local now = os.time()

	if now - st.lastRanking < RANKING_COOLDOWN then
		return
	end

	st.lastRanking = now

	if Ranking.rows ~= nil and now - Ranking.time < RANKING_CACHE then
		Net.Send(aIndex, CHANNEL, { op = "ranking", rows = Ranking.rows })
		return
	end

	Ranking.waiting[aIndex] = st

	if Ranking.requesting then
		return
	end

	Ranking.requesting = true

	Net.Request(CHANNEL, { op = "ranking", limit = 20 }, nil, function(reply, err)
		Ranking.requesting = false

		if err == nil then
			Ranking.rows = reply.rows or {}
			Ranking.time = os.time()
		end

		for index, waiting in pairs(Ranking.waiting) do
			if State[index] == waiting then
				Net.Send(index, CHANNEL, { op = "ranking", rows = Ranking.rows or {}, error = err })
			end
		end

		Ranking.waiting = {}
	end)
end

---------------------------------------------------------------------------
-- Network
---------------------------------------------------------------------------

-- numbers with an integer value only (math.tointeger also accepts strings)
local function Integer(value)
	return type(value) == "number" and math.tointeger(value) or nil
end

Net.On(CHANNEL, function(aIndex, msg)
	local st = State[aIndex]

	if type(msg) ~= "table" or st == nil then
		return
	end

	if msg.op == "defs_next" then
		local defs = BuildDefs(st.lang)
		local part = Integer(msg.part)

		if part ~= nil and defs.parts[part] ~= nil then
			Net.Send(aIndex, CHANNEL, defs.parts[part])
		end

		return
	end

	if msg.op == "sync" then
		if type(msg.lang) == "string" and #msg.lang <= 8 then
			st.lang = msg.lang
		end

		local defs = BuildDefs(st.lang)

		if msg.hash ~= defs.hash then
			Net.Send(aIndex, CHANNEL, defs.parts[1])
		end

		st.synced = true

		if st.loaded then
			SendState(aIndex, st)
		else
			Net.Send(aIndex, CHANNEL, { op = "loading", failed = st.failed or nil })
		end

		return
	end

	if msg.op == "ranking" then
		SendRanking(aIndex, st)
		return
	end

	if not st.loaded then
		return
	end

	if msg.op == "claim" and Integer(msg.id) ~= nil then
		msg.id = Integer(msg.id)

		local ok, reason = Claim(aIndex, st, msg.id)
		local row = st.rows[msg.id]

		Net.Send(aIndex, CHANNEL, {
			op = "claim_result",
			id = msg.id,
			ok = ok,
			reason = reason,
			claimed = row and row.claimed or 0,
			pending = PendingClaims(st),
		})
	elseif msg.op == "claim_milestone" then
		-- integers only: the milestone key must be unique (50 and 50.0 are the same milestone)
		local kind = Integer(msg.kind)
		local category = Integer(msg.category)
		local value = Integer(msg.value)

		if kind == nil or category == nil or value == nil then
			return
		end

		if kind == KIND_POINTS then
			category = 0
		end

		local ok, reason = ClaimMilestone(aIndex, st, kind, category, value)

		Net.Send(aIndex, CHANNEL, {
			op = "milestone_result",
			kind = kind,
			category = category,
			value = value,
			ok = ok,
			reason = reason,
			pending = PendingClaims(st),
		})
	end
end)

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

Events.Off(OWNER)

Events.On("CharacterEntry", function(aIndex)
	Leave(aIndex) -- stale state of the same index
	Enter(aIndex)
end, OWNER)

Events.On("CharacterClose", function(aIndex)
	Leave(aIndex)
end, OWNER)

local SaveTimer = 0
local UpdateTimer = 0

Events.On("Timer", function()
	local now = os.time()

	SaveTimer = SaveTimer + 1
	UpdateTimer = UpdateTimer + 1

	local save = SaveTimer >= (Config.SaveInterval or 60)
	local update = UpdateTimer >= (Config.UpdateInterval or 1)

	if save then SaveTimer = 0 end
	if update then UpdateTimer = 0 end

	for aIndex, st in pairs(State) do
		if GetObjectConnected(aIndex) ~= OBJECT_ONLINE or GetObjectName(aIndex) ~= st.name then
			State[aIndex] = nil -- missed CharacterClose: nothing reliable to save
		elseif not st.loaded then
			if not st.loading and not st.failed and now >= st.retry then
				Load(aIndex, st)
			end
		else
			if update then SendUpdates(aIndex, st) end
			if save then Save(aIndex, st) end
		end
	end
end, OWNER)

Events.On("ShutScript", function()
	for aIndex, st in pairs(State) do
		Save(aIndex, st)
	end
end, OWNER)

-- Script reload: players already online
for aIndex = GetMinUserIndex(), GetMaxUserIndex() do
	if State[aIndex] == nil and GetObjectConnected(aIndex) == OBJECT_ONLINE and GetObjectType(aIndex) == OBJECT_USER then
		Enter(aIndex)
	end
end

Platform.Log(string.format("Achievements loaded: %d achievements, %d categories", #Config.List, #Config.Categories))
