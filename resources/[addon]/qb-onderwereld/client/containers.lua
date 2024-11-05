local QBCore = exports['qb-core']:GetCoreObject()
local RandomObjective = {}
local containerID = 'container'
local called = false
local pilot
local navigator
local dealercar





CreateThread(function()
    while true do
	    Citizen.Wait(1000)
		if called then
			exports["qb-target"]:AddCircleZone(containerID,RandomObjective, 1.0,{
            name = containerID,
		    debugPoly = false, --Config.debugPoly,
		    useZ = true,
            }, { 
            options = {
                {       
                    type = "client",
                    event = "qb-onderwereld:client:branden",
                    -- icon = "",
                    label = "Branden",

                }
            },
            distance = 1.5
            })
	    end		
	end	
end)


function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

RegisterNetEvent('qb-onderwereld:client:start:drugs-call')
AddEventHandler('qb-onderwereld:client:start:drugs-call', function()
if CurrentCops >= Config.MinimumContainerPolice then
    for k, v in pairs(Config.containers) do
        Citizen.SetTimeout(1250, function()
			TriggerServerEvent('qb-onderwereld:server:removenummer')
			TriggerEvent('inventory:client:set:busy', true)
            loadAnimDict('cellphone@')
            TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_text_to_call', 3.0, 3.0, -1, 50, 0, false, false, false)
            local Time = 5
			TriggerServerEvent("InteractSound_SV:PlayOnSource", "ringing", 0.2)
            Citizen.Wait(6500)
			TriggerServerEvent("InteractSound_SV:PlayOnSource", "containers", 0.5) 
            Citizen.SetTimeout(10000, function()
                RandomObjective = Config.containers.locations[math.random(1, #Config.containers[k])]
                TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                    sender = Config.dealernaam,
                    subject = "Ophaal Locatie",
                    message = "Ga naar!, <br><br>Locatie: <b>"..Config.locatienaam.."</b><br><br> Zorg dat je alleen bent en wees snel! <br><br>Met vriendelijke groet,<br><br><b>"..Config.dealernaam..'</b>',
                    button = {
                        enabled = true,
                        buttonEvent = "qb-onderwereld:client:start:pickup:drugs",
                        buttonData = RandomObjective
                    }
                })
                TriggerEvent('inventory:client:set:busy', false)
                ClearPedTasks(PlayerPedId())
            end)
        end)
    end
else
    QBCore.Functions.Notify("Minimaal "..Config.MinimumContainerPolice.."Politie nodig")
end	
end)

RegisterNetEvent('qb-onderwereld:client:start:pickup:drugs')
AddEventHandler('qb-onderwereld:client:start:pickup:drugs', function(PickupData)
	SetNewWaypoint(RandomObjective)
	called = true
end)



RegisterNetEvent("qb-onderwereld:client:branden",function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	exports['qb-target']:RemoveZone(containerID)
	called = false
	local chance = math.random(1, 5)
    if chance < 5 then
	    spawngoon()
		exports['ps-dispatch']:ContainerRobbery()	
	elseif chance < 3 then
        exports['ps-dispatch']:ContainerRobbery()	
	end
	-- TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    -- TaskPlayAnim(PlayerPedId(), 'cellphone@', 'WORLD_HUMAN_WELDING', 3.0, 3.0, -1, 50, 0, false, false, false)
	QBCore.Functions.Progressbar("start_brand", 'Open branden..', 15000, false, true, {

		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-onderwereld:server:lootdrugs')
		ClearPedTasksImmediately(ped)
        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)



    end)
	
end)

