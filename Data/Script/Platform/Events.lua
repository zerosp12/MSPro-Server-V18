---------------------------------------------------------------------------
-- Events: every game event in one place
--
--   Events.On("MonsterDie", function(monster, killer) end, "my_module")
--   Events.Off("my_module")        -- removes every handler of that owner
--
-- Events (arguments):
--   ReadScript()                     ShutScript()
--   Timer()                          (every second)
--   CharacterEntry(aIndex)           CharacterClose(aIndex)
--   MonsterDie(monster, killer)      UserDie(victim, killer)
--   UserRespawn(aIndex, killerType)  NpcTalk(npc, aIndex)
--   ItemPick(aIndex, mapItemIndex)   (before the pick is confirmed)
--   EventWin(aIndex, event, level)   event: 0 BC, 1 DS, 2 CC, 3 IT, 4 Doppelganger,
--                                           5 Imperial, 6 Crywolf, 7 Kanturu
--   LevelUp(aIndex, levels, level)   MasterLevelUp(aIndex, levels, level)
--   Reset(aIndex, mode, count)       mode: 0 reset, 1 master reset
--   ChaosMix(aIndex, mixType, success)
--   ItemUpgrade(aIndex, jewelIndex, itemIndex, success, level, option)
--   QuestFinish(aIndex, quest, type)
--   DuelEnd(winner, loser)
--
-- Handlers only observe: they can not cancel the game action.
---------------------------------------------------------------------------

Events = Events or {}
Events.Handlers = Events.Handlers or {}

function Events.On(name, fn, owner)
	if type(fn) ~= "function" then
		error("Events.On: handler must be a function", 2)
	end

	Events.Handlers[name] = Events.Handlers[name] or {}
	table.insert(Events.Handlers[name], { fn = fn, owner = owner })
end

function Events.Off(owner)
	for _, list in pairs(Events.Handlers) do
		for i = #list, 1, -1 do
			if list[i].owner == owner then
				table.remove(list, i)
			end
		end
	end
end

function Events.Emit(name, ...)
	local list = Events.Handlers[name]

	if list == nil then
		return
	end

	for i = 1, #list do
		local ok, err = pcall(list[i].fn, ...)

		if not ok then
			Platform.Log(string.format("Event %s (%s): %s", name, tostring(list[i].owner), tostring(err)))
		end
	end
end

-- Called by the GameServer (CScriptLoader::OnEvent)
function BridgeFunction_OnEvent(name, ...)
	if not Events.Checked and Events.CheckDispatchers then
		Events.CheckDispatchers()
	end

	Events.Emit(name, ...)
end

-- Existing ScriptCore bridges forwarded as events. The return value keeps the
-- default behavior of each bridge (never blocks the game).
local Forward = {
	{ bridge = "OnReadScript",     event = "ReadScript" },
	{ bridge = "OnShutScript",     event = "ShutScript" },
	{ bridge = "OnTimerThread",    event = "Timer" },
	{ bridge = "OnCharacterEntry", event = "CharacterEntry" },
	{ bridge = "OnCharacterClose", event = "CharacterClose" },
	{ bridge = "OnNpcTalk",        event = "NpcTalk",     ret = 0 },
	{ bridge = "OnMonsterDie",     event = "MonsterDie",  ret = 0 },
	{ bridge = "OnUserDie",        event = "UserDie" },
	{ bridge = "OnUserRespawn",    event = "UserRespawn" },
	{ bridge = "OnUserItemPick",   event = "ItemPick",    ret = 1 },
}

if not Events.Attached then
	for _, entry in ipairs(Forward) do
		local name = "PlatformForward_" .. entry.bridge

		_G[name] = function(...)
			Events.Emit(entry.event, ...)
			return entry.ret
		end

		BridgeFunctionAttach(entry.bridge, name)
	end

	-- ScriptCore dispatchers, to detect scripts that replace them
	Events.Dispatchers = {}

	for _, entry in ipairs(Forward) do
		local global = "BridgeFunction_" .. entry.bridge
		Events.Dispatchers[global] = _G[global]
	end

	Events.Attached = true
end

-- A script that defines BridgeFunction_OnMonsterDie (etc.) itself replaces the
-- ScriptCore dispatcher: no attached function runs anymore (platform included).
-- Checked once, after every script is loaded (first platform event or timer).
function Events.CheckDispatchers()
	if Events.Checked or Events.Dispatchers == nil then
		return
	end

	Events.Checked = true

	for global, fn in pairs(Events.Dispatchers) do
		if _G[global] ~= fn then
			Platform.Log(string.format("WARNING: %s was redefined by another script; its events do not reach the platform. "
				.. "Use BridgeFunctionAttach(\"%s\", \"MyFunction\") in that script instead.", global, global:sub(16)))
		end
	end
end

Events.Off("Platform.Events")
Events.On("Timer", Events.CheckDispatchers, "Platform.Events")

