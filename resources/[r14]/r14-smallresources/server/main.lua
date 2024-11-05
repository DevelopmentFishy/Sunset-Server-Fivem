QBCore = exports['qb-core']:GetCoreObject()

whiteout, snow, block = false, Config.MiscImprovements.SnowOnServerStart, false

------------------------------------------------------------------------------------------------------------
--------------------------------------------    VERSION CHECK   --------------------------------------------
------------------------------------------------------------------------------------------------------------

PerformHttpRequest('https://raw.githubusercontent.com/regalonefour/r14-versions/main/r14-smallresources.txt', function(err, version, headers)
    local curVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

    if not version then print('Could not complete version request.') return end

    if utf8.codepoint(version:sub(#version, #version)) == 10 then version = version:sub(1, #version - 1) end -- controls for data link escape character at the end of string from github, removes it if found

    if version ~= curVersion then
        print(('^3Current Version: %s, Latest Version: %s'):format(curVersion, version))
        print('Please download the latest version of r14-smallresources from your keymaster!^0')
    end
end)

------------------------------------------------------------------------------------------------------------
--------------------------------------------    MISC COMMANDS   --------------------------------------------
------------------------------------------------------------------------------------------------------------

if Config.MiscImprovements.Whiteout.Enabled then
    QBCore.Commands.Add('whiteout', 'Set whiteout blizzard conditions.', {}, true, function(source, args)
        if block then return end

        whiteout = not whiteout
        block = true

        if whiteout then 
            Config.MiscImprovements.Whiteout.ServerStartTrigger()
            snow = true
        else
            Config.MiscImprovements.Whiteout.ServerEndTrigger()
            snow = false
        end

        Config.Functions.ServerNotify(source, ('Whiteout conditions have been turned %s'):format(snow and 'on' or 'off'))

        Wait(15000)

        if snow then TriggerClientEvent('r14-smallresources:client:snowpass', -1, whiteout) end

        block = false
    end, 'admin')
end

if Config.MiscImprovements.ToggleSnow then
    QBCore.Commands.Add('togglesnow', 'Enable or disable snow on the ground.', {}, true, function(source, args)
        snow = not snow

        TriggerClientEvent('r14-smallresources:client:snowpass', -1, snow)

        Config.Functions.ServerNotify(source, ('Snow has been toggled %s'):format(snow and 'on' or 'off'))
    end, 'admin')
end

RegisterNetEvent('r14-smallresources:server:requestsnowpass', function()
    local src = source
    TriggerClientEvent('r14-smallresources:client:snowpass', src, snow) 
end)

------------------------------------------------------------------------------------------------------------
--------------------------------------------  VEHICLE COMMANDS  --------------------------------------------
------------------------------------------------------------------------------------------------------------

if Config.VehicleImprovements.LiveryCommand.Enabled then
    QBCore.Commands.Add('livery', 'Change the livery of your vehicle.', {}, true, function(source, args)
        local Player = QBCore.Functions.GetPlayer(source)

        if Config.VehicleImprovements.LiveryCommand.AllowAll then perm = true end
        if not perm and (IsPlayerAceAllowed(source, 'admin') or QBCore.Functions.HasPermission(source, 'admin')) then perm = true end
        if not perm and (Config.VehicleImprovements.LiveryCommand.AllowMod and IsPlayerAceAllowed(source, 'mod') or QBCore.Functions.HasPermission(source, 'mod')) then perm = true end
        if not perm and (Config.VehicleImprovements.LiveryCommand.AllowEmergency and Config.AuthorizedJobs.FirstResponder.Check(source)) then perm = true end

        if perm then
            TriggerClientEvent('r14-smallresources:client:changelivery', source, args[1])
        end
    end)
end

if Config.VehicleImprovements.DoorCommand then
    QBCore.Commands.Add('door', 'Enter a number between 1 and 4 to toggle the door of a vehicle you are in or nearby', {}, true, function(source, args)
        door = args[1]

        if not door then Config.Functions.ServerNotify(source, 'Please enter a number between 1 and 4.') return end
        if type(door) == 'string' and not tonumber(door) then Config.Functions.ServerNotify(source, 'This was not a valid door, please enter a number between 1 and 4.') return else door = tonumber(door) - 1 end
        if door < 0 or door > 3 then Config.Functions.ServerNotify(source, 'This was not a valid door, please enter a number between 1 and 4.') return end       

        TriggerClientEvent('r14-smallresources:client:toggledoor', source, door )
    end)

    QBCore.Commands.Add('hood', 'Toggle the hood of a vehicle you are in or nearby', {}, true, function(source, args)
        TriggerClientEvent('r14-smallresources:client:toggledoor', source, 4)
    end)

    QBCore.Commands.Add('trunk', 'Toggle the trunk of a vehicle you are in or nearby', {}, true, function(source, args)
        TriggerClientEvent('r14-smallresources:client:toggledoor', source, 5)
    end)
end

if Config.VehicleImprovements.DomeLightCommand then
    QBCore.Commands.Add('dome', 'Toggle the dome light of the car you are in', {}, true, function(source, args)
        TriggerClientEvent('r14-smallresources:client:toggledomelight', source)
    end)
end

if Config.VehicleImprovements.SeatCommand.Enabled then
    QBCore.Commands.Add('seat', 'Change seats while in a vehicle.', {}, true, function(source, args)
        TriggerClientEvent('r14-smallresources:client:changeseat', source, args[1])
    end)
end

if Config.VehicleImprovements.WindowCommand then
    QBCore.Commands.Add('window', 'Enter a number between 1 and 7 to toggle the window of a vehicle you are in', {}, true, function(source, args)
        window = args[1]

        if type(window) == 'string' and not tonumber(window) then Config.Functions.ServerNotify(source, 'This was not a valid door, please enter a number between 1 and 6.') return else if window then window = tonumber(window) - 1 end end
        if window and (window < 0 or window > 6) then Config.Functions.ServerNotify(source, 'This was not a valid door, please enter a number between 1 and 6.') return end       

        TriggerClientEvent('r14-smallresources:client:togglewindow', source, window)
    end)
end
