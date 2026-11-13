---------------------------------------------------------------------------
-- PlatformTest: in-game check of the Lua Platform (phase 1)
-- Enable in ScriptMain.lua (after Platform\Platform):
--     require("Modules\\PlatformTest\\Server")
-- Client side: Encoder\Lua\PlatformTest.lua (channel "platform.test")
--
--   ping   -> pong (any player)
--   reward -> gives 1000 zen + 1 Jewel of Bless          (GM only)
--   bonus  -> +50 damage, +5% exp (visible in stats)     (GM only)
--   clear  -> removes the bonus                           (GM only)
-- Every new game event of the player is sent to the client.
---------------------------------------------------------------------------

local CHANNEL = "platform.test"
local OWNER = "PlatformTest"
local GM_AUTHORITY = 32

local function IsGM(aIndex)
	return GetObjectAuthority(aIndex) == GM_AUTHORITY
end

Net.On(CHANNEL, function(aIndex, msg)
	if type(msg) ~= "table" then
		return
	end

	if msg.op == "ping" then
		Net.Send(aIndex, CHANNEL, { op = "pong", t = msg.t, name = GetObjectName(aIndex) })
		return
	end

	-- Phase 2: DataServer Lua + SQL (Storage). Any player.
	if msg.op == "load" then
		Storage.Load(aIndex, "platform_test", function(data, err)
			Net.Send(aIndex, CHANNEL, { op = "load", data = data, error = err })
		end)
		return
	end

	if msg.op == "save" then
		Storage.Load(aIndex, "platform_test", function(data, err)
			if err ~= nil then
				Net.Send(aIndex, CHANNEL, { op = "save", error = err })
				return
			end

			data = data or { count = 0 }
			data.count = data.count + 1
			data.last = os.date("%Y-%m-%d %H:%M:%S")

			Storage.Save(aIndex, "platform_test", data)
			Net.Send(aIndex, CHANNEL, { op = "save", data = data })
		end)
		return
	end

	if not IsGM(aIndex) then
		Net.Send(aIndex, CHANNEL, { op = "error", reason = "gm_only" })
		return
	end

	if msg.op == "reward" then
		local ok, reason = Reward.Give(aIndex, {
			{ type = "zen", value = 1000 },
			{ type = "item", section = 14, index = 13, count = 1 },
		}, "PlatformTest")

		Net.Send(aIndex, CHANNEL, { op = "reward", ok = ok, reason = reason })
	elseif msg.op == "bonus" then
		Bonus.Set(aIndex, OWNER, { damage = 50, exp_rate = 5 })
		Net.Send(aIndex, CHANNEL, { op = "bonus", ok = true })
	elseif msg.op == "clear" then
		Bonus.Clear(aIndex, OWNER)
		Net.Send(aIndex, CHANNEL, { op = "clear", ok = true })
	end
end)

local function Forward(name, ...)
	local args = { ... }
	local aIndex = args[1]

	if aIndex ~= nil and GetObjectType(aIndex) == 1 then
		Net.Send(aIndex, CHANNEL, { op = "event", name = name, args = args })
	end
end

Events.Off(OWNER)

for _, name in ipairs({ "LevelUp", "MasterLevelUp", "Reset", "ChaosMix", "ItemUpgrade", "EventWin", "QuestFinish", "DuelEnd" }) do
	Events.On(name, function(...) Forward(name, ...) end, OWNER)
end

Platform.Log("PlatformTest loaded (channel " .. CHANNEL .. ")")
