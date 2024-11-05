local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
------------------------------
 -- RESOURCE START/LOAD IN --
------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        LocateGuy2()
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    LocateGuy2()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


function LocateGuy2()
    exports['qb-target']:AddBoxZone("locateguy2", vector3(-806.68, 166.86, 76.75), 0.7, 0.5, {
        name="locateguy2",
        heading=110,
        minZ=76.55,
        maxZ=77.15,
    }, {
        options = {
            {
                event = "qb-blackmarket:client:tracktheguyWitwas",
                icon = "fa-solid fa-location-dot",
                label = "Wasje draaien",
            },
        },
        distance = 2.5
    })
end

--locatie veranderen!!!!!!!!!

function DeletemarketguyWitwas()
    if DoesEntityExist(marketguyWitwas) then
        DeletePed(marketguyWitwas)
    end
end

function TrackBlip2()
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
        if hours >= Config.OpenWitwas or hours < Config.CloseWitwas then
                RequestModel(GetHashKey(Config.ModelWitwas))
                while not HasModelLoaded(GetHashKey(Config.ModelWitwas)) do
                    Wait(0)
                end

                if not DoesEntityExist(marketguyWitwas) then

                    local pickaspotbro = math.random(#Config.LocationsWitwas)
                
                    marketguyWitwas = CreatePed(0, GetHashKey(Config.ModelWitwas) , Config.LocationsWitwas[pickaspotbro].x, Config.LocationsWitwas[pickaspotbro].y, Config.LocationsWitwas[pickaspotbro].z, Config.LocationsWitwas[pickaspotbro].w, false, false)

                    SetEntityAsMissionEntity(marketguyWitwas)
                    SetPedFleeAttributes(marketguyWitwas, 0, 0)
                    SetBlockingOfNonTemporaryEvents(marketguyWitwas, true)
                    SetEntityInvincible(marketguyWitwas, true)
                    FreezeEntityPosition(marketguyWitwas, true)
                    TaskStartScenarioInPlace(marketguyWitwas, "WORLD_HUMAN_AA_SMOKE", 0, true)

                    exports['qb-target']:AddTargetEntity(marketguyWitwas, {
                        options = {
                            { 
                                icon = "fa-solid fa-comments",
                                label = "Praat met Mevrouw Was",
                                action = function(entity)
                                    exports["rpemotes"]:EmoteCommandStart("think4")
                                    QBCore.Functions.Progressbar("negotiate", "Wat kom je doen?..", 7500, false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function()
                                        ClearPedTasks(PlayerPedId())
                                        if PlayerJob.name ~= "police" then
                                            exports['qb-menu']:openMenu({
                                                {
                                                    header = "Grote wasjes kleine wasjes",
                                                    isMenuHeader = true
                                                },
												 {
                                                    header = "Geldwassen",
                                                    icon = "fa-solid fa-money-bill-transfer",
                                                    txt = "Geld witwassen",
                                                    params = {
                                                        event = "qb-onderwereld:client:startVask",
                                                    }
                                                },
												{
                                                    header = "Geldverzamelen",
                                                    icon = "fa-solid fa-money-bill-transfer",
                                                    txt = "Verzamel geld van wassen",
                                                    params = {
                                                        event = "qb-onderwereld:client:hentPenger",
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
                                            QBCore.Functions.Notify("Rare Gast ik was niet voor jou!", "error")
                                        end
                                    end)
                                end,
                            },
                        },
                        distance = 2.5,
                    })
                end
        else
            DeletemarketguyWitwas()
        end
    end
end)


RegisterNetEvent('qb-blackmarket:client:tracktheguyWitwas')
AddEventHandler('qb-blackmarket:client:tracktheguyWitwas', function()
    if DoesEntityExist(marketguyWitwas) then
        -- TriggerEvent('animations:client:EmoteCommandStart', {"type"})
        exports["rpemotes"]:EmoteCommandStart("type")
        QBCore.Functions.Progressbar("locate_guy", "Proberen de dealer te vinden..", 10500, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        exports["rpemotes"]:EmoteCommandStart("texting")
        Wait(1000)
        exports['glow_minigames']:StartMinigame(function(success)
            if success then
                findme = GetEntityCoords(marketguyWitwas)
                SetNewWaypoint(findme.x, findme.y)
                TrackBlip2()
                QBCore.Functions.Notify("Dealer gevonden. Hun locatie is nu gemarkeerd op uw GPS", "primary", 6000)
               exports["rpemotes"]:EmoteCommandStart("c")          
            else
                QBCore.Functions.Notify("You failed the hack.", "error")
                exports["rpemotes"]:EmoteCommandStart("c") 
            end
         end, Config.Minigame.game)
        end)
    else
        QBCore.Functions.Notify("Het is te vroeg om dit te doen. Kom later terug.", "error")
    end
end)


AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        DeletemarketguyWitwas()
        exports['qb-target']:RemoveZone("locateguy2")
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