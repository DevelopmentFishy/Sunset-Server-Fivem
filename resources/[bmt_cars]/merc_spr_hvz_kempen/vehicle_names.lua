function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()

AddTextEntry('Brand', 'Mercedes')

AddTextEntry('sprkempen', 'Mercedes Sprinter HVZ Kempen Ambulance')


end)