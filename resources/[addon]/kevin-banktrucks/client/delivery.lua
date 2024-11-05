local QBCore = exports['qb-core']:GetCoreObject()

local jobData = nil
local job = nil
local truckCoords = nil
local truckAreaBlip = nil
local truckZone = nil
local delivTruck = nil
local gotDestination = false
local gpsTime = 0
local dropCoords = nil
local destBlip = nil
local meetZone = nil
local dropPed = nil


RegisterNetEvent('kevin-banktrucks:takedelivery', function (data)
    if not data then return end
    jobData = data.data
    job = data.job
    truckCoords = GetRandomData(jobData.trucklocations)
    gpsTime = math.random(jobData.gpstime.min, jobData.gpstime.max)

    truckAreaBlip = AddBlipForRadius(truckCoords.x, truckCoords.y + 175, truckCoords.z, 450.0)
    SetBlipColour(truckAreaBlip, 72)



    local title = 'Lester\'s Computer'
    local subject = 'Job Info'
    local message = 'Anonymous: Hey er was een probleem met de vorige overval we moesten de truck dumpen bekijk je gps daar is ongeveer de laatste locatie vind hem en bezorg hem'
    SendMail(title, subject, message)
    
    local hasPhone = HasPhoneItem()
    if not hasPhone then
        Notification('Informatie verzonden naar je telefoon..', 6000, 'primary')
    end
    Wait(15000)

    truckZone = lib.zones.sphere({
        coords = vec3(truckCoords.x, truckCoords.y, truckCoords.z),
        radius = 150,
        debug = false,
        onEnter = CreateDeliveryTruck,
    })
end)

function CreateDeliveryTruck()
    local player = PlayerPedId()
    local hash = `stockade`
    lib.requestModel(hash)
    delivTruck = CreateVehicle(hash, truckCoords.x, truckCoords.y, truckCoords.z, truckCoords.w, true, true)
    if DoesEntityExist(delivTruck) then
        truckZone:remove()
        SetEntityAsMissionEntity(delivTruck)
        CreateThread( function ()
            while DoesEntityExist(delivTruck) do
                if IsPedInVehicle(player, delivTruck) then
                    TriggerAlert()
                    RemoveBlip(truckAreaBlip)
                    GetDropLocation()
                    break
                end
                Wait(1000)
            end
        end)
    end
end

function GetDropLocation()
    local title = 'NOTIFICATION'
    local message = 'Rijd tot je een afdrop locatie krijgt'
    PhoneNotification(title, message)
    CreateThread(function ()
        while not DoesBlipExist(destBlip) do
            local coords = GetEntityCoords(delivTruck)
            TriggerServerEvent('kevin-banktrucks:policegps', coords)
            Wait(4000)
        end
    end)
    Wait(gpsTime * 60000)

    dropCoords = GetRandomData(jobData.droplocations)
    destBlip = AddBlipForCoord(dropCoords.x, dropCoords.y, dropCoords.z)
    SetBlipSprite(destBlip, 440)
    SetBlipColour(destBlip, 64)
    SetBlipScale(destBlip, 0.85)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Drop Location')
    EndTextCommandSetBlipName(destBlip)

    title = 'NOTIFICATION'
    message = 'Lever het voertuig af aan het droppunt'
    PhoneNotification(title, message)

    meetZone = lib.zones.sphere({
        coords = vec3(dropCoords.x, dropCoords.y, dropCoords.z),
        radius = 25,
        debug = false,
        onEnter = CreateDropPed,
    })
end

RegisterNetEvent('kevin-banktrucks:policegps', function(coords)
    local transG = 250
    local truckGps = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(truckGps, 161)
    SetBlipColour(truckGps, 43)
    SetBlipDisplay(truckGps, 8)
    SetBlipAlpha(truckGps, transG)
    SetBlipScale(truckGps, 1.5)
    SetBlipAsShortRange(truckGps, false)
    PulseBlip(truckGps)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Bank Truck Gps')
    EndTextCommandSetBlipName(truckGps)
    while transG ~= 0 do
        Wait(14)
        transG = transG - 1
        SetBlipAlpha(truckGps, transG)
        if transG == 0 then
            RemoveBlip(truckGps)
            return
        end
    end
end)

function CreateDropPed()
    local player = PlayerPedId()
    local hash = jobData.pedhash
    local coords = vector3(dropCoords.x, dropCoords.y, dropCoords.z)
    lib.requestModel(hash)
    dropPed = CreatePed(0, hash, dropCoords.x, dropCoords.y, dropCoords.z, dropCoords.w, true, true)
    if DoesEntityExist(dropPed) then
        meetZone:remove()
        SetEntityInvincible(dropPed, true)
        SetBlockingOfNonTemporaryEvents(dropPed, true)
        SetPedKeepTask(dropPed, true)
        CreateThread(function ()
            while DoesEntityExist(dropPed) do
                local pCoords = GetEntityCoords(player)
                local dist = #(pCoords - coords)
                if dist < 10.0 and IsVehicleStopped(delivTruck) then
                    if not IsPedInVehicle(player, delivTruck) then
                        RemoveBlip(destBlip)
                        TaskEnterVehicle(dropPed, delivTruck, -1, -1, 1.0, 0, 0)
                        ClearPedTasks(dropPed)
                        SetPedAsNoLongerNeeded(dropPed)
                        Wait(15000)
                        DeleteEntity(dropPed)
                        DeleteEntity(delivTruck)
                        TriggerServerEvent('kevin-banktrucks:givedeliveryreward', jobData)
                        ClearVariables()
                        break
                    end
                end
                Wait(1000)
            end
        end)
    end
end

function ClearVariables()
    jobData = nil
    job = nil
    truckCoords = nil
    truckAreaBlip = nil
    truckZone = nil
    delivTruck = nil
    gotDestination = false
    gpsTime = 0
    dropCoords = nil
    destBlip = nil
    meetZone = nil
    dropPed = nil
end

RegisterNetEvent('kevin-banktrucks:canceldelivery', function ()
    if truckZone then
        truckZone:remove()
    end
    if meetZone then
        meetZone:remove()
    end
    if DoesBlipExist(destBlip) then
        RemoveBlip(destBlip)
    end

    if DoesBlipExist(truckAreaBlip) then
        RemoveBlip(truckAreaBlip)
    end

    if DoesEntityExist(delivTruck) then
        SetEntityAsMissionEntity(delivTruck, true, true)
        NetworkRequestControlOfEntity(delivTruck)
        DeleteEntity(delivTruck)
    end
    if DoesEntityExist(dropPed) then
        SetEntityAsMissionEntity(dropPed, true, true)
        NetworkRequestControlOfEntity(dropPed)
        DeleteEntity(dropPed)
    end

    ClearVariables()
    QBCore.Functions.Notify("Job Cancelled..", 'error')
end)