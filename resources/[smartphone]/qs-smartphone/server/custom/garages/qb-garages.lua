if Config.GarageScript ~= 'qb-garages' then
    return
end

impoundTable = 'state'
garageOutTable = 'OUT'
impoundOutSide = 0

function GetVehicleImpound(data)
    local info = data
    if info.state == 2 then
        return false
    end
    return true
end

RegisterServerEvent('qs-smartphone:valetCarSetOutside')
AddEventHandler('qs-smartphone:valetCarSetOutside', function(plate)
    MySQL.Async.execute('UPDATE ' .. vehiclesTable .. ' SET ' .. impoundTable .. ' = @stored WHERE `plate` = @plate', { ['@plate'] = plate, ['@stored'] = impoundOutSide })
end)

RegisterServerEvent('qs-smartphone:getInfoPlate')
AddEventHandler('qs-smartphone:getInfoPlate', function(plate)
    local src = source
    local player = GetPlayerFromIdFramework(src)

    local veh_datastore = MySQL.Sync.fetchAll('SELECT * FROM ' .. vehiclesTable .. ' WHERE ' .. vehiclesOwner .. " ='" .. player.identifier .. "' AND " .. plateTable .. " ='" .. plate .. "' ", {})
    if veh_datastore and veh_datastore[1] then
        if veh_datastore[1].garage == garageOutTable then
            TriggerClientEvent('qs-smartphone:client:notify', src, {
                title = Lang('GARAGE_TITLE'),
                text = 'The vehicle is outside',
                icon = './img/apps/garages.png',
                timeout = 1500
            })
            return
        end
        if GetVehicleImpound(veh_datastore[1]) then
            TriggerClientEvent('qs-smartphone:vehSpawn', src, veh_datastore[1].mods, veh_datastore[1].vehicle, veh_datastore[1].plate)
        else
            TriggerClientEvent('qs-smartphone:client:notify', src, {
                title = Lang('GARAGE_TITLE'),
                text = 'Vehicle is in impound',
                icon = './img/apps/garages.png',
                timeout = 1500
            })
        end
    end
end)

RegisterServerCallback('qs-smartphone:getCars', function(a, b)
    local player = GetPlayerFromIdFramework(source)
    MySQL.Async.execute('SELECT plate, vehicle, stored FROM player_vehicles WHERE `citizenid` = @cid and `type` = @type', { ['@cid'] = player.citizenid, ['@type'] = 'car' }, function(d)
        local e = {}
        for f, g in ipairs(d) do
            table.insert(e, { ['garage'] = g['stored'], ['plate'] = g['plate'], ['props'] = json.decode(g['mods']) })
        end
        b(e)
    end)
end)

RegisterServerCallback('qs-smartphone:server:GetGarageVehicles', function(source, cb)
    local Player = GetPlayerFromIdFramework(source)
    local Vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM ' .. vehiclesTable .. " WHERE `citizenid` = '" .. Player.identifier .. "'", {}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local vehdata = {}
                vehdata.props = v.mods
                vehdata.plate = v.plate
                vehdata.model = v.vehicle
                vehdata.garage = v.state
                vehdata.realGarage = v.garage
                vehdata.label = v.vehicle

                table.insert(Vehicles, vehdata)
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)
