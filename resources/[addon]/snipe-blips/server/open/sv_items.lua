CreateThread(function()
    if Config.TrackerItems.enabled then
        if Config.Core == "QBCore" then
            QBCore.Functions.CreateUseableItem(Config.TrackerItems.jobItemName, function(source, item)
                lib.callback.await("snipe-blips:client:UseTrackerItem", source)
            end)

            QBCore.Functions.CreateUseableItem(Config.TrackerItems.gangItemName, function(source, item)
                lib.callback.await("snipe-blips:client:UseTrackerItemGang", source)
            end)
        elseif Config.Core == "ESX" then
            ESX.RegisterUsableItem(Config.TrackerItems.jobItemName, function(source, item)
                lib.callback.await("snipe-blips:client:UseTrackerItem", source)
            end)

            ESX.RegisterUsableItem(Config.TrackerItems.gangItemName, function(source, item)
                lib.callback.await("snipe-blips:client:UseTrackerItemGang", source)
            end)
        end
    end
end)

RegisterServerEvent("snipe-blips:server:trackerRemoved", function(group, coords)
    local source = source
    if Config.GroupJobs[group] then
        for k, v in pairs(Config.GroupJobs[group]) do
            if Config.Blips[v] then
                TriggerClientEvent("snipe-blips:client:trackerRemoved", -1, v, true, coords, source, playerNames[source])
            else
                TriggerClientEvent("snipe-blips:client:trackerRemoved", -1, v, false, coords, source, playerNames[source])
            end
        end
    else
        if Config.Blips[group] then
            TriggerClientEvent("snipe-blips:client:trackerRemoved", -1, group, true, coords, source, playerNames[source])
        else
            TriggerClientEvent("snipe-blips:client:trackerRemoved", -1, group, false, coords, source, playerNames[source])
        end
    end
end)