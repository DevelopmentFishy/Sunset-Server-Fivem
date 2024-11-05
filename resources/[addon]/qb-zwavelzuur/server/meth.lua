local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-zwavelzuur:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("sulfuric_acid", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "add")
	end
end)

