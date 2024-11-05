if Config.GarageScript ~= 'esx_garages' then
    return 
end

impoundTable = 'stored'
garageOutTable = 'OUT' 
impoundOutSide = 1

function GetVehicleImpound(data)
    local info = data
    if info.stored == 1 or info.stored == 2 then
        return false
    end
    return true
end

RegisterServerEvent("qs-smartphone:valetCarSetOutside")
AddEventHandler("qs-smartphone:valetCarSetOutside", function(plate)
    MySQL.Async.execute("UPDATE "..vehiclesTable.." SET "..impoundTable.." = @stored WHERE `plate` = @plate", {["@plate"] = plate, ["@stored"] = impoundOutSide})
end)

RegisterServerEvent("qs-smartphone:getInfoPlate")
AddEventHandler("qs-smartphone:getInfoPlate", function(plate)
    if Config.Framework == 'esx' then
        local src = source
        local xPlayer = GetPlayerFromIdFramework(src)
      
        local veh_datastore = MySQL.Sync.fetchAll("SELECT * FROM " ..vehiclesTable.. " WHERE "..vehiclesOwner.." ='"..xPlayer.identifier.."' AND "..plateTable.." ='"..plate.."' ", {})
        if veh_datastore and veh_datastore[1] then 
            if veh_datastore[1].garage == garageOutTable then
                TriggerClientEvent('qs-smartphone:client:notify', src, {
                    title = Lang("GARAGE_TITLE"),
                    text = 'The vehicle is outside',
                    icon = "./img/apps/garages.png",
                    timeout = 1500
                })
                return
            end
            if GetVehicleImpound(veh_datastore[1]) then 
                if veh_datastore[1].modelname then 
                    TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].vehicle, veh_datastore[1].modelname, veh_datastore[1].plate)
                else 
                    TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].vehicle, nil, veh_datastore[1].plate)
                end
            else
                TriggerClientEvent('qs-smartphone:client:notify', src, {
                    title = Lang("GARAGE_TITLE"),
                    text = 'Vehicle is in impound',
                    icon = "./img/apps/garages.png",
                    timeout = 1500
                })

            end
        end
    elseif Config.Framework == 'qb' then
        local src = source
        local player = GetPlayerFromIdFramework(src)
      
        local veh_datastore = MySQL.Sync.fetchAll("SELECT * FROM " ..vehiclesTable.. " WHERE "..vehiclesOwner.." ='"..player.identifier.."' AND "..plateTable.." ='"..plate.."' ", {})
        if veh_datastore and veh_datastore[1] then
            if veh_datastore[1].garage == garageOutTable then
                TriggerClientEvent('qs-smartphone:client:notify', src, {
                    title = Lang("GARAGE_TITLE"),
                    text = 'The vehicle is outside',
                    icon = "./img/apps/garages.png",
                    timeout = 1500
                })
                return
            end
            if GetVehicleImpound(veh_datastore[1]) then 
                TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].mods, veh_datastore[1].vehicle, veh_datastore[1].plate)
            else
                TriggerClientEvent('qs-smartphone:client:notify', src, {
                    title = Lang("GARAGE_TITLE"),
                    text = 'Vehicle is in impound',
                    icon = "./img/apps/garages.png",
                    timeout = 1500
                })
            end
        end
    end
end)

RegisterServerCallback("qs-smartphone:getCars", function(a, b)
    if Config.Framework == 'esx' then
        local player = ESX.GetPlayerFromId(source)
        MySQL.Async.execute("SELECT * FROM owned_vehicles WHERE `owner` = @cid and `type` = @type", {["@cid"] = c.identifier, ["@type"] = "car"}, function(d)
            local e = {}
            for f, g in ipairs(d) do
                table.insert(e, {["garage"] = g["parking"], ["plate"] = g["plate"], ["props"] = json.decode(g["vehicle"])})
            end
            b(e)
        end)
    elseif Config.Framework == 'qb' then
        local player = GetPlayerFromIdFramework(source) 
        MySQL.Async.execute("SELECT * FROM player_vehicles WHERE `citizenid` = @cid and `type` = @type", {["@cid"] = player.citizenid, ["@type"] = "car"}, function(d)
            local e = {} 
            for f, g in ipairs(d) do
                table.insert(e, {["garage"] = g["parking"], ["plate"] = g["plate"], ["props"] = json.decode(g["mods"])})
            end
            b(e)
        end)
    end
end) 

RegisterServerCallback('qs-smartphone:server:GetGarageVehicles', function(source, cb)
    if Config.Framework == 'esx' then 
        local Player = GetPlayerFromIdFramework(source)
        local Vehicles = {}

        MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `owner` = '"..Player.identifier.."'", {}, function(result)
            if result[1] ~= nil then
                for k, v in pairs(result) do

                    if v.parking == "OUT" or v.parking == nil then
                        VehicleState = "OUT"
                    else
                        VehicleState = v.parking
                    end

                    local vehdata = {}
                    local genData = json.decode(result[k].vehicle)
                    local vehicleInfo = { ['name'] = json.decode(result[k].vehicle).model }

                    vehdata = {
                        model = json.decode(result[k].vehicle).model,
                        plate = v.plate,
                        garage = VehicleState,
                        fuel = genData.fuel or 1000,
                        engine = genData.engine or 1000,
                        body = genData.body or 1000,
                        label = vehicleInfo["name"]
                    }
                    table.insert(Vehicles, vehdata)
                end
                cb(Vehicles)
            else
                cb(nil)
            end
        end)
    elseif Config.Framework == 'qb' then 
        local Player = GetPlayerFromIdFramework(source)
        local Vehicles = {}

        MySQL.Async.fetchAll("SELECT * FROM " .. vehiclesTable .. " WHERE `citizenid` = '"..Player.identifier.."'", {}, function(result)
            if result[1] ~= nil then
                for k, v in pairs(result) do

                    if v.parking == nil then
                        VehicleState = "OUT"
                    else
                        VehicleState = v.parking
                    end

                    local vehdata = {}
                    vehdata.props = v.mods
                    vehdata.plate = v.plate
                    vehdata.model = v.vehicle
                    vehdata.garage = VehicleState
                    vehdata.label = v.vehiclename
                    
                    table.insert(Vehicles, vehdata)
                end
                cb(Vehicles)
            else
                cb(nil)
            end
        end)
    end
end)