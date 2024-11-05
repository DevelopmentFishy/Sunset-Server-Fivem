local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-stad:server:hasrepair', function(source, cb, what)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money.bank >= Config.repaircost then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-stad:server:hascolor', function(source, cb, what)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money.bank >= Config.costStad then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-stad:server:removemoney', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveMoney("bank", amount, "colorchangestad")
end)
