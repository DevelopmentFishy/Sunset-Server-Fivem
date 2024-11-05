function AddEntityToTargeting(entity, hash, message, event, key, canInteract)
    if (Config.target.enabled and Config.target.system) then

        local system = Config.target.system
        
        local options = {
            {
                type = 'client',
                event = event,
                icon = 'fas fa-box',
                label = message,
                key = key,
                canInteract = canInteract or function () return true end
            }
        }
    
        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addLocalEntity({entity}, options)
        else
            exports[system]:AddEntityZone(hash, entity, {
                name = hash,
                debugPoly = false,
                useZ = true,
            }, {
                options = options,
                distance = 1.5
            })
        end
    end
end

function AddATCToTargeting()
    if (Config.target.enabled and Config.target.system) then

        local system = Config.target.system
        
        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addBoxZone({
                coords = vector3(Config.atc.location.x, Config.atc.location.y, Config.atc.location.z),
                size = vector3(1.1, 1.1, 1.0),
                rotation = 35.0,
                options = {
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:turnOnAtc',
                        icon = 'fas fa-power-off',
                        label = L('Turn on the ATC computer'),
                        canInteract = function(entity, distance, data)
                            return not ATC_ACTIVE
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:triggerAtcScan',
                        icon = 'fas fa-signal',
                        label = L('Perform the airspace scan'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'index'
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:atcExit',
                        icon = 'fas fa-power-off',
                        label = L('Shut down'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'index'
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:atcReturn',
                        icon = 'fas fa-arrow-left',
                        label = L('Return to main menu'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'scan_finish'
                        end,
                    }
                },
            })
        else
            exports[system]:RemoveZone('kq_smugglers_atc')
            exports[system]:AddBoxZone('kq_smugglers_atc', vector3(Config.atc.location.x, Config.atc.location.y, Config.atc.location.z), 1.1, 1.1, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
                name = 'kq_smugglers_atc',
                heading = 35.0,
                debugPoly = false,
                minZ = Config.atc.location.z - 0.5,
                maxZ = Config.atc.location.z + 0.5,
            }, {
                options = {
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:turnOnAtc',
                        icon = 'fas fa-power-off',
                        label = L('Turn on the ATC computer'),
                        canInteract = function(entity, distance, data)
                            return not ATC_ACTIVE
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:triggerAtcScan',
                        icon = 'fas fa-signal',
                        label = L('Perform the airspace scan'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'index'
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:atcExit',
                        icon = 'fas fa-power-off',
                        label = L('Shut down'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'index'
                        end,
                    },
                    {
                        type = 'client',
                        event = 'kq_smugglers:target:atcReturn',
                        icon = 'fas fa-arrow-left',
                        label = L('Return to main menu'),
                        canInteract = function(entity, distance, data)
                            return ATC_ACTIVE and ATC_STATE == 'scan_finish'
                        end,
                    }
                },
                distance = 2.0,
            })
        end
    end
end

local looting = false
local securing = false
function AddPlaneToTargeting(entity, eventHash)
    if (Config.target.enabled and Config.target.system) then
        
        local system = Config.target.system
        
        local options = {
            {
                type = 'client',
                event = 'kq_smugglers:target:lootPlane',
                icon = 'fas fa-box',
                label = L('Loot the plane'),
                eventHash = eventHash,
                canInteract = function ()
                    return Config.looting.enabled and (not looting) and (not Contains(Config.policeJobs, PLAYER_JOB)) and (not EVENTS[eventHash].secured) and (not EVENTS[eventHash].looted)
                end
            },
            {
                type = 'client',
                event = 'kq_smugglers:target:secureArea',
                icon = 'fas fa-arrow-down',
                label = L('Secure the area'),
                eventHash = eventHash,
                canInteract = function ()
                    return (Contains(Config.policeJobs, PLAYER_JOB)) and (not EVENTS[eventHash].secured) and (not securing)
                end
            },
            {
                type = 'client',
                event = 'kq_smugglers:target:cancelPlaneAction',
                icon = 'fas fa-box',
                label = L('Cancel'),
                eventHash = eventHash,
                canInteract = function ()
                    return securing or looting
                end
            }
        }
        
        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addEntity({NetworkGetNetworkIdFromEntity(entity)}, options)
        else
            exports[system]:AddTargetEntity(entity, {
                options = options,
                distance = 2.0
            })
        end
    end
end


RegisterNetEvent('kq_smugglers:target:sell')
AddEventHandler('kq_smugglers:target:sell', function(data)
    SellItem(data.key)
end)

RegisterNetEvent('kq_smugglers:target:buyHint')
AddEventHandler('kq_smugglers:target:buyHint', function()
    PurchaseHint()
end)

RegisterNetEvent('kq_smugglers:target:turnOnAtc')
AddEventHandler('kq_smugglers:target:turnOnAtc', function()
    TriggerBootAtc()
end)

RegisterNetEvent('kq_smugglers:target:triggerAtcScan')
AddEventHandler('kq_smugglers:target:triggerAtcScan', function()
    TriggerStartAtcScan()
end)

RegisterNetEvent('kq_smugglers:target:atcExit')
AddEventHandler('kq_smugglers:target:atcExit', function()
    PressAnimation()
    TriggerServerEvent('kq_smugglers:server:atc:exit')
end)


RegisterNetEvent('kq_smugglers:target:atcReturn')
AddEventHandler('kq_smugglers:target:atcReturn', function()
    PressAnimation()
    TriggerServerEvent('kq_smugglers:server:atc:set-state', 'index')
end)


RegisterNetEvent('kq_smugglers:target:lootPlane')
AddEventHandler('kq_smugglers:target:lootPlane', function(data)
    Citizen.CreateThread(function()
        looting = true
        PlayAnim('mp_car_bomb', 'car_bomb_mechanic', 17)
        RealWait(Config.looting.duration * 1000)
    
        if looting then
            LootCrashSite(data.eventHash)
            looting = false
        end
    end)
end)

RegisterNetEvent('kq_smugglers:target:secureArea')
AddEventHandler('kq_smugglers:target:secureArea', function(data)
    Citizen.CreateThread(function()
        securing = true
        PlayAnim('mp_car_bomb', 'car_bomb_mechanic', 17)
        RealWait(Config.securing.duration * 1000)
    
        if securing then
            SecureCrashSite(data.eventHash, data.entity)
            securing = false
        end
    end)
end)

RegisterNetEvent('kq_smugglers:target:cancelPlaneAction')
AddEventHandler('kq_smugglers:target:cancelPlaneAction', function()
    Citizen.CreateThread(function()
        looting = false
        securing = false
        ClearPedTasks(PlayerPedId())
    end)
end)
