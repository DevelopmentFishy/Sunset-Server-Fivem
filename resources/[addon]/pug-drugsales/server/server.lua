local function GetItemsInformation(I, bool)
	if Framework == "QBCore" then
		if FWork.Shared.Items[I].label ~= nil then
            if bool then
			    return FWork.Shared.Items[I].label
            else
                return FWork.Shared.Items[I]
            end
		else
			return I
		end
	else
		return I
	end
end

RegisterNetEvent('Pug:Server:SellDrugs', function(Drug)	
	local src = source
	local Player = Config.FrameworkFunctions.GetPlayer(src)
	local lucky = math.random(1, 100)
	if Player then		
		local price = math.random(Drug.priceMin,Drug.priceMax)
		local amount = math.random(Config.BagsCanSellMin,Config.BagsCanSellMax)
		local pay = amount * price
		local HasAmount
		if Framework == "QBCore" then
			HasAmount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).amount
		else
			HasAmount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).count
		end
		if HasAmount >= amount then
			Player.RemoveItem(Drug.item, amount)
			if Framework == "QBCore" then
				TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Drug.item), "remove")		
			end
			Wait(500) -- Just to make sure the item is removed and them money is provided to the player	
			if Config.ItemsInsteadOfMopney then
				if Config.AddItemAmountInsteadOfLableAMount then
					Player.AddItem(Config.ItemToGive, pay)
				else
					if Framework == "QBCore" then
						if Config.FrameworkFunctions.GetItemByName(src, Config.ItemToGive, 1) then
							local ItemData = Config.FrameworkFunctions.GetItemByName(src, Config.ItemToGive).info.worth
							local NewAmount = math.ceil(pay + ItemData)
							local info = {
								worth = NewAmount
							}
							Player.RemoveItem(Config.ItemToGive, 1)
							Player.AddItem(Config.ItemToGive, 1, false, info)
							if Framework == "QBCore" then
								TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Config.ItemToGive), "add", NewAmount)		
							end
						else
							local info = {
								worth = pay
							}
							Player.AddItem(Config.ItemToGive, 1, false, info)
							if Framework == "QBCore" then
								TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Config.ItemToGive), "add", pay)		
							end
						end
					else
						local info = {
							worth = price
						}
						Player.AddItem(Config.ItemToGive, 1, false, info)
					end
				end
			else	
				Player.AddMoney("cash", pay)
			end
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je verkocht '..amount..' '..GetItemsInformation(Drug.item, true)..' voor €'..pay)
		elseif HasAmount >= 1 then
			Player.RemoveItem(Drug.item, 1)
			amount = 1
			if Framework == "QBCore" then
				TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Drug.item), "remove")		
			end
			Wait(500) -- Just to make sure the item is removed and them money is provided to the player		
			if Config.ItemsInsteadOfMopney then
				if Config.AddItemAmountInsteadOfLableAMount then
					Player.AddItem(Config.ItemToGive, price)
				else
					if Framework == "QBCore" then
						if Config.FrameworkFunctions.GetItemByName(src, Config.ItemToGive, 1) then
							local ItemData = Config.FrameworkFunctions.GetItemByName(src, Config.ItemToGive).info.worth
							local NewAmount = math.ceil(price + ItemData)
							local info = {
								worth = NewAmount
							}
							Player.RemoveItem(Config.ItemToGive, 1)
							Player.AddItem(Config.ItemToGive, 1, false, info)
							if Framework == "QBCore" then
								TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Config.ItemToGive), "add", NewAmount)		
							end
						else
							local info = {
								worth = price
							}
							Player.AddItem(Config.ItemToGive, 1, false, info)
							if Framework == "QBCore" then
								TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Config.ItemToGive), "add", price)		
							end
						end
					else
						local info = {
							worth = price
						}
						Player.AddItem(Config.ItemToGive, 1, false, info)
					end
				end
			else	
				Player.AddMoney("cash", price)
			end
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je verkocht '..GetItemsInformation(Drug.item, true)..' voor €'..price)
		else
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je hebt niet genoeg geld..', 'error')
		end
		if Config.Debug then print('You got 1 '..Drug.item..' voor $'..price) end
	end
end)

Config.FrameworkFunctions.CreateCallback('PugCallBack:server:getCops', function(source, cb)
	local amount = 0
	if Framework == "QBCore" then
		for k, v in pairs(FWork.Functions.GetQBPlayers()) do
			if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty or v.PlayerData.job.name == "bcso" and v.PlayerData.job.onduty 
			or v.PlayerData.job.name == "troopers" and v.PlayerData.job.onduty or v.PlayerData.job.name == "rangers" and v.PlayerData.job.onduty then
				amount = amount + 1
			end
		end
	else
		for _, v in pairs(FWork.GetPlayers()) do
			local Player = FWork.GetPlayerFromId(v)
			if Player.job.name == "police" or Player.job.name == "bcso" or Player.job.name == "troopers" or Player.job.name == "rangers" then
				amount = amount + 1
			end
		end
	end
    cb(amount)
end)

