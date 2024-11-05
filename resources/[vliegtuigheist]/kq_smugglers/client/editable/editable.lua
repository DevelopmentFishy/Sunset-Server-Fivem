-- This function is responsible for drawing all the 3d texts ('Press [E] to ...' e.g)
function Draw3DText(x, y, z, textInput, fontId, scaleY)
    local scaleX = scaleY
    
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 25
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = (scale * fov) * Config.fontScale
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentSubstringKeyboardDisplay(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

RegisterNetEvent('kq_smugglers:client:showTooltip')
AddEventHandler('kq_smugglers:client:showTooltip', function(message)
    ShowTooltip(message)
end)

function PlayAnim(dict, anim, flag, duration)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(50)
            timeout = timeout + 1
            if timeout > 100 then
                return
            end
        end
        TaskPlayAnim(PlayerPedId(), dict, anim, 1.5, 1.0, duration or -1, flag or 1, 0, false, false, false)
        RemoveAnimDict(dict)
    end)
end



function CreateEstimatedAreaBlip(coords)
    Citizen.CreateThread(function()
        local blipData = Config.crash.blip
        local blip = AddBlipForCoord(coords)
        
        SetBlipSprite(blip, blipData.sprite)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, blipData.color)
        SetBlipAlpha(blip, 255)
        SetBlipScale(blip, blipData.scale)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(blipData.label)
        EndTextCommandSetBlipName(blip)
        SetBlipAsShortRange(blip, false)
    
        local radar = nil
        if blipData.showRadar then
            radar = AddBlipForCoord(coords)
    
            SetBlipSprite(radar, 161)
            SetBlipHighDetail(radar, true)
            SetBlipColour(radar, blipData.color)
            SetBlipAlpha(radar, 255)
            SetBlipScale(radar, blipData.scale * 1.5)
            BeginTextCommandSetBlipName('STRING')
            SetBlipHiddenOnLegend(radar, true)
            AddTextComponentString(blipData.label)
            EndTextCommandSetBlipName(radar)
            SetBlipAsShortRange(radar, false)
        end
        
        RealWait(Config.planeTimeout * 60000)
        
        RemoveBlip(blip)
        if radar ~= nil then
            RemoveBlip(radar)
        end
    end)
end

function KeyboardInput(TextEntry, DefaultText, MaxStringLength)
    AddTextEntry('KQ_SMUGGLERS_INPUT', TextEntry)
    DisplayOnscreenKeyboard(1, 'KQ_SMUGGLERS_INPUT', '', DefaultText, '', '', '', MaxStringLength)
    
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Citizen.Wait(1);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    
    return nil
end

function IsPlayerUnreachable()
    local playerPed = PlayerPedId()
    return IsPedInAnyVehicle(playerPed) or IsPedRagdoll(playerPed) or IsEntityDead(playerPed)
end


function SendCrashSoonMessage(message, subtitle)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    
    -- Set the notification icon, title and subtitle.
    local title = L('FIREWALL BR34KR')
    local iconType = 0
    local flash = false
    EndTextCommandThefeedPostMessagetext('CHAR_BLOCKED', 'CHAR_BLOCKED', flash, iconType, title, subtitle)
    
    -- Draw the notification
    local showInBrief = true
    local blink = false
    EndTextCommandThefeedPostTicker(blink, showInBrief)
end

----------------------
--- Hook functions ---
----------------------
--- DO NOT REMOVE THESE ---

function OnAtcScanComplete(scanData)

end

function OnHackingStart()

end

function OnHackingFailure()

end

function OnHackingSuccess()

end

function OnHeistTrigger(estLandingLocation)

end
