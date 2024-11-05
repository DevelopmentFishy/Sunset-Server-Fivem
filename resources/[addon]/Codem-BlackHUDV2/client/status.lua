speedMultiplier = Config.DefaultSpeedUnit == "kmh" and 3.6 or 2.23694


Citizen.CreateThread(function()
    while true do
        HideHudComponentThisFrame(6) -- VEHICLE_NAME
        HideHudComponentThisFrame(7) -- AREA_NAME
        HideHudComponentThisFrame(8) -- VEHICLE_CLASS
        HideHudComponentThisFrame(9) -- STREET_NAME
        HideHudComponentThisFrame(3) -- CASH
        HideHudComponentThisFrame(4) -- MP_CASH
		HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
		HideHudComponentThisFrame(22) -- 22 : HUD_WEAPONS

		DisplayAmmoThisFrame(false)
        Citizen.Wait(4)

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('codem-blackhudv2:LoadHud')
    Citizen.CreateThread(function()
        loadESXMoneyAndJob()
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('codem-blackhudv2:LoadHud')
end)


Citizen.CreateThread(function()
    WaitPlayer()
    Citizen.Wait(2500)
    while true do
        Citizen.Wait(4000)
        if Config.Framework == "esx" then
            TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
                TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                    local myhunger = hunger.getPercent()
                    local mythirst = thirst.getPercent()
                    SendNUIMessage({
                        type = "set_status",
                        statustype = "hunger",
                        value =  myhunger,
                    })
                    SendNUIMessage({
                        type = "set_status",
                        statustype = "thirst",
                        value =  mythirst,
                    })
                end)
            end)
        else
            local myhunger = frameworkObject.Functions.GetPlayerData().metadata["hunger"]
            local mythirst = frameworkObject.Functions.GetPlayerData().metadata["thirst"]

            SendNUIMessage({
                type = "set_status",
                statustype = "hunger",
                value =  myhunger,
            })
            SendNUIMessage({
                type = "set_status",
                statustype = "thirst",
                value =  mythirst,
            })

        end
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
            SetEntityMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
        end
    end
end)

function LoadRectMinimap(hud)

    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    RequestStreamedTextureDict("squaremap", false)
    while not HasStreamedTextureDictLoaded("squaremap") do
        Wait(150)
    end

    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    -- 0.0 = nav symbol and icons left
    -- 0.1638 = nav symbol and icons stretched
    -- 0.216 = nav symbol and icons raised up
    SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

    -- icons within map
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

    -- -0.01 = map pulled left
    -- 0.025 = map raised up
    -- 0.262 = map stretched
    -- 0.315 = map shorten

    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)

    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(0)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end

function LoadRadialMap(hud)
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(150)
    end
    SetMinimapClipType(1)

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
    -- -0.0100 = nav symbol and icons left
    -- 0.180 = nav symbol and icons stretched
    -- 0.258 = nav symbol and icons raised up
    SetMinimapComponentPosition("minimap", "L", "B", -0.0100 + minimapOffset, -0.030, 0.180, 0.258)

    -- icons within map
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200 + minimapOffset, 0.0, 0.065, 0.20)

    -- -0.00 = map pulled left
    -- 0.015 = map raised up
    -- 0.252 = map stretched
    -- 0.338 = map shorten
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00 + minimapOffset, 0.015, 0.252, 0.338)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(1)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end



Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Citizen.Wait(100)
        SetRadarZoom(1100)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        SetBigmapActive(false, false)
    end
end)


Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        WaitPlayer()
        Citizen.Wait(2500)
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                local myhunger = hunger.getPercent()
                local mythirst = thirst.getPercent()
                SendNUIMessage({
                    type = "set_status",
                    statustype = "hunger",
                    value =  myhunger,
                })
                SendNUIMessage({
                    type = "set_status",
                    statustype = "thirst",
                    value =  mythirst,
                })
            end)
        end)
    else
        WaitPlayer()
        local myhunger = frameworkObject.Functions.GetPlayerData().metadata["hunger"]
        local mythirst = frameworkObject.Functions.GetPlayerData().metadata["thirst"]
        Citizen.Wait(2500)

        SendNUIMessage({
            type = "set_status",
            statustype = "hunger",
            value =  myhunger,
        })
        SendNUIMessage({
            type = "set_status",
            statustype = "thirst",
            value =  mythirst,
        })

    end
    local playerPed = playerPed
    local health = GetEntityHealth(playerPed)
    local val = health-100


    SendNUIMessage({
        type = "set_status",
        statustype = "health",
        value = val,
    })
end)

local lastHealth = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1250)
        local playerPed = playerPed
        local health = GetEntityHealth(playerPed)
        if lastHealth ~= health then
            local val = health-100

            SendNUIMessage({
                type = "set_status",
                statustype = "health",
                value = val,
            })

            lastHealth = health
        end
    end
end)

RegisterNUICallback('ResetHudPositions', function(data, cb)
    local data = {}

    for _, v in pairs(Config.DefaultHudPositions) do
        if type(v) == 'string' and Config.AvaliablePositions[v] then
            data[_] = Config.AvaliablePositions[v]
        end
    end
    TriggerServerEvent('codem-blvckhudv2:UpdateData', "positionsData", data)
    cb("ok")

end)


RegisterNUICallback('hudselected', function(data, cb)
    local hudtype = data.type
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    TriggerServerEvent('codem-blvckhudv2:UpdateData', data.settingstype, data.val)
    if data.settingstype == "hud" then

        if data.val == "radial" then
            local playerPed = playerPed
            local armour = GetPedArmour(playerPed)
            SendNUIMessage({
                type = "armour_update",
                armour = armour,
            })
            if Config.Framework == "esx" then

            else
                local myhunger = frameworkObject.Functions.GetPlayerData().metadata["hunger"]
                local mythirst = frameworkObject.Functions.GetPlayerData().metadata["thirst"]
                SendNUIMessage({
                    type = "set_status",
                    statustype = "hunger",
                    value =  myhunger,
                })
                SendNUIMessage({
                    type = "set_status",
                    statustype = "thirst",
                    value =  mythirst,
                })
            end


            local health = GetEntityHealth(playerPed)
            local val = health-100

            SendNUIMessage({
                type = "set_status",
                statustype = "health",
                value = val,
            })
        end
    end
    cb("ok")

end)