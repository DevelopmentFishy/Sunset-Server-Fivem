if Config.Target and Config.TargetScript ~= 'qb-target' then
    return
end

Config.listBooth = {
    1158960338,
    1511539537,
    1281992692,
    -429560270,
    -1559354806,
    -78626473,
    -2103798695,
    295857659,
}

function OpenTechMenu(crafter)
    exports['qb-target']:AddTargetEntity(crafter, {
        options = {
            {
                num = 1,
                label = 'Telephone Technician',
                icon = 'fa-solid fa-microchip',
                action = function()
                    TriggerEvent('qs-smartphone:OpenTechMenu')
                end,
            }
        },
        distance = 2.5,
    })
end

function OpenBoothMenu()
    exports['qb-target']:AddTargetModel(Config.listBooth, {
        options = {
            {
                num = 1,
                label = 'Telephone Booth',
                icon = 'fa-solid fa-phone',
                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    TriggerEvent('qs-smartphone:openBoothTarget')
                end,
            }
        },
        distance = 2.5,
    })
end

if Config.EnableBattery then
    CreateThread(function()
        for k, v in pairs(Config.ChargerSpots) do
            exports['qb-target']:AddBoxZone(k, vec3(v['coords'].x, v['coords'].y, v['coords'].z), 1.5, 1.5, {
                name = k,
                heading = 90.0,
                debugPoly = false,
                minZ = v['coords'].z - 1,
                maxZ = v['coords'].z + 1,
            }, {
                options = {
                    {
                        type = 'client',
                        icon = 'fa-solid fa-bolt',
                        label = 'Charge Phone',
                        canInteract = function(entity, distance, data)
                            return true
                        end,
                        action = function(entity)
                            if ChargerBattery[k] == nil and not isCharger then
                                isCharger = true
                                ClosePhone()
                                TriggerServerEvent('qs-smartphone:ChargePhone', k, Battery)
                            else
                                if Config.Framework == 'esx' then
                                    isCharger = false
                                    ChargerBattery[k] = nil
                                    TriggerServerEvent('qs-smartphone:TakeBackPhoneFromCharging', k)
                                elseif Config.Framework == 'qb' then
                                    isCharger = false
                                    ChargerBattery[k] = nil
                                    TriggerServerEvent('qs-smartphone:TakeBackPhoneFromCharging', k)
                                end
                            end
                        end,
                    },
                },
                distance = 2.5
            })
        end
    end)
end
