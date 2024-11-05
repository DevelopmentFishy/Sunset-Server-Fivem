local QBCore = exports['qb-core']:GetCoreObject()
local carStad = nil

Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("pedstad", vector3(Config.npcStad.x, Config.npcStad.y, Config.npcStad.z), 1.3, 1.3, {
        name = "pedstad",
        heading = 70,
        debugPoly = false,
		minZ = Config.npcStad.z-2,
		maxZ = Config.npcStad.z+4,
    }, {
        options = {
            {
                type = "client",
                event = "qb-stad:client:randomcolor",
                icon = 'fa fa-paint-brush',
                label = "Random Kleur (€"..Config.costStad..")",
            },
        },
        distance = 1.5
    })
end)
Citizen.CreateThread(function()
    modelStad = GetHashKey(Config.modelStad)
    RequestModel(modelStad)
    while not HasModelLoaded(modelStad) do
        Wait(1)
    end
    pedStad()
end)

function pedStad()
    talkStad = CreatePed(0, modelStad, Config.npcStad.x, Config.npcStad.y, Config.npcStad.z-1, Config.npcStad.w, false, true)
    FreezeEntityPosition(talkStad, true)
    SetEntityInvincible(talkStad, true)
    SetBlockingOfNonTemporaryEvents(talkStad, true)
    TaskStartScenarioInPlace(talkStad, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    local plr = PlayerPedId()
    local plyCoords = GetEntityCoords(plr, 0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(vector3(Config.npcStad.x, Config.npcStad.y, Config.npcStad.z) - plyCoords)
        if distance < 10 then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(plr,true), -1) == plr then
                carStad = GetVehiclePedIsIn(plr,true)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function repairpedStad()
    repairStad = CreatePed(0, modelStad, Config.pedStad.x, Config.pedStad.y, Config.pedStad.z-1 ,Config.pedStad.w, false, true)
     FreezeEntityPosition(repairStad, true)
    SetEntityInvincible(repairStad, true)
    SetBlockingOfNonTemporaryEvents(repairStad, true)
    TaskStartScenarioInPlace(repairStad, "WORLD_HUMAN_MAID_CLEAN", 0, true)
end

RegisterNetEvent('qb-stad:client:randomcolor')
AddEventHandler('qb-stad:client:randomcolor', function()
    if carStad ~= nil then
        QBCore.Functions.TriggerCallback("qb-stad:server:hascolor", function(hasMoney)
            if hasMoney then
                DeletePed(talkStad)
                repairpedStad()
                FreezeEntityPosition(carStad, false)
                SetEntityCoords(carStad, Config.carStad.x, Config.carStad.y, Config.carStad.z, 0, 0, 0, false)
                SetEntityHeading(carStad,Config.carStad.w)
                QBCore.Functions.Progressbar("check-", "Je auto aan het herspuiten..", 10000, false, true, {
                    disableMovement = false,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    DeletePed(repairStad)
                    pedStad()
                    SetVehicleCustomPrimaryColour(carStad, math.random(0,255), math.random(0,255), math.random(0,255))
                    SetVehicleCustomSecondaryColour(carStad, math.random(0,255), math.random(0,255), math.random(0,255))
                    QBCore.Functions.Notify("Je auto is klaar!", "success")
                    TriggerServerEvent("qb-stad:server:removemoney", Config.costStad)
                    carStad = nil
                end)
            else
                QBCore.Functions.Notify("Je hebt niet genoeg geld..", "error")
            end
        end)
    else
        QBCore.Functions.Notify("No car found..", "error")
    end
end)

