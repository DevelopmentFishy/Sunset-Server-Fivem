function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end


RegisterNetEvent('r14-smallresources:client:changelivery', function(livery)
	if IsPedInAnyVehicle(PlayerPedId(), false) then    
        local liveryIsString = nil

        if type(livery) == 'string' and not tonumber(livery) then liveryIsString = true end

        local livery = tonumber(livery)
        local veh = GetVehiclePedIsIn(ped)

        
        if livery then
		    SetVehicleLivery(veh, livery)
        else
            livcount = GetVehicleLiveryCount(veh)
            if livcount == -1 then
                Config.Functions.Notify("This vehicle has no liveries.")
            else
                if liveryIsString then
                    Config.Functions.Notify(("You did not enter a number, please enter retry with a number between 1 and %s."):format(livcount))
                else
                    Config.Functions.Notify(("This vehicle has %s liveries."):format(livcount))
                end
            end
	    end 
    else
        Config.Functions.Notify("You are not in a vehicle.", "error")
    end
end)


RegisterNetEvent('r14-smallresources:client:toggledoor', function(door)
    local closestVehicle = nil

    if IsPedInAnyVehicle(ped, false) then
        closestVehicle = GetVehiclePedIsIn(ped)
    else
        closestVehicle = getNearestVeh()
    end

    if closestVehicle ~= 0 then
        if GetVehicleDoorLockStatus(closestVehicle) > 1 then Config.Functions.Notify('This vehicle is locked!') return end

        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = QBCore.Functions.GetPlate(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        Config.Functions.Notify('You are not facing a vehicle.', 'error')
    end
end)

RegisterNetEvent('r14-smallresources:client:toggledomelight', function()
    if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped)

	    SetVehicleInteriorlight(veh, not IsVehicleInteriorLightOn(veh))
    else 
        Config.Functions.Notify('You are not in a vehicle!', 'error')
    end
end)

RegisterNetEvent('r14-smallresources:client:changeseat', function(seat)
	if IsPedInAnyVehicle(ped, false) then
        if type(seat) == 'string' and not tonumber(seat) then seatIsString = true end

        local seat = tonumber(seat)
        local veh = GetVehiclePedIsIn(ped)
        local vehmodel = GetEntityModel(veh)
        local vehhash = GetHashKey(vehmodel)
        local vehseats = GetVehicleModelNumberOfSeats(vehmodel)
        if seat then
            if not Config.VehicleImprovements.SeatCommand.CheckHarness or (Config.VehicleImprovements.SeatCommand.CheckHarness and not Config.VehicleImprovements.SeatCommand.HarnessCheck()) then
    		    SetPedIntoVehicle(ped, veh, seat - 2)
            else
                Config.Functions.Notify(("You have a harness on!"):format(vehseats))
            end
        else
            if not seatIsString then
    		    Config.Functions.Notify(("This vehicle has %s seats."):format(vehseats))
            else
                Config.Functions.Notify(("You did not enter a number, please enter retry with a number between 1 and %s."):format(vehseats))
            end
	    end 
    else
        Config.Functions.Notify("You are not in a vehicle", "error")
    end
end, false)

RegisterNetEvent('r14-smallresources:client:togglewindow', function(window)
    if not window then
        local count = 0
        for i = -1, 7 do
            local result = IsVehicleWindowIntact(GetVehiclePedIsIn(PlayerPedId(), false), i)
            if result then
                count = count + 1
            end
        end
        if count == 0 then
            Config.Functions.Notify('This vehicle has no working windows!')
        else
            Config.Functions.Notify('This vehicle has '.. count .. ' windows.')            
        end        
    else
        local veh = nil
        local plate = nil

        if IsPedInAnyVehicle(ped, false) then
            veh = GetVehiclePedIsIn(ped)
            
            if IsVehicleWindowIntact(veh, window) then
                RollDownWindow(veh, window)
            else
                RollUpWindow(veh, window)
            end
        else 
            Config.Functions.Notify('You are not in a vehicle...', 'error')            
        end
    end
end)