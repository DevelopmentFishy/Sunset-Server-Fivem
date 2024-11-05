local saveRequest

-- Triggered by a successful placement event
AddEventHandler('eco_crafting:addedWorkstation', function(workstationParams, usableItemName, ownerId)

    saveRequest = true
end)


-- Triggered by a successful removal event
AddEventHandler('eco_crafting:removedWorkstation', function(workstationId, requesterId)

    saveRequest = true
end)


-- If you want to save immediately, insert the 'savePortableWS()' function into the event handlers
-- ('eco_crafting:removedWorkstation', 'eco_crafting:addedWorkstation'), and other parts of the script can be commented

-- The portable data loading is done by the functions.lua/loadPortableWS() function


local function scheduledSave()

    SetTimeout(60000, function()

        if saveRequest then

            saveRequest = false
            savePortableWS()
        end

        scheduledSave()
    end)
end

if Config.savePortableWorkstations then

    scheduledSave()
end


RegisterServerEvent('txAdmin:events:scheduledRestart', function(eventData)

    if eventData.secondsRemaining == 60 then

        CreateThread(function()
            Wait(45000)

            if saveRequest then

                saveRequest = false
                savePortableWS()
            end
        end)
    else

        if saveRequest then

            saveRequest = false
            savePortableWS()
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)

    if saveRequest and GetCurrentResourceName() == resourceName then

        saveRequest = false
        savePortableWS()
    end
end)