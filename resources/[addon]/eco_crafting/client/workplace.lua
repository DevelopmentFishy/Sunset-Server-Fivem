function objectHandler(closestZones)

    local pos, zone, fx, data
    local tmp = {}

    for _, id in pairs(closestZones) do

        zone = Config.workstations[id]
        pos = zone.pos
        tmp[id] = {}

        if not ECO.WORKPLACE[id] then
            ECO.WORKPLACE[id] = {}
        end

        -- OBJECT
        if zone.object.model then

            if ECO.WORKPLACE[id].object then

                tmp[id].object = ECO.WORKPLACE[id].object
            else

                modelLoader(zone.object.model)

                local obj

                if zone.object.placeOnGround then

                    obj = CreateObject(zone.object.model, pos.xyz)
					PlaceObjectOnGroundProperly(obj)

                    if zone.object.offset then

                        SetEntityCoords(obj, GetEntityCoords(obj) + zone.object.offset)
                    end
                else

                    obj = CreateObject(zone.object.model, (zone.object.offset and pos.xyz + zone.object.offset or pos.xyz))
                end

                SetEntityHeading(obj, pos.w)
                FreezeEntityPosition(obj, true)
                tmp[id].object = obj
            end
        end


        -- FX MARKER
        if zone.fx and zone.accessToUse then

            if ECO.WORKPLACE[id].fx then

                tmp[id].fx = ECO.WORKPLACE[id].fx
            else

                fxLoader(zone.fx.dict)
                UseParticleFxAsset(zone.fx.dict)

                local pfx = StartParticleFxLoopedAtCoord(zone.fx.name,
                        pos.xyz + zone.fx.offset,
                        zone.fx.loopedAtCoord[1],
                        zone.fx.loopedAtCoord[2],
                        zone.fx.loopedAtCoord[3],
                        zone.fx.loopedAtCoord[4],
                        false, false, false, false)

                SetParticleFxLoopedColour(pfx, -- handle
                        zone.fx.loopedColour[1], -- külső méret 0-8
                        zone.fx.loopedColour[2], -- belső mag méret 0-5
                        zone.fx.loopedColour[3], -- fényesség(fehéredik) 0-6
                        0) -- nothing

                tmp[id].fx = pfx
            end
        end


        -- POLYZONE
        if Config.useTarget and (zone.accessToUse or zone.accessToRemove) then

            if ECO.WORKPLACE[id].polyZone then

                tmp[id].polyZone = ECO.WORKPLACE[id].polyZone
            else

                local obj
                local options = {

                    {
                        type = "client",
                        event = 'eco_crafting:targetControl',
                        icon = "fa-solid fa-screwdriver-wrench",
                        label = Lang:t('use_workstation_target', { v1 = Lang:t(zone.workstation) }),
                        zoneId = id,
                        canInteract = function() -- entity, distance, data

                            local ws = Config.workstations[id]
                            return ws and ws.accessToUse or false
                        end,
                    },
                    {

                        type = "client",
                        event = 'eco_crafting:workstationRemovalRequest',
                        icon = "fa-solid fa-toolbox",
                        label = Lang:t('workstation_removal'),
                        zoneId = id,
                        canInteract = function() -- entity, distance, data

                            local ws = Config.workstations[id]
                            return ws and ws.accessToRemove or false
                        end,
                    }
                }

                if tmp[id].object then

                    obj = tmp[id].object
                else

                    local objects = GetGamePool('CObject')
                    local closestDistance = 1.0

                    for i = 1, #objects do

                        local distance = #(GetEntityCoords(objects[i]) - pos.xyz)

                        if closestDistance > distance then

                            obj = objects[i]
                            closestDistance = distance
                        end
                    end
                end

                -- https://github.com/mkafrin/PolyZone/wiki/EntityZone
                -- https://github.com/qbcore-framework/qb-target/blob/main/EXAMPLES.md

                if obj then

                    tmp[id].polyZone = exports['qb-target']:AddEntityZone(zone.workstation .. id, obj,
                            {
                                debugPoly = Config.debugPoly,
                                name = zone.workstation .. id,
                                --useZ = true,
                            },
                            {
                                options = options,
                                distance = zone.actionDistance
                            })

                    --tmp[id].polyZone = exports['qb-target']:AddTargetEntity(obj,
                    --        {
                    --            options = { options },
                    --            distance = zone.actionDistance
                    --        })

                else

                    tmp[id].polyZone = exports['qb-target']:AddBoxZone(zone.workstation .. id, pos.xyz, 1.5, 1.0, {
                        name = zone.workstation .. id,
                        heading = pos.w,
                        debugPoly = Config.debugPoly,
                        minZ = pos.z - 1.0,
                        maxZ = pos.z + 2.0,
                    }, {
                        options = options,
                        distance = zone.actionDistance
                    })
                end
            end
        end
    end

    for id, params in pairs(ECO.WORKPLACE) do

        if params.fx and (not tmp[id] or not tmp[id].fx) then

            StopParticleFxLooped(params.fx, 0)
        end

        if params.object and (not tmp[id] or not tmp[id].object) then

            DeleteObject(params.object)
        end

        if params.polyZone and (not tmp[id] or not tmp[id].polyZone) then

            exports['qb-target']:RemoveZone(params.polyZone.name)
        end
    end

    ECO.WORKPLACE = tmp
end

function workplaceDeleter()

    for _, params in pairs(ECO.WORKPLACE) do

        if params.fx then

            StopParticleFxLooped(params.fx, 0)
        end

        if params.object then

            DeleteObject(params.object)
        end

        if params.polyZone then

            exports['qb-target']:RemoveZone(params.polyZone.name)
        end
    end

    ECO.WORKPLACE = {}
end