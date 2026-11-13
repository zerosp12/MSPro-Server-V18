---------------------------------------------------------------------------
-- MSPro Lua Platform - GameServer
-- Load from ScriptMain.lua AFTER System\ScriptCore:
--     require("Platform\\Platform")
-- Spec: docs/LuaPlatform_Achievements_Spec.md
---------------------------------------------------------------------------

Platform = Platform or {}

function Platform.Log(text)
	LogPrint("[Platform] " .. tostring(text))
end

require("Platform\\Events")
require("Platform\\Net")
require("Platform\\Reward")
require("Platform\\Bonus")
require("Platform\\Objectives")
require("Platform\\Storage")
