---------------------------------------------------------------------------
-- Net: messages by channel between the client (mspro.net) and GameServer Lua
--
--   Net.On("shop", function(aIndex, msg) end)     -- one handler per channel
--   Net.Send(aIndex, "shop", { ok = true })        -- any Lua table/value
--   Net.Broadcast("shop", { event = "sale" })
--   Net.Config(20, 64000)                          -- messages/second, max size
--
-- Channel names: a-z 0-9 _ . (max 32). Messages are serialized with LuaPack,
-- split in 4 KB fragments and rate limited per player by the GameServer.
-- The client can only use channels declared in its script metadata.
-- HackPacketCheck.txt must allow head 250 (0xFA) without encryption.
---------------------------------------------------------------------------

Net = Net or {}
Net.Handlers = Net.Handlers or {}

function Net.On(channel, fn)
	if type(fn) ~= "function" then
		error("Net.On: handler must be a function", 2)
	end

	Net.Handlers[channel] = fn
end

function Net.Off(channel)
	Net.Handlers[channel] = nil
end

function Net.Send(aIndex, channel, msg)
	return NetSend(aIndex, channel, msg)
end

function Net.Broadcast(channel, msg)
	return NetBroadcast(channel, msg)
end

function Net.Config(rate, maxSize)
	NetConfig(rate, maxSize)
end

---------------------------------------------------------------------------
-- DataServer Lua (Scripts\DataServer)
--
--   Net.ToData("storage", { op = "save", ... }, aIndex)       -- aIndex optional
--   Net.OnData("ranking", function(msg, aIndex) end)            -- messages sent by the DataServer
--   Net.Request("storage", { op = "load" }, aIndex, function(reply, err) end, 15)
--   Net.ReloadData()                                            -- reloads the DataServer scripts
--
-- Net.Request adds msg._req; the DataServer answers with Net.Reply(ctx, msg).
-- The callback receives (nil, "timeout") if there is no answer in time.
---------------------------------------------------------------------------

Net.DataHandlers = Net.DataHandlers or {}
Net.Pending = Net.Pending or {}
Net.NextRequest = Net.NextRequest or 0

function Net.ToData(channel, msg, aIndex)
	return NetSendData(channel, msg, aIndex)
end

function Net.OnData(channel, fn)
	Net.DataHandlers[channel] = fn
end

function Net.ReloadData()
	NetDataReload()
end

function Net.Request(channel, msg, aIndex, callback, timeout)
	Net.NextRequest = (Net.NextRequest % 2000000000) + 1

	local id = Net.NextRequest
	msg._req = id
	Net.Pending[id] = { callback = callback, expire = os.time() + (timeout or 15), channel = channel }

	if not NetSendData(channel, msg, aIndex) then
		Net.Pending[id] = nil
		callback(nil, "send_failed")
		return false
	end

	return true
end

local function RunCallback(entry, reply, err)
	local ok, e = pcall(entry.callback, reply, err)

	if not ok then
		Platform.Log(string.format("Net request %s: %s", entry.channel, tostring(e)))
	end
end

-- Called by the GameServer (CScriptLoader::OnDataMessage)
function BridgeFunction_OnDataMessage(channel, msg, aIndex)
	if type(msg) == "table" and msg._reply ~= nil then
		local entry = Net.Pending[msg._reply]

		if entry ~= nil then
			Net.Pending[msg._reply] = nil
			RunCallback(entry, msg, nil)
		end

		return
	end

	local handler = Net.DataHandlers[channel]

	if handler == nil then
		return
	end

	local ok, err = pcall(handler, msg, aIndex)

	if not ok then
		Platform.Log(string.format("Net data %s: %s", channel, tostring(err)))
	end
end

Events.Off("Platform.Net")

Events.On("Timer", function()
	local now = os.time()

	for id, entry in pairs(Net.Pending) do
		if now >= entry.expire then
			Net.Pending[id] = nil
			RunCallback(entry, nil, "timeout")
		end
	end
end, "Platform.Net")

-- Called by the GameServer (CScriptLoader::OnNetMessage)
function BridgeFunction_OnNetMessage(aIndex, channel, msg)
	local handler = Net.Handlers[channel]

	if handler == nil then
		return
	end

	local ok, err = pcall(handler, aIndex, msg)

	if not ok then
		Platform.Log(string.format("Net %s from %d: %s", channel, aIndex, tostring(err)))
	end
end
