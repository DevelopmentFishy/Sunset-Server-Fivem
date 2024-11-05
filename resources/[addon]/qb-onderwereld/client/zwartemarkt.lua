local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
------------------------------
 -- RESOURCE START/LOAD IN --
------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        LocateGuy()
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    LocateGuy()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


function LocateGuy()
    exports['qb-target']:AddBoxZone("locateguy", vector3(-1156.86, -1516.59, 10.63), 0.9, 1, {
        name="locateguy",
        heading=306,
        --debugPoly=true,
        minZ=10.23,
        maxZ=10.83,
    }, {
        options = {
            {
                event = "qb-blackmarket:client:tracktheguy",
                icon = "fa-solid fa-location-dot",
                label = "Dealer",
            },
        },
        distance = 2.5
    })
end



function DeleteMarketGuy()
    if DoesEntityExist(marketguy) then
        DeletePed(marketguy)
    end
end

function TrackBlip()
	tracked = AddBlipForCoord(findme.x, findme.y, findme.z)
    SetBlipSprite(tracked, 162)
    SetBlipColour(tracked, 1)
    SetBlipAlpha(tracked, 200)
    SetBlipDisplay(tracked, 4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Dealer Location")
    EndTextCommandSetBlipName(tracked)

    SetTimeout(120000, function() --2 minutes then removes blip from map.
        QBCore.Functions.Notify("Blip is verlopen.", 'error')
        RemoveBlip(tracked)
    end)
end


CreateThread(function()
    while true do
        Wait(5)
        local hours = GetClockHours()
        if hours >= Config.Open or hours < Config.Close then
                RequestModel(GetHashKey(Config.Model))
                while not HasModelLoaded(GetHashKey(Config.Model)) do
                    Wait(0)
                end

                if not DoesEntityExist(marketguy) then

                    local pickaspotbro = math.random(#Config.Locations)
                
                    marketguy = CreatePed(0, GetHashKey(Config.Model) , Config.Locations[pickaspotbro].x, Config.Locations[pickaspotbro].y, Config.Locations[pickaspotbro].z, Config.Locations[pickaspotbro].w, false, false)

                    SetEntityAsMissionEntity(marketguy)
                    SetPedFleeAttributes(marketguy, 0, 0)
                    SetBlockingOfNonTemporaryEvents(marketguy, true)
                    SetEntityInvincible(marketguy, true)
                    FreezeEntityPosition(marketguy, true)
                    TaskStartScenarioInPlace(marketguy, "WORLD_HUMAN_AA_SMOKE", 0, true)

                    exports['qb-target']:AddTargetEntity(marketguy, {
                        options = {
                            { 
                                icon = "fa-solid fa-comments",
                                label = "Talk to Stranger",
                                action = function(entity)
                                    exports["rpemotes"]:EmoteCommandStart("think4")
                                    QBCore.Functions.Progressbar("negotiate", "Uw gegevens checken controleren..", 7500, false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function()
                                        ClearPedTasks(PlayerPedId())
                                        if PlayerJob.name ~= "police" then
                                            exports['qb-menu']:openMenu({
                                                {
                                                    header = "Blackmarket",
                                                    isMenuHeader = true
                                                },
                                                {
                                                    header = "Bekijk aanbod",
                                                    icon = "fa-solid fa-box-open",
                                                    params = {
                                                        event = 'qb-blackmarket:openshop'
                                                    }
                                                },
                                                {
                                                    header = "Sluit menu",
                                                    txt = "",
                                                    icon = "fa-solid fa-angle-left",
                                                    params = {
                                                        event = 'qb-menu:closeMenu'
                                                    }
                                                },
                                            })
                                        else
                                            QBCore.Functions.Notify("Ga weg van mij varkentje!", "error")
                                        end
                                    end)
                                end,
                            },
                        },
                        distance = 2.5,
                    })
                end
        else
            DeleteMarketGuy()
        end
    end
end)

--------------------
-- OPEN STORE --
--------------------

RegisterNetEvent('qb-blackmarket:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('qb-blackmarket:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('qb-blackmarke:client:setDealerItems', function(itemData, amount)
    Config.Products[itemData.slot].amount = Config.Products[itemData.slot].amount - amount
end)


local currentDealer = nil
RegisterNetEvent("qb-blackmarket:openshop", function()
    local repItems = {}
	repItems.label = "Blackmarket"
    repItems.items = {}
	repItems.maxweight = 4000000
    repItems.slots = 30
    for k, v in pairs(Config.Products) do
        -- if QBCore.Functions.GetPlayerData().metadata["drugsrep"] >= Config.Products[k].minrep then
            repItems.items[k] = Config.Products[k]
        -- end
    end

    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Black_", repItems)
end)



-- function HackingSuccess(success)
--     if success then
--         -- TriggerEvent('mhacking:hide')
--         findme = GetEntityCoords(marketguy)
--         SetNewWaypoint(findme.x, findme.y)
--         TrackBlip()
--         QBCore.Functions.Notify("Dealer gevonden. Hun locatie is nu gemarkeerd op uw GPS", "primary", 6000)
--         TriggerEvent('animations:client:EmoteCommandStart', {"c"})
--     else
--         -- TriggerEvent('mhacking:hide')
--         QBCore.Functions.Notify("You failed the hack.", "error")
--         TriggerEvent('animations:client:EmoteCommandStart', {"c"})
--     end
-- end


RegisterNetEvent('qb-blackmarket:client:tracktheguy')
AddEventHandler('qb-blackmarket:client:tracktheguy', function()
    if DoesEntityExist(marketguy) then
        -- TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        exports["rpemotes"]:EmoteCommandStart("type")
        QBCore.Functions.Progressbar("locate_guy", "Proberen de dealer te vinden..", 10500, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        -- TriggerEvent('animations:client:EmoteCommandStart', {"texting"})
        exports["rpemotes"]:EmoteCommandStart("texting")
        Wait(1000)
        -- TriggerEvent("mhacking:show")
	    -- TriggerEvent("mhacking:start", 6, 15, HackingSuccess)
        exports['ps-ui']:VarHack(function(success)
            if success then
                 -- TriggerEvent('mhacking:hide')
                findme = GetEntityCoords(marketguy)
                SetNewWaypoint(findme.x, findme.y)
                TrackBlip()
                QBCore.Functions.Notify("Dealer gevonden. Hun locatie is nu gemarkeerd op uw GPS", "primary", 6000)
            --    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
               exports["rpemotes"]:EmoteCommandStart("c")          
            else
                QBCore.Functions.Notify("You failed the hack.", "error")
                exports["rpemotes"]:EmoteCommandStart("c")
                -- TriggerEvent('animations:client:EmoteCommandStart', {"c"})   
            end
         end, 4, 3) -- Number of Blocks, Time (seconds)
        end)
    else
        QBCore.Functions.Notify("Het is te vroeg om dit te doen. Kom later terug.", "error")
    end
end)


AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        DeleteMarketGuy()
        exports['qb-target']:RemoveZone("locateguy")
	end 
end)



--//Telefoon wapens
RegisterNetEvent('qb-onderwereld:client:start:wapen-call')
AddEventHandler('qb-onderwereld:client:start:wapen-call', function()
    if not DoingSomething then
        DoingSomething = true
        local RandomObjective = {}
        local RandomValue = math.random(1, 2)
        local RandomAmount = math.random(60, 60)
        local RandomItem = {[1] = 'rifle_ammo'}--, [2] = 'packed-blueprint-brick'}
        local RandomName = {[1] = 'OG', [2] = 'Brain'}
        Citizen.SetTimeout(1250, function()
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['telefoonnummerprints'], "remove")
			TriggerEvent('inventory:client:set:busy', true)
            loadAnimDict('cellphone@')
            TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_text_to_call', 3.0, 3.0, -1, 50, 0, false, false, false)
            local Time = 5
            --repeat
              --Time = Time -1
			  TriggerServerEvent("InteractSound_SV:PlayOnSource", "ringing", 0.2)
              Citizen.Wait(6500)
            --until Time == 0
            if RandomValue == 1 then
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "wapensdealer", 0.7) 
            elseif RandomValue == 2 then
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "wapensdealer", 0.7)  
            end
            Citizen.SetTimeout(10000, function()
                RandomObjective = Config.RandomLocation[math.random(1, #Config.RandomLocation)]
                RandomObjective['Name'] = RandomName[math.random(1, #RandomName)]
                RandomObjective['Amount'] = RandomAmount
                RandomObjective['ItemName'] = RandomItem[math.random(1, #RandomItem)]
                TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                    sender = RandomObjective['Name'],
                    subject = "Ophaal Locatie",
                    message = "Ga naar!, <br><br>Locatie: <b>"..RandomObjective["Street"].."</b><br><br> Zorg dat je alleen bent en wees snel! <br><br>Met vriendelijke groet,<br><br><b>"..RandomObjective['Name']..'</b>',
                    button = {
                        enabled = true,
                        buttonEvent = "qb-onderwereld:client:start:pickup:wapen",
                        buttonData = RandomObjective
                    }
                })
                TriggerEvent('inventory:client:set:busy', false)
                ClearPedTasks(PlayerPedId())
            end)
        end)
    end
end)

local startded = false
RegisterNetEvent('qb-onderwereld:client:start:pickup:wapen')
AddEventHandler('qb-onderwereld:client:start:pickup:wapen', function(PickupData)
    local DoingJob = true
    local JobData = PickupData
	SetNewWaypoint(JobData.coords.x, JobData.coords.y)
    while DoingJob do
        Citizen.Wait(4)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local Distance = GetDistanceBetweenCoords(PlayerCoords, JobData.coords.x, JobData.coords.y, JobData.coords.z, true)
        if Distance <= 10.0 then
			RequestModel(GetHashKey("ig_gustavo"))
	        while not HasModelLoaded(GetHashKey("ig_gustavo")) do
            Wait(10)
	        end
			if not startded then
				startded = true
			    local npc = CreatePed(1, 0xB585B217, JobData.coords.x, JobData.coords.y, JobData.coords.z, false, true)
			    ped = npc
		        FreezeEntityPosition(npc, true)	
		        SetEntityHeading(npc, JobData.coords.w)
		        SetEntityInvincible(npc, true)
		        SetBlockingOfNonTemporaryEvents(npc, true)
		        RequestAnimDict("amb@world_human_aa_smoke@male@idle_a")
		        while not HasAnimDictLoaded("amb@world_human_aa_smoke@male@idle_a") do
		        Citizen.Wait(100)
		        end
	
		        local netScene2 = CreateSynchronizedScene(JobData.coords.x, JobData.coords.y, JobData.coords.z, vec3(0.0, 0.0, 0.0), 2)
		        TaskSynchronizedScene(npc, netScene2, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", 1.0, -4.0, 261, 0, 0)
		        SetSynchronizedSceneLooped(netScene2, 1)
		        SetModelAsNoLongerNeeded(model)


			
			end	

		end
		if Distance <= 2.0 then
			DrawText3D(JobData.coords.x, JobData.coords.y, JobData.coords.z + 0.1, '~g~E~s~ - Bestelling')
            if IsControlJustReleased(0, 38) then
                QBCore.Functions.TriggerCallback('qb-onderwereld:server:blueprintnummer', function(HasItem)
				    if HasItem then
						TriggerServerEvent('qb-onderwereld:server:removenummerwapens')
				        local ShopItems = {}
                        ShopItems.label = "Dealer"
                        ShopItems.items = Config.wapens
                        ShopItems.slots = #Config.wapens
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "StreetDealer_"..math.random(0, 1), ShopItems)
                        DoingSomething = false
						DoingJob = false
						Citizen.Wait(30000)
						DeletePed(ped)						
			            
					else
					    QBCore.Functions.Notify('Zonder het telefoon nummer kan je hier niets komen doen bestevriend..', 'error')
					end
				end)		
            end
        end
    

	end
end)

function DrawText3D(x, y, z, text)
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(true)
 AddTextComponentString(text)
 SetDrawOrigin(x,y,z, 0)
 DrawText(0.0, 0.0)
 ClearDrawOrigin()
end