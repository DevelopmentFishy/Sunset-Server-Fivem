print("^1Reworked by ^2Fishy ^5(Sunset Scripts)")
local QBCore = exports['qb-core']:GetCoreObject()

local queued = false

local areaZone = nil
local areaBlip = nil
local blipOffset = 150.0

local chopVehicle = 0

local dropOffZone = nil
local dropOffBlip = nil

local vehMods = { -- You can add more here
    0, -- Spoiler
    1, -- Front Bumper
    2, -- Rear Bumper
    3, -- Skirt
    4, -- Exhaust
    5, -- Chassis
    6, -- Grill
    7, -- Bonnet
    8, -- Wing L
    9, -- Wing R
    10, -- Roof
    22 -- Xenon Lights
}

--- Loads an animation dictionary
--- @param dict string - Animation dictionary
--- @return nil
local LoadAnimationDict = function(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
end

--- Performs the animation of chopping a vehicle and deletes the vehicle
--- @param veh object - Vehicle object
--- @return nil
local ChopVehicle = function(veh)
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    local vehCo = GetEntityCoords(veh, false)

    -- Ped steps out of the vehicle
    TaskLeaveVehicle(ped, veh, 258)
    FreezeEntityPosition(veh, true)
    Wait(1500)

    -- Front Left Door
    if not IsVehicleDoorDamaged(veh, 0) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'door_dside_f'))
        SetVehicleDoorOpen(veh, 0, false, true)
        SetEntityCoords(ped, coords.x, coords.y, coords.z-1.0)
        SetEntityHeading(ped, heading-45.0)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
        Wait(14000)
        SetVehicleDoorBroken(veh, 0, true)
        TriggerServerEvent('qb-chopshop:server:Reward', 'door')
        ClearPedTasks(ped)
    end

    -- Rear Left Door
    if GetVehicleMaxNumberOfPassengers(veh) > 1 and not IsVehicleDoorDamaged(veh, 2) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'door_dside_r'))
        SetVehicleDoorOpen(veh, 2, false, true)
        SetEntityCoords(ped, coords.x, coords.y, coords.z-1.0)
        SetEntityHeading(ped, heading-45.0)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
        Wait(14000)
        SetVehicleDoorBroken(veh, 2, true)
        TriggerServerEvent('qb-chopshop:server:Reward', 'door')
        ClearPedTasks(ped)
    end

    -- Trunk
    if not IsVehicleDoorDamaged(veh, 5) then
        if GetEntityBoneIndexByName(veh, 'boot') ~= -1 then
            local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'boot'))
            local offSet = GetOffsetFromEntityInWorldCoords(veh, 0.0, -1.25, 0.0)
            local dif = offSet-vehCo
            local animCo = coords+dif
            SetVehicleDoorOpen(veh, 5, false, true)
            SetEntityCoords(ped, animCo.x, animCo.y, coords.z-1.0)
            SetEntityHeading(ped, heading)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
            Wait(14000)
            SetVehicleDoorBroken(veh, 5, true)
            TriggerServerEvent('qb-chopshop:server:Reward', 'trunk')
            ClearPedTasks(ped)
        end
    end

    -- Rear Right door
    if GetVehicleMaxNumberOfPassengers(veh) > 1 and not IsVehicleDoorDamaged(veh, 3) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'door_pside_r'))
        SetVehicleDoorOpen(veh, 3, false, true)
        SetEntityCoords(ped, coords.x, coords.y, coords.z-1.0)
        SetEntityHeading(ped, heading+45.0)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
        Wait(14000)
        SetVehicleDoorBroken(veh, 3, true)
        TriggerServerEvent('qb-chopshop:server:Reward', 'door')
        ClearPedTasks(ped)
    end

    -- Passenger door
    if not IsVehicleDoorDamaged(veh, 1) then
        SetVehicleDoorOpen(veh, 1, false, true)
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'door_pside_f'))
        SetEntityCoords(ped, coords.x, coords.y, coords.z-1.0)
        SetEntityHeading(ped, heading+45.0)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
        Wait(14000)
        SetVehicleDoorBroken(veh, 1, true)
        TriggerServerEvent('qb-chopshop:server:Reward', 'door')
        ClearPedTasks(ped)
    end

    -- Bonnet
    if not IsVehicleDoorDamaged(veh, 4) then
        if GetEntityBoneIndexByName(veh, 'boot') ~= -1 then
            SetVehicleDoorOpen(veh, 4, false, true)
            local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'boot'))
            SetEntityCoords(ped, coords.x, coords.y, coords.z-1.0)
            SetEntityHeading(ped, heading-180.00+45.0) -- quick mafs
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
            Wait(14000)
            SetVehicleDoorBroken(veh, 4, true)
            TriggerServerEvent('qb-chopshop:server:Reward', 'hood')
            ClearPedTasks(ped)
        end
    end

    -- Front Left Wheel
    if not IsVehicleTyreBurst(veh, 0, true) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'wheel_lf'))
        local offSet = GetOffsetFromEntityInWorldCoords(veh, -1.0, 0.0, 0.0)
        local dif = offSet-vehCo
        local animCo = coords+dif
        SetEntityCoords(ped, animCo.x, animCo.y, coords.z-1.0)
        SetEntityHeading(ped, heading-90.00)
        LoadAnimationDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, -8.0, -1, 1, 0, 0, 0, 0)
        Wait(10000)
        SetVehicleTyreBurst(veh, 0, true, 1000.0)
        TriggerServerEvent('qb-chopshop:server:Reward', 'wheel')
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.5)
    end

    -- Rear Left Wheel
    if not IsVehicleTyreBurst(veh, 4, true) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'wheel_lr'))
        local offSet = GetOffsetFromEntityInWorldCoords(veh, -1.0, 0.0, 0.0)
        local dif = offSet-vehCo
        local animCo = coords+dif
        SetEntityCoords(ped, animCo.x, animCo.y, coords.z-1.0)
        SetEntityHeading(ped, heading-90.00)
        LoadAnimationDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, -8.0, -1, 1, 0, 0, 0, 0)
        Wait(10000)
        SetVehicleTyreBurst(veh, 4, true, 1000.0)
        TriggerServerEvent('qb-chopshop:server:Reward', 'wheel')
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.5)
    end

    -- Rear Right Wheel
    if not IsVehicleTyreBurst(veh, 5, true) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'wheel_rr'))
        local offSet = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 0.0)
        local dif = offSet-vehCo
        local animCo = coords+dif
        SetEntityCoords(ped, animCo.x, animCo.y, coords.z-1.0)
        SetEntityHeading(ped, heading+90.00)
        LoadAnimationDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, -8.0, -1, 1, 0, 0, 0, 0)
        Wait(10000)
        SetVehicleTyreBurst(veh, 5, true, 1000.0)
        TriggerServerEvent('qb-chopshop:server:Reward', 'wheel')
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.5)
    end

    -- Front Right Wheel
    if not IsVehicleTyreBurst(veh, 1, true) then
        local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, 'wheel_rf'))
        local offSet = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 0.0)
        local dif = offSet-vehCo
        local animCo = coords+dif
        SetEntityCoords(ped, animCo.x, animCo.y, coords.z-1.0)
        SetEntityHeading(ped, heading+90.00)
        LoadAnimationDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, -8.0, -1, 1, 0, 0, 0, 0)
        Wait(10000)
        SetVehicleTyreBurst(veh, 1, true, 1000.0)
        TriggerServerEvent('qb-chopshop:server:Reward', 'wheel')
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.5)
    end

    -- Finishing up
    QBCore.Functions.Notify("Je bent klaar! Kom terug als je nog een job wilt!", "primary", 8300)


    -- Cash reward
    TriggerServerEvent('qb-chopshop:server:Reward', 'cash')

    -- Delete Vehicle
    chopVehicle = 0
    Wait(5000)
    NetworkFadeOutEntity(veh, true, false)
    Wait(2000)
    local netId = NetworkGetNetworkIdFromEntity(veh)
    TriggerServerEvent("qb-chopshop:server:DeleteVehicle", netId)
