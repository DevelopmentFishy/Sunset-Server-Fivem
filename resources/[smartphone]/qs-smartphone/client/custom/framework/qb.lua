--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()
qb_menu_name = 'qb-menu'

CreateThread(function()
    Wait(200)
    TriggerServerEvent('qs-smartphone:server:btShare', false)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local Inventory = PlayerData.items
    HavePhone = HavePhoneQBCore(Inventory)

    LoadPhone()

    TriggerServerEvent('smartphone:playerLoaded')

    TriggerServerCallback('qs-smartphone:GetUserApps', function(apps)
        SendNUIMessage({
            action = 'UpdateApplications',
            JobData = PlayerData.job,
            applications = Config.PhoneApplications
        })
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
    loading = false
    FirstCheckHavePhone = false

    deletePhone()
    deleteMusic()
    UnloadPhone()

    TriggerServerEvent('smartphone:unloaded')
end)

function TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayerDataFramework()
    return QBCore.Functions.GetPlayerData()
end

function GetJobFramework()
    return QBCore.Functions.GetPlayerData().job
end

function GetClosestVehicleFramework()
    return QBCore.Functions.GetClosestVehicle()
end

function GetVehicles()
    return QBCore.Functions.GetVehicles()
end

function GetClosestPlayer()
    return QBCore.Functions.GetClosestPlayer()
end

function Trim(number)
    return QBCore.Shared.Trim(number)
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, false, -1)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        QBCore = exports['qb-core']:GetCoreObject()
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)
