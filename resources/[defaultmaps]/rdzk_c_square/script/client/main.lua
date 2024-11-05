local Interiors = {}

AddEventHandler('onClientResourceStart', function(resourceName)
	if resourceName ~= GetCurrentResourceName() then
		return
	end

	TriggerServerEvent('rdzk:server:getInteriors')
end)

RegisterNetEvent('rdzk:client:setInteriors', function(interiors)
	Interiors = interiors

	for k, v in pairs(Config.Interiors) do
		local interior = GetInteriorAtCoords(v.coords.x, v.coords.y, v.coords.z)

		while interior == 0 do
			interior = GetInteriorAtCoords(v.coords.x, v.coords.y, v.coords.z)

			Citizen.Wait(0)
		end

		EnableInteriorProp(interior, Config.Ipls[Interiors[k]])
		RefreshInterior(interior)
	end
end)

RegisterNetEvent('rdzk:client:syncInterior', function(interiorId, iplId)
	local interiorCoords = Config.Interiors[interiorId].coords
	local interior = GetInteriorAtCoords(interiorCoords.x, interiorCoords.y, interiorCoords.z)

	while interior == 0 do
		interior = GetInteriorAtCoords(interiorCoords.x, interiorCoords.y, interiorCoords.z)

		Citizen.Wait(0)
	end

	EnableInteriorProp(interior, Config.Ipls[iplId])

	Interiors[interiorId] = iplId

	for k, v in pairs(Config.Ipls) do
		if k ~= Interiors[interiorId] then
			DisableInteriorProp(interior, v)
		end
	end

	RefreshInterior(interior)
end)

for k, _ in pairs(Config.Interiors) do
	for k2, _ in pairs(Config.Ipls) do
		RegisterCommand('rdzk_ipl_' .. k .. '_' .. k2, function()
			TriggerServerEvent('rdzk:server:syncInterior', k, k2)
		end, false)
	end
end