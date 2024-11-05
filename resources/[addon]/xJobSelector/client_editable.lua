
RegisterNetEvent("xJob:Open")
AddEventHandler("xJob:Open", function()
    Open()
end)

local targetCache = {}
function InitInteraction()
    WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        if targetCache['xJob'] then return end
        targetCache['xJob'] = true
        exports.ox_target:addBoxZone({
            name = 'xJob',
            coords = Config.Coords,
            size = vec3(3.6, 3.6, 3.6),
            drawSprite = true,
            options =  {
                {
                    name = 'xJob',
                    event = 'xJob:Open',
                    icon = 'fas fa-gears',
                    label = "Open Menu",
                }
            }
        })
    end
    if Config.InteractionHandler == 'qb_target'  then
        if targetCache['xJob'] then return end
        targetCache['xJob'] = true
        exports['qb-target']:AddBoxZone('xJob', Config.Coords, 1.5, 1.6,
            {
                name = 'xJob',
                heading = 12.0,
                debugPoly = false,
                minZ = Config.Coords.z - 1,
                maxZ = Config.Coords.z + 1,
            }, 
            {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = 'fas fa-gears',
                    label = "Open Menu",
                    targeticon = 'fas fa-gears',
                    action = function()
                        TriggerEvent("xJob:Open")
                    end
                }
            },
            distance = 2.5,
        })
    end
    if Config.InteractionHandler == 'qb_textui' then
        
        if targetCache['xJob'] then return end
        targetCache['xJob'] = true
        CreateThread(function()
            while true do
                local show = false
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec =  Config.Coords
                local dist = #(vec - plyCoords)
                if dist < 2.0 then
                    cd = 0
                    if not show then
                        TriggerEvent('qb-core:client:DrawText', "PRESS E TO OPEN MENU", 'left')
                        show = true
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("xJob:Open")

                     
                    end
                else
                    if show then
                        show = false
                        TriggerEvent('qb-core:client:HideText')
                    end
                end
                
                Wait(cd)
            end
        end)
    end 
    if Config.InteractionHandler == 'esx_textui' then
        
        if targetCache['xJob'] then return end
        targetCache['xJob'] = true

        CreateThread(function()
            local show = false
            while true do
                
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = Config.Coords
                local dist = #(vec - plyCoords)
                if dist < 2.0 then
                    cd = 0
                    if not show then
                        Core.TextUI("PRESS E TO OPEN MENU")
                        show = true
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("xJob:Open")

                    end
                else
                    if show then
                        show = false
                        Core.HideUI()
                    end
                end
              
                Wait(cd)
            end
        end)
    end 
    
    if Config.InteractionHandler == 'drawtext' then
        if targetCache['xJob'] then return end
        targetCache['xJob'] = true
        CreateThread(function()
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = Config.Coords
                local dist = #(vec - plyCoords)
                if dist < 2.0  then
                    cd = 0
                    DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                        true, false, false, false)
                    DrawText3D(Config.Coords.x, Config.Coords.y, Config.Coords.z, "PRESS E TO OPEN MENU")
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("xJob:Open")

                    end
                end
                Wait(cd)
            end
        end)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function CreateBlip()
    local blipConfig = Config.Blip
    if blipConfig.show then
        local blip = AddBlipForCoord(Config.Coords)
    
        SetBlipSprite(blip, blipConfig.sprite)
        SetBlipColour(blip, blipConfig.color)
        SetBlipScale(blip, blipConfig.scale)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Gemeentehuis")
        EndTextCommandSetBlipName(blip)
    end
end

CreateThread(function()
    InitInteraction()
    CreateBlip()
end)
