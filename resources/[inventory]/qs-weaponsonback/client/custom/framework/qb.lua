if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(3500)
    LocalPlayer.state:set('isLoggedIn', true, false)
end)

function IsPlayerLoaded()
    return LocalPlayer.state['isLoggedIn']
end

function GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

function GetInventory()
    return GetPlayerData().items
end
