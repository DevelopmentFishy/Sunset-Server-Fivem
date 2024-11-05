local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-paleto:server:hasrepair', function(source, cb, what)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money.bank >= Config.repaircost then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-paleto:server:hascolor', function(source, cb, what)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money.bank >= Config.costPaleto then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-paleto:server:removemoney', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveMoney("bank", amount, "colorchangepaleto")
end)
