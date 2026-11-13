---------------------------------------------------------------------------
-- Last Man Standing
---------------------------------------------------------------------------

local LMS = EventCore.New({
    Name        = "Last Man Standing",
    Map         = MAP_LORENCIA,
    MapY        = 144,
    MapX        = 127,
    MinPlayers  = 2,
    MaxPlayers  = 20,
    WaitTime    = 60,
    RunTime     = 300,

    OnEnd = function(self, winner)
        if winner ~= -1 and GetObjectConnected(winner) == OBJECT_ONLINE then
            -- Premio: 100 de Coin1
            ObjectAddCoin(winner, 100, 0, 0)
            NoticeSend(winner, 0, "Ganaste 100 coins!")
        end
    end,
})

-- Timer cada segundo
BridgeFunctionAttach("OnTimerThread", "LMS_OnTimerThread")
function LMS_OnTimerThread()
    LMS:OnTick()
end

-- Comando /lms para inscribirse, /lmsstart para GM
BridgeFunctionAttach("OnCommandManager", "LMS_OnCommandManager")
function LMS_OnCommandManager(aIndex, arg)
    if arg == "/lms" then
        LMS:AddPlayer(aIndex)
        return 1
    end
    if arg == "/lmsstart" then
        if GetObjectAuthority(aIndex) > 0 then
            LMS:StartWaiting()
        end
        return 1
    end
    return 0
end

-- Muertes
BridgeFunctionAttach("OnUserDie", "LMS_OnUserDie")
function LMS_OnUserDie(aIndex, bIndex)
    LMS:HandleDie(aIndex, bIndex)
end

-- Desconexiones
BridgeFunctionAttach("OnCharacterClose", "LMS_OnCharacterClose")
function LMS_OnCharacterClose(aIndex)
    LMS:HandleDisconnect(aIndex)
end

-- Control de PK
BridgeFunctionAttach("OnCheckUserKiller", "LMS_OnCheckUserKiller")
function LMS_OnCheckUserKiller(aIndex, bIndex)
    return LMS:HandleCheckKiller(aIndex, bIndex)
end