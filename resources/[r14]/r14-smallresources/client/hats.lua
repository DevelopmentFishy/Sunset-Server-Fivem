local curhat, curtex = nil, nil
local nightvision = false
local hasItem = false
local animDict, animName = 'veh@bus@bus@driver@idle_duck', 'passenger_sit' -- this animation is used and canceled to fix hats dissapearing, it's jank but works...

if GetUsingnightvision() then SetNightvision(false) end -- remove night vision if script is restarted in runtime

local function RequiredItemCheck()
	local PlayerData = QBCore.Functions.GetPlayerData()

	for k, v in pairs(PlayerData.items) do		
		if Config.PedImprovements.EnableNightvision.Items[v.name] then return true end
	end

	return false
end

if Config.PedImprovements.EnableNightvision.Enabled or Config.PedImprovements.KeepHatsInVehicle then
	CreateThread(function()
		while true do
			curhat = GetPedPropIndex(ped, 0)
			curtex = GetPedPropTextureIndex(ped, 0)
			pedmod = GetEntityModel(ped)

			if prevhat ~= curhat then hasItem = false end

			prevhat = curhat

			if not hasItem and Config.PedImprovements.EnableNightvision.RequireItem and pedmod and Config.PedImprovements.EnableNightvision.Hats[pedmod] and Config.PedImprovements.EnableNightvision.Hats[pedmod][curhat] then hasItem = RequiredItemCheck() end
	
			Wait(1000)
		end
	end)



	if Config.PedImprovements.KeepHatsInVehicle then
		AddEventHandler('gameEventTriggered', function (name, args) -- checks when ped enters a vehicle to reapply their hat
			if name == 'CEventNetworkPlayerEnteredVehicle' and curhat ~= -1 then
				if GetPedPropIndex(ped, 0) ~= curhat then
					SetPedPropIndex(ped, 0, curhat, curtex, true)
					
					while not HasAnimDictLoaded(animDict) do
						RequestAnimDict(animDict)
						Wait(100)
					end

					TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 50, 0, false, false, false)
					Wait(20)
					StopEntityAnim(ped, animName, animDict, 1)
				end
			end
		end)
	end
end

if Config.PedImprovements.EnableNightvision.Enabled then
	CreateThread(function() -- checks when ped is wearing a nightvision helmet
		while true do 
			Wait(500)
			if pedmod and Config.PedImprovements.EnableNightvision.Hats[pedmod] and Config.PedImprovements.EnableNightvision.Hats[pedmod][curhat] and (not Config.PedImprovements.EnableNightvision.RequireItem or hasItem) then
				if not nightvision then
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "nv", 0.5) 
					SetNightvision(true)
					nightvision = true
				end
			else
				if nightvision then
					SetNightvision(false)
					Wait(400)
					nightvision = false
				end
			end
		end
	end)
end
