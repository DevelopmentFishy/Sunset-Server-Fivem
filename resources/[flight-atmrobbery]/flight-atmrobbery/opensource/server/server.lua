Webhook = ""

if Config.Framework == "qb-core" then
    local QBCore = exports[Config.Core.resource]:GetCoreObject()
    function UseableItem()
        QBCore.Functions.CreateUseableItem(AtmConfig.Items.Rope, function(source, Item) 
            if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
            TriggerClientEvent("flight-atmrobbery:userope", source, AtmConfig.Items.Rope)
        end)

        QBCore.Functions.CreateUseableItem(AtmConfig.Settings['Atms']['Atmred']['ItemName'], function(source, Item)
            if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmred")
        end)

        QBCore.Functions.CreateUseableItem(AtmConfig.Settings['Atms']['Atmblue']['ItemName'], function(source, Item)
            if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmblue")
        end)

        QBCore.Functions.CreateUseableItem(AtmConfig.Settings['Atms']['Atmgreen']['ItemName'], function(source, Item)
            if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmgreen")
        end)

        if not Config.DrillWithTarget then
            QBCore.Functions.CreateUseableItem(AtmConfig.Items.Drill, function(source, Item)
                if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
                TriggerClientEvent('flight-atmrobbery:client:useDrill', source, AtmConfig.Items.Drill)
            end)
        end
    end

    function AddItem(source, item, amount, info)
        if info == nil then
            QBCore.Functions.GetPlayer(source).Functions.AddItem(item, amount)
        else
            QBCore.Functions.GetPlayer(source).Functions.AddItem(item, amount, false, info)
        end
    end

    function RemoveItem(source, item, amount)
        return QBCore.Functions.GetPlayer(source).Functions.RemoveItem(item, amount)
    end

    function ItemBox(source, item, addRemove, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], addRemove, amount)
    end

    function AddMoney(source, cash, amount)
        QBCore.Functions.GetPlayer(source).Functions.AddMoney(cash, amount)
    end

    function NotificationServer(source, notification, notificationType, duration)
        TriggerClientEvent('QBCore:Notify', source, notification, notificationType, duration)
    end

    lib.callback.register("flight-atmrobbery:getOnlinPoliceCountQB", function(source)
        local jobs = {"police", "statepolice", "fib"}
        local CurrentCops = 0
        for k, v in pairs(jobs) do
            local players = QBCore.Functions.GetPlayers()
            for i = 1, #players do
                local Player = QBCore.Functions.GetPlayer(players[i])
                if Player ~= nil then
                    if Player.PlayerData.job.name == v then
                        CurrentCops = CurrentCops + 1
                    end
                end
            end
        end
        return (CurrentCops >= Config.MinimumAtmRobberyPolice)
    end)

    AddEventHandler(Config.Core.name..':Server:PlayerLoaded', function(Player)
        Wait(1000)
        TriggerClientEvent('flight-atmrobbery:sync-atms', Player.PlayerData.source, Atms)
        TriggerClientEvent('flight-atmrobbery:client:wallatm', -1, wallAtms)
        if not DoesEntityExist(sync2) then return end
        TriggerClientEvent("flight-atmrobbery:delprop", Player.PlayerData.source, sync2)
    end)

    function DiscordLogClient(source, amount)
        if Config.DiscordLogStatus then
            local player = QBCore.Functions.GetPlayer(source)
            DiscordLog("**Name:** **"..player.PlayerData.charinfo.firstname.."** **"..player.PlayerData.charinfo.lastname.."**".."\n".."**Server ID:** "..player.PlayerData.cid.."\n".."**Citizen ID:** "..player.PlayerData.citizenid.."\n".."**License:** "..player.PlayerData.license.." \n \n".."Log info: ".." **Robbed an ATM**")
        end
    end

    function DiscordLogCash(source, amount)
        if Config.DiscordLogStatus then
            local player = QBCore.Functions.GetPlayer(source)
            DiscordLog("**Name:** **"..player.PlayerData.charinfo.firstname.."** **"..player.PlayerData.charinfo.lastname.."**".."\n".."**Server ID:** "..player.PlayerData.cid.."\n".."**Citizen ID:** "..player.PlayerData.citizenid.."\n".."**License:** "..player.PlayerData.license.." \n \n".."Log info: ".." **+** **"..amount.."**")
        end
    end
