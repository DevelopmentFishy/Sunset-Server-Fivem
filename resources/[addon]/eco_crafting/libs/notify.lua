-- OPTIONS:

-- text = message
-- texType: success, error, warning, info, etc...
-- length: display time in ms

-- position: Accepted positions: Left, Right, Top
-- drawText('message','position') = Persistent message e.g.: 'Use Cooking workstation: E'
-- hideText() = hide Persistent message

-- don't forget to set the server side as well, many messages come from there!

interface = {}
interface.client = {}
interface.client.progressbar = {}

interface.server = {}

-----------------------------------
----------- CLIENT SIDE -----------
-----------------------------------

function interface.client.notify(text, texType, length)

    --TriggerEvent('QBCore:Notify', text, texType, length)
    QBCore.Functions.Notify(text, texType, length) -- CHANGE ME
end

function interface.client.drawText (message, position) -- Persistent message e.g.: 'Use Cooking workstation: E'

    TriggerEvent('qb-core:client:DrawText', message, position) -- CHANGE ME
end

function interface.client.hideText() -- hide Persistent message

    TriggerEvent('qb-core:client:HideText') -- CHANGE ME
end

function interface.client.progressbar.add(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)

    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
                onFinish()
            end
        else
            if onCancel then
                onCancel()
            end
        end
    end)
end

function interface.client.progressbar.cancel()

    TriggerEvent("progressbar:client:cancel")
end


-----------------------------------
----------- SERVER SIDE -----------
-----------------------------------

function interface.server.notify(targetId, text, texType, length)

    TriggerClientEvent('QBCore:Notify', targetId, text, texType, length) -- CHANGE ME
end

function interface.server.drawText(targetId, message, position)

    TriggerClientEvent('qb-core:client:DrawText', targetId, message, position) -- CHANGE ME
end

function interface.server.hideText(targetId)

    TriggerClientEvent('qb-core:client:HideText', targetId) -- CHANGE ME
end