---------------------------------------------------------------------------
-- Bonus: permanent stat bonuses, applied in the character calculation
-- (same place as custom pets and mounts)
--
--   Bonus.Set(aIndex, "achievements", { damage = 20, exp_rate = 3 })
--   Bonus.Clear(aIndex, "achievements")
--
-- Each module uses its own key; the bonuses of every key are added together.
-- Bonuses are not saved: modules set them again on CharacterEntry.
--
-- Options:
--   str, agi, vit, ene, cmd
--   damage, attack_speed, double_damage, triple_damage, exp_rate
--   add_life, add_mana
--   resist_double, resist_ignore_def, resist_ignore_sd,
--   resist_critical, resist_excellent, resist_stun
---------------------------------------------------------------------------

Bonus = Bonus or {}

function Bonus.Set(aIndex, key, values)
	BonusSet(aIndex, key, values)
end

function Bonus.Clear(aIndex, key)
	BonusClear(aIndex, key)
end

-- Maximum total per option for all modules together (0 = no cap)
function Bonus.SetCaps(caps)
	for option, value in pairs(caps) do
		BonusSetCap(option, value)
	end
end

-- Adds every value of b into a (helper to combine several sources)
function Bonus.Add(a, b)
	for option, value in pairs(b or {}) do
		a[option] = (a[option] or 0) + value
	end

	return a
end
