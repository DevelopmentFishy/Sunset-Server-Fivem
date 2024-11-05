RegisterNetEvent('qs-smartphone:server:CustomServerDispatch', function(data, sender)
    --[[ 
        data.phone    the job 
        data.message  the message 
        data.type     the type of message
        data.img      the image  (business app)
        data.location  the location (business app)
        data.phoneNumber  the phone number of sender (business app)
        sender       the ID of sender
    ]]
    
    --[[ 
        Example of cd_dispatch
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = {data.phone},
            coords = vector3(0, 0, 0),
            title = '10-15 - Store Robbery',
            message = data.message,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = data.message,
                time = (5*60*1000),
                sound = 1,
            }
        })
    ]]
end)
