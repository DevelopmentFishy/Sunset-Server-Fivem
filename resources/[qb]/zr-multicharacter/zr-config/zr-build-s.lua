zr_config.discord_token = "MTAyNjE5MjIzNjY0NTQ0OTg1OQ.GJENlm.rC--J-wPS0R2y5JxBjOC5TZ9HQmxaK0OPQs-AE"

if (zr_config.framework=='QB') then
    QBcore.Functions.CreateCallback("zr-multicharacter:getSkinData", function(_, cb, cid)
        if (zr_config.clothing=='qb-clothing') then
            local zr_data = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
            if zr_data[1] ~= nil then
                cb(zr_data[1].model, zr_data[1].skin)
            else
                cb(nil)
            end
        elseif (zr_config.clothing=='illenium-appearance') then
            local zr_data = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
            if zr_data[1] ~= nil then
                cb(zr_data[1].model, zr_data[1].skin)
            else
                cb(nil)
            end
        end
    end)

    function zr_custom_spawn_menu(zr_source, zr_data)
        if (zr_config.spawn=='ps-housing') then
            TriggerClientEvent('ps-housing:client:setupSpawnUI', zr_source, zr_data)
        else
            TriggerClientEvent('apartments:client:setupSpawnUI', zr_source, zr_data)
        end
    end

    QBcore.Commands.Add("logout", 'logout', {}, false, function(source)
        local src = source
        QBcore.Player.Logout(src)
        TriggerClientEvent('zr-multicharacter:start', src)
    end, "admin")
end


if (zr_config.framework=='ESX') then
    zr_dbtablesesx = {users = 'identifier'}

    function zr_custom_spawn_menu(zr_source)
        -- Spawn menu trigger here! 
    end 

    RegisterCommand('relog', function(source)
        TriggerClientEvent('zr-multicharacter:start', source)
        TriggerEvent('esx:playerLogout', source)
        -- TriggerClientEvent('esx_skin:resetFirstSpawn', source)
    end)
end