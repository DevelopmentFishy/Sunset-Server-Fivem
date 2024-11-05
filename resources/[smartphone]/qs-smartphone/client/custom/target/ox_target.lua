if Config.Target and Config.TargetScript ~= 'ox_target' then
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
    local options = {
        {
            name = 'qs:tech',
            label = 'Telephone Technician',
            icon = 'fa-solid fa-microchip',
            onSelect = function()
                TriggerEvent('qs-smartphone:OpenTechMenu')
            end
        },
    }
    exports.ox_target:addLocalEntity(crafter, options)
end

function OpenBoothMenu()
    local options = {
        {
            name = 'qs:booth',
            label = 'Telephone Booth',
            icon = 'fa-solid fa-phone',
            onSelect = function()
                TriggerEvent('qs-smartphone:openBoothTarget')
            end
        },
    }
    exports.ox_target:addModel(Config.listBooth, options)
end

if Config.EnableBattery then
    CreateThread(function()
        -- Selling
        for k, v in pairs(Config.ChargerSpots) do
            local options = {
                coords = vec3(v.coords.x, v.coords.y, v.coords.z), -- Se corrigieron las coordenadas
                distance = 5.0,
                rotation = 180.0,
                debug = false,
                options = {
                    {
                        icon = 'fa-solid fa-bolt',
                        label = 'Charge Phone',
                        distance = 2.5,
                        onSelect = function()
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
                        end
                    }
                },
            }
            exports.ox_target:addBoxZone(options)
        end
    end)
end
