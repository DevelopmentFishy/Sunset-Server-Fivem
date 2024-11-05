function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()

AddTextEntry('Mercedes', 'Mercedes')

AddTextEntry('GLSSMUR', 'Mercedes GLS SMUR')


end)