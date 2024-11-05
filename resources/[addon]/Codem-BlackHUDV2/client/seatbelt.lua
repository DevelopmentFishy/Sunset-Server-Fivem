
seatbeltOn = false
if Config.EnableSeatbelt then
    function CheckVehicleHasSeatbelt(vehicle)
        if DoesEntityExist(vehicle) then
            local class = GetVehicleClass(vehicle)
            if class == 0 or class == 1 or class == 2  or class == 3 or class == 4 or class == 5 or class == 6 or class == 7 or class == 9 or class == 12 or class == 22 or class == 20 or class == 18 or class == 17   then
                return true 
            end
        end
        return false
    end
    if Config.SeatbeltSound then
        CreateThread(function()
            while true do
                local ped = playerPed
                local car = GetVehiclePedIsIn(ped)
                if DoesEntityExist(car) and CheckVehicleHasSeatbelt(car) then
                    if not seatbeltOn then
                        local speed = GetEntitySpeed(car) * 3.6
                        if speed > Config.SeatbeltSoundSpeedLimit then
                            SendNUIMessage({
                                type="PLAY_SEATBELT_SOUND",
                            })
                        end
                    end
                end
                Wait(2800)
            end
        end)
    end
    local seatbeltSpam = 0
    function playSound(action)
        local ped = playerPed
        local car = GetVehiclePedIsIn(ped)
        local seatPlayerId = {}
        if IsCar(car) then
            for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(car)) do
                if not IsVehicleSeatFree(car, i-2) then 
                    local otherPlayerId = GetPedInVehicleSeat(car, i-2) 
                    local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                    local playerServerId = GetPlayerServerId(playerHandle)
                    table.insert(seatPlayerId, playerServerId)
                end
            end
            if #seatPlayerId > 0 then TriggerServerEvent("seatbelt:server:PlaySound", action, seatPlayerId) end 
        end
    end
    
    RegisterNetEvent('seatbelt:client:PlaySound')
    AddEventHandler('seatbelt:client:PlaySound', function(action, volume)
        SendNUIMessage({type = action, volume = volume})
    end)

    RegisterKeyMapping('seatbelt', 'Toggle Seatbelt', 'keyboard', Config.DefaultSeatbeltControlKey)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1500)
            if seatbeltSpam > 0 then
                Citizen.Wait(3500)
                seatbeltSpam = 0
            end
        end
    end)
    
    RegisterNetEvent('codem-blackhudv2:seatbelt:toggle')
    AddEventHandler('codem-blackhudv2:seatbelt:toggle', function(toggle)
        local car = GetVehiclePedIsIn(playerPed)
	    if car ~= 0 and IsCar(car) then
            local vehicleClass = GetVehicleClass(GetVehiclePedIsIn(playerPed))
            if vehicleClass == 8 or vehicleClass == 13 or vehicleClass == 14 or vehicleClass == 21 then
                return 
            end
            if seatbeltSpam >= 3 then
                if Config.EnableSpamNotification  then
                    Config.Notification(Config.Notifications["spam"]["message"], Config.Notifications["spam"]["type"])
                end
                return
            end        
            seatbeltOn = toggle
            if seatbeltOn then
                SendNUIMessage({
                    type="update_seatbelt",
                    toggle = true
                })                
                playSound("buckle")
                Config.Notification(Config.Notifications["took_seatbelt"]["message"], Config.Notifications["took_seatbelt"]["type"])
            else
                SendNUIMessage({
                    type="update_seatbelt",
                    toggle = false
                })
                playSound("unbuckle")
                Config.Notification(Config.Notifications["took_off_seatbelt"]["message"], Config.Notifications["took_off_seatbelt"]["type"])
            end              
        end
    end)

    RegisterCommand('seatbelt', function()
        if IsPedHangingOnToVehicle(playerPed) then
            return
        end
        local car = GetVehiclePedIsIn(playerPed)
	    if car ~= 0 and IsCar(car) then
            local vehicleClass = GetVehicleClass(GetVehiclePedIsIn(playerPed))
            if vehicleClass == 8 or vehicleClass == 13 or vehicleClass == 14 or vehicleClass == 21 then
                return 
            end
            if seatbeltSpam >= 3 then
                if Config.EnableSpamNotification  then
                    Config.Notification(Config.Notifications["spam"]["message"], Config.Notifications["spam"]["type"])
                end
                return
            end        
            seatbeltOn = not seatbeltOn
            if seatbeltOn then
                SendNUIMessage({
                    type="update_seatbelt",
                    toggle = true
                })                
                playSound("buckle")
                Config.Notification(Config.Notifications["took_seatbelt"]["message"], Config.Notifications["took_seatbelt"]["type"])
            else
                SendNUIMessage({
                    type="update_seatbelt",
                    toggle = false
                })
                playSound("unbuckle")
                Config.Notification(Config.Notifications["took_off_seatbelt"]["message"], Config.Notifications["took_off_seatbelt"]["type"])
            end              
        end
              				  
    end, false)    
    function Fwv(entity)  
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
    end
    function IsCar(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
    end  
    RegisterNetEvent('codem-blackhud-v2:client:EjectPlayer')
    AddEventHandler('codem-blackhud-v2:client:EjectPlayer', function(velocity)
	    if not seatbeltOn then
            local co = GetEntityCoords(playerPed)
	        local fw = Fwv(playerPed)
	        SetEntityCoords(playerPed, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
	        SetEntityVelocity(playerPed, velocity.x, velocity.y, velocity.z)
	        Wait(500)
	        SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)       
            seatbeltOn = false 
            SendNUIMessage({
                type="update_seatbelt",
                toggle = false
            })  
        end
    end)


    local speedBuffer, velBuffer  = {0.0,0.0}, {}
    local wasInCar = false
    CreateThread(function()
	    while true do
	        local car = GetVehiclePedIsIn(playerPed)
	        if car ~= 0 and (wasInCar or IsCar(car)) then
	        	wasInCar = true
	        	if seatbeltOn then 
                	DisableControlAction(0, 75)
                end
	        	speedBuffer[2] = speedBuffer[1]
	        	speedBuffer[1] = GetEntitySpeed(car) 
           
                if speedBuffer[2] and GetEntitySpeedVector(car, true).y > 1.0  and speedBuffer[1] > Config.SeatBeltFlySpeed and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then			   
                  
                    if not seatbeltOn then

                        local co = GetEntityCoords(playerPed)
	        		    local fw = Fwv(playerPed)
	        		    SetEntityCoords(playerPed, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
	        		    SetEntityVelocity(playerPed, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
	        		    Wait(500)
	        		    SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)                    
                        seatbeltOn = false
                        SendNUIMessage({
                            type="update_seatbelt",
                            toggle = false
                        })  
                    end

                    local seatPlayerId = {}
                    for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(car)) do
                        if i ~= 1 then
                            if not IsVehicleSeatFree(car, i-2) then 
                                local otherPlayerId = GetPedInVehicleSeat(car, i-2) 
                                local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                                local playerServerId = GetPlayerServerId(playerHandle)
                                table.insert(seatPlayerId, playerServerId)
                            end
                        end
                    end
                    if #seatPlayerId > 0 then TriggerServerEvent("codem-blackhud-v2:server:EjectPlayer", seatPlayerId, velBuffer[2]) end                    
	        	end
	        	velBuffer[2] = velBuffer[1]
	        	velBuffer[1] = GetEntityVelocity(car)
	        elseif wasInCar then
                wasInCar = false
                seatbeltOn = false
                cruiseIsOn = false
                SendNUIMessage({type = "toggle_cruise", toggle = false})
                SendNUIMessage({
                    type="update_seatbelt",
                    toggle = false
                })  
               	speedBuffer[1], speedBuffer[2] = 0.0, 0.0
            else
                Wait(2000)
            end
            Wait(0) 
        end
    end)
end
