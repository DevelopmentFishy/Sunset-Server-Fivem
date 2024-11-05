-- local currentVehicleDead, currentVehicleModel, vehicleExempt, vehicleInAir

-- local function GetVehInfo(vehicle)
--     if not vehicle and not currentVehicle then currentVehicle = GetVehiclePedIsIn(ped, false) else currentVehicle = vehicle end

--     currentVehicleDead = IsEntityDead(currentVehicle)
--     currentVehicleModel = GetEntityModel(currentVehicle)

--     if Config.VehicleImprovements.DisableAirControl.ExemptList[currentVehicleModel] or IsThisModelABoat(currentVehicleModel) or IsThisModelAHeli(currentVehicleModel) or IsThisModelAPlane(currentVehicleModel) or IsThisModelABicycle(currentVehicleModel) or IsThisModelABike(currentVehicleModel) then
--         vehicleExempt = true
--     else
--         vehicleExempt = false
--     end
-- end

-- if Config.VehicleImprovements.DisableAirControl then
   
--     AddEventHandler('gameEventTriggered', function (name, args)
-- 	    if name == 'CEventNetworkPlayerEnteredVehicle' and args[1] == player then  
--              currentVehicle = args[2]
--              GetVehInfo(currentVehicle)
--         end
--     end)

--     CreateThread(function() -- thread fetches information about our vehicle every half second
-- 	    while true do
--             if LocalPlayer.state.isLoggedIn then		
--                 inVehicle = IsPedInAnyVehicle(ped, false)

--                 if inVehicle then
--                     vehicleInAir = IsEntityInAir(currentVehicle)              

--                     if not currentVehicleModel then GetVehInfo() end
--                 else
--                     currentVehicle = nil
--                     currentVehicleDead = nil
--                     currentVehicleModel = nil
--                     vehicleInAir = nil
--                 end
--             end
            
-- 	        Wait(500)
-- 	    end
--     end)

--     CreateThread(function() -- disables rolling vehicle in the air
--         while true do
--             Wait(0)

--             local roll = GetEntityRoll(currentVehicle)

--             if currentVehicle and not vehicleExempt and not currentVehicleDead and vehicleInAir or ((roll > 50 or roll < -50) and GetEntitySpeed(currentVehicle) < 5) then -- if the vehicle and it is not exempt or destroyed, and the vehilce is off the ground with ALL wheels, then block leaning
--                 DisableControlAction(0, 59) -- leaning left/right
--                 DisableControlAction(1, 59)
--                 DisableControlAction(2, 59)
--                 DisableControlAction(0, 59) -- leaning left/right
--                 DisableControlAction(1, 59)
--                 DisableControlAction(2, 59)

--                 DisableControlAction(0, 60) -- leaning up/down
--                 DisableControlAction(1, 60)
--                 DisableControlAction(2, 60)
--                 DisableControlAction(0, 61) -- leaning up/down
--                 DisableControlAction(1, 61)
--                 DisableControlAction(2, 61)

--             else
--                 Wait(200)
--             end
--         end
--     end)
-- end
