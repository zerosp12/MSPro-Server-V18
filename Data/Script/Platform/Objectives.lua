---------------------------------------------------------------------------
-- Objectives: turns game events into objective progress.
-- Shared by achievements, Lua quests or any custom system.
--
--   Objectives.Register("achievements", {
--       { key = 101, type = "monster_kill", filter = { min_level = 50 } },
--       { key = 102, type = "boss_kill",    filter = { monsters = { 161, 181 } } },
--   }, function(aIndex, key, amount) ... end)
--
--   Objectives.Unregister("achievements")
--
-- Types and filters (every filter is optional unless noted):
--   monster_kill     monsters = {class}, maps = {map}, min_level, max_level
--   boss_kill        monsters = {class} (required), maps
--   player_kill      maps, min_victim_level          (anti-abuse, see Objectives.Config.PvP)
--   duel_win                                          (anti-abuse, see Objectives.Config.PvP)
--   event_win        events = {"bc","ds","cc","it","doppelganger","imperial","crywolf","kanturu"}, min_level
--   npc_talk         npcs = {class}
--   item_pick        section, index, min_level, excellent = true
--   level_up         (amount = levels gained)
--   master_level_up  (amount = master levels gained)
--   reset            mode = "reset" (default) | "master"
--   chaos_mix        mixes = {type}, success = true | false
--   item_upgrade     jewel = "bless" | "soul" | "life", success = true | false, min_level
--   quest_finish     quests = {index}
--   playtime         (amount = 1 per online minute)
--   castle_siege     (1 per siege won, for every online member of the owning guild)
--
-- Filters that look at the player instead of the target work on every kill,
-- duel and event type:
--   party = true | false    the player must (or must not) be in a party
--   guild = true | false    the player must (or must not) be in a guild
---------------------------------------------------------------------------

Objectives = Objectives or {}
Objectives.Index = Objectives.Index or {}

Objectives.Config = Objectives.Config or {
	PvP = {
		SameIP = false,         -- count kills between players with the same IP
		SameHWID = false,       -- count kills between players with the same hardware id
		Cooldown = 600,         -- seconds before the same victim counts again for the same killer
	},
	Debug = false,              -- logs every PvP kill/duel that the filters discard
}

local OBJECT_USER = 1
local OBJECT_ONLINE = 3

local EventNames = { [0] = "bc", "ds", "cc", "it", "doppelganger", "imperial", "crywolf", "kanturu" }
local JewelItems = { bless = 7181, soul = 7182, life = 7184 }

local Types = {
	monster_kill = true, boss_kill = true, player_kill = true, duel_win = true,
	event_win = true, npc_talk = true, item_pick = true, level_up = true,
	master_level_up = true, reset = true, chaos_mix = true, item_upgrade = true,
	quest_finish = true, playtime = true, castle_siege = true,
}

---------------------------------------------------------------------------
-- Registration
---------------------------------------------------------------------------

function Objectives.Unregister(module)
	for _, list in pairs(Objectives.Index) do
		for i = #list, 1, -1 do
			if list[i].module == module then
				table.remove(list, i)
			end
		end
	end
end

function Objectives.Register(module, list, callback)
	if type(callback) ~= "function" then
		error("Objectives.Register: callback must be a function", 2)
	end

	Objectives.Unregister(module)

	for _, objective in ipairs(list) do
		if not Types[objective.type] then
			error("Objectives.Register: unknown type '" .. tostring(objective.type) .. "' (key " .. tostring(objective.key) .. ")", 2)
		end

		if objective.type == "boss_kill" and (objective.filter == nil or objective.filter.monsters == nil) then
			error("Objectives.Register: boss_kill needs filter.monsters (key " .. tostring(objective.key) .. ")", 2)
		end

		Objectives.Index[objective.type] = Objectives.Index[objective.type] or {}
		table.insert(Objectives.Index[objective.type], {
			module = module,
			key = objective.key,
			filter = objective.filter or {},
			callback = callback,
		})
	end
