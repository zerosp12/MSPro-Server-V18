---------------------------------------------------------------------------
-- MSPro - MuServerPro Team - Desarrollos de MUOnline
-- Web: wwww.muserverpro.com 
-- FB: @mspromu
---------------------------------------------------------------------------

require("System\\ScriptCore")

-- Lua Platform (after ScriptCore)
require("Platform\\Platform")
require("Modules\\PlatformTest\\Server")
require("Modules\\Achievements\\Server")

-- Event Core
--require("Events\\EventCore")
--require("Events\\LastManStanding")
require("Custom\\WelcomeLua")
require("Custom\\BossTopDamage")


-- Auctions: available to all accounts.
AuctionTestAccounts = nil
require("Modules\\Auctions\\Server")