elseif Config.Framework == "esx" then

    CreateThread(function()
        while ESX == nil do Wait(1000) end
    end)
    
    function UseableItem()
        ESX.RegisterUsableItem(AtmConfig.Items.Rope, function(source)
            TriggerClientEvent("flight-atmrobbery:userope", source, AtmConfig.Items.Rope)
        end)

        ESX.RegisterUsableItem(AtmConfig.Settings['Atms']['Atmred']['ItemName'], function(source)
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmred")
        end)

        ESX.RegisterUsableItem(AtmConfig.Settings['Atms']['Atmblue']['ItemName'], function(source)
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmblue")
        end)

        ESX.RegisterUsableItem(AtmConfig.Settings['Atms']['Atmgreen']['ItemName'], function(source)
            TriggerClientEvent('flight-atmrobbery:use-atm', source, "Atmgreen")
        end)

        if not Config.DrillWithTarget then
            ESX.RegisterUsableItem(AtmConfig.Items.Drill, function(source)
                TriggerClientEvent('flight-atmrobbery:client:useDrill', source, AtmConfig.Items.Drill)
            end)
        end
    end

    function AddItem(source, item, amount)
        ESX.GetPlayerFromId(source).addInventoryItem(item, amount)
    end

    function RemoveItem(source, item, amount)
        ESX.GetPlayerFromId(source).removeInventoryItem(item, amount)
    end

    function ItemBox(source, item, addRemove, amount)

    end

    function AddMoney(source, amount)
        ESX.GetPlayerFromId(source).addMoney(amount)
    end

    function NotificationServer(source, notification, notificationType, duration)
        TriggerClientEvent('esx:showNotification', source, notification, notificationType, duration)
    end

    lib.callback.register('flight-atmrobbery:server:hasitem', function(source, item)
        if Config.Inventory == "ox" then
            local check = exports.ox_inventory:GetItemCount(source, item)
            return check >= 1
        elseif Config.Inventory == "qs" then
            local check = exports['qs-inventory']:GetItemTotalAmount(source, item)
            return check >= 1
        else
            check = ESX.GetPlayerFromId(source).hasItem(item)
            return check.count >= 1
        end
    end)

    lib.callback.register("flight-atmrobbery:getOnlinePoliceCount", function(source)
        local Players = ESX.GetPlayers()
        local policeOnline = 0
        for i = 1, #Players do
            local xPlayer = ESX.GetPlayerFromId(Players[i])
            if xPlayer["job"]["name"] == "police" then
                policeOnline = policeOnline + 1
            end
        end
        return (policeOnline >= Config.MinimumAtmRobberyPolice)
    end)

    RegisterServerEvent('flight-atmrobbery:server:PdNotify', function()
        local xPlayer = ESX.GetPlayerFromId(source)
        local Players = ESX.GetPlayers()
        for i = 1, #Players do
            local xPlayer = ESX.GetPlayerFromId(Players[i])
            if xPlayer["job"]["name"] == "police" then
                TriggerClientEvent('esx:showNotification', source, 'Someone is robbing an atm, check your map for the location')
            end
        end
        local coords = xPlayer.getCoords(true)
        TriggerClientEvent('flight-atmrobbery:client:pdnotify', coords)
    end)

    RegisterNetEvent('esx:playerLoaded', function(source)
        Wait(1000)
        TriggerClientEvent('flight-atmrobbery:sync-atms', source, Atms)
        TriggerClientEvent('flight-atmrobbery:client:wallatm', -1, wallAtms)
        if not DoesEntityExist(sync2) then return end
        TriggerClientEvent("flight-atmrobbery:client:DelProp", source, sync2)
    end)


    function DiscordLogCash(source, amount)
        if Config.DiscordLogStatus then
            local player = ESX.GetPlayerFromId(source)
            DiscordLog(player.getName().. ' - '..player.getIdentifier(), "Log info: ".." **+** **"..amount.."**")
        end
    end

    function DiscordLogClient(source)
        if Config.DiscordLogStatus then
            local player = ESX.GetPlayerFromId(source)
            DiscordLog(player.getName().. ' - '..player.getIdentifier(), "Log info: ".." **Robbed an ATM**")
        end
    end
else

end

function RobbedServer(source)

end

lib.callback.register("flight-atmrobbery:place-atm", function(source, pCoords, pHeading, Type)
    local AtmData = {}
    ::again::
    AtmData.id = math.random(111111111111111, 999999999999999)
    AtmData.coords = pCoords
    AtmData.heading = pHeading
    AtmData.prepared = false
    AtmData.type = Type
    AtmData.step = 0
    AtmData.busy = false
    AtmData.status = false
    local checkifexists = MySQL.query.await('SELECT * FROM flight_atmrobbery WHERE id = ?', {AtmData.id})
    if checkifexists[1] then
        goto again
    end
    Atms[#Atms + 1] = AtmData
    TriggerClientEvent('flight-atmrobbery:sync-atms', -1, Atms)
    coordsfinal = {pCoords[1], pCoords[2], pCoords[3]}
    MySQL.insert('INSERT INTO flight_atmrobbery (id, x, y, z, heading, type, step) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        AtmData.id,
        pCoords[1], 
        pCoords[2], 
        pCoords[3],
        AtmData.heading,
        AtmData.type,
        AtmData.step,
    })
end)

function SQLUpdate(step, AtmId)
    MySQL.update('UPDATE flight_atmrobbery SET step = ? WHERE id = ? ', {step, AtmId}, function() end)
end

function SQLDelete(AtmId)
    MySQL.update('DELETE FROM flight_atmrobbery WHERE id = ?', {AtmId}, function() TriggerClientEvent('flight-atmrobbery:delete-atm', -1, AtmId) end)
end

function SQLUpdate2(AtmId)
    MySQL.update('DELETE FROM flight_atmrobbery WHERE id = ?', {AtmId}, function() TriggerClientEvent('flight-atmrobbery:delete-atm', -1, AtmId) end)
end

function SQLDeleteAll()
    MySQL.update('DELETE FROM flight_atmrobbery', function() end)
end

function SQLQueryAwait(AtmId)
    local check = MySQL.query.await('SELECT * FROM flight_atmrobbery WHERE id = ?', {AtmId})
    return check
end

function SQLQuerySelect()
    MySQL.query('SELECT * FROM flight_atmrobbery', {}, function(result)
        if result then
            for _, v in pairs(result) do
                local AtmData = {
                    id = v.id,
                    coords = vec3(tonumber(v.x), tonumber(v.y), tonumber(v.z)),
                    heading = v.heading,
                    prepared = false,
                    type = v.type,
                    step = v.step,
                    busy = false,
                    status = false,
                } Atms[#Atms + 1] = AtmData
                Wait(1000 + (#Atms * 50))
                TriggerClientEvent('flight-atmrobbery:sync-atms', -1, Atms)
            end
        end
    end)
end