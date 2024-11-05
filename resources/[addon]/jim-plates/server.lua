local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	if Config.UseCommand then
		QBCore.Commands.Add(Config.Command, Loc[Config.Lan].command["change_plate"], {}, false, function(source, args) TriggerClientEvent("jim-plates:client:setplate:Menu", source, false) end)
	end
	if Config.UseItem then
		QBCore.Functions.CreateUseableItem("newplate", function(source, item) TriggerClientEvent("jim-plates:client:setplate:Menu", source, true) end)
	end
end)

RegisterNetEvent("jim-plates:server:setplate", function(data)
	local src = source
	data.src = src
	--Check if owner is online before changing the plates.
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: [^6"..data.currentplate.."^6] ^2Check if owner is online before changing the plates^7...") end
	local playercheck = MySQL.scalar.await('SELECT citizenid FROM player_vehicles WHERE plate = ?', {data.currentplate})
	local playeronline = false
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then if Player.PlayerData.citizenid == playercheck then
			playeronline = true
			if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Player Online^7!") end
		end end
	end
	if not playeronline then
		if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Player ^1NOT ^2Online^7!") end
		triggerNotify(nil, Loc[Config.Lan].error["owner_not_online"], "error", src)
		return
	end

	--Check if plate is already in use
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Check if ^7'^2new^7' ^2plate is already in use^7...") end
	local platecheck = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {data.newplate})
	if platecheck[1] then
		if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Plate already in use^7.") end
		triggerNotify(nil, Loc[Config.Lan].error["already_exists"], "error", src)
		return
	else if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Plate not in use^7.") end end

	--Grab table id from database
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Grabbing database ID of the vehicle to start transfer^7...") end
	MySQL.update('UPDATE player_vehicles SET plate = ? WHERE plate = ?', {data.newplate, data.currentplate})

	if Config.CoreVehicles then MySQL.update('UPDATE vehicle_parts SET plate = ? WHERE plate = ?', {data.newplate, data.currentplate}) end

	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Plate entry changed for correct vehicle database ID^7.") end

	--Update the cars actual physical plate
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Updating physical plate on the current car^7...") end

	TriggerClientEvent("jim-plates:updatePlate", -1, data)

	--Wait for database to catch up for next steps
	Wait(500)

	--Give the owner of the vehicle the keys to the updated vehicle.
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Grabbing vehicle owners citizenID to give new vehicle keys^7...") end
	local citizenid = MySQL.Sync.fetchAll('SELECT citizenid FROM player_vehicles WHERE plate = ?', {data.newplate})
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			if Player.PlayerData.citizenid == citizenid[1].citizenid then
				if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Giving new keys of vehicle^7[^6"..data.newplate.."^7] ^2to ^7'^6"..citizenid[1].citizenid.."^7'(^6"..Player.PlayerData.source.."^7)") end
				TriggerClientEvent("vehiclekeys:client:SetOwner", Player.PlayerData.source, data.newplate)
			end
		end
	end

	--Update trunk and glovebox database with new plate
	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Transferring ^4trunkitems ^2to new vehicle plate^7...") end
	MySQL.update('UPDATE trunkitems SET plate = ? WHERE plate = ?', {data.newplate, data.currentplate})

	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Transferring ^4gloveboxitems ^2to new vehicle plate^7...") end
	MySQL.update('UPDATE gloveboxitems SET plate = ? WHERE plate = ?', {data.newplate, data.currentplate})
end)

--This call back checks for the players name, but also by doing this checks if the vehicles owned.
QBCore.Functions.CreateCallback('jim-plates:getInfo', function(source, cb, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
	if result and result[1] then
		if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Found info ^7- ^3CitizenID^7: ^6"..result[1].citizenid.."^7") end
		if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Found info ^7- ^3State^7: ^6"..result[1].state.."^7") end
		if result[1].state ~= 3 then
			if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Checking if owner is online^7..") end
			for k, v in pairs(QBCore.Functions.GetPlayers()) do
				local Player = QBCore.Functions.GetPlayer(v)
				if Player then
					if Player.PlayerData.citizenid == result[1].citizenid then
						result = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname
						if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Owner found^7: ^6"..result.."^7") end
						break
					end
				end
			end
			cb(result)
		else cb("Parked") end
	else cb("Not Found") end
end)

RegisterNetEvent("jim-plates:saveInfo", function(mods, plate)
	if Config.Debug then print("^5Debug^7: ^3saveInfo^7: ^2Vehicle Mods ^7- [^6"..plate.."^7]") end
	MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(mods), plate})
end)

local function dupeWarn(src, item)
	local P = QBCore.Functions.GetPlayer(src)
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to remove item ^7('^3"..item.."^7')^2 but it wasn't there^7")
	if not Config.Debug then DropPlayer(src, "^1Kicked for attempting to duplicate items") end
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Dropped from server for item duplicating^7")
end

RegisterNetEvent('jim-plates:server:toggleItem', function(give, item, amount, newsrc)
	local src = newsrc or source
	local Player = QBCore.Functions.GetPlayer(src)
	local remamount = (amount or 1)
	if give == 0 or give == false then
		if HasItem(src, item, amount or 1) then -- check if you still have the item
			while remamount > 0 do if Player.Functions.RemoveItem(item, 1) then end remamount -= 1 end
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
			if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
		else dupeWarn(src, item) end -- if not boot the player
	else
		if Player.Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
		end
	end
end)

local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/jimathy/UpdateVersions/master/jim-plates.txt', function(err, newestVersion, headers)
		local currentVersion = "^3"..GetResourceMetadata(GetCurrentResourceName(), 'version'):gsub("%.", "^7.^3").."^7"
		newestVersion = "^3"..newestVersion:sub(1, -2):gsub("%.", "^7.^3").."^7"
		if not newestVersion then print("Currently unable to run a version check.") return end
		print("^6Version Check^7: ^2Running^7: "..currentVersion.." ^2Latest^7: "..newestVersion)
		print(newestVersion == currentVersion and '^6You are running the latest version.^7 ('..currentVersion..')' or "^1You are currently running an outdated version^7, ^1please update^7!")
	end)
end
CheckVersion()
