-- all credit for this callback module goes to overextended team (https://github.com/overextended/ox_lib/blob/master/imports/callback/client.lua)
callback = {}
local events = {}
local timers = {}
local cbEvent = ("__x-radiolist_cb_%s")

RegisterNetEvent(cbEvent:format(Shared.currentResourceName), function(key, ...)
    local cb = events[key]
    return cb and cb(...)
end)

---@param event string
---@param delay number | false prevent the event from being called for the given time
local function eventTimer(event, delay)
    if delay and type(delay) == "number" and delay > 0 then
        local time = GetGameTimer()

        if (timers[event] or 0) > time then
            return false
        end

        timers[event] = time + delay
    end

    return true
end

---@param _ any
---@param event string
---@param delay number | false
---@param cb function|false
---@param ... any
---@return ...
local function triggerServerCallback(_, event, delay, cb, ...)
    if not eventTimer(event, delay) then return end

    local key

    repeat
        key = ("%s:%s"):format(event, math.random(0, 100000))
    until not events[key]

    TriggerServerEvent(cbEvent:format(event), Shared.currentResourceName, key, ...)

    ---@type promise | false
    local promise = not cb and promise.new()

    events[key] = function(response, ...)
        response = { response, ... }
        events[key] = nil

        if promise then
            return promise:resolve(response)
        end

        if cb then
            cb(table.unpack(response))
        end
    end

    if promise then
        return table.unpack(Citizen.Await(promise))
    end
end

---@overload fun(event: string, delay: number | false, cb: function, ...)
callback = setmetatable({}, {
    __call = triggerServerCallback
})

---@param event string
---@param delay number | false prevent the event from being called for the given time
--- Sends an event to the server and halts the current thread until a response is returned.
function callback.await(event, delay, ...)
    return triggerServerCallback(nil, event, delay, false, ...)
end