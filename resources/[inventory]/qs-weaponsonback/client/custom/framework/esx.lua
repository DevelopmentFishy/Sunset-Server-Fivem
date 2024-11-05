if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Wait(3500)
    ESX.PlayerLoaded = true
end)

function IsPlayerLoaded()
    return ESX.PlayerLoaded
end

function GetPlayerData()
    return ESX.GetPlayerData()
end

function GetInventory()
    return GetPlayerData().inventory
end
