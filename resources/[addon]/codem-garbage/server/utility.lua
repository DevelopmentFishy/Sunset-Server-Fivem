function ExecuteSql(query, parameters)
    local IsBusy = true
    local result = nil
    if Config.SQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function RegisterCallback(name, cbFunc)
    while not Core do
        Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        Core.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end

function WaitCore()
    while Core == nil do
        Wait(0)
    end
end

function GetPlayer(source)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    else
        Player = Core.Functions.GetPlayer(source)
    end
    return Player
end

function GetIdentifier(source)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            return Player.getIdentifier()
        else
            return Player.PlayerData.citizenid
        end
    end
end

function GetName(source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = Core.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end

function AddMoney(source, type, value)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if type == 'bank' then
                Player.addAccountMoney('bank', tonumber(value))
            end
            if type == 'cash' then
                Player.addMoney(value)
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if type == 'bank' then
                Player.Functions.AddMoney('bank', value)
            end
            if type == 'cash' then
                Player.Functions.AddMoney('cash', value)
            end
        end
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while Core == nil do
        Citizen.Wait(0)
    end
    if (Config.Framework == "qb" or Config.Framework == "old-qb") then
        Core.Commands.Add(Config.AddLevelCommands, "Give An Level Garbage job (Admin Only)",
            { { name = "id", help = "Player ID" }, { name = "level", help = "Next level" } }, false,
            function(source, args)
                local id = tonumber(args[1])
                local Player = GetPlayer(id)
                local level = tonumber(args[2])
                if Player then
                    AddLevelGarbageJob(Player.PlayerData.source, level)
                    savePlayerData(Player.PlayerData.source)
                else
                    Config.Notification(Config.NotificationText['notplayer'].text,
                        Config.NotificationText['notplayer'].type, true, source)
                end
            end, "admin")
        Core.Commands.Add(Config.RemoveLevelCommands, "Remove An Level Garbage job (Admin Only)",
            { { name = "id", help = "Player ID" }, { name = "level", help = "Next level" } }, false,
            function(source, args)
                local id = tonumber(args[1])
                local Player = GetPlayer(id)
                local level = tonumber(args[2])
                if Player then
                    RemoveLevelGarbageJob(Player.PlayerData.source, level)
                    savePlayerData(Player.PlayerData.source)
                else
                    Config.Notification(Config.NotificationText['notplayer'].text,
                        Config.NotificationText['notplayer'].type, true, source)
                end
            end, "admin")
    else
        while Core == nil do
            Citizen.Wait(0)
        end
        Core.RegisterCommand(Config.AddLevelCommands, 'admin', function(xPlayer, args, showError)
            local source = xPlayer.source
            local id = tonumber(args.playerId.source)
            local Player = GetPlayer(id)
            local level = tonumber(args[2])
            if Player then
                AddLevelGarbageJob(Player.source, level)
                savePlayerData(Player.source)
            else
                Config.Notification(Config.NotificationText['notplayer'].text,
                    Config.NotificationText['notplayer'].type, true, source)
            end
        end, true, {
            help = 'Give level to player',
            validate = true,
            arguments = {
                { name = 'playerId', help = 'playerid', type = 'player' },
                { name = 'level',    help = 'level',    type = 'level' },
            }
        })
        Core.RegisterCommand(Config.RemoveLevelCommands, 'admin', function(xPlayer, args, showError)
            local source = xPlayer.source
            local id = tonumber(args[1])
            local Player = GetPlayer(id)
            local level = tonumber(args[2])
            if Player then
                RemoveLevelGarbageJob(Player.source, level)
                savePlayerData(Player.source)
            else
                Config.Notification(Config.NotificationText['notplayer'].text,
                    Config.NotificationText['notplayer'].type, true, source)
            end
        end, true, {
            help = 'Remove level to player',
            validate = true,
            arguments = {
                { name = 'playerId', help = 'playerid', type = 'player' },
                { name = 'level',    help = 'level',    type = 'level' },
            }
        })
    end
end)