end

--- Alerts the police - Change this to whatever police alert script you use, ProjectSloth qb-dispatch by default
--- @param veh object - Vehicle object
--- @return nil
local AlertPolice = function(veh)
    exports['ps-dispatch']:CarJacking(veh) -- Project-SLoth qb-dispatch
    --TriggerServerEvent('police:server:policeAlert', 'Vehicle Theft') -- Regular QBCore
end

--- Creates a randomly off-set blip radius for given coordinates
--- @param coords vec3 - Coordinates of a location
--- @return blip object - Off-set blip radius
local CreateAreaBlip = function(coords)
    local offsetSign = math.random(-100, 100)/100
    local blip = AddBlipForRadius(coords.x + (offsetSign*blipOffset), coords.y + (offsetSign*blipOffset), coords.z + (offsetSign*blipOffset), 250.00)
    SetBlipHighDetail(blip, true)
    SetBlipAlpha(blip, 100)
    SetBlipColour(blip, 2)
    return blip
end

--- Creates a drop-off zone blip for given coordinates
--- @param coords vec3 - Coordinates of a location
--- @return blip object - blip
local CreateDropOffBlip = function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 227)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.80)
    AddTextEntry('MYBLIP', "Dropoff Location")
    BeginTextCommandSetBlipName('MYBLIP')
    AddTextComponentSubstringPlayerName('Vehicle Drop off')
    EndTextCommandSetBlipName(blip)
    return blip
end

--- Gives a vehicle random cosmetic upgrades
--- @param vehicle object - Vehicle object
--- @return nil
local SetRandomCosmetics = function(vehicle)
    -- Colours
    local c1, c2 = math.random(160), math.random(160)
    SetVehicleColours(vehicle, c1, c2)
    -- Cosmetics
    SetVehicleModKit(vehicle, 0)
    for i=1, #vehMods, 1 do
        local modAmount = GetNumVehicleMods(vehicle, vehMods[i])
        local rndm = math.random(modAmount)
        SetVehicleMod(vehicle, vehMods[i], rndm, false)
    end
end