function spawngoon()
    
	local player = GetPlayerPed(-1)
	local pcoords = GetEntityCoords(GetPlayerPed(-1))
	local gangster = Config.npc
	SetPedRelationshipGroupHash(player, GetHashKey("PLAYER"))
	
	
    local DrawCoord = math.random(1, 5)
    if DrawCoord == 1 then
        VehicleCoords = Config.spawn1
    elseif DrawCoord == 2 then
        VehicleCoords = Config.spawn2
    elseif DrawCoord == 3 then
        VehicleCoords = Config.spawn3
    elseif DrawCoord == 4 then
       VehicleCoords = Config.spawn4
    elseif DrawCoord == 5 then
        VehicleCoords = Config.spawn5
    end

    RequestModel(GetHashKey(Config.car))
    while not HasModelLoaded(GetHashKey(Config.car)) do
        Citizen.Wait(0)
    end

    ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
    dealercar = CreateVehicle(GetHashKey(Config.car), VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 52.0, true,
        true)
    SetEntityAsMissionEntity(dealercar)

    --
    RequestModel(gangster)
    while not HasModelLoaded(gangster) do
        Wait(10)
    end
    pilot = CreatePed(26, gangster, VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true, false)
    navigator = CreatePed(26, gangster, VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true,
        false)
    SetPedIntoVehicle(pilot, dealercar, -1)
    SetPedIntoVehicle(navigator, dealercar, 0)
    SetPedCombatAttributes(pilot, 46, 1)
    SetPedCombatAbility(pilot, 2)
    SetPedCombatMovement(pilot, 3)
    SetPedCombatRange(pilot, 2)
    GiveWeaponToPed(pilot, GetHashKey(Config.weapon), 250, false, true)
	TaskVehicleShootAtPed(pilot, player, 100)
    --
    SetPedCombatAttributes(navigator, 46, 1)
    SetPedCombatAbility(navigator, 2)
    SetPedCombatMovement(navigator, 3)
    SetPedCombatRange(navigator, 2)
	AddRelationshipGroup('HeistGuards')
	SetPedRelationshipGroupHash(pilot, GetHashKey("HeistGuards"))
    SetPedRelationshipGroupHash(navigator, GetHashKey("HeistGuards"))	
	SetRelationshipBetweenGroups(0, GetHashKey('HeistGuards'), GetHashKey('HeistGuards'))
	SetRelationshipBetweenGroups(5, GetHashKey('HeistGuards'), GetHashKey("PLAYER"))
    GiveWeaponToPed(navigator, GetHashKey(Config.weapon), 250, false, true)
    TaskVehicleShootAtPed(navigator, player, 100)
	TaskVehicleDriveToCoord(pilot, GetVehiclePedIsIn(pilot, false), pcoords.x, pcoords.y, pcoords.z, 20.00, 1, GetVehiclePedIsIn(pilot, false), 786468, 7.0, true)
    
	CreateThread(function()

	    exports['qb-target']:AddTargetModel(gangster, {
	            options = {
                    {
                       
					   action = function()
                            loot(k)
                       end,
					   type = "client",
                       label = "Persoon beroven",


                    },
                },

            distance = 2.5
        })


    end)
	function loot()
	    TriggerServerEvent('qb-onderwereld:server:loot')
		exports['qb-target']:RemoveTargetModel(gangster)
	end
end	




local wasinzone = false
local lostnoty = false
CreateThread(function()
	while true do
        Wait(4)
		local carCoords = GetEntityCoords(dealercar)
		local pcoords = GetEntityCoords(GetPlayerPed(-1))
		local dist = #(pcoords - carCoords)
        if dist < 5.5 then
		    wasinzone = true
            ClearPedTasks(pilot)
			TaskVehicleFollow(pilot, GetVehiclePedIsIn(pilot, false), GetPlayerPed(-1), 0, 180.0, 5)
		
        elseif dist > 140 then
		    if wasinzone then
			    if not lostnoty then
					lostnoty = true
					wasinzone = false
					ClearPedTasks(pilot)
					TaskVehicleDriveToCoord(pilot, GetVehiclePedIsIn(pilot, false), 0, 0, 0, 30.00, 1, GetVehiclePedIsIn(pilot, false), 786468, 7.0, true)
					Wait(20000)
					DeletePed(pilot)
					DeletePed(navigator)
					DeleteVehicle(dealercar)
				end	
		    end
		end
        Wait(3)
    end
end)
