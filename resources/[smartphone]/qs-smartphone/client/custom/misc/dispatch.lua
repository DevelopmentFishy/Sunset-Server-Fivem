RegisterNetEvent('qs-smartphone:client:CustomClientDispatch', function(data, sender, businessapp)
    --[[
        data.phone    the job
        data.message  the message
        data.type     the type of message
        data.img      the image  (business app)
        data.location  the location (business app)
        data.phoneNumber  the phone number of sender (business app)
        sender       return the sender of message
    ]]
    if GetResourceState('qs-dispatch') == 'started' then
        if businessapp then
            local playerData = exports['qs-dispatch']:GetPlayerInfo()
            exports['qs-dispatch']:getSSURL(function(image)
                TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                    job = data.phone,
                    callLocation = vec3(data.location.x, data.location.y, data.location.z),
                    callCode = { code = 'Alert from Business App', snippet = 'Business!' },
                    message = data.message,
                    flashes = false,
                    image = data.img or nil,
                    blip = {
                        sprite = 110,
                        scale = 1.5,
                        colour = 1,
                        flashes = true,
                        text = 'Alert from Business App',
                        time = (6 * 60 * 1000) -- 6 minutes
                    }
                })
            end)
        else
            local playerData = exports['qs-dispatch']:GetPlayerInfo()
            exports['qs-dispatch']:getSSURL(function(image)
                TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                    job = data.phone,
                    callLocation = playerData.coords,
                    callCode = { code = 'Alert from Business SMS', snippet = 'Business!' },
                    message = data.message,
                    flashes = false,
                    image = nil,
                    blip = {
                        sprite = 110,
                        scale = 1.5,
                        colour = 1,
                        flashes = true,
                        text = 'Alert from SMS',
                        time = (6 * 60 * 1000) -- 6 minutes
                    }
                })
            end)
        end
    elseif GetResourceState('cd_dispatch') == 'started' then
        local dispatch = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = { data.phone }, -- Data of job
            coords = dispatch.coords,
            title = '10-15 - Phone Dispatch',
            message = data.message, -- Data of messages
            flash = 0,
            unique_id = tostring(math.random(0000000, 9999999)),
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = data.message,
                time = (5 * 60 * 1000),
                sound = 1,
            }
        })
    end
end)