end

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

local function Contains(list, value)
	if list == nil then
		return true
	end

	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end

	return false
end

-- Filtros que miran al jugador y no al objetivo, asi que valen para cualquier
-- tipo: party = true pide estar en grupo, guild = true pide estar en un gremio.
-- Las funciones del ScriptCore no devuelven nada si el indice no es un usuario.
local function PlayerMatches(f, aIndex)
	if f.party ~= nil then
		local number = GetObjectPartyNumber(aIndex)

		if ((number ~= nil and number >= 0) and true or false) ~= f.party then
			return false
		end
	end

	if f.guild ~= nil then
		local number = GetObjectGuildNumber(aIndex)

		if ((number ~= nil and number > 0) and true or false) ~= f.guild then
			return false
		end
	end

	return true
end

local function Progress(objectiveType, aIndex, amount, check)
	local list = Objectives.Index[objectiveType]

	if list == nil or amount == nil or amount <= 0 then
		return
	end

	for _, entry in ipairs(list) do
		if check == nil or check(entry.filter) then
			local ok, err = pcall(entry.callback, aIndex, entry.key, amount)

			if not ok then
				Platform.Log(string.format("Objective %s (%s/%s): %s", objectiveType, entry.module, tostring(entry.key), tostring(err)))
			end
		end
	end
end

local function IsUser(aIndex)
	return aIndex ~= nil and aIndex >= GetMinUserIndex() and aIndex <= GetMaxUserIndex() and GetObjectType(aIndex) == OBJECT_USER
end

-- killer name -> victim name -> time (separate history for kills and duels)
local KillHistory = {}
local DuelHistory = {}

local function Discard(killer, victim, reason)
	if Objectives.Config.Debug then
		Platform.Log(string.format("PvP discarded (%s): %s -> %s", reason, tostring(GetObjectName(killer)), tostring(GetObjectName(victim))))
	end

	return false
end

local function IsValidPvP(killer, victim, history)
	if not IsUser(killer) or not IsUser(victim) or killer == victim then
		return false
	end

	local config = Objectives.Config.PvP

	if not config.SameIP and GetObjectIpAddress(killer) == GetObjectIpAddress(victim) then
		return Discard(killer, victim, "same ip")
	end

	if not config.SameHWID and GetObjectHardwareId(killer) == GetObjectHardwareId(victim) then
		return Discard(killer, victim, "same hardware id")
	end

	local now = os.time()
	local killerName = GetObjectName(killer)
	local victimName = GetObjectName(victim)

	history[killerName] = history[killerName] or {}

	local last = history[killerName][victimName]

	if last ~= nil and (now - last) < config.Cooldown then
		return Discard(killer, victim, "cooldown")
	end

	history[killerName][victimName] = now
	return true
end

---------------------------------------------------------------------------
-- Event mapping
---------------------------------------------------------------------------

local OWNER = "Platform.Objectives"

Events.Off(OWNER)

Events.On("MonsterDie", function(monster, killer)
	if not IsUser(killer) then
		return
	end

	local class = GetObjectClass(monster)
	local level = GetObjectLevel(monster)
	local map = GetObjectMap(monster)

	Progress("monster_kill", killer, 1, function(f)
		return PlayerMatches(f, killer) and Contains(f.monsters, class) and Contains(f.maps, map)
			and (f.min_level == nil or level >= f.min_level)
			and (f.max_level == nil or level <= f.max_level)
	end)

	Progress("boss_kill", killer, 1, function(f)
		return PlayerMatches(f, killer) and Contains(f.monsters, class) and Contains(f.maps, map)
	end)
end, OWNER)

Events.On("UserDie", function(victim, killer)
	if not IsValidPvP(killer, victim, KillHistory) then
		return
	end

	local map = GetObjectMap(victim)
	local level = GetObjectLevel(victim)

	Progress("player_kill", killer, 1, function(f)
		return PlayerMatches(f, killer) and Contains(f.maps, map)
			and (f.min_victim_level == nil or level >= f.min_victim_level)
	end)
end, OWNER)

