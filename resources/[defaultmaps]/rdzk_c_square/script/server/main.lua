local Interiors = {}

Citizen.CreateThread(function()
	for k, v in pairs(Config.Interiors) do
		Interiors[k] = v.iplId
	end
end)

RegisterNetEvent('rdzk:server:getInteriors', function()
  local _source = source

  TriggerClientEvent('rdzk:client:setInteriors', _source, Interiors)
end)

RegisterNetEvent('rdzk:server:syncInterior', function(interiorId, iplId)
  Interiors[interiorId] = iplId

  TriggerClientEvent('rdzk:client:syncInterior', -1, interiorId, iplId)
end)

local bannedModels = {
  [`blimp`] = true,
  [`blimp2`] = true,
}

AddEventHandler("entityCreating", function(e)
  local model = GetEntityModel(e)
  
  if bannedModels[model] then
      CancelEvent()
      return
  end
end)