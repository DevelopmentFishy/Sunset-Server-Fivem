local WhileDriving = Config.CameraImprovements.ForceFirstPerson.WhileDriving
local WhileAiming = Config.CameraImprovements.ForceFirstPerson.WhileAiming
local DuringDriveby = Config.CameraImprovements.ForceFirstPerson.DuringDriveby


local peeked = false
local savedcam = {ped = nil, veh = nil}
local prevcam = {ped = nil, veh = nil}
local forcedFirstPerson = nil
local vehWep = nil

if Config.CameraImprovements then
    if Config.CameraImprovements.Peek then
        CreateThread(function()
            while true do
                Wait(50)
                if LocalPlayer.state.isLoggedIn then      
                    if IsControlPressed(0, 0) then 
                        Wait(200)
                        if IsControlPressed(0, 0) and not peeked and not forcedFirstPerson then
                            if IsPedInAnyVehicle(ped) then
                                savedcam.veh = GetFollowVehicleCamViewMode()
                                savedcam.ped = GetFollowPedCamViewMode()
                                savedcam.context = GetCamActiveViewModeContext()
                                SetFollowVehicleCamViewMode(4)
                                SetFollowVehicleCamViewMode(4)
    		                    SetCamViewModeForContext(savedcam.context, 4)
                            else
                                savedcam.veh = GetFollowVehicleCamViewMode()
                                savedcam.ped = GetFollowPedCamViewMode()
                                SetFollowPedCamViewMode(4)
                                SetFollowPedCamViewMode(4)
                            end
                            peeked = true
                        end
                    else
                        if peeked and not forcedFirstPerson then
                            peeked = false
                            SetFollowPedCamViewMode(savedcam.ped)
                            SetFollowVehicleCamViewMode(savedcam.veh)		        
                            SetCamViewModeForContext(savedcam.context, savedcam.veh)
                            savedcam.ped = nil
                            savedcam.veh = nil
                            savedcam.context = nil
                        elseif peeked and forcedFirstPerson then
                            peeked = false
                            prevcam.ped = savedcam.ped
                            prevcam.veh = savedcam.veh
                        end          
                    end
		        else
			        Wait(5000)
		        end
            end
        end)
    end

    if Config.CameraImprovements.ForceFirstPerson.Enabled then
        CreateThread(function()
            while true do
                inVehicle = IsPedInAnyVehicle(ped, false)
                driver = GetPedInVehicleSeat(currentVehicle, -1) == ped
                currentVehicleModel = GetEntityModel(currentVehicle)
                isVehWeapon, vehWep = GetCurrentPedVehicleWeapon(ped)

                if WhileDriving and inVehicle then forceFirstPerson = true end

                Wait(1000)
            end
        end)

        CreateThread(function()
            while true do
                Wait(0)
                if LocalPlayer.state.isLoggedIn then      
                    local forceFirstPerson = false

                    isAiming = IsPlayerFreeAiming(player)

                    if WhileAiming or Config.CombatImprovements.RequireAimToFire then
                        if (IsPedArmed(ped, 4) or (inVehicle and not isVehWeapon)) and not isAiming then
                            SetPlayerCanDoDriveBy(player, false)
                            DisablePlayerFiring(player, true) 
                        else
                            SetPlayerCanDoDriveBy(player, true)     
                        end
                    end				

                    if DuringDriveby and inVehicle and isAiming then forceFirstPerson = true end

                    if WhileAiming and isAiming then forceFirstPerson = true end 

                    if forceFirstPerson then 
                        if not IsPedGettingIntoAVehicle(ped) then
                            if not forcedFirstPerson then
                                prevcam.veh = GetFollowVehicleCamViewMode()
                                prevcam.ped = GetFollowPedCamViewMode()
                                prevcam.context = GetCamActiveViewModeContext()
                            end
                            DisableControlAction(0, 0)
                            SetFollowVehicleCamViewMode(4)
                            SetFollowVehicleCamViewMode(4)
		                    SetCamViewModeForContext(2, 4)
		                    SetCamViewModeForContext(3, 4)
		                    SetCamViewModeForContext(4, 4)
		                    SetCamViewModeForContext(5, 4)
		                    SetCamViewModeForContext(6, 4)
		                    SetCamViewModeForContext(7, 4)
                            SetFollowPedCamViewMode(4)

                            forcedFirstPerson = true
                        end
                    else
                        if forcedFirstPerson then
                            forcedFirstPerson = false
                            SetFollowPedCamViewMode(prevcam.ped)
                            SetFollowVehicleCamViewMode(prevcam.veh)
		                    SetCamViewModeForContext(prevcam.context, prevcam.veh)
                            prevcam.ped = nil
                            prevcam.veh = nil
                            prevcam.context = nil
                        end          
                    end
		        else
			        Wait(5000)
		        end
            end
        end)
    end
end