Events.On("DuelEnd", function(winner, loser)
	if not IsValidPvP(winner, loser, DuelHistory) then
		return
	end

	Progress("duel_win", winner, 1, function(f)
		return PlayerMatches(f, winner)
	end)
end, OWNER)

Events.On("EventWin", function(aIndex, event, level)
	local name = EventNames[event]

	Progress("event_win", aIndex, 1, function(f)
		return PlayerMatches(f, aIndex) and Contains(f.events, name)
			and (f.min_level == nil or level >= f.min_level)
	end)
end, OWNER)

-- El GameServer lo emite una vez por cada miembro conectado del gremio que
-- se queda con el castillo (CastleSiege.cpp, al terminar el asedio)
Events.On("CastleSiegeWin", function(aIndex)
	if not IsUser(aIndex) then
		return
	end

	Progress("castle_siege", aIndex, 1, function(f)
		return PlayerMatches(f, aIndex)
	end)
end, OWNER)

Events.On("NpcTalk", function(npc, aIndex)
	local class = GetObjectClass(npc)

	Progress("npc_talk", aIndex, 1, function(f)
		return Contains(f.npcs, class)
	end)
end, OWNER)

Events.On("ItemPick", function(aIndex, mapItem)
	if Objectives.Index["item_pick"] == nil then
		return
	end

	local item = MapGetItemTable(aIndex, mapItem)

	if item == nil or item.Index == nil or item.Index < 0 then
		return
	end

	local section = math.floor(item.Index / 512)
	local index = item.Index % 512

	Progress("item_pick", aIndex, 1, function(f)
		return (f.section == nil or f.section == section)
			and (f.index == nil or f.index == index)
			and (f.min_level == nil or item.Level >= f.min_level)
			and (f.excellent == nil or ((item.NewOption or 0) > 0) == f.excellent)
	end)
end, OWNER)

Events.On("LevelUp", function(aIndex, levels)
	Progress("level_up", aIndex, levels)
end, OWNER)

Events.On("MasterLevelUp", function(aIndex, levels)
	Progress("master_level_up", aIndex, levels)
end, OWNER)

Events.On("Reset", function(aIndex, mode)
	local name = (mode == 1) and "master" or "reset"

	Progress("reset", aIndex, 1, function(f)
		return (f.mode or "reset") == name
	end)
end, OWNER)

Events.On("ChaosMix", function(aIndex, mixType, success)
	local ok = (success == 1)

	Progress("chaos_mix", aIndex, 1, function(f)
		return Contains(f.mixes, mixType) and (f.success == nil or f.success == ok)
	end)
end, OWNER)

Events.On("ItemUpgrade", function(aIndex, jewel, item, success, level)
	local ok = (success == 1)

	Progress("item_upgrade", aIndex, 1, function(f)
		return (f.jewel == nil or JewelItems[f.jewel] == jewel)
			and (f.success == nil or f.success == ok)
			and (f.min_level == nil or level >= f.min_level)
	end)
end, OWNER)

Events.On("QuestFinish", function(aIndex, quest)
	Progress("quest_finish", aIndex, 1, function(f)
		return Contains(f.quests, quest)
	end)
end, OWNER)

local Seconds = 0

Events.On("Timer", function()
	Seconds = Seconds + 1

	if Seconds < 60 or Objectives.Index["playtime"] == nil then
		return
	end

	Seconds = 0

	for aIndex = GetMinUserIndex(), GetMaxUserIndex() do
		if GetObjectConnected(aIndex) == OBJECT_ONLINE then
			Progress("playtime", aIndex, 1)
		end
	end
end, OWNER)

-- Free the PvP history of players that leave
Events.On("CharacterClose", function(aIndex)
	local name = GetObjectName(aIndex)
	KillHistory[name] = nil
	DuelHistory[name] = nil
end, OWNER)
