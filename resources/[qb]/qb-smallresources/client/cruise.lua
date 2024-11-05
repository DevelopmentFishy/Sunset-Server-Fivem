local QBCore = exports['qb-core']:GetCoreObject()
local vehicleClasses = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false,
    [9] = false,
    [10] = false,
    [11] = false,
    [12] = false,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = false,
    [18] = false,
    [19] = false,
    [20] = false,
    [21] = false
}

local function triggerCruiseControl(veh)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local speed = GetEntitySpeed(veh)
        if speed > 0 and GetVehicleCurrentGear(veh) > 0 then
            speed = GetEntitySpeed(veh)
            local isTurningOrHandbraking = IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
            TriggerEvent('seatbelt:client:ToggleCruise', true)
            QBCore.Functions.Notify(Lang:t('cruise.activated'))
            
            CreateThread(function()
                while speed > 0 and GetPedInVehicleSeat(veh, -1) == ped do
                    Wait(0)
                    if not isTurningOrHandbraking and GetEntitySpeed(veh) < speed - 1.5 then
                        speed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise', false)
                        QBCore.Functions.Notify(Lang:t('cruise.deactivated'), "error")
                        Wait(2000)
                        break
                    end

                    if not isTurningOrHandbraking and IsVehicleOnAllWheels(veh) and GetEntitySpeed(veh) < speed then
                        SetVehicleForwardSpeed(veh, speed)
                    end

                    if IsControlJustPressed(1, 246) then
                        speed = GetEntitySpeed(veh)
                    end

                    if IsControlJustPressed(2, 72) then
                        speed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise', false)
                        QBCore.Functions.Notify(Lang:t('cruise.deactivated'), "error")
                        Wait(2000)
                        break
                    end
                end
            end)
        end
    end
end

RegisterCommand('togglecruise', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local driver = GetPedInVehicleSeat(veh, -1)
    local vehClass = GetVehicleClass(veh)
    if ped == driver and vehicleClasses[vehClass] then
        triggerCruiseControl(veh)
    else
        QBCore.Functions.Notify(Lang:t('cruise.unavailable'), "error")
    end
end, false)

RegisterKeyMapping('togglecruise', 'Toggle Cruise Control', 'keyboard', 'Y')