RegisterServerEvent('Pug:server:GiveDrugItem')
AddEventHandler('Pug:server:GiveDrugItem', function(drug, amnt)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	if drug then
        if amnt then
            Player.AddItem(drug, amnt)
        else
            Player.AddItem(drug, 1)
		end
		if Framework == "QBCore" then
			TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(drug), "add", amnt or 1)
		end
	end
end)

RegisterNetEvent('Pug:Server:StealDrugs', function(Drug)	
	local src = source
	local Player = Config.FrameworkFunctions.GetPlayer(src)
	local lucky = math.random(1, 100)
	if Player then		
		local amount = math.random(Config.BagsCanSellMin,Config.BagsCanSellMax)
		local HasAmount
		if Framework == "QBCore" then
			HasAmount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).amount
		else
			HasAmount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).count
		end
		if HasAmount >= amount then
			if Framework == "QBCore" then
				TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Drug.item), "remove", amount or 1)	
			end	
			Wait(500) -- Just to make sure the item is removed and them money is provided to the player		
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je bent bestolen van '..amount..' '..GetItemsInformation(Drug.item, true))
			TriggerClientEvent("Pug:client:SetStolenItemData", src, Drug.item, amount)
		elseif HasAmount >= 1 then
			if Framework == "QBCore" then
				amount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).amount
			else
				amount = Config.FrameworkFunctions.GetItemByName(src, Drug.item).count
			end
			Player.RemoveItem(Drug.item, Config.FrameworkFunctions.GetItemByName(src, Drug.item).amount)
			print(amount)
			if Framework == "QBCore" then
				TriggerClientEvent('inventory:client:ItemBox', src, GetItemsInformation(Drug.item), "remove", amount or 1)
			end
			Wait(500) -- Just to make sure the item is removed and them money is provided to the player		
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je bent bestolen van '..amount..' '..GetItemsInformation(Drug.item, true))
			TriggerClientEvent("Pug:client:SetStolenItemData", src, Drug.item, amount)
		else
			TriggerClientEvent('Pug:client:DrugSaleNotify', src, 'Je hebt niet genoeg drug.', 'error')
		end
	end
end)

Config.FrameworkFunctions.CreateCallback('Pug:serverCB:CheckIfHasDrugs', function(source, cb)
    local src = source
	local hasitem = false
	for k, v in pairs(Config.DrugsToSell) do
		if Config.FrameworkFunctions.GetItemByName(src, v.item) then
			cb(true)
			hasitem = true
		end
	end
	Wait(200)
	if not hasitem then
		cb(false)
		TriggerClientEvent('Pug:client:DrugSaleNotify', src, "Je hebt geen drug bij?", "error")
	end
end)
if Framework == "ESX" then
    Config.FrameworkFunctions.CreateCallback('Pug:Drugs:check', function(source, cb, item, amount)
        local retval = false
        local Player = FWork.GetPlayerFromId(source)
        local PlayerItem = Player.getInventoryItem(item)
        local Cost = amount or 1
        if PlayerItem then
            if PlayerItem.count >= Cost then
                retval = true
            end
        end
        cb(retval)
    end)
elseif Framework == "QBCore" then
	local function GetFirstSlotByItem(items, itemName)
		if not items then return nil end
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				return tonumber(slot)
			end
		end
		return nil
	end
	local function GetItemByName(source, item)
		local Player = FWork.Functions.GetPlayer(source)
		item = tostring(item):lower()
		local slot = GetFirstSlotByItem(Player.PlayerData.items, item)
		return Player.PlayerData.items[slot]
	end
	Config.FrameworkFunctions.CreateCallback('Pug:Drugs:check', function(source, cb, items, amount)
		local src = source
		local retval = false
		local Player = Config.FrameworkFunctions.GetPlayer(src)
		if not Player then return false end
		local isTable = type(items) == 'table'
		local isArray = isTable and table.type(items) == 'array' or false
		local totalItems = #items
		local count = 0
		local kvIndex = 2
		if amount == 'hidden' then
			amount = 1
		end
		if isTable and not isArray then
			totalItems = 0
			for _ in pairs(items) do totalItems += 1 end
			kvIndex = 1
		end
		if isTable then
			for k, v in pairs(items) do
				local itemKV = {k, v}
				local item = GetItemByName(src, itemKV[kvIndex])
				if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
					count += 1
				end
			end
			if count == totalItems then
				retval = true
			end
		else -- Single item as string
			local item = GetItemByName(src, items)
			if item and (not amount or (item and amount and item.amount >= amount)) then
				retval = true
			end
		end
		cb(retval)
	end)
end