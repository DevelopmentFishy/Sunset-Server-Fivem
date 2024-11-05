local QBCore = exports['qb-core']:GetCoreObject()

local debugProps, sitting, lastPos, currentSitCoords, currentScenario, occupied = {}
local curobjpos = nil
local playerPos = nil
local disableControls = false
local currentObj = nil
local ped = nil
local ActiveChairs = {}

exports('sitting', function()
    return sitting
end)

local function displayNUIText()
    SendNUIMessage({type = "display", text = Config.GetUpText, color = 'rgb(100 100 100)'})
    Wait(0)
end

local function hideNUI()
    SendNUIMessage({type = "hide"})
    Wait(0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
        if LocalPlayer.state.isLoggedIn then
			if sitting and not IsPedUsingScenario(ped, currentScenario) then
				TaskStartScenarioAtPosition(ped, currentScenario, curobjpos.x, curobjpos.y, curobjpos.z, GetEntityHeading(ped), 0, true, false)			
				--wakeup()
			end

			if sitting and isCurDead then
				wakeup()
			end

			if IsControlPressed(0, 23) then
				if sitting then
					wakeup()
				end			
			end
		end
	end
end)

CreateThread(function()
	while true do
        if LocalPlayer.state.isLoggedIn then
			if QBCore.Functions.GetPlayerData().metadata["isdead"] or QBCore.Functions.GetPlayerData().metadata["inlaststand"] then
				isCurDead = true
			else
				isCurDead = false
			end
		end
		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		ped = PlayerPedId()
		Wait(1000)
	end
end)


Citizen.CreateThread(function()
	local Sitables = {}

	for k,v in pairs(Config.Interactables) do
		local model = GetHashKey(v)
		table.insert(Sitables, model)
	end

	Citizen.Wait(100)
	exports['qb-target']:AddTargetModel(Sitables, {
        options = {
            {
                event = "qb-Sit:Sit",
                icon = "fas fa-chair",
                label = "Sit Down",
				entity = entity,
				canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
				  if ActiveChairs[entity] then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
				  return true
				end,
            },
        },
        job = {"all"},
        distance = Config.MaxDistance,
    })
	for k, v in pairs(Config.SitPoints) do
		exports['qb-target']:AddBoxZone("Sitpoint"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.75, 0.75, {
			name = "Sitpoint"..k,
			heading = v.coords.w,
			debugPoly = false,
			minZ = v.coords.z - 0.5,
			maxZ = v.coords.z + 0.5,
		}, {
		options = {
			{
				type = "client",
				event = "qb-Sit:SitPoint",
				icon = "fas fa-chair",
				label = "Sit Down",
				sitpoint = k,
				coords = v.coords
			},
		},
		distance = 2.5
		})
	end
end)

RegisterNetEvent('qb-sit:client:updatechairs', function(entity, bool)
    if bool then
		ActiveChairs[entity] = true
    else
        ActiveChairs[entity] = nil
    end
end)

RegisterNetEvent("qb-Sit:Sit", function(data)
	local playerPed = PlayerPedId()

	if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
		wakeup()
	end

	if disableControls then
		DisableControlAction(1, 37, true)
	end

	local object, hash = data.entity, GetEntityModel(data.entity)

	for k,v in pairs(Config.Sitable) do
		if GetHashKey(k) == hash then
			sit(object, k, v)
			break
		end
	end
end)

RegisterNetEvent("qb-Sit:SitPoint", function(data)
	local playerPed = PlayerPedId()

	if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
		wakeup()
	end

	if disableControls then
		DisableControlAction(1, 37, true)
	end

	sitpoint(data.sitpoint, data.coords)
end)


function wakeup()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())
	
	hideNUI()

	TaskStartScenarioAtPosition(playerPed, currentScenario, 0.0, 0.0, 0.0, 180.0, 2, true, false)
	while IsPedUsingScenario(PlayerPedId(), currentScenario) do
		Citizen.Wait(100)
	end
	ClearPedTasks(playerPed)

	FreezeEntityPosition(playerPed, false)
	TriggerServerEvent('qb-sit:leavePlace', currentSitCoords)
	currentSitCoords, currentScenario = nil, nil
	sitting = false
	disableControls = false
end

function sit(object, modelName, data)
	if not HasEntityClearLosToEntity(PlayerPedId(), object, 17) then
		return
	end
	
	disableControls = true
	currentObj = object
	FreezeEntityPosition(object, true)

	playerPos = GetEntityCoords(PlayerPedId())
	curobjpos = GetEntityCoords(object)
	curobjpos = vector3(curobjpos.x, curobjpos.y, curobjpos.z + (playerPos.z - curobjpos.z)/2)
	local objectCoords = curobjpos

	QBCore.Functions.TriggerCallback('qb-sit:getPlace', function(occupied)
		if occupied then
			QBCore.Functions.Notify('Chair is being used.', 'error')
		else
			local playerPed = PlayerPedId()
			lastPos, currentSitCoords = GetEntityCoords(playerPed), objectCoords

			displayNUIText()
			TriggerServerEvent('qb-sit:takePlace', objectCoords)
			
			currentScenario = data.scenario
			TaskStartScenarioAtPosition(playerPed, currentScenario, curobjpos.x, curobjpos.y, curobjpos.z - data.verticalOffset, GetEntityHeading(object) + 180.0, 0, true, false)

			Citizen.Wait(2500)
			if GetEntitySpeed(PlayerPedId()) > 0 then
				ClearPedTasks(PlayerPedId())
				TaskStartScenarioAtPosition(playerPed, currentScenario, curobjpos.x, curobjpos.y, curobjpos.z - data.verticalOffset, GetEntityHeading(object) + 180.0, 0, true, true)
			end

			sitting = true
		end
	end, objectCoords)
end

function sitpoint(sitpoint, coords)
	disableControls = true

	playerPos = GetEntityCoords(PlayerPedId())
	curobjpos = coords
	local objectCoords = coords.x .. coords.y .. coords.z

	QBCore.Functions.TriggerCallback('qb-sit:getPlace', function(occupied)
		if occupied then
			QBCore.Functions.Notify('Someone is already sitting here.', 'error')
		else
			local playerPed = PlayerPedId()
			lastPos, currentSitCoords = GetEntityCoords(playerPed), objectCoords

			TriggerServerEvent('qb-sit:takePlace', objectCoords)
			
			currentScenario = 'PROP_HUMAN_SEAT_BENCH'
			TaskStartScenarioAtPosition(playerPed, currentScenario, coords.x, coords.y, coords.z, coords.w, 0, true, false)

			Citizen.Wait(2500)
			if GetEntitySpeed(PlayerPedId()) > 0 then
				ClearPedTasks(PlayerPedId())
				TaskStartScenarioAtPosition(playerPed, currentScenario, coords.x, coords.y, coords.z, coords.w, 0, true, true)
			end

			sitting = true
		end
	end, objectCoords)
end
