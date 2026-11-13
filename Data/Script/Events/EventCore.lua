---------------------------------------------------------------------------
-- EventCore - Sistema base de eventos
---------------------------------------------------------------------------

EventCore = {}
EventCore.__index = EventCore

function EventCore.New(config)
    local self = setmetatable({}, EventCore)
    
    self.Name       = config.Name       or "Evento"
    self.Map        = config.Map        or MAP_ARENA
    self.MapX       = config.MapX       or 135
    self.MapY       = config.MapY       or 135
    self.MinPlayers = config.MinPlayers or 2
    self.MaxPlayers = config.MaxPlayers or 20
    self.WaitTime   = config.WaitTime   or 60    -- segundos para inscripcion
    self.RunTime    = config.RunTime    or 300   -- segundos max del evento

    self.State      = "IDLE"
    self.Timer      = 0
    self.Players    = {}  -- [aIndex] = true
    self.Winner     = -1

    self.OnStart    = config.OnStart    or nil   -- callback
    self.OnEnd      = config.OnEnd      or nil   -- callback
    self.OnDie      = config.OnDie      or nil   -- callback(aIndex, bIndex)
    self.OnCheck    = config.OnCheck    or nil   -- callback(aIndex, bIndex) retorna 0 o 1

    return self
end

function EventCore:IsPlayer(aIndex)
    return self.Players[aIndex] == true
end

function EventCore:PlayerCount()
    local count = 0
    for _ in pairs(self.Players) do count = count + 1 end
    return count
end

function EventCore:AddPlayer(aIndex)
    if self.State ~= "WAITING" then
        NoticeSend(aIndex, 0, "["..self.Name.."] No hay inscripcion abierta.")
        return
    end
    if self:IsPlayer(aIndex) then
        NoticeSend(aIndex, 0, "["..self.Name.."] Ya estas inscripto.")
        return
    end
    if self:PlayerCount() >= self.MaxPlayers then
        NoticeSend(aIndex, 0, "["..self.Name.."] El evento esta lleno.")
        return
    end
    self.Players[aIndex] = true
    NoticeSend(aIndex, 0, "["..self.Name.."] Te inscribiste! Jugadores: "..self:PlayerCount().."/"..self.MaxPlayers)
end

function EventCore:RemovePlayer(aIndex)
    self.Players[aIndex] = nil
end

function EventCore:Announce(msg)
    NoticeSendToAll(0, "["..self.Name.."] "..msg)
end

function EventCore:StartWaiting()
    if self.State ~= "IDLE" then return end
    self.State = "WAITING"
    self.Timer = self.WaitTime
    self.Players = {}
    self.Winner = -1
    self:Announce("Inscripcion abierta! Tienes "..self.WaitTime.." segundos para unirte.")
end

function EventCore:StartEvent()
    if self:PlayerCount() < self.MinPlayers then
        self:Announce("No hay suficientes jugadores ("..self:PlayerCount().."/"..self.MinPlayers.."). Cancelado.")
        self.State = "IDLE"
        self.Players = {}
        return
    end

    self.State = "RUNNING"
    self.Timer = self.RunTime

    -- Mover a todos al mapa del evento
    for aIndex in pairs(self.Players) do
        if GetObjectConnected(aIndex) == OBJECT_ONLINE then
            MoveUserEx(aIndex, self.Map, self.MapX, self.MapY)
        else
            self:RemovePlayer(aIndex)
        end
    end

    self:Announce("Inicio! Jugadores: "..self:PlayerCount()..". Duracion: "..self.RunTime.." segundos.")

    if self.OnStart then self.OnStart(self) end
end

function EventCore:EndEvent(winnerIndex)
    if self.State ~= "RUNNING" then return end

    self.Winner = winnerIndex or -1
    self.State = "IDLE"

    if self.Winner ~= -1 and GetObjectConnected(self.Winner) == OBJECT_ONLINE then
        self:Announce("Ganador: "..GetObjectName(self.Winner).."!")
    else
        self:Announce("El evento termino sin ganador.")
    end

    if self.OnEnd then self.OnEnd(self, self.Winner) end

    self.Players = {}
    self.Timer = 0
end

function EventCore:OnTick()
    if self.State == "IDLE" then return end

    self.Timer = self.Timer - 1

    if self.State == "WAITING" then
        if self.Timer == 30 then
            self:Announce("30 segundos para el cierre de inscripcion. Jugadores: "..self:PlayerCount())
        elseif self.Timer == 10 then
            self:Announce("10 segundos para el cierre de inscripcion.")
        elseif self.Timer <= 0 then
            self:StartEvent()
        end

    elseif self.State == "RUNNING" then
        if self.Timer == 60 then
            self:Announce("1 minuto restante!")
        elseif self.Timer == 30 then
            self:Announce("30 segundos restantes!")
        elseif self.Timer <= 0 then
            self:EndEvent(-1)
        end
    end
end

function EventCore:HandleDie(aIndex, bIndex)
    if self.State ~= "RUNNING" then return end
    if not self:IsPlayer(aIndex) then return end

    self:RemovePlayer(aIndex)

    if self.OnDie then self.OnDie(self, aIndex, bIndex) end

    local count = self:PlayerCount()

    if count == 1 then
        for idx in pairs(self.Players) do
            self:EndEvent(idx)
            return
        end
    elseif count == 0 then
        self:EndEvent(-1)
    end
end

function EventCore:HandleDisconnect(aIndex)
    if not self:IsPlayer(aIndex) then return end
    self:RemovePlayer(aIndex)
    if self.State == "RUNNING" then
        if self:PlayerCount() == 1 then
            for idx in pairs(self.Players) do
                self:EndEvent(idx)
                return
            end
        end
    end
end

function EventCore:HandleCheckKiller(aIndex, bIndex)
    if self.State ~= "RUNNING" then return 1 end
    if self.OnCheck then return self.OnCheck(self, aIndex, bIndex) end
    -- Por defecto: PK solo entre participantes
    if self:IsPlayer(aIndex) and self:IsPlayer(bIndex) then return 1 end
    return 0
end