--- Enables upgrades for a specific vehicle
--- @param vehicle object - Vehicle object
--- @return nil
local EnableUpgrades = function(vehicle)
    SetVehicleModKit(vehicle, 0)
    ToggleVehicleMod(vehicle, 18, true) -- Turbo
    SetVehicleMod(vehicle, 11, 2, false) -- Engine
    SetVehicleMod(vehicle, 12, 1, false) -- Brakes
    SetVehicleMod(vehicle, 13, 1, false) -- Transmission
end

--- Generates random vehicle model and license plate and sends an email
--- @return nil
local ReceiveMission = function()
    SetTimeout(math.random(2500, 4000), function()
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        local model = Shared.Vehicles[math.random(#Shared.Vehicles)]
        QBCore.Functions.TriggerCallback('qb-chopshop:server:GetPlate', function(result)
            local plate = result
            TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                sender = Shared.MailAuthor,
                subject = Shared.MailTitle,
                message = "Yo "..charinfo.firstname..", Kan je dit voertuig voor me ophalen.. <br><br>Model: "..QBCore.Shared.Vehicles[model]["brand"].." "..QBCore.Shared.Vehicles[model]["name"].."<br>Nummerplaat: "..plate.."<br><br>Laat je het me weten als je deze auto gaat halen..",
                button = {
                    enabled = true,
                    buttonEvent = "qb-chopshop:client:AcceptMission",
                    buttonData = {
                        model = model,
                        plate = plate
                    }
                }
            })
        end)
    end)
end

RegisterNetEvent('qb-chopshop:client:AcceptMission', function(data)
    local model = data.model
    local plate = data.plate
    
    QBCore.Functions.Notify("Ga naar de locatie en zoek de auto!", "primary", 7000)
    -- Random Location
    local randLoc = math.random(#Shared.Locations)
    local vehLoc = Shared.Locations[randLoc]
    
    -- Area Zone
    areaBlip = CreateAreaBlip(vehLoc)
    areaZone = CircleZone:Create(vehLoc, 200.00, {
        name = "chopshop_veharea",
        debugPoly = false
    })
    areaZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            -- Spawn Car
            QBCore.Functions.TriggerCallback('qb-chopshop:server:SpawnVehicle', function(netId)
                while not NetworkDoesEntityExistWithNetworkId(netId) do Wait(10) end
                chopVehicle = NetworkGetEntityFromNetworkId(netId)
                SetRandomCosmetics(chopVehicle)
                EnableUpgrades(chopVehicle)
            end, model, vehLoc, plate)
            -- Destroy Zone
            areaZone:destroy()
            -- Notify
            QBCore.Functions.Notify("Vind het voertuig", "primary", 7000)
        end
    end)

    -- Wait until car found
    local madeDropOffZone = false
    while not madeDropOffZone do
        Wait(1000)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if GetVehicleNumberPlateText(veh) == plate then
            chopVehicle = veh
            exports[Shared.FuelScript]:SetFuel(chopVehicle, 80.00)
            -- Alert Cops
            AlertPolice(chopVehicle)
            QBCore.Functions.Notify("Lever het voertuig naar de drop-off", "primary", 7000)
            RemoveBlip(areaBlip)
            madeDropOffZone = true
        end
    end

    -- Drop-off Zone
    local dropOffLoc = Shared.DropOffLocations[math.random(#Shared.DropOffLocations)]
    dropOffBlip = CreateDropOffBlip(dropOffLoc)
    dropOffZone = CircleZone:Create(dropOffLoc, 4.0, {
        name = "chopshop_dropOffArea",
        debugPoly = false
    })

    local inZone = false
    dropOffZone:onPlayerInOut(function(isPointInside, point)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if isPointInside then
            inZone = true
            if chopVehicle == veh then
                exports['jg-textui']:DrawText('[E] - Chop Vehicle', 'left')
                -- E to start chopping vehicle
                CreateThread(function()
                    while inZone and chopVehicle == veh do
                        if IsControlJustPressed(0, 38) then
                            exports['jg-textui']:HideText()
                            dropOffZone:destroy()
                            RemoveBlip(dropOffBlip)
                            ChopVehicle(chopVehicle)
                            return
                        end
                        Wait(3)
                    end
                end)
            end
        else
            inZone = false
            exports['qb-core']:HideText()
        end
    end)
end)

RegisterNetEvent('qb-chopshop:client:StartChopShop', function()
    queued = not queued
    if queued then 
        QBCore.Functions.Notify("Ik zal contact met je opnemen als ik een job heb!", "primary", 7000)
        CreateThread(function()
            Wait(Shared.Time*60*1000)
            if not queued then return end
            ReceiveMission()
            queued = false
        end)
    else
        QBCore.Functions.Notify("Je hebt de job verlaten", "error", 7000)
    end
end)

CreateThread(function()
	exports['qb-target']:SpawnPed({
        model = 'a_m_m_bevhills_02',
        coords = vector4(-418.91, -1676.32, 19.03, 127.37),
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-chopshop:client:StartChopShop",
                    icon = 'fas fa-user-secret',
                    label = 'Start Chop Shop'
                }
            },
            distance = 1.5
        },
    })
end)
