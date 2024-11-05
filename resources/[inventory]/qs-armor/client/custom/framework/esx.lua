--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

ESX = exports['es_extended']:getSharedObject()

function GetPlayerData()
    return ESX.GetPlayerData()
end

local first = true
RegisterNetEvent('esx:playerLoaded', function()
    if first then
        first = false
        CreateThread(function()
            Wait(1000)
            GetPlayerData(function(PlayerData)
                PlayerJob = PlayerData.job
                SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
                currentarmor = PlayerData.metadata["armor"]
                startedsync = true
                Wait(100)
                if Config.VestTexture then
                    local ped = PlayerPedId()
                    local PlayerData = GetPlayerData()
                    local GetArmor = GetPedArmour(ped)
                    currentVest = GetPedDrawableVariation(ped, 9)
                    currentVestTexture = GetPedTextureVariation(ped, 9)
                    if GetArmor >= 1 then 
                        SetVest()
                    elseif GetArmor >= 51 then
                        SetHeavyVest()
                    end
                end
            end)
        end)
    end
end)

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

function ProgressBar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('progressbar') ~= 'started' then error('progressbar needs to be started in order for Progressbar to work') end
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
                onFinish()
            end
        else
            if onCancel then
                onCancel()
            end
        end
    end)
end