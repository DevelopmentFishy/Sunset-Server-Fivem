local QBCore = exports['qb-core']:GetCoreObject()
local carPaleto = nil

Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("pedpaleto", vector3(Config.npcPaleto.x, Config.npcPaleto.y, Config.npcPaleto.z), 1.3, 1.3, {
        name = "pedpaleto",
        heading = 70,
        debugPoly = false,
		minZ = Config.npcPaleto.z-2,
		maxZ = Config.npcPaleto.z+4,
    }, {
        options = {
            {
                type = "client",
                event = "qb-paleto:client:randomcolor",
                icon = 'fa fa-paint-brush',
                label = "Random Kleur (€"..Config.costPaleto..")",
            },
        },
        distance = 1.5
    })
end)
Citizen.CreateThread(function()
    modelPaleto = GetHashKey(Config.modelPaleto)
    RequestModel(modelPaleto)
    while not HasModelLoaded(modelPaleto) do
        Wait(1)
    end
    pedPaleto()
end)

function pedPaleto()
    talkPaleto = CreatePed(0, modelPaleto, Config.npcPaleto.x, Config.npcPaleto.y, Config.npcPaleto.z-1, Config.npcPaleto.w, false, true)
    FreezeEntityPosition(talkPaleto, true)
    SetEntityInvincible(talkPaleto, true)
    SetBlockingOfNonTemporaryEvents(talkPaleto, true)
    TaskStartScenarioInPlace(talkPaleto, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    local plr = PlayerPedId()
    local plyCoords = GetEntityCoords(plr, 0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(vector3(Config.npcPaleto.x, Config.npcPaleto.y, Config.npcPaleto.z) - plyCoords)
        if distance < 10 then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(plr,true), -1) == plr then
                carPaleto = GetVehiclePedIsIn(plr,true)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function repairpedPaleto()
    repairPaleto = CreatePed(0, modelPaleto, Config.pedPaleto.x, Config.pedPaleto.y, Config.pedPaleto.z-1 ,Config.pedPaleto.w, false, true)
     FreezeEntityPosition(repairPaleto, true)
    SetEntityInvincible(repairPaleto, true)
    SetBlockingOfNonTemporaryEvents(repairPaleto, true)
    TaskStartScenarioInPlace(repairPaleto, "WORLD_HUMAN_MAID_CLEAN", 0, true)
end

RegisterNetEvent('qb-paleto:client:randomcolor')
AddEventHandler('qb-paleto:client:randomcolor', function()
    if carPaleto ~= nil then
        QBCore.Functions.TriggerCallback("qb-paleto:server:hascolor", function(hasMoney)
            if hasMoney then
                DeletePed(talkPaleto)
                repairpedPaleto()
                FreezeEntityPosition(carPaleto, false)
                SetEntityCoords(carPaleto, Config.carPaleto.x, Config.carPaleto.y, Config.carPaleto.z, 0, 0, 0, false)
                SetEntityHeading(carPaleto,Config.carPaleto.w)
                QBCore.Functions.Progressbar("check-", "Je auto aan het herspuiten..", 10000, false, true, {
                    disableMovement = false,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    DeletePed(repairPaleto)
                    pedPaleto()
                    SetVehicleCustomPrimaryColour(carPaleto, math.random(0,255), math.random(0,255), math.random(0,255))
                    SetVehicleCustomSecondaryColour(carPaleto, math.random(0,255), math.random(0,255), math.random(0,255))
                    QBCore.Functions.Notify("Je auto is klaar!", "success")
                    TriggerServerEvent("qb-paleto:server:removemoney", Config.costPaleto)
                    carPaleto = nil
                end)
            else
                QBCore.Functions.Notify("Je hebt niet genoeg geld..", "error")
            end
        end)
    else
        QBCore.Functions.Notify("No car found..", "error")
    end
end)

