local zones = {}

if Config.Framework == "qb-core" then
    local QBCore = exports[Config.Core.resource]:GetCoreObject()

    function Progressbar(name, label, duration, success, fail, icon)
        QBCore.Functions.Progressbar(name, label, duration, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, success, fail, icon)
    end

    function CarClass()
        return GetVehicleClass(QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId())))
    end

    function ClosestCar()
        return QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    end

    function HasItem(item)
        return QBCore.Functions.HasItem(item)
    end

    function Notification(notification, notificationType, duration)
        TriggerEvent('QBCore:Notify', notification, notificationType, duration)
    end
elseif Config.Framework == "esx" then
    function Progressbar(name, label, duration, success, fail, icon)
        if lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = true,
            disable = {car = true},
            anim = {},
            prop = {},
        }) then success() else fail() end
    end
    
    function Notification(notification, notificationType, duration)
        TriggerEvent('esx:showNotification', notification, notificationType, duration)
    end
    
    function HasItem(item)
        local p = promise.new()
        lib.callback('flight-atmrobbery:server:hasitem', false, function(result)
            p:resolve(result)
        end, item)
        return Citizen.Await(p)
    end
    
    function ClosestCar()
        local veh, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
        return veh, distance
    end
    
    function CarClass()
        local class = GetVehicleClass(ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId())))
        return class
    end
else

end

function Emote(name)
    if Config.EmoteMenu == "dpemotes" then
        TriggerEvent('animations:client:EmoteCommandStart', {name})
    elseif Config.EmoteMenu == "rpemotes" then
        exports["rpemotes"]:EmoteCommandStart(name, 1)
    elseif Config.EmoteMenu == "scully" then
        ExecuteCommand("e " .. name)
    else
        -- Add your other emote menu export here if it's none of the above
    end
end

function Dispatch()
    if Config.DispatchSystem == "cd" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police', }, 
            coords = data.coords,
            title = '10-15 - ATM Robbery',
            message = 'A '..data.sex..' robbing an ATM at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - ATM Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.DispatchSystem == "qs" then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police', 'sheriff', 'traffic', 'patrol' },
            callLocation = playerData.coords,
            callCode = { code = 'Atm Robbery', snippet = 'ATM' },
            message = "ATM Robbery",
            flashes = false,
            image = nil,
            blip = {
                sprite = 269,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'ATM Robbery',
                time = (20 * 1000),     --20 secs
            },
        })
    elseif Config.DispatchSystem == "ps" then
        exports["ps-dispatch"]:CustomAlert({
            coords = GetEntityCoords(PlayerPedId()),
            message = "ATM Overval",
            dispatchCode = "10-35",
            description = "ATM being robbed",
            radius = 0,
            sprite = 272,
            color = 1,
            scale = 1.0,
            length = 3,
        })
    else
        if Config.Framework == "esx" then
            TriggerServerEvent('flight-atmroi:server:PdNotify')
            -- (ESX) Add your disptach script here if it's none of the above and remove the line above this one
        else
            -- (Qbcore) Add your disptach script here if it's none of the above
        end
    end
end

function Robbed()
    --Trigger something here after robbing (if needed, for example adding theft exp)
end

function triggerMinigame(step)
    local p = promise.new()
    
    local seconds = math.random(8, 9)
    local circles = math.random(3, 4)

    if step == 1 then
        exports["ps-ui"]:Circle(function(yes)
            p:resolve(yes) 
        end, circles, seconds)
    elseif step == 2 then
        exports["ps-ui"]:Circle(function(yes)
            p:resolve(yes) 
        end, circles, seconds)
    elseif step == 3 then
        exports["ps-ui"]:Circle(function(yes)
            p:resolve(yes) 
        end, circles, seconds)
    elseif step == 4 then
        exports["ps-ui"]:Circle(function(yes)
            p:resolve(yes) 
        end, circles, seconds)
    end

    -- You can change the minigame for every step if you want to.

    return Citizen.Await(p)
end

function zoneDestroy(name)
    for k, v in pairs(zones) do
        if v.name == name then
            zones[k]:remove() zones[k] = nil
        end
    end
end

function zoneCreate(name, coords, size, rotation, onExit)
    zones[#zones + 1] = lib.zones.box({
        name = name,
        coords = coords,
        size = size,
        rotation = rotation,
        debug = Config.Debug,
        onExit = onExit,
    })
end

RegisterCommand("removerope", function(source, args, rawCommand)
    TriggerEvent("flight-atmrobbery:inhand")
end, false)
RegisterKeyMapping('removerope', 'Remove Atm Rope', 'keyboard', Config.RopeCancelButton)