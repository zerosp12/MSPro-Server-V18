---------------------------------------------------------------------------
-- Achievements - configuration
--
-- RULES
--  * ids are permanent: never reuse or change the id of an achievement
--    (removed achievements are ignored, their data stays in the database)
--  * every objective counts actions done AFTER the system is installed
--    ("do 10 resets", never "have reset 10")
--  * the same file must be used by every GameServer
--
-- Objective types and filters: see Scripts\GameServer\Platform\Objectives.lua
-- Reward types: see Scripts\GameServer\Platform\Reward.lua
-- Bonus options: see Scripts\GameServer\Platform\Bonus.lua
--
-- Texts: numeric IDs in Data\Messages\Message_ENG/SPN/POR.txt; legacy strings/tables still accepted.
---------------------------------------------------------------------------

AchievementsConfig = {
	DefaultLang = "es",
	SaveInterval = 60,          -- seconds between batch saves (also saved on logout)
	UpdateInterval = 1,         -- seconds between progress updates to the client

	-- Maximum total bonus from achievements (all sources together)
	BonusCaps = { damage = 100, exp_rate = 20, add_life = 500, double_damage = 5 },

	-- PvP filters (Objectives.Config.PvP: shared by every module that counts PvP)
	-- SameIP / SameHWID = true is needed to test duels and kills with two
	-- clients on the same machine, and lets players farm kills with two accounts.
	PvP = {
		SameIP = false,
		SameHWID = false,
		Cooldown = 600,     -- seconds before the same victim counts again
	},

	-- Logs every PvP kill or duel discarded by those filters (to check why it does not count)
	Debug = true,
}

---------------------------------------------------------------------------
-- Categories (milestones by % of tiers completed in the category)
---------------------------------------------------------------------------

AchievementsConfig.Categories = {
	{ id = 1, name = 3502, icon = "Sword",
	  milestones = {
		{ percent = 50,  rewards = { { type = "item", section = 14, index = 14, count = 5 } } },
		{ percent = 100, rewards = { { type = "bonus_points", value = 20 } }, bonus = { damage = 10 } },
	  } },
	{ id = 2, name = 3503, icon = "Skull",
	  milestones = {
		{ percent = 100, rewards = { { type = "item", section = 14, index = 22, count = 3 } }, bonus = { double_damage = 1 } },
	  } },
	{ id = 3, name = 3504, icon = "Flag",
	  milestones = {
		{ percent = 50,  rewards = { { type = "zen", value = 50000000 } } },
		{ percent = 100, rewards = { { type = "bonus_points", value = 20 } }, bonus = { exp_rate = 3 } },
	  } },
	{ id = 4, name = 3505, icon = "Level",
	  milestones = {
		{ percent = 100, rewards = { { type = "bonus_points", value = 30 } }, bonus = { add_life = 100 } },
	  } },
	{ id = 5, name = 3506, icon = "Anvil",
	  milestones = {
		{ percent = 100, rewards = { { type = "item", section = 14, index = 42, count = 1 } } },
	  } },
	{ id = 6, name = 3507, icon = "Swords",
	  milestones = {
		{ percent = 100, rewards = { { type = "bonus_points", value = 20 } }, bonus = { damage = 10 } },
	  } },
	{ id = 7, name = 3508, icon = "Compass",
	  milestones = {
		{ percent = 100, rewards = { { type = "bonus_points", value = 10 } } },
	  } },
	{ id = 8, name = 3509, icon = "Trophy",
	  milestones = {
		{ percent = 100, rewards = { { type = "coins", coin1 = 200 } }, bonus = { damage = 10 } },
	  } },
	{ id = 9, name = 3510, icon = "Star",
	  milestones = {
		{ percent = 50,  rewards = { { type = "item", section = 14, index = 16, count = 3 } } },
		{ percent = 100, rewards = { { type = "bonus_points", value = 20 } }, bonus = { exp_rate = 3 } },
	  } },
	{ id = 10, name = 3511, icon = "Compass",
	  milestones = {
		{ percent = 50,  rewards = { { type = "item", section = 14, index = 14, count = 10 } } },
		{ percent = 100, rewards = { { type = "coins", coin1 = 150 } }, bonus = { exp_rate = 3 } },
	  } },
	{ id = 11, name = 3512, icon = "Alert",
	  milestones = {
		{ percent = 100, rewards = { { type = "bonus_points", value = 25 } }, bonus = { damage = 10 } },
	  } },
}

