TriggerServerEvent('r14-smallresources:server:requestsnowpass')

RegisterNetEvent('r14-smallresources:client:snowpass', function(bool)
	SetForceVehicleTrails(bool)
	SetForcePedFootstepsTracks(bool)
	ForceSnowPass(bool)
end)
