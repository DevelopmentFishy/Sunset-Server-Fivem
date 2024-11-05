local QBCore = exports["qb-core"]:GetCoreObject()

local Webhook = ''

local sellingVehicles = {}

RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	if sellingVehicles["veh_".._source] == nil then return end

	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local tPlayer = QBCore.Functions.GetPlayer(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	
	MySQL.query('SELECT * FROM player_vehicles WHERE citizenid = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
		['@plate'] = plate:match( "^%s*(.-)%s*$" )
	}, function(result)
		if Config.RemoveMoneyOnSign then
			local bankMoney = tPlayer.PlayerData.money.bank

			if result[1] ~= nil  then
				if bankMoney >= vehicle_price then
					MySQL.query('UPDATE player_vehicles SET citizenid = @target, license = @license WHERE citizenid = @owner AND plate = @plate', {
						['@owner'] = xPlayer.PlayerData.citizenid,
						['@target'] = tPlayer.PlayerData.citizenid,
						['@license'] = xPlayer.PlayerData.license,
						['@plate'] = plate:match( "^%s*(.-)%s*$" )
					}, function (result2)
						if result2 ~= 0 then	
							tPlayer.Functions.RemoveMoney('bank', vehicle_price)
							xPlayer.Functions.AddMoney('bank', vehicle_price)
							sellingVehicles["veh_".._source] = nil

							if Config.UseOkokBankingTransactions then
								TriggerEvent('okokBanking:AddNewTransaction', source_name, xPlayer.PlayerData.citizenid, target_name, tPlayer.PlayerData.citizenid, vehicle_price, 'Vehicle Sale')
							end

							TriggerClientEvent("vehiclekeys:client:SetOwner", target, plate)
							TriggerEvent("vehiclekeys:server:RemoveKeys", plate, xPlayer.PlayerData.citizenid)
							TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Je hebt het voertuig verkocht<b>"..model.."</b> Met nummerplaat <b>"..plate.."</b>", 10000, 'success')
							TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "Je hebt het voertuig gekocht <b>"..model.."</b> Met nummerplaat <b>"..plate.."</b>", 10000, 'success')

							if Webhook ~= '' then
								sellVehicleWebhook(webhookData)
							end
						end
					end)
				else
					TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", target_name.." Je hebt niet genoeg geld om dit voertuig te kopen", 10000, 'error')
					TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "Je hebt niet genoeg geld om dit te kopen "..source_name.."'s Voertuig", 10000, 'error')
				end
			else
				TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Het voertuig met nummerplaat <b>"..plate.."</b> Is nu van jou!", 10000, 'error')
				TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." Probeerd een voertuig te verkopen die niet van hem is", 10000, 'error')
			end
		else
			if result[1] ~= nil then
				MySQL.query('UPDATE player_vehicles SET citizenid = @target, license = @license WHERE citizenid = @owner AND plate = @plate', {
					['@owner'] = xPlayer.PlayerData.citizenid,
					['@target'] = tPlayer.PlayerData.citizenid,
					['@license'] = xPlayer.PlayerData.license,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then
						sellingVehicles["veh_".._source] = nil
						TriggerClientEvent("vehiclekeys:client:SetOwner", target, plate)
						TriggerEvent("vehiclekeys:server:RemoveKeys", plate, xPlayer.PlayerData.citizenid)
						TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "You successfully sold the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')
						TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "You successfully bought the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "Het voertuig met nummerplaat <b>"..plate.."</b> Is niet van jou", 10000, 'error')
				TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." Probeerd een voertuig te verkopen die waar hij/zij geen eigenaar van is", 10000, 'error')
			end
		end
	end)
end)

QBCore.Functions.CreateCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = QBCore.Functions.GetPlayer(targetid)
	local targetname = target.PlayerData.charinfo.firstname..' '..target.PlayerData.charinfo.lastname

	cb(targetname)
end)

QBCore.Functions.CreateCallback('okokContract:checkIfOwnsVehicle', function(source, cb, plate)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('SELECT * FROM player_vehicles WHERE citizenid = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
		['@plate'] = plate:match( "^%s*(.-)%s*$" )
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('okokContract:Checker')
AddEventHandler('okokContract:Checker', function(plate)
	local _source = source

	sellingVehicles["veh_".._source] = {
		plate = plate
	}
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if sellingVehicles["veh_".._source] ~= nil then
		TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
		TriggerClientEvent('okokContract:startContractAnimation', data.targetID)
	end

	if Config.RemoveContractAfterUse then
		xPlayer.Functions.RemoveItem('contract', 1)
	end
end)

QBCore.Functions.CreateUseableItem('contract', function(source)
	local _source = source

	if Config.UseOkokRequests then
		TriggerClientEvent('okokContract:doRequest', _source)
	else
		TriggerClientEvent("okokContract:OpenContractInfo", _source)
	end
end)

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'VEHICLE SALE',
			["description"] = '**Vehicle: **'..data.model..'**\nPlate: **'..data.plate..'**\nBuyer name: **'..data.target_name..'**\nSeller name: **'..data.source_name..'**\nPrice: **'..data.vehicle_price..'€',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end