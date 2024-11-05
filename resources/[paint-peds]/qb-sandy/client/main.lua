local QBCore = exports['qb-core']:GetCoreObject()
local carSandy = nil

Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("pedsandy", vector3(Config.npcSandy.x, Config.npcSandy.y, Config.npcSandy.z), 1.3, 1.3, {
        name = "pedsandy",
        heading = 70,
        debugPoly = false,
		minZ = Config.npcSandy.z-2,
		maxZ = Config.npcSandy.z+4,
    }, {
        options = {
            {
                type = "client",
                event = "qb-sandy:client:randomcolor",
                icon = 'fa fa-paint-brush',
                label = "Random Kleur (€"..Config.costSandy..")",
            },
        },
        distance = 1.5
    })
end)
Citizen.CreateThread(function()
    modelSandy = GetHashKey(Config.modelSandy)
    RequestModel(modelSandy)
    while not HasModelLoaded(modelSandy) do
        Wait(1)
    end
    pedSandy()
end)

function pedSandy()
    talkSandy = CreatePed(0, modelSandy, Config.npcSandy.x, Config.npcSandy.y, Config.npcSandy.z-1, Config.npcSandy.w, false, true)
    FreezeEntityPosition(talkSandy, true)
    SetEntityInvincible(talkSandy, true)
    SetBlockingOfNonTemporaryEvents(talkSandy, true)
    TaskStartScenarioInPlace(talkSandy, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    local plr = PlayerPedId()
    local plyCoords = GetEntityCoords(plr, 0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(vector3(Config.npcSandy.x, Config.npcSandy.y, Config.npcSandy.z) - plyCoords)
        if distance < 10 then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(plr,true), -1) == plr then
                carSandy = GetVehiclePedIsIn(plr,true)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function repairpedSandy()
    repairSandy = CreatePed(0, modelSandy, Config.pedSandy.x, Config.pedSandy.y, Config.pedSandy.z-1 ,Config.pedSandy.w, false, true)
     FreezeEntityPosition(repairSandy, true)
    SetEntityInvincible(repairSandy, true)
    SetBlockingOfNonTemporaryEvents(repairSandy, true)
    TaskStartScenarioInPlace(repairSandy, "WORLD_HUMAN_MAID_CLEAN", 0, true)
end

RegisterNetEvent('qb-sandy:client:randomcolor')
AddEventHandler('qb-sandy:client:randomcolor', function()
    if carSandy ~= nil then
        QBCore.Functions.TriggerCallback("qb-sandy:server:hascolor", function(hasMoney)
            if hasMoney then
                DeletePed(talkSandy)
                repairpedSandy()
                FreezeEntityPosition(carSandy, false)
                SetEntityCoords(carSandy, Config.carSandy.x, Config.carSandy.y, Config.carSandy.z, 0, 0, 0, false)
                SetEntityHeading(carSandy,Config.carSandy.w)
                QBCore.Functions.Progressbar("check-", "Je auto aan het herspuiten..", 10000, false, true, {
                    disableMovement = false,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    DeletePed(repairSandy)
                    pedSandy()
                    SetVehicleCustomPrimaryColour(carSandy, math.random(0,255), math.random(0,255), math.random(0,255))
                    SetVehicleCustomSecondaryColour(carSandy, math.random(0,255), math.random(0,255), math.random(0,255))
                    QBCore.Functions.Notify("Je auto is klaar!", "success")
                    TriggerServerEvent("qb-sandy:server:removemoney", Config.costSandy)
                    carSandy = nil
                end)
            else
                QBCore.Functions.Notify("Je hebt niet genoeg geld..", "error")
            end
        end)
    else
        QBCore.Functions.Notify("No car found..", "error")
    end
end)