---------------------------------------------------------------------------
-- Global milestones (by total achievement points)
---------------------------------------------------------------------------

AchievementsConfig.Milestones = {
	{ points = 50,   rewards = { { type = "item", section = 14, index = 13, count = 5 } } },
	{ points = 150,  rewards = { { type = "bonus_points", value = 10 } } },
	{ points = 300,  rewards = { { type = "coins", coin1 = 100 } } },
	{ points = 600,  rewards = { { type = "item", section = 14, index = 14, count = 10 } }, bonus = { exp_rate = 2 } },
	{ points = 1000, rewards = { { type = "coins", coin1 = 300 } }, bonus = { damage = 10 } },
}

---------------------------------------------------------------------------
-- Achievements
--   objective = { type = "...", <filters> }
--   tiers     = { { goal, points, rewards, bonus }, ... } (goals must increase)
--   hidden    = true: shown as "???" until the first tier is done
--   requires  = { ids }: only counts after the first tier of those achievements
--   icon      = "Sword" | "Skull" | ... icono del UI Kit, o { section, index } para un item
---------------------------------------------------------------------------

local function Jewel(index, count) return { type = "item", section = 14, index = index, count = count } end
local function Zen(value) return { type = "zen", value = value } end
local function Points(value) return { type = "bonus_points", value = value } end

