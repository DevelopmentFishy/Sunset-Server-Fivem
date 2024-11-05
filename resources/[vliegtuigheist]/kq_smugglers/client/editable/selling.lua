
Citizen.CreateThread(function()
    Citizen.Wait(10000)
    
    while not DoesEntityExist(PlayerPedId()) or not HasCollisionLoadedAroundEntity(PlayerPedId()) do
        Citizen.Wait(2000)
    end
    
    for k, selling in pairs(Config.selling) do
        local model = selling.pedModel
        local loc = selling.location
        DoRequestModel(model)
        
        local ped = CreatePed(0, model, loc.x, loc.y, loc.z - 1.0, loc.h, false, false)
        SetModelAsNoLongerNeeded(model)
        
        Config.selling[k].ped = ped
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GUARD_STAND', 0, true)
        SetPedCanUseAutoConversationLookat(ped, true)
        TaskLookAtEntity(ped, PlayerPedId(), -1, 2048, 3)
        SetEntityAsMissionEntity(ped, true, true)
        
        AddEntityToTargeting(ped, 'selling_' .. ped, L('Sell {ITEM}'):gsub('{ITEM}', selling.itemLabel), 'kq_smugglers:target:sell', k)
    
        local blipData = selling.blip
        if blipData.showBlip then
            CreateBlip(vector3(loc.x, loc.y, loc.z), blipData.sprite, blipData.color, 255, blipData.scale, selling.name)
        end
    end
end)

if not Config.target.enabled then
    Citizen.CreateThread(function()
        while true do
            local sleep = 4000
            
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            for k, selling in pairs(Config.selling) do
                local loc = selling.location
                local distance = GetDistanceBetweenCoords(playerCoords, loc.x, loc.y, loc.z, 1)
                if distance < 20 then
                    sleep = 1000
                    if distance < 2 then
                        Draw3DText(loc.x, loc.y, loc.z, L('Press ~g~[~w~{KEYBIND}~g~]~w~ to sell {ITEM}'):gsub('{KEYBIND}', Config.keybinds.interact.label):gsub('{ITEM}', selling.itemLabel), 4, 0.035, 0.035)
                        
                        sleep = 1
                        if IsControlJustReleased(0, Config.keybinds.interact.input) then
                            SellItem(k)
                        end
                    end
                end
            end
            
            Citizen.Wait(sleep)
        end
    end)
end

function SellItem(sellingKey)
    local playerPed = PlayerPedId()
    RemoveHandWeapons()
    
    local sellingPed = Config.selling[sellingKey].ped
    ClearPedTasks(sellingPed)
    TaskTurnPedToFaceEntity(playerPed, sellingPed, 1000)
    Citizen.Wait(1000)
    
    ClearPedTasksImmediately(sellingPed)
    PlayAnim('mp_common', 'givetake2_b', 0, sellingPed)
    PlayAnim('mp_common', 'givetake1_a')
    
    Citizen.Wait(Config.selling[sellingKey].duration)
    
    ClearPedTasks(playerPed)
    TaskStartScenarioInPlace(sellingPed, 'WORLD_HUMAN_GUARD_STAND', 0, true)
    TriggerServerEvent('kq_smugglers:server:sell', sellingKey)
end
