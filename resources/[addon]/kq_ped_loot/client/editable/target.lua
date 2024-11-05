function AddEntityToTargeting(entity, message, event, canInteract, hash)
    if (Config.target.enabled and Config.target.system) then
        
        local system = Config.target.system
        
        local options = {
            {
                type = 'client',
                event = event,
                icon = 'fas fa-box',
                label = message,
                targetEntity = entity,
                canInteract = canInteract or function () return true end
            }
        }

        local coords = GetEntityCoords(entity)

        if system == 'ox-target' or system == 'ox_target' then
            return exports[system]:addBoxZone({
                coords = coords,
                size = vector3(0.6, 0.6, 0.6),
                rotation = vector3(0.0, 0.0, 0.0),
                debug = Config.debug,
                drawSprite = true,
                options = options,
            })
        else
            exports[system]:AddBoxZone(hash, coords, 0.6, 0.6, {
                name = hash,
                debugPoly = Config.debug,
                useZ = true,
                minZ = coords.z - 0.2,
                maxZ = coords.z + 0.6,
            }, {
                options = options,
                distance = Config.pickupDistance or 1.4
            })
            return hash
        end
    end
end

function RemoveTargetZone(identifier)
    local system = Config.target.system

    if system == 'ox-target' or system == 'ox_target' then
        exports[system]:removeZone(identifier)
    else
        exports[system]:RemoveZone(identifier)
    end
end

RegisterNetEvent('kq_ped_loot:target:pickup')
AddEventHandler('kq_ped_loot:target:pickup', function(data)
    if DoesEntityExist(data.targetEntity) then
        DeleteEntityInput(data.targetEntity)
        TriggerPickup(data.targetEntity)
    end
end)
