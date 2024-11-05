ped, player = PlayerPedId(), PlayerId()
local relaxed = false
local reticleEnabled = true

CreateThread(function()
    while true do
        Wait(1000)
		ped = PlayerPedId() -- this is a global variable that fetches once per second for his entire resource (THAT MEANS ITS IMPORTANT AND YOU SHOULDN'T TOUCH IT)
		player = PlayerId()
        currentVehicle = GetVehiclePedIsIn(ped, false)
		curWeapHash = GetSelectedPedWeapon(ped)
    end
end)

 SetPedConfigFlag(ped, 424, false)

CreateThread(function() -- this thread sets various config flags and natives every five seconds, mainly to account for /refreshskin
    while true do      
		if Config.VehicleImprovements.DisableAutoStart then SetPedConfigFlag(ped, 429, 1) end -- auto on

		if Config.VehicleImprovements.DisableAutoOff then SetPedConfigFlag(ped, 241, 1) end -- auto off

		if Config.PedImprovements.DisableHelmetArmor then SetPedConfigFlag(ped, 438, 0) end -- helmet armor off

		if Config.PedImprovements.DisableBikeAndAicraftHelmets then SetPedConfigFlag(ped, 35, 0) end-- helmets off

        if Config.PedImprovements.KeepPropsOnDamage then SetPedCanLosePropsOnDamage(ped, false, 0) end -- disables losing your hat/glasses when getting punched

		if Config.CombatImprovements.KeepWeaponFlashlightOn then SetFlashLightKeepOnWhileMoving(true) end -- keeps your flashlight or weapon flashlight on when not actively aiming

		if Config.CombatImprovements.DisableAutoReload then SetWeaponsNoAutoreload(true) end -- disables automatic reloading when firing on foot (does not disable auto reloading firing from a vehicle)

		if Config.PedImprovements.DisableIdleCam then DisableIdleCamera(true) end -- disables idle camera that pans around after 30 seconds of being idle

		if relaxed then SetPedConfigFlag(ped, 424, true) end

        Wait(5000)
    end
end)

if Config.PedImprovements.DisableActionMode or Config.PedImprovements.DisableMeleeKeybind then
	CreateThread(function() -- disables action mode!
		while true do
			Wait(0)
		
			if Config.PedImprovements.DisableActionMode then SetPedResetFlag(ped, 200, 1) end-- THIS KEEPS YOU FROM WALKING AROUND LIKE AN ASSHOLE AFTER PUNCHING, THIS IS THE ONLY WAY TO DISABLE IT

			if Config.PedImprovements.DisableMeleeKeybind then -- this disables R causing you to melee
				DisableControlAction(0, 140)
				DisableControlAction(1, 140)
				DisableControlAction(2, 140)
			end
		end
	end)
end

if Config.CombatImprovements.DisableCombatRoll then -- disables combat roll
	local isArmed, isAiming = nil, nil

	CreateThread(function()
		while true do
			isArmed = IsPedArmed(ped, 4)
			isFreeAiming = IsPlayerFreeAiming(player)
			Wait(500)
		end
	end)

	CreateThread(function()
		while true do
			Wait(0)
			if isArmed and (isFreeAiming or IsControlPressed(0, 25) or IsControlPressed(2, 25)) then 
				DisableControlAction(0, 22, true)
				DisableControlAction(1, 22, true)
				DisableControlAction(2, 22, true)
			end
		end
	end)
end

if Config.PedImprovements.RelaxedMotorcyclePosture.Enabled and Config.PedImprovements.RelaxedMotorcyclePosture.Command then
	RegisterCommand(Config.PedImprovements.RelaxedMotorcyclePosture.Command, function()
		relaxed = not relaxed
        SetPedConfigFlag(ped, 424, relaxed)
	end)
end

RegisterKeyMapping(Config.PedImprovements.RelaxedMotorcyclePosture.Command, 'Relaxed motorcycle posture', 'keyboard', 'J')

if Config.CombatImprovements.SmallReticle.Enabled then
	CreateThread(function() 
		RequestStreamedTextureDict('mpinventory')

		while true do
			if (IsAimCamActive() and not IsPedInMeleeCombat(ped) and not IsPedGoingIntoCover(ped) and (not IsPedInCover(ped) or IsPedInCover(ped) and IsPedAimingFromCover(ped))) and (GetFollowPedCamViewMode() ~= 4 or inVehicle) and not Config.CombatImprovements.SmallReticle[curWeapHash or GetSelectedPedWeapon(ped)] then
				HideHudComponentThisFrame(14)
				if reticleEnabled then
					DrawSprite('mpinventory', 'in_world_circle', 0.5, 0.5, 0.00425, 0.00675, 0, 0, 0, 0, 255)
					DrawSprite('mpinventory', 'in_world_circle', 0.5, 0.5, 0.00225, 0.00475, 0, 255, 255, 255, 255)
				end
			end
			Wait(0)
		end
	end)
end

RegisterCommand(Config.CombatImprovements.SmallReticle.Command, function()
	reticleEnabled = not reticleEnabled
end)

RegisterKeyMapping(Config.CombatImprovements.SmallReticle.Command, 'Toggle reticle', 'keyboard', 'Q')

--[[
CreateThread(function() -- causes ped to fire weapon in their hand when tazed
	while true do
		Wait(0)
		if IsPedBeingStunned(ped, 0) then
			SetControlNormal(0, 24)
			SetControlNormal(1, 24)
			SetControlNormal(2, 24)
			Wait(200)a
		end
	end
end)
--]]
