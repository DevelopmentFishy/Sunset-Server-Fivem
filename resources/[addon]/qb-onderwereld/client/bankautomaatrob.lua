local QBCore = exports['qb-core']:GetCoreObject()
local destroidlocation = {}
local destroid = false
local bankautomaat = 'automa'
local AtmModels = {}
CurrentCops = 0


RegisterNetEvent('qb-onderwereld:client:startcount')
AddEventHandler('qb-onderwereld:client:startcount', function()	
if CurrentCops >= Config.MinimumbankautomaatPolice then
    for k, v in pairs(Config.automaaten) do
		local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.coords, false)
        if dist < 0.7 then
			RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
			while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
				Citizen.Wait(0)
			end
				
			TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
		    QBCore.Functions.Progressbar("start_bomb", 'Bomplaatsen..', 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
		        ClearPedTasks(ped)

            end)
			Wait(10000)
			TriggerServerEvent('qb-onderwereld:server:removebomb')
			TriggerServerEvent("qb-onderwereld:server:zetstatus", "IsBezet", true, k)
			TriggerServerEvent("qb-onderwereld:server:zetstatus", "defect", true, k)
	        TriggerServerEvent("qb-onderwereld:server:ZetDefectTijd")
			Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 10','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 9','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 8','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 7','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 6','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 5','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 4','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 3','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 2','left')
		    Wait(1000)
		    exports['jg-textui']:DrawText('ontplofing in 1','left')
		    exports['jg-textui']:HideText()
		    AddExplosion(v.coords, 2, 50.0, true, false, true)
			exports['ps-dispatch']:Atmrobbery()
			exports['ps-dispatch']:Explosion()
			local cashProp = GetHashKey("bkr_prop_bkr_cashpile_02")
		    RequestModel(cashProp)
		    while not HasModelLoaded(cashProp) do
			    Citizen.Wait(100)
		    end
		    local dropCoords = vector3(v.coords.x, v.coords.y, v.coords.z-1.4)
			local cashPile = CreateObject(cashProp, dropCoords, true)
			FreezeEntityPosition(cashPile, true)
			TriggerServerEvent('qb-onderwereld:server:propje',cashProp)

			CreateThread(function()
	           exports['qb-target']:AddTargetModel(cashProp, {
	                options = {
                      {
                       
			        action = function()
                              lootgeld()
                            end,
			 		        type = "client",
                            label = "Geldverzamelen",


                         },
                    },

                     distance = 2.5
                })


            end)
	        function lootgeld()
		        exports['qb-target']:RemoveTargetModel(cashProp)
                local ped = GetPlayerPed(-1);
				RequestAnimDict("pickup_object")
				while not HasAnimDictLoaded("pickup_object") do
					Citizen.Wait(0)
				end
				
			    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
				QBCore.Functions.Progressbar("start_rapen", 'Geldverzamelen..', 40000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('qb-onderwereld:server:lootmoney')
		            DeleteObject(cashPile)
		            ClearPedTasks(ped)

                end)
				
	        end
		end	
    end 
else
	QBCore.Functions.Notify("Minimaal "..Config.MinimumbankautomaatPolice.."Politie nodig")
end
end)

RegisterNetEvent('qb-onderwereld:client:target')
RegisterNetEvent("qb-onderwereld:client:target", function(cashProp)
   print(cashProp)
   exports['qb-target']:AddTargetModel(cashProp, {
	    options = {
            {
             
				action = function()
                    lootgeld()
                end,
				type = "client",
                label = "Geldverzamelen",
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	exports['qb-target']:RemoveZone(bankautomaat)
end)

RegisterNetEvent("qb-onderwereld:client:krijgstatus", function(fase, staat, k)
    Config.automaaten[k][fase] = staat
end)


CreateThread(function () 
	for k, v in pairs(Config.automaaten) do
	exports['qb-target']:AddTargetModel(Config.ATmModels,
	{
		options = {
			{
				type = "server",
				event = "qb-onderwereld:server:planten",
				icon = "fa-solid fa-bomb",
				label = "Atm beroven",
				canInteract = function(entity)
					local PlyData = QBCore.Functions.GetPlayerData()
					local hasItem = false
			    	for k, v in pairs(PlyData.items) do
                    	if v.name == 'zfmbomb' then hasItem = true end
                	end
					if v["defect"] or v["IsBezet"] then
                    	return false
                	end
                		if hasItem then
				    		return true
						end	
					end
				},
			},
				distance = 1.5,
		})
	end
end)
