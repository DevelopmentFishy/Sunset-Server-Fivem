function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()

AddTextEntry('Brand', 'BMW')

AddTextEntry('r1250rt', 'BMW R1250RT Police Bike')


end)