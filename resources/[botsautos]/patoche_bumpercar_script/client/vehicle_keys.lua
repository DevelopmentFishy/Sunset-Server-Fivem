local waitLoop = 500
local givenKeys = {}

function findExinstingKeys(array, finder)
  for k, v in pairs(array) do
    if v == finder then
      return true
    end
  end
  return false
end

CreateThread(function()
  while true do
    local pPed = PlayerPedId()
    local vehicle = GetVehiclePedIsTryingToEnter(pPed)
    if vehicle > 0 then
      waitLoop = 0
      local model = GetEntityModel(vehicle)
      local plate = GetVehicleNumberPlateText(vehicle)
      if model == GetHashKey(Config.vehicle_model) and not findExinstingKeys(givenKeys, plate) then
        -- YOUR EVENT TO GIVE KEYS HERE
        table.insert(givenKeys, plate)
      end
    else
      waitLoop = 500
    end
    Wait(waitLoop)
  end
end)