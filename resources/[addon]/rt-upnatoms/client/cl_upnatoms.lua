local QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}

CreateThread(function()
    Upnatom = AddBlipForCoord(82.86, 281.48, 110.21)
    SetBlipSprite (Upnatom, 269)
    SetBlipDisplay(Upnatom, 4)
    SetBlipScale  (Upnatom, 0.6)
    SetBlipAsShortRange(Upnatom, true)
    SetBlipColour(Upnatom, 51)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Up n Atoms")
    EndTextCommandSetBlipName(Upnatom)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        UpnatomZones()
    end
end)

AddEventHandler('onResourceStop', function(resourceName) 
    if GetCurrentResourceName() == resourceName then
        for k, v in pairs(Config.Zones) do
            exports['qb-target']:RemoveZone("upnatom"..k)
        end
        DeletePed(jobPed)
    end 
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    UpnatomZones()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    for k, v in pairs(Config.Zones) do
        exports['qb-target']:RemoveZone("upnatom"..k)
    end
    DeletePed(jobPed)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function UpnatomZones()
    for k, v in pairs(Config.Zones) do
        exports['qb-target']:AddCircleZone("upnatom"..k, v.coords, v.radius, {
            name = "upnatom"..k,
            debugPoly = false,
            useZ=true,
        }, {
            options = {
                {
                    type = "client",
                    event = v.event,
                    icon = v.icon,
                    label = v.label,
                    job = v.job,
                },
            },
            distance = 1.5
        })
    end
    if not DoesEntityExist(jobPed) then

        RequestModel(Config.GaragePed) while not HasModelLoaded(Config.GaragePed) do Wait(0) end

	    jobPed = CreatePed(0, Config.GaragePed, Config.PedLocation, false, false)

        SetEntityAsMissionEntity(jobPed, true, true)
	    SetPedFleeAttributes(jobPed, 0, 0)
	    SetBlockingOfNonTemporaryEvents(jobPed, true)
	    SetEntityInvincible(jobPed, true)
	    FreezeEntityPosition(jobPed, true)
	    loadAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a")        
	    TaskPlayAnim(jobPed, "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", 8.0, 1.0, -1, 01, 0, 0, 0, 0)

        exports['qb-target']:AddTargetEntity(jobPed, { 
            options = {
            { 
                type = "client",
                event = "rt-upnatoms:client:jobGarage",
                icon = "fa-solid fa-clipboard-check",
                label = "Garage",
                job = "upnatoms"
            },
            { 
                type = "client",
                event = "rt-upnatoms:client:storeGarage",
                icon = "fa-solid fa-clipboard-check",
                label = "Parkeer Voertuig",
                job = "upnatoms"
            },
            }, 
            distance = 1.5, 
        })
    end
end

CreateThread(function()
    DecorRegister("t_vehicle", 1)
end)

RegisterNetEvent('rt-upnatoms:client:jobGarage', function(vehicle)
    local vehicle = Config.Vehicle
    local coords = Config.VehicleSpawn
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "UPNATOMS"..tostring(math.random(1000, 9999)))
        DecorSetFloat(veh, "t_vehicle", 1)
        SetEntityAsMissionEntity(veh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
        SetVehicleFuelLevel(veh, 100.0)
    end, coords, true)
end)

RegisterNetEvent('rt-upnatoms:client:storeGarage', function()
    local veh = QBCore.Functions.GetClosestVehicle()
    if DecorExistOn((veh), "t_vehicle") then
        QBCore.Functions.DeleteVehicle(veh)
        QBCore.Functions.Notify("Je hebt het voertuig ingeleverd", "success")
    else
        QBCore.Functions.Notify("Dit is geen dienstvoertuig", "error")
    end
end)

RegisterNetEvent("rt-upnatoms:client:frontTray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "dienblad1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "dienblad1", {
        maxweight = 10000,
        slots = 5,
    })
end)

RegisterNetEvent("rt-upnatoms:client:frontTray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "dienblad2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "dienblad2", {
        maxweight = 10000,
        slots = 5,
    })
end)

RegisterNetEvent("rt-upnatoms:client:frontTray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "dienblad3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "dienblad3", {
        maxweight = 10000,
        slots = 5,
    })
end)

RegisterNetEvent("rt-upnatoms:client:frontTray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "drivein")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "drivein", {
        maxweight = 10000,
        slots = 5,
    })
end)

RegisterNetEvent("rt-upnatoms:client:jobHeater1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "warmhouder")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "warmhouder", {
        maxweight = 2500000,
        slots = 30,
    })
end)

RegisterNetEvent("rt-upnatoms:client:jobFridge1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "koelkast")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "koelkast", {
        maxweight = 5000000,
        slots = 50,
    })
end)

RegisterNetEvent("rt-upnatoms:client:ingredientStore", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "upnatoms", Config.Items)
end)

RegisterNetEvent('rt-upnatoms:clientToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("rt-upnatoms:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Kassa",
		submitText = "Aanrekenen",
        inputs = {
            {
                text = "Burger ID(#)",
				name = "citizenid", 
                type = "text", 
                isRequired = true --
            },
            {
                text = "   Bedrag (€)",
                name = "billprice", 
                type = "number",
                isRequired = false
            }
			
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil then 
            return 
        end
        TriggerServerEvent("rt-upnatoms:server:billPlayer", bill.citizenid, bill.billprice)
    end
end)