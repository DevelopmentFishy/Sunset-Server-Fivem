if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

function TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)


function PlayerIdForStash(id)
    id = QBCore.Functions.GetPlayerData().citizenid 
    return id
end

function CheckPlayerJobName()
    return PlayerData.job
end

function CheckPlayerJobGrade()
    return PlayerData.job.grade.level
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
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
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
        QBCore = exports['qb-core']:GetCoreObject()
        PlayerData = QBCore.Functions.GetPlayerData()
    end
  end)