---------------------------------------------------------------------------
-- MSPro Lua Platform - DataServer
--
--   Net.On("storage", function(msg, ctx) ... Net.Reply(ctx, { ok = true }) end)
--   Net.Send(serverIndex, channel, msg, aIndex)   -- message to a GameServer (Net.OnData)
--   Platform.Install("my_module", function() SQL.Exec(...) end)   -- runs on load
--   SQL.Transaction(function() ... end)
--
-- ctx = { server = GameServer index, channel = ..., aIndex = player index or nil, req = request id }
--
-- SQL (C++, parameters only - never build SQL with string concatenation):
--   SQL.Query(sql, ...)   -> list of rows { Column = value } | nil, error
--   SQL.Exec(sql, ...)    -> affected rows | nil, error
--   SQL.Scalar(sql, ...)  -> first value | nil
--   SQL.Binary(string)    -> VARBINARY parameter
-- Parameters: nil, boolean, integer, number, string, SQL.Binary(...)
-- Result types: integers, numbers, strings, binary strings, NULL -> nil
--
-- Pack(value) / Unpack(string): LuaPack serialization (to save Lua tables as VARBINARY)
-- LogPrint(text) / LogError(text): DataServer log
---------------------------------------------------------------------------

Platform = Platform or {}
Platform.Installs = Platform.Installs or {}

function Platform.Log(text)
	LogPrint(tostring(text))
end

function Platform.Error(text)
	LogError(tostring(text))
end

-- Registers a function that creates/updates the tables of a module (runs on every load)
function Platform.Install(name, fn)
	table.insert(Platform.Installs, { name = name, fn = fn })
end

---------------------------------------------------------------------------
-- Net
---------------------------------------------------------------------------

Net = Net or {}
Net.Handlers = Net.Handlers or {}

function Net.On(channel, fn)
	Net.Handlers[channel] = fn
end

function Net.Send(serverIndex, channel, msg, aIndex)
	return NetSend(serverIndex, channel, msg, aIndex)
end

-- Answers a Net.Request of the GameServer
function Net.Reply(ctx, msg)
	msg = msg or {}
	msg._reply = ctx.req
	return NetSend(ctx.server, ctx.channel, msg, ctx.aIndex)
end

-- Called by the DataServer (CLuaData::Dispatch)
function BridgeFunction_OnNetMessage(serverIndex, channel, msg, aIndex)
	local handler = Net.Handlers[channel]

	if handler == nil then
		Platform.Error("no handler for channel " .. channel)
		return
	end

	local ctx = {
		server = serverIndex,
		channel = channel,
		aIndex = aIndex,
		req = (type(msg) == "table") and msg._req or nil,
	}

	local ok, err = pcall(handler, msg, ctx)

	if not ok then
		Platform.Error(string.format("net %s: %s", channel, tostring(err)))

		if ctx.req ~= nil then
			Net.Reply(ctx, { error = "server_error" })
		end
	end
end

---------------------------------------------------------------------------
-- SQL helpers
---------------------------------------------------------------------------

-- Runs fn inside a transaction; rolls back if fn fails
function SQL.Transaction(fn)
	SQL.Begin()

	local ok, err = pcall(fn)

	if ok then
		SQL.Commit()
		return true
	end

	SQL.Rollback()
	Platform.Error("transaction rolled back: " .. tostring(err))
	return false, err
end

---------------------------------------------------------------------------
-- Load / shutdown
---------------------------------------------------------------------------

function BridgeFunction_OnLoad()
	for _, install in ipairs(Platform.Installs) do
		local ok, err = pcall(install.fn)

		if ok then
			Platform.Log("installed " .. install.name)
		else
			Platform.Error("install " .. install.name .. ": " .. tostring(err))
		end
	end
end

function BridgeFunction_OnShutdown()
end
