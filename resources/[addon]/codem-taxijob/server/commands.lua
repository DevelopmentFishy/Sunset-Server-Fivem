Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == 'esx' then
        frameworkObject.RegisterCommand('taxiaddxp', 'admin', function(source, args)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args.id))
            local xp = args.xp
            if xPlayer then
                AddXPTaxi(xPlayer.source, xp)
            end
        end, true, {help = "Add xp taxi.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'xp', help = "xp count", type = 'number'}
        }})

        frameworkObject.RegisterCommand('taxiremovexp', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args.id))
            local xp = args.xp
            if xPlayer then
                TaxiRemoveXP(xPlayer.source, xp)
            end
        end, true, {help = "Remove xp taxi.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'xp', help = "xp count", type = 'number'}
        }})

        frameworkObject.RegisterCommand('setleveltaxi', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(args.id))
            local level = args.level
            if xPlayer then
                SetTaxiLevel(xPlayer.source, level)
            end
        end, true, {help = "addlevel.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'level', help = "Level", type = 'number'}
        }})

    else
        frameworkObject.Commands.Add('taxiaddxp', "Add xp taxi", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                AddXPTaxi(Player.PlayerData.source, xp)
            end
        end, 'admin')

        frameworkObject.Commands.Add('taxiremovexp', "Remove xp taxi", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                TaxiRemoveXP(Player.PlayerData.source, xp)
            end
        end, 'admin')

        frameworkObject.Commands.Add('setleveltaxi', "Add level taxi", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local level = tonumber(args[2])
            if Player then
                SetTaxiLevel(Player.PlayerData.source, level)
            end
        end, 'admin')
    end
end)