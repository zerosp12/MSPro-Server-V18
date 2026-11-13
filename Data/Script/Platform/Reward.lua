---------------------------------------------------------------------------
-- Reward: same delivery engine as the MSPro Quest System
--
--   local ok, reason = Reward.Give(aIndex, {
--       { type = "item", section = 14, index = 13, count = 5 },
--       { type = "coins", coin1 = 50 },
--   }, "Achievements")
--
-- Everything is validated before giving anything. If items do not fit in the
-- inventory it returns false, "no_space" (pass allowDrop = true to drop them).
--
-- Types and fields:
--   zen           value
--   points        value, kind = "levelup" | "master"
--   bonus_points  value            (Character.BonusPoints, added again on every reset)
--   coins         coin1, coin2, coin3
--   item          section, index, count, level, durability, skill, luck, option,
--                 excellent, ancient, harmony, op380, socket = {5 values}, time (seconds)
--   exp           value
--   buff          index, minutes, value1, value2
--   ruud          value
--   itembag       value (bag index), count
--   vip           mode (0 same level, 1 upgrade, 2 add days), level, days
--   flag          index, minutes
--   gremory       (same as item) + gremory_type
--   battle_points value
---------------------------------------------------------------------------

Reward = Reward or {}

function Reward.Give(aIndex, rewards, reason, allowDrop)
	return RewardGive(aIndex, rewards, reason or "LuaReward", allowDrop and true or false)
end

function Reward.CheckSpace(aIndex, rewards)
	return RewardCheckSpace(aIndex, rewards)
end
