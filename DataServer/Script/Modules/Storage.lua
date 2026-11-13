---------------------------------------------------------------------------
-- Storage: key-value storage of Lua values for simple systems
-- (GameServer side: Scripts\GameServer\Platform\Storage.lua)
--
-- Table MSPro_LuaStorage (created automatically):
--   Scope  0 character (Owner = name), 1 account (Owner = account), 2 global (Owner = '')
--   Data   LuaPack of the saved value
---------------------------------------------------------------------------

Platform.Install("storage", function()
	local ok, err = SQL.Exec([[
		IF OBJECT_ID('MSPro_LuaStorage') IS NULL
		CREATE TABLE MSPro_LuaStorage (
			Scope   tinyint        NOT NULL,
			Owner   varchar(32)    NOT NULL,
			Module  varchar(32)    NOT NULL,
			Data    varbinary(max) NULL,
			Updated datetime       NOT NULL DEFAULT GETDATE(),
			CONSTRAINT PK_MSPro_LuaStorage PRIMARY KEY (Scope, Owner, Module)
		)
	]])

	if ok == nil then
		error(err)
	end
end)

local function Valid(msg)
	return type(msg.scope) == "number" and msg.scope >= 0 and msg.scope <= 2
		and type(msg.owner) == "string" and #msg.owner <= 32
		and type(msg.module) == "string" and msg.module:match("^[a-z0-9_%.]+$") and #msg.module <= 32
end

Net.On("storage", function(msg, ctx)
	if type(msg) ~= "table" or not Valid(msg) then
		if ctx.req then Net.Reply(ctx, { error = "invalid" }) end
		return
	end

	if msg.op == "load" then
		local data, err = SQL.Scalar("SELECT Data FROM MSPro_LuaStorage WHERE Scope = ? AND Owner = ? AND Module = ?", msg.scope, msg.owner, msg.module)

		if err ~= nil then
			Net.Reply(ctx, { error = "sql" })
			return
		end

		local value = nil

		if data ~= nil then
			value, err = Unpack(data)

			if err ~= nil then
				Platform.Error(string.format("storage %s/%s: corrupted data (%s)", msg.owner, msg.module, err))
			end
		end

		Net.Reply(ctx, { data = value })
	elseif msg.op == "save" then
		if msg.data == nil then
			SQL.Exec("DELETE FROM MSPro_LuaStorage WHERE Scope = ? AND Owner = ? AND Module = ?", msg.scope, msg.owner, msg.module)
			return
		end

		local blob = SQL.Binary(Pack(msg.data))
		local rows = SQL.Exec("UPDATE MSPro_LuaStorage SET Data = ?, Updated = GETDATE() WHERE Scope = ? AND Owner = ? AND Module = ?", blob, msg.scope, msg.owner, msg.module)

		if rows == 0 then
			SQL.Exec("INSERT INTO MSPro_LuaStorage (Scope, Owner, Module, Data) VALUES (?, ?, ?, ?)", msg.scope, msg.owner, msg.module, blob)
		end
	end
end)
