local Ped = nil
RegisterNetEvent('QBCore:Client:OnPlayerLoaded') AddEventHandler('QBCore:Client:OnPlayerLoaded', function() QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job end) Ped = PlayerPedId() end)
RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo end)
AddEventHandler('onResourceStart', function(t) if GetCurrentResourceName() ~= t then return end QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job end) Ped = PlayerPedId() end)

RegisterNetEvent('jim-plates:client:setplate:Menu', function(item) Ped = PlayerPedId()
	if item then -- If item has been used check if job is needed
		if Config.ItemRequireJob and not jobCheck() then triggerNotify(nil, Loc[Config.Lan].error["only_job"], "error") return end
	end
	if not item then -- If Item hasn't been used (/command) then check if job is needed
		if Config.ComRequireJob and not jobCheck() then triggerNotify(nil, Loc[Config.Lan].error["only_job"], "error")	return end
	end
	--Allows use outside and inside vehicle
	local vehicle = not IsPedInAnyVehicle(Ped, false) and GetClosestVehicle(GetEntityCoords(Ped), 4.5, 0, 71) or GetVehiclePedIsIn(Ped, false)

	--Grabs vehicle/owners info
	local trimmedPlate = nil
	if DoesEntityExist(vehicle) then trimmedPlate = trim(GetVehicleNumberPlateText(vehicle))
		if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Using vehicle's current plate ^7[^6"..trimmedPlate.."^7] ^2to find player info from server^7") end
		local p = promise.new()
		QBCore.Functions.TriggerCallback('jim-plates:getInfo', function(cb) p:resolve(cb) end, trimmedPlate)
		if Citizen.Await(p) == "Not Found" then
			triggerNotify(nil, Loc[Config.Lan].error["not_owned"], "error") return
		elseif Citizen.Await(p) == "Parked" then
			triggerNotify(nil, Loc[Config.Lan].error["parked"], "error") return
		else playerinfo = Citizen.Await(p) end
	else
		triggerNotify(nil, Loc[Config.Lan].error["no_vehicle_nearby"], "error") return
	end
	if Config.Debug then print("^5Debug^7: ^3getInfo^7: ^2Info database result: ^7'^6"..playerinfo.."^7'") end

	--Trigger animation
	ExecuteCommand("e clipboard")

	--Grab car info if its available in the shared.
	if Config.Debug then print("^5Debug^7: ^3GetDisplayName^7: ^2Seraching ^4QBCore^7.^4Shared^6.^4Vehicles^7...") end
	local model = QBCore.Shared.Vehicles[GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()] and QBCore.Shared.Vehicles[GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()].name or GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	if Config.Debug then print("^5Debug^7: ^3GetDisplayName^7: ^2Result^7: '^6"..model.."^7'") end

	if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^2Attempting to display ^4Input ^2menu^7...") end
	if Config.Menu == "ox" then
		local dialog = exports.ox_lib:inputDialog("Current Plate: ["..trimmedPlate.."]", { { type = 'input', label = Loc[Config.Lan].menu["max_characters"], min = Config.CharacterReq and 8 or 1, max = 8, placeholder = trimmedPlate, }, })
		if dialog then
			if not dialog[1] then return end
			TriggerEvent('jim-plates:client:setplate', dialog[1], vehicle, item)
		end
	else
		local dialog = exports['qb-input']:ShowInput({
			header = "<center><img src=https://i.imgur.com/ojBmBHi.png width=100px>"..
					"<br>- Customise Plates - <br>"..
					"<br>Owner: "..playerinfo..
					"<br>Vehicle: "..model.."<br>"..
					"<br>Current Plate: ["..trimmedPlate.."]<br>",
			submitText = Loc[Config.Lan].menu["submit"],
			inputs = { { type = 'text', isRequired = true, name = 'plate', text = Loc[Config.Lan].menu["max_characters"], } } })
		if dialog then
			if not dialog.plate then return end
			TriggerEvent('jim-plates:client:setplate', dialog.plate, vehicle, item)
		end
	end
	ExecuteCommand("e c")
end)