AchievementsConfig.List = {
	-- Cazador ----------------------------------------------------------------
	{ id = 101, category = 1, order = 1, icon = "Sword",
	  name = 3513,
	  desc = 3514,
	  objective = { type = "monster_kill" },
	  tiers = {
		{ goal = 500,   points = 5,  rewards = { Zen(5000000) } },
		{ goal = 5000,  points = 10, rewards = { Jewel(13, 5) }, bonus = { add_life = 20 } },
		{ goal = 50000, points = 25, rewards = { Jewel(14, 5) }, bonus = { add_life = 30 } },
	  } },
	{ id = 102, category = 1, order = 2, icon = "Sword",
	  name = 3515,
	  desc = 3516,
	  objective = { type = "monster_kill", min_level = 80 },
	  tiers = {
		{ goal = 1000,  points = 10, rewards = { Jewel(13, 3) } },
		{ goal = 10000, points = 25, rewards = { Jewel(14, 5) }, bonus = { damage = 5 } },
	  } },
	{ id = 103, category = 1, order = 3, icon = "Skull",
	  name = 3517,
	  desc = 3518,
	  objective = { type = "monster_kill", maps = { 2 } },
	  tiers = { { goal = 2000, points = 10, rewards = { Jewel(16, 2) } } } },

	-- Jefes --------------------------------------------------------------------
	{ id = 201, category = 2, order = 1, icon = "Skull",
	  name = 3519,
	  desc = 3520,
	  objective = { type = "boss_kill", monsters = { 275 } },
	  tiers = { { goal = 1, points = 20, rewards = { Jewel(22, 2) } } } },
	{ id = 202, category = 2, order = 2, icon = "Skull",
	  name = 3521,
	  desc = 3522,
	  objective = { type = "boss_kill", monsters = { 459 } },
	  tiers = { { goal = 1, points = 20, rewards = { Jewel(22, 2) } } } },
	{ id = 203, category = 2, order = 3, icon = "Skull", hidden = true, requires = { 201 },
	  name = 3523,
	  desc = 3524,
	  objective = { type = "boss_kill", monsters = { 349 } },
	  tiers = { { goal = 1, points = 30, rewards = { Jewel(22, 5) } } } },
	{ id = 204, category = 2, order = 4, icon = "Trophy",
	  name = 3525,
	  desc = 3526,
	  objective = { type = "boss_kill", monsters = { 275, 459, 349, 361, 561 } },
	  tiers = {
		{ goal = 5,   points = 10, rewards = { Jewel(22, 1) } },
		{ goal = 25,  points = 25, rewards = { Jewel(22, 3) } },
		{ goal = 100, points = 50, rewards = { Jewel(22, 10) }, bonus = { damage = 10 } },
	  } },

	-- Eventos ------------------------------------------------------------------
	{ id = 301, category = 3, order = 1, icon = "Flag",
	  name = 3527,
	  desc = 3528,
	  objective = { type = "event_win", events = { "bc" } },
	  tiers = { { goal = 1, points = 5, rewards = { Zen(10000000) } }, { goal = 10, points = 10, rewards = { Jewel(13, 5) } }, { goal = 50, points = 25, rewards = { Points(5) } } } },
	{ id = 302, category = 3, order = 2, icon = "Flag",
	  name = 3529,
	  desc = 3530,
	  objective = { type = "event_win", events = { "ds" } },
	  tiers = { { goal = 1, points = 5, rewards = { Zen(10000000) } }, { goal = 10, points = 10, rewards = { Jewel(14, 5) } }, { goal = 50, points = 25, rewards = { Points(5) } } } },
	{ id = 303, category = 3, order = 3, icon = "Flag",
	  name = 3531,
	  desc = 3532,
	  objective = { type = "event_win", events = { "cc" } },
	  tiers = { { goal = 1, points = 10, rewards = { Jewel(22, 1) } }, { goal = 10, points = 25, rewards = { Points(10) } } } },
	{ id = 304, category = 3, order = 4, icon = "Trophy",
	  name = 3533,
	  desc = 3534,
	  objective = { type = "event_win" },
	  tiers = { { goal = 100, points = 25, rewards = { Points(10) } }, { goal = 500, points = 50, rewards = { Points(20) }, bonus = { exp_rate = 2 } } } },

	-- Progresión ---------------------------------------------------------------
	{ id = 401, category = 4, order = 1, icon = "Level",
	  name = 3535,
	  desc = 3536,
	  objective = { type = "level_up" },
	  tiers = { { goal = 100, points = 5, rewards = { Zen(5000000) } }, { goal = 1000, points = 10, rewards = { Jewel(13, 5) } }, { goal = 10000, points = 25, rewards = { Points(10) } } } },
	{ id = 402, category = 4, order = 2, icon = "Level",
	  name = 3537,
	  desc = 3538,
	  objective = { type = "reset" },
	  tiers = {
		{ goal = 1,   points = 5,  rewards = { Jewel(13, 2) } },
		{ goal = 10,  points = 10, rewards = { Points(5) } },
		{ goal = 50,  points = 25, rewards = { Points(10) }, bonus = { add_life = 50 } },
		{ goal = 100, points = 50, rewards = { Points(20) }, bonus = { add_life = 100 } },
	  } },
	{ id = 403, category = 4, order = 3, icon = "Level",
	  name = 3539,
	  desc = 3540,
	  objective = { type = "master_level_up" },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(14, 3) } }, { goal = 200, points = 25, rewards = { Points(10) } } } },
	{ id = 404, category = 4, order = 4, icon = "Trophy",
	  name = 3541,
	  desc = 3542,
	  objective = { type = "reset", mode = "master" },
	  tiers = { { goal = 1, points = 25, rewards = { Points(10) } }, { goal = 5, points = 50, rewards = { Points(25) } } } },

	-- Artesano -----------------------------------------------------------------
	{ id = 501, category = 5, order = 1, icon = "Anvil",
	  name = 3543,
	  desc = 3544,
	  objective = { type = "chaos_mix", success = true },
	  tiers = { { goal = 10, points = 5, rewards = { Jewel(13, 2) } }, { goal = 100, points = 10, rewards = { Jewel(14, 5) } }, { goal = 500, points = 25, rewards = { Points(10) } } } },
	{ id = 502, category = 5, order = 2, icon = "Anvil",
	  name = 3545,
	  desc = 3546,
	  objective = { type = "chaos_mix", success = false },
	  tiers = { { goal = 10, points = 5, rewards = { Jewel(13, 1) } }, { goal = 50, points = 10, rewards = { Jewel(12, 5) } } } },
	{ id = 503, category = 5, order = 3, icon = "Anvil",
	  name = 3547,
	  desc = 3548,
	  objective = { type = "item_upgrade", jewel = "bless", success = true },
	  tiers = { { goal = 50, points = 5, rewards = { Jewel(13, 5) } }, { goal = 500, points = 10, rewards = { Jewel(13, 20) } } } },
	{ id = 504, category = 5, order = 4, icon = "Anvil",
	  name = 3549,
	  desc = 3550,
	  objective = { type = "item_upgrade", jewel = "soul", success = true },
	  tiers = { { goal = 25, points = 10, rewards = { Jewel(14, 5) } }, { goal = 250, points = 25, rewards = { Jewel(14, 20) } } } },
	{ id = 505, category = 5, order = 5, icon = "Star",
	  name = 3551,
	  desc = 3552,
	  objective = { type = "item_upgrade", jewel = "soul", success = true, min_level = 9 },
	  tiers = { { goal = 1, points = 10, rewards = { Jewel(16, 3) } }, { goal = 10, points = 25, rewards = { Points(10) } } } },

	-- PvP ----------------------------------------------------------------------
	{ id = 601, category = 6, order = 1, icon = "Swords",
	  name = 3553,
	  desc = 3554,
	  objective = { type = "duel_win" },
	  tiers = { { goal = 1, points = 5, rewards = { Zen(5000000) } }, { goal = 25, points = 10, rewards = { Jewel(13, 5) } }, { goal = 100, points = 25, rewards = { Points(10) } } } },
	{ id = 602, category = 6, order = 2, icon = "Swords",
	  name = 3555,
	  desc = 3556,
	  objective = { type = "player_kill", min_victim_level = 150 },
	  tiers = { { goal = 10, points = 5, rewards = { Jewel(14, 1) } }, { goal = 100, points = 10, rewards = { Jewel(14, 5) } }, { goal = 500, points = 25, rewards = { Points(10) }, bonus = { damage = 5 } } } },

	-- Aventura -----------------------------------------------------------------
	{ id = 701, category = 7, order = 1, icon = "Compass",
	  name = 3557,
	  desc = 3558,
	  objective = { type = "playtime" },
	  tiers = { { goal = 600, points = 5, rewards = { Zen(10000000) } }, { goal = 6000, points = 10, rewards = { Points(5) } }, { goal = 30000, points = 25, rewards = { Points(10) } } } },
	{ id = 702, category = 7, order = 2, icon = "Compass",
	  name = 3559,
	  desc = 3560,
	  objective = { type = "quest_finish" },
	  tiers = { { goal = 10, points = 5, rewards = { Jewel(13, 3) } }, { goal = 100, points = 10, rewards = { Points(5) } } } },
	{ id = 703, category = 7, order = 3, icon = "Star",
	  name = 3561,
	  desc = 3562,
	  objective = { type = "item_pick", section = 14, index = 13 },
	  tiers = { { goal = 10, points = 5, rewards = { Zen(5000000) } }, { goal = 100, points = 10, rewards = { Jewel(13, 5) } } } },
	-- Cazador (extra) --------------------------------------------------------
	{ id = 104, category = 1, order = 4, icon = "Sword",
	  name = 3563,
	  desc = 3564,
	  objective = { type = "monster_kill", min_level = 120 },
	  tiers = { { goal = 500, points = 10, rewards = { Jewel(14, 3) } }, { goal = 5000, points = 25, rewards = { Jewel(16, 3) } } } },
	{ id = 105, category = 1, order = 5, icon = "Skull",
	  name = 3565,
	  desc = 3566,
	  objective = { type = "monster_kill", maps = { 7 } },
	  tiers = { { goal = 2000, points = 10, rewards = { Jewel(16, 2) } } } },
	{ id = 106, category = 1, order = 6, icon = "Sword",
	  name = 3567,
	  desc = 3568,
	  objective = { type = "monster_kill" },
	  tiers = { { goal = 100000, points = 50, rewards = { Points(25) }, bonus = { damage = 10 } } } },

	-- Jefes (extra) ----------------------------------------------------------
	{ id = 205, category = 2, order = 5, icon = "Skull",
	  name = 3569,
	  desc = 3570,
	  objective = { type = "boss_kill", monsters = { 361 } },
	  tiers = { { goal = 1, points = 20, rewards = { Jewel(22, 2) } } } },
	{ id = 206, category = 2, order = 6, icon = "Skull",
	  name = 3571,
	  desc = 3572,
	  objective = { type = "boss_kill", monsters = { 561 } },
	  tiers = { { goal = 1, points = 25, rewards = { Jewel(22, 3) } } } },
	{ id = 207, category = 2, order = 7, icon = "Trophy",
	  name = 3573,
	  desc = 3574,
	  objective = { type = "boss_kill", monsters = { 275, 459, 349, 361, 561, 295, 143 } },
	  tiers = { { goal = 250, points = 50, rewards = { Points(20) } }, { goal = 1000, points = 100, rewards = { Points(50) }, bonus = { double_damage = 1 } } } },

	-- Eventos (extra) --------------------------------------------------------
	{ id = 305, category = 3, order = 5, icon = "Flag",
	  name = 3575,
	  desc = 3576,
	  objective = { type = "event_win", events = { "it" } },
	  tiers = { { goal = 1, points = 10, rewards = { Jewel(14, 3) } }, { goal = 25, points = 25, rewards = { Points(10) } } } },
	{ id = 306, category = 3, order = 6, icon = "Flag",
	  name = 3577,
	  desc = 3578,
	  objective = { type = "event_win", events = { "doppelganger" } },
	  tiers = { { goal = 1, points = 10, rewards = { Jewel(16, 2) } }, { goal = 25, points = 25, rewards = { Points(10) } } } },
	{ id = 307, category = 3, order = 7, icon = "Flag",
	  name = 3579,
	  desc = 3580,
	  objective = { type = "event_win", events = { "imperial" } },
	  tiers = { { goal = 1, points = 15, rewards = { Jewel(22, 1) } }, { goal = 20, points = 30, rewards = { Points(15) } } } },

	-- Progresion (extra) -----------------------------------------------------
	{ id = 405, category = 4, order = 5, icon = "Level",
	  name = 3581,
	  desc = 3582,
	  objective = { type = "level_up" },
	  tiers = { { goal = 50000, points = 50, rewards = { Points(25) }, bonus = { exp_rate = 3 } } } },
	{ id = 406, category = 4, order = 6, icon = "Level",
	  name = 3583,
	  desc = 3584,
	  objective = { type = "reset" },
	  tiers = { { goal = 250, points = 75, rewards = { Points(30) }, bonus = { add_life = 150 } } } },

	-- Artesano (extra) -------------------------------------------------------
	{ id = 506, category = 5, order = 6, icon = "Anvil",
	  name = 3585,
	  desc = 3586,
	  objective = { type = "chaos_mix", success = true },
	  tiers = { { goal = 1000, points = 50, rewards = { Jewel(42, 1) } } } },
	{ id = 507, category = 5, order = 7, icon = "Star",
	  name = 3587,
	  desc = 3588,
	  objective = { type = "item_upgrade", jewel = "life", success = true },
	  tiers = { { goal = 25, points = 10, rewards = { Jewel(16, 5) } }, { goal = 250, points = 25, rewards = { Jewel(16, 20) } } } },

	-- PvP (extra) ------------------------------------------------------------
	{ id = 603, category = 6, order = 3, icon = "Swords",
	  name = 3589,
	  desc = 3590,
	  objective = { type = "duel_win" },
	  tiers = { { goal = 500, points = 50, rewards = { Points(20) }, bonus = { damage = 10 } } } },
	{ id = 604, category = 6, order = 4, icon = "Swords",
	  name = 3591,
	  desc = 3592,
	  objective = { type = "player_kill" },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(13, 5) } }, { goal = 1000, points = 40, rewards = { Points(20) } } } },

	-- Aventura (extra) -------------------------------------------------------
	{ id = 704, category = 7, order = 4, icon = "Compass",
	  name = 3593,
	  desc = 3594,
	  objective = { type = "npc_talk" },
	  tiers = { { goal = 50, points = 5, rewards = { Zen(5000000) } }, { goal = 500, points = 10, rewards = { Points(5) } } } },
	{ id = 705, category = 7, order = 5, icon = "Star",
	  name = 3595,
	  desc = 3596,
	  objective = { type = "item_pick", section = 14, index = 14 },
	  tiers = { { goal = 25, points = 5, rewards = { Jewel(14, 2) } }, { goal = 250, points = 15, rewards = { Points(10) } } } },
	{ id = 706, category = 7, order = 6, icon = "Compass",
	  name = 3597,
	  desc = 3598,
	  objective = { type = "playtime" },
	  tiers = { { goal = 50000, points = 50, rewards = { Points(25) } } } },

	-- Eventos (Crywolf y Kanturu) ---------------------------------------------
	{ id = 308, category = 3, order = 8, icon = "Flag",
	  name = 3599,
	  desc = 3600,
	  objective = { type = "event_win", events = { "crywolf" } },
	  tiers = { { goal = 1, points = 15, rewards = { Jewel(22, 1) } }, { goal = 20, points = 35, rewards = { Points(15) } } } },
	{ id = 309, category = 3, order = 9, icon = "Flag",
	  name = 3601,
	  desc = 3602,
	  objective = { type = "event_win", events = { "kanturu" } },
	  tiers = { { goal = 1, points = 15, rewards = { Jewel(22, 1) } }, { goal = 20, points = 35, rewards = { Points(15) } } } },

	-- Gremio -----------------------------------------------------------------
	{ id = 801, category = 8, order = 1, icon = "Trophy",
	  name = 3603,
	  desc = 3604,
	  objective = { type = "castle_siege" },
	  tiers = {
		{ goal = 1,  points = 30, rewards = { Jewel(22, 2) } },
		{ goal = 5,  points = 60, rewards = { Points(30) }, bonus = { damage = 5 } },
		{ goal = 25, points = 120, rewards = { { type = "coins", coin1 = 300 } }, bonus = { double_damage = 1 } },
	  } },
	{ id = 802, category = 8, order = 2, icon = "Swords",
	  name = 3605,
	  desc = 3606,
	  objective = { type = "player_kill", guild = true },
	  tiers = { { goal = 100, points = 15, rewards = { Jewel(13, 5) } }, { goal = 1000, points = 40, rewards = { Points(20) } } } },
	{ id = 803, category = 8, order = 3, icon = "Skull",
	  name = 3607,
	  desc = 3608,
	  objective = { type = "boss_kill", monsters = { 275, 459, 349, 361, 561, 295, 143 }, guild = true },
	  tiers = { { goal = 50, points = 20, rewards = { Jewel(22, 1) } }, { goal = 300, points = 45, rewards = { Points(20) } } } },

	-- Escuadron (en grupo) ---------------------------------------------------
	{ id = 901, category = 9, order = 1, icon = "Star",
	  name = 3609,
	  desc = 3610,
	  objective = { type = "monster_kill", party = true },
	  tiers = {
		{ goal = 1000,   points = 10, rewards = { Zen(10000000) } },
		{ goal = 25000,  points = 25, rewards = { Jewel(14, 5) }, bonus = { exp_rate = 1 } },
		{ goal = 100000, points = 50, rewards = { Points(25) }, bonus = { add_life = 100 } },
	  } },
	{ id = 902, category = 9, order = 2, icon = "Skull",
	  name = 3611,
	  desc = 3612,
	  objective = { type = "boss_kill", monsters = { 275, 459, 349, 361, 561, 295, 143 }, party = true },
	  tiers = { { goal = 25, points = 15, rewards = { Jewel(22, 1) } }, { goal = 200, points = 40, rewards = { Points(20) }, bonus = { damage = 5 } } } },
	{ id = 903, category = 9, order = 3, icon = "Flag",
	  name = 3613,
	  desc = 3614,
	  objective = { type = "event_win", events = { "bc", "ds", "cc", "it", "doppelganger" }, party = true },
	  tiers = { { goal = 10, points = 15, rewards = { Jewel(16, 3) } }, { goal = 50, points = 35, rewards = { Points(20) } } } },
	{ id = 904, category = 9, order = 4, icon = "Swords",
	  name = 3615,
	  desc = 3616,
	  objective = { type = "player_kill", party = true },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(13, 3) } }, { goal = 500, points = 30, rewards = { Points(15) } } } },

	-- Cartógrafo (farmeo por región) -----------------------------------------
	-- Los mapas de evento quedan afuera a propósito: ya suman por event_win y
	-- contarlos también como farmeo seria pagar dos veces lo mismo.
	{ id = 1001, category = 10, order = 1, icon = "Compass",
	  name = 3617,
	  desc = 3618,
	  objective = { type = "monster_kill", maps = { 0, 1, 2, 3, 51 } },
	  tiers = { { goal = 5000, points = 10, rewards = { Zen(10000000) } },
	            { goal = 25000, points = 20, rewards = { Jewel(13, 5) } } } },
	{ id = 1002, category = 10, order = 2, icon = "Compass",
	  name = 3619,
	  desc = 3620,
	  objective = { type = "monster_kill", maps = { 4, 7, 8 } },
	  tiers = { { goal = 5000, points = 10, rewards = { Jewel(14, 3) } },
	            { goal = 25000, points = 20, rewards = { Jewel(14, 10) } } } },
	{ id = 1003, category = 10, order = 3, icon = "Compass",
	  name = 3621,
	  desc = 3622,
	  objective = { type = "monster_kill", maps = { 10, 33 } },
	  tiers = { { goal = 5000, points = 10, rewards = { Jewel(16, 3) } },
	            { goal = 25000, points = 20, rewards = { Points(10) } } } },
	{ id = 1004, category = 10, order = 4, icon = "Compass",
	  name = 3623,
	  desc = 3624,
	  objective = { type = "monster_kill", maps = { 24, 25, 26, 27, 28, 29, 36 } },
	  tiers = { { goal = 3000, points = 15, rewards = { Jewel(22, 1) } },
	            { goal = 15000, points = 30, rewards = { Points(15) } } } },
	{ id = 1005, category = 10, order = 5, icon = "Compass",
	  name = 3625,
	  desc = 3626,
	  objective = { type = "monster_kill", maps = { 37, 38 } },
	  tiers = { { goal = 3000, points = 15, rewards = { Jewel(22, 1) } },
	            { goal = 15000, points = 30, rewards = { Points(15) } } } },
	{ id = 1006, category = 10, order = 6, icon = "Compass",
	  name = 3627,
	  desc = 3628,
	  objective = { type = "monster_kill", maps = { 34, 56 } },
	  tiers = { { goal = 3000, points = 15, rewards = { Jewel(16, 5) } },
	            { goal = 15000, points = 30, rewards = { Points(15) } } } },
	{ id = 1007, category = 10, order = 7, icon = "Compass",
	  name = 3629,
	  desc = 3630,
	  objective = { type = "monster_kill", maps = { 57 } },
	  tiers = { { goal = 3000, points = 15, rewards = { Jewel(22, 2) } },
	            { goal = 15000, points = 30, rewards = { Points(15) } } } },
	{ id = 1008, category = 10, order = 8, icon = "Compass",
	  name = 3631,
	  desc = 3632,
	  objective = { type = "monster_kill", maps = { 80, 81, 63 } },
	  tiers = { { goal = 3000, points = 15, rewards = { Jewel(31, 1) } },
	            { goal = 15000, points = 30, rewards = { Points(15) } } } },
	{ id = 1009, category = 10, order = 9, icon = "Compass",
	  name = 3633,
	  desc = 3634,
	  objective = { type = "monster_kill", maps = { 40, 41, 42, 84, 95 } },
	  tiers = { { goal = 3000, points = 20, rewards = { Jewel(31, 2) } },
	            { goal = 15000, points = 40, rewards = { Points(20) }, bonus = { exp_rate = 2 } } } },
	-- Solo empieza a contar cuando las nueve regiones tienen su primer nivel
	{ id = 1010, category = 10, order = 10, icon = "Trophy", requires = { 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009 },
	  name = 3635,
	  desc = 3636,
	  objective = { type = "monster_kill" },
	  tiers = { { goal = 10000, points = 75, rewards = { { type = "coins", coin1 = 200 } }, bonus = { damage = 10 } } } },

	-- Dorados: aparecen al azar en todo el mundo -----------------------------
	{ id = 1011, category = 10, order = 11, icon = "Star", hidden = true,
	  name = 3637,
	  desc = 3638,
	  objective = { type = "boss_kill", monsters = { 43, 53, 54, 78, 79, 80, 81, 82, 83, 236,
	                                                 493, 494, 495, 496, 497, 498, 499, 500, 502 } },
	  tiers = { { goal = 1,   points = 10, rewards = { Jewel(14, 3) } },
	            { goal = 25,  points = 25, rewards = { Jewel(22, 2) } },
	            { goal = 100, points = 50, rewards = { Points(25) }, bonus = { exp_rate = 2 } } } },

	-- Jefes por región --------------------------------------------------------
	-- Las clases salen de Data\Monster (el bicho mas duro de cada zona por vida).
	{ id = 208, category = 2, order = 8, icon = "Skull",
	  name = 3639,
	  desc = 3640,
	  objective = { type = "boss_kill", monsters = { 38, 35 } },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(13, 5) } },
	            { goal = 250, points = 20, rewards = { Jewel(14, 5) } } } },
	{ id = 209, category = 2, order = 9, icon = "Skull",
	  name = 3641,
	  desc = 3642,
	  objective = { type = "boss_kill", monsters = { 49, 48 } },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(16, 3) } },
	            { goal = 250, points = 20, rewards = { Points(10) } } } },
	{ id = 210, category = 2, order = 10, icon = "Skull",
	  name = 3643,
	  desc = 3644,
	  objective = { type = "boss_kill", monsters = { 63, 59 } },
	  tiers = { { goal = 50, points = 15, rewards = { Jewel(22, 1) } },
	            { goal = 250, points = 30, rewards = { Points(15) } } } },
	{ id = 211, category = 2, order = 11, icon = "Skull",
	  name = 3645,
	  desc = 3646,
	  objective = { type = "boss_kill", monsters = { 77, 75 } },
	  tiers = { { goal = 50, points = 15, rewards = { Jewel(22, 2) } },
	            { goal = 250, points = 30, rewards = { Points(15) } } } },
	{ id = 212, category = 2, order = 12, icon = "Skull",
	  name = 3647,
	  desc = 3648,
	  objective = { type = "boss_kill", monsters = { 551, 549, 317, 316 } },
	  tiers = { { goal = 50, points = 20, rewards = { Jewel(31, 1) } },
	            { goal = 250, points = 35, rewards = { Points(20) } } } },
	{ id = 213, category = 2, order = 13, icon = "Skull",
	  name = 3649,
	  desc = 3650,
	  objective = { type = "boss_kill", monsters = { 556, 555, 360, 359 } },
	  tiers = { { goal = 50, points = 20, rewards = { Jewel(31, 1) } },
	            { goal = 250, points = 35, rewards = { Points(20) } } } },
	{ id = 214, category = 2, order = 14, icon = "Skull",
	  name = 3651,
	  desc = 3652,
	  objective = { type = "boss_kill", monsters = { 559, 558, 565, 563 } },
	  tiers = { { goal = 50, points = 25, rewards = { Jewel(42, 1) } },
	            { goal = 250, points = 45, rewards = { Points(25) }, bonus = { damage = 5 } } } },
	{ id = 215, category = 2, order = 15, icon = "Skull",
	  name = 3653,
	  desc = 3654,
	  objective = { type = "boss_kill", monsters = { 574, 573, 490, 489 } },
	  tiers = { { goal = 50, points = 20, rewards = { Jewel(31, 2) } },
	            { goal = 250, points = 35, rewards = { Points(20) } } } },
	-- Oculto: solo aparece cuando ya cayeron los jefes de todas las regiones
	{ id = 216, category = 2, order = 16, icon = "Trophy", hidden = true,
	  requires = { 208, 209, 210, 211, 212, 213, 214, 215 },
	  name = 3655,
	  desc = 3656,
	  objective = { type = "boss_kill", monsters = { 38, 35, 49, 48, 63, 59, 77, 75, 551, 549,
	                                                 317, 316, 556, 555, 360, 359, 559, 558,
	                                                 565, 563, 574, 573, 490, 489 } },
	  tiers = { { goal = 1000, points = 100, rewards = { { type = "coins", coin1 = 250 } }, bonus = { double_damage = 1 } } } },

	-- Artesano (items al limite) ----------------------------------------------
	{ id = 508, category = 5, order = 8, icon = "Anvil",
	  name = 3657,
	  desc = 3658,
	  objective = { type = "item_upgrade", success = false },
	  tiers = { { goal = 50, points = 10, rewards = { Jewel(13, 5) } },
	            { goal = 250, points = 25, rewards = { Points(10) } } } },
	{ id = 509, category = 5, order = 9, icon = "Star", hidden = true,
	  name = 3659,
	  desc = 3660,
	  objective = { type = "item_upgrade", success = true, min_level = 13 },
	  tiers = { { goal = 1,  points = 25, rewards = { Jewel(22, 3) } },
	            { goal = 10, points = 50, rewards = { Points(25) }, bonus = { damage = 5 } } } },

	-- Desafios (por nivel del monstruo) ---------------------------------------
	{ id = 1101, category = 11, order = 1, icon = "Alert",
	  name = 3661,
	  desc = 3662,
	  objective = { type = "monster_kill", min_level = 100 },
	  tiers = { { goal = 5000, points = 15, rewards = { Jewel(14, 5) } },
	            { goal = 25000, points = 30, rewards = { Points(15) } } } },
	{ id = 1102, category = 11, order = 2, icon = "Alert",
	  name = 3663,
	  desc = 3664,
	  objective = { type = "monster_kill", min_level = 130 },
	  tiers = { { goal = 2000, points = 20, rewards = { Jewel(22, 2) } },
	            { goal = 10000, points = 40, rewards = { Points(20) }, bonus = { damage = 5 } } } },
	{ id = 1103, category = 11, order = 3, icon = "Star", hidden = true,
	  name = 3665,
	  desc = 3666,
	  objective = { type = "monster_kill", max_level = 30 },
	  tiers = { { goal = 1000, points = 10, rewards = { Zen(20000000) } },
	            { goal = 10000, points = 25, rewards = { Points(10) } } } },
	{ id = 1104, category = 11, order = 4, icon = "Trophy", requires = { 1101, 1102, 1103 },
	  name = 3667,
	  desc = 3668,
	  objective = { type = "monster_kill", min_level = 110 },
	  tiers = { { goal = 20000, points = 80, rewards = { { type = "coins", coin1 = 200 } }, bonus = { exp_rate = 3 } } } },

}
