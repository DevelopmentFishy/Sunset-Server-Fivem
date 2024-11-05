if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    local legacyEsx = pcall(function()
        ESX = exports['es_extended']:getSharedObject()
    end)
    Citizen.Wait(0)
    if legacyEsx then return end
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end  
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function PlayerIdForStash(id)
    id = ESX.GetPlayerData().identifier 
    return id
end

function CheckPlayerJobName()
	return ESX.PlayerData.job
end

function CheckPlayerJobGrade()
    return ESX.PlayerData.job.grade
end

function ItemsInfo(items)
    for k, v in pairs(items) do
        if v.name == 'backpack' then
            local info = {
                bagid = math.random(111111,999999)
            }
            items[k].info = info
        elseif v.name == 'game_ticket' then
            local info = {
                type = "game_ticket",
                cardnumber = math.random(1111,9999),
            }
            items[k].info = info
            end
        end
    return items
end

function SendTextMessage(msg, type)
    if type == 'inform' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'error' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'success' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() == resourceName) then
        ESX = exports['es_extended']:getSharedObject()
        ESX.PlayerData = ESX.GetPlayerData()
  end
end)