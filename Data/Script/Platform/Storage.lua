---------------------------------------------------------------------------
-- Storage: saves any Lua value per character, per account or global,
-- in the DataServer (table MSPro_LuaStorage, module Scripts\DataServer\Modules\Storage.lua)
--
--   Storage.Load(aIndex, "daily_login", function(data, err) end)            -- character
--   Storage.Load(aIndex, "vault", function(data) end, "account")
--   Storage.Load(nil, "season", function(data) end, "global")
--
--   Storage.Save(aIndex, "daily_login", { day = 3 })
--   Storage.Save(aIndex, "daily_login", nil)                                  -- deletes
--
-- data is nil when nothing was saved yet. The load callback is not called if the
-- player left (or the index now belongs to another character) before the answer.
-- For systems that need their own tables and queries, write a DataServer module instead.
---------------------------------------------------------------------------

Storage = Storage or {}

local SCOPES = { character = 0, account = 1, global = 2 }

local function CheckModule(module)
	if type(module) ~= "string" or not module:match("^[a-z0-9_%.]+$") or #module > 32 then
		error("Storage: invalid module name '" .. tostring(module) .. "' (a-z 0-9 _ . max 32)", 3)
	end
end

local function Owner(aIndex, scope)
	if scope == "global" then
		return ""
	end

	if aIndex == nil or GetObjectConnected(aIndex) ~= 3 then
		return nil
	end

	return (scope == "account") and GetObjectAccount(aIndex) or GetObjectName(aIndex)
end

function Storage.Load(aIndex, module, callback, scope)
	scope = scope or "character"
	CheckModule(module)

	local owner = Owner(aIndex, scope)

	if owner == nil or SCOPES[scope] == nil then
		callback(nil, "offline")
		return
	end

	Net.Request("storage", { op = "load", scope = SCOPES[scope], owner = owner, module = module }, aIndex, function(reply, err)
		if err ~= nil then
			callback(nil, err)
			return
		end

		if scope ~= "global" and Owner(aIndex, scope) ~= owner then
			return
		end

		callback(reply.data, reply.error)
	end)
end

function Storage.Save(aIndex, module, data, scope)
	scope = scope or "character"
	CheckModule(module)

	local owner = Owner(aIndex, scope)

	if owner == nil or SCOPES[scope] == nil then
		return false
	end

	return Net.ToData("storage", { op = "save", scope = SCOPES[scope], owner = owner, module = module, data = data }, aIndex)
end
