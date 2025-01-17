local QBCore = exports['qb-core']:GetCoreObject()
local vehNitrous = {}

RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent('tackle:client:GetTackled', playerId)
end)

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(_, cb)
    cb(vehNitrous)
end)

QBCore.Commands.Add('id', 'Check Your ID #', {}, false, function(source)
    TriggerClientEvent('QBCore:Notify', source,  'ID: '..source)
end)

-- QBCore.Functions.CreateUseableItem('harness', function(source, item)-- start jim mechanic
--     TriggerClientEvent('seatbelt:client:UseHarness', source, item)
-- end)

-- RegisterNetEvent('equip:harness', function(item)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)

--     if not Player then return end

--     if not Player.PlayerData.items[item.slot].info.uses then
--         Player.PlayerData.items[item.slot].info.uses = Config.HarnessUses - 1
--         Player.Functions.SetInventory(Player.PlayerData.items)
--     elseif Player.PlayerData.items[item.slot].info.uses == 1 then
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['harness'], 'remove')
--         Player.Functions.RemoveItem('harness', 1)
--     else
--         Player.PlayerData.items[item.slot].info.uses -= 1
--         Player.Functions.SetInventory(Player.PlayerData.items)
--     end
-- end)

-- RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)

--     if not Player then return end

--     if hp == 0 then
--         Player.Functions.RemoveItem('harness', 1, data.slot)
--     else
--         Player.PlayerData.items[data.slot].info.uses -= 1
--         Player.Functions.SetInventory(Player.PlayerData.items)
--     end
-- end)-- end jim mechanic

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if Player.Functions.RemoveMoney('cash', Config.CarWash.defaultPrice, 'car-washed') then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.CarWash.defaultPrice, 'car-washed') then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.dont_have_enough_money'), 'error')
    end
end)

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(_, cb)
    cb(#GetPlayers())
end)