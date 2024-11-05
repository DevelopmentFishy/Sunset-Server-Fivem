-- all credit for this callback module goes to overextended team (https://github.com/overextended/ox_lib/blob/master/imports/callback/server.lua)
callback = {}
local cbEvent = ("__x-radiolist_cb_%s")

local function callbackResponse(success, result, ...)
	if not success then
		if result then
			return print(("^1SCRIPT ERROR: %s^0\n%s"):format(result , Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString()) or ""))
		end

		return false
	end

	return result, ...
end

local pcall = pcall

---@param name string
---@param cb function
--- Registers an event handler and callback function to respond to client requests.
function callback.register(name, cb)
	RegisterNetEvent(cbEvent:format(name), function(resource, key, ...)
		TriggerClientEvent(cbEvent:format(resource), source, key, callbackResponse(pcall(cb, source, ...)))
	end)
end