RegisterNetEvent('jim-plates:client:setplate', function(arg, vehicle, item) local plateinfo = arg:upper()
	if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2New plate info received, capitilizing: '^6"..arg.."^7' ^2into ^7'^6"..plateinfo.."^7'") end

	--Check for illegal characters
	local input = plateinfo:gsub("[^"..Config.Filter.."]", "")
	if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Filtering out blacklisted characters ^7'^6"..input.."^7'") end

	--If letters have been removed then show error
	if string.len(tostring(input)) ~= string.len(plateinfo) then
		triggerNotify(nil, Loc[Config.Lan].error["illegal_characters"], "error")
		if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Blacklisted letters found^7. ^1Cancelling^7") end
		return
	end

	--Check plate length, I had issues with it being more or less than 8 so I've set a hard limit
	if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Checking plate length^7...") end

	if string.len(plateinfo) > 8 then
		triggerNotify(nil, Loc[Config.Lan].error["too_long"], "error")
		TriggerEvent("jim-mechanic:plate:client:setplate:Menu")
		if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Plate too long^7: '^6"..string.len(plateinfo).." Letters^7' (^18 Max^7)") end
		return
	elseif (string.len(plateinfo) < 8 and Config.CharacterReq) then triggerNotify(nil, Loc[Config.Lan].error["too_short"], "error") TriggerEvent("jim-mechanic:plate:client:setplate:Menu") return end

	if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Checking for blacklisted phrases^7...") end
	for _, v in pairs(Config.BlacklistPhrases) do local v = v:upper()
		if plateinfo:find(v) then
			if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Found blacklisted phrase^7: '^1"..v.."^7'") end
			triggerNotify(nil, "Found blacklisted phrase", "error")
			return
		end
	end
	--Start changing server side stuff
	if Config.Debug then print("^5Debug^7: ^3setplate^7: ^2Accepted^7, ^2sending info to server side^7...") end

	TriggerServerEvent("jim-plates:server:setplate", { vehicle = VehToNet(vehicle), currentplate = trim(GetVehicleNumberPlateText(vehicle)), newplate = input, item = item })
end)

RegisterNetEvent("jim-plates:updatePlate", function(data)
	if Config.Debug then print("^5Debug^7: ^3updatePlate^7: ^2Converitng vehicle ^4NetID^7[^6"..data.vehicle.."^7] ^2back to ^4EntityID^7[^6"..NetToVeh(data.vehicle).."^7]") end
	local vehicle = NetToVeh(data.vehicle)

	if data.src == QBCore.Functions.GetPlayerData().source then
		triggerNotify(nil, Loc[Config.Lan].success["plate_updated"].." ["..data.newplate.."]", "success")
		local Player = QBCore.Functions.GetPlayerData()
		TriggerServerEvent('qb-log:server:CreateLog', 'vehicleupgrades', GetCurrentResourceName() .." - "..Player.charinfo.firstname.." "..Player.charinfo.lastname.."("..Player.id..") ["..Player.citizenid.."]", 'lightgreen',
		"Player changing plate of vehicle [**"..trim(GetVehicleNumberPlateText(vehicle)).."**] to [**"..data.newplate.."**]")
		-- Remove item from player if set to
		if data.item == true and Config.ItemRemoval then
			if Config.Debug then print("^5Debug^7: ^3ItemRemoval^7: ^2Removing plate from players inventory^7...") end
			toggleItem(false, "newplate", 1)
		end
	end
	--Update cars physical plate
	if Config.Debug then print("^5Debug^7: ^3updatePlate^7: ^2Setting vehicle plate^7: [^6"..data.newplate.."^7]") end
	SetVehicleNumberPlateText(vehicle, data.newplate)

	--Update database mod data to reflect the changes
	if Config.Debug then print("^5Debug^7: ^3updatePlate^7: ^2Saving ^4VehicleProperties^2 to assure changes^7...") end
	TriggerServerEvent("jim-plates:saveInfo", QBCore.Functions.GetVehicleProperties(vehicle), data.newplate)

	if GetResourceState("jim-mechanic") == "started" then
		if Config.Debug then print("^5Debug^7: ^3setPlate^7: ^4Jim^7-^4Mechanic ^2found, triggering ^7'^6setupVehicleStatus^7'") end
		TriggerEvent("jim-mechanic:server:setupVehicleStatus", data.newplate, GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle))
	end
end)