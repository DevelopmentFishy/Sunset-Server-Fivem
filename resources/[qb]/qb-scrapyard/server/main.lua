local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback('qb-scrapyard:checkOwnerVehicle', function(_, cb, plate)
    local result = MySQL.scalar.await("SELECT `plate` FROM `player_vehicles` WHERE `plate` = ?",{plate})
    if result then
        cb(false)
    else
        cb(true)
    end
end)


RegisterNetEvent('qb-scrapyard:server:ScrapVehicle', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.Vehicles[listKey] ~= nil then
        for _ = 1, math.random(2, 4), 1 do
            local item = Config.Items[math.random(1, #Config.Items)]
            Player.Functions.AddItem(item, math.random(25, 45))
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            Wait(500)
        end
        local Luck = math.random(1, 8)
        local Odd = math.random(1, 8)
        if Luck == Odd then
            local random = math.random(10, 20)
            Player.Functions.AddItem("glass", random)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["glass"], 'add')

        end
    end
end)

function IsInList(name)
    local retval = false
    if Config.Vehicles ~= nil and next(Config.Vehicles) ~= nil then
        for k in pairs(Config.Vehicles) do
            if Config.Vehicles[k] == name then
                retval = true
            end
        end
    end
    return retval
end
