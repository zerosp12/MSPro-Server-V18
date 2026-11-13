-- ============================================
-- BossTopDamage.lua
-- Top 3 HitDamage drop al morir Selupan (459)
-- ============================================

-- Attached to the ScriptCore bridge (defining BridgeFunction_OnMonsterDie
-- directly would replace the dispatcher and break every other script)
function BossTopDamage_OnMonsterDie(aIndex, bIndex)
    if GetObjectClass(aIndex) ~= 459 then return 0 end

    local winners = {}
    for rank = 1, 3 do
        local playerIdx, damage = GetMonsterTopDamager(aIndex, rank)
        if playerIdx >= 0 then
            winners[#winners + 1] = { index = playerIdx, damage = damage, rank = rank }
        end
    end

    if #winners == 0 then return 0 end

    local RANK_BAG_SPECIALVALUE = { 52, 51, 50 }
    local RANK_MSG = {
        "[Selupan] You dealt the most damage! Top reward granted.",
        "[Selupan] 2nd place damage dealer! Great reward granted.",
        "[Selupan] 3rd place damage dealer! Reward granted."
    }

    NoticeColorSendToAll(1, 6, 9, 10, "[Selupan] has been defeated! Rewarding top damage dealers...")

    for _, w in ipairs(winners) do
        local name = GetObjectName(w.index)
        ItemDrop(w.index, GetObjectMap(w.index), GetObjectMapX(w.index), GetObjectMapY(w.index), RANK_BAG_SPECIALVALUE[w.rank])
        MessageSend(w.index, 1, 0, RANK_MSG[w.rank])
        NoticeColorSendToAll(1, 6, 9, 10, string.format("[Selupan] #%d: %s (%d damage)", w.rank, name, w.damage))

        FireworksSend(w.index, -1, -1);
    end

    return 1
end

BridgeFunctionAttach("OnMonsterDie", "BossTopDamage_OnMonsterDie")
