local GetResourceState, LoadResourceFile = GetResourceState, LoadResourceFile
local fwObj
if cfg?['framework'] then
    framework = cfg['framework']:lower()
else
    local esx = GetResourceState('es_extended'):find('start')
    local qbcore = GetResourceState('qb-core'):find('start')
    if esx then
        framework = 'esx'
    elseif qbcore then
        framework = 'qb'
    end
end

if cfg and not cfg['disableOxLibInterfaces'] then
    if GetResourceState('ox_lib'):find('start') then
        local oxlib = LoadResourceFile('ox_lib', 'init.lua')
        load(oxlib)()
    end
end

CreateThread(function()
    local timeout = 0
    while not fwObj and timeout < 1000 do
        timeout = timeout + 1
        if framework == 'esx' then
            pcall(function() fwObj = exports['es_extended']:getSharedObject() end)
            if not fwObj then
                TriggerEvent('esx:getSharedObject', function(obj) fwObj = obj end)
            end
            if fwObj then
                ESX = fwObj
                break
            end
        elseif framework == 'qb' or framework == 'qbcore' then
            pcall(function() fwObj = exports['qb-core']:GetCoreObject() end)
            if not fwObj then
                pcall(function() fwObj = exports['qb-core']:GetSharedObject() end)
            end
            if not fwObj then
                TriggerEvent('QBCore:GetObject', function(obj) fwObj = obj end)
            end
            if fwObj then
                QBCore = fwObj
                break
            end
        end
        Wait(0)
    end
end)

resourceName = GetCurrentResourceName()
mathrandom, random, mathrandomseed = math.random, math.random, math.randomseed
mathrandomseed(GetGameTimer())
uuid = function()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and mathrandom(0, 0xf) or mathrandom(8, 0xb)
        return string.format('%x', v)
    end)
end

dumptable = function(table, nb)
    if nb == nil then
        nb = 0
    end

    if type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. '    '
        end

        s = '{\n'
        for k, v in pairs(table) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            for i = 1, nb, 1 do
                s = s .. '    '
            end
            s = s .. '[' .. k .. '] = ' .. dt(v, nb + 1) .. ',\n'
        end

        for i = 1, nb, 1 do
            s = s .. '    '
        end

        return s .. '}'
    else
        return tostring(table)
    end
end

dt = function(table, w)
    if w then return dumptable(table) else print(dumptable(table)) end
end

if not IsDuplicityVersion() then --client
    playerId = PlayerId()
    serverCallbacks = {}

    triggerCallback = function(name, cb, ...)
        serverCallbacks[name] = cb
        TriggerServerEvent(resourceName .. ':server:triggerCallback', name, ...)
    end

    RegisterNetEvent(resourceName .. ':client:triggerCallback', function(name, ...)
        if serverCallbacks[name] then
            serverCallbacks[name](...)
            serverCallbacks[name] = nil
        end
    end)

    notification = function(str, type, length)
        if lib then
            lib.notify({
                id = resourceName .. '_notify_' .. uuid(),
                description = str,
                type = type,
            })
        elseif ESX then
            ESX.ShowNotification(str, type, length)
        elseif QBCore then
            QBCore.Functions.Notify(str, type, length)
        else
            BeginTextCommandThefeedPost('STRING')
            AddTextComponentSubstringPlayerName(str)
            EndTextCommandThefeedPostTicker(0, 1)
        end
    end

    RegisterNetEvent(resourceName .. ':client:notification', notification)

    helpNotification = function(str)
        AddTextEntry('helpNotification', str)
        BeginTextCommandDisplayHelp('helpNotification')
        EndTextCommandDisplayHelp(0, 0, 0, -1)
    end

    drawText3D = function(x, y, z, str, length, r, g, b, a)
        local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
        if onScreen then
            local factor = #str / 370
            if length then
                factor = #str / length
            end
            SetTextScale(0.30, 0.30)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(r or 255, g or 255, b or 255, a or 215)
            BeginTextCommandDisplayText('STRING')
            SetTextCentre(1)
            AddTextComponentSubstringPlayerName(str)
            EndTextCommandDisplayText(_x, _y)
            DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
        end
    end

    progressBar = function(time, str, cb)
        if lib then
            local libprogressBar = lib.progressBar
            if cfg and cfg['useOxCircleProgressBar'] then libprogressBar = lib.progressCircle end
            if libprogressBar({ duration = time * 1000, label = str }) then
                if cb then cb(true) end
            end
        else
            loadTextureDict('timerbars', function()
                local percent, width = 1700, 0.005
                local w = width * (percent / 100)
                local x = (0.95 - (width * (percent / 100)) / 2) - width / 2

                BeginTextCommandGetWidth('STRING')
                AddTextComponentSubstringPlayerName(str)
                SetTextScale(0.3, 0.3)
                SetTextCentre(true)
                local textWidth = EndTextCommandGetWidth(true)
                CreateThread(function()
                    while true do
                        percent = percent - (1700 / (time * 100))
                        w = width * (percent / 100)
                        x = (0.91 - (width * (percent / 100)) / 2) - width / 2
                        -- DrawSprite('TimerBars', 'ALL_BLACK_bg', 0.95, 0.95, 0.15, 0.0305, 0.0, 255, 255, 255, 180)
                        DrawSprite('timerbars', 'ALL_BLACK_bg', 0.96 - textWidth, 0.95, 0.2 + textWidth, 0.0305, 0.0, 255, 255, 255, 180)
                        DrawRect(0.95, 0.95, 0.085, 0.0109, 255, 255, 255, 50)
                        DrawRect(x + w, 0.95, w, 0.0109, 255, 255, 255, 255)
                        SetTextColour(255, 255, 255, 255)
                        SetTextFont(0)
                        SetTextScale(0.3, 0.3)
                        BeginTextCommandDisplayText('STRING')
                        AddTextComponentSubstringPlayerName(str)
                        EndTextCommandDisplayText(0.9 - textWidth, 0.938)
                        if percent <= 0 then
                            if cb then cb(true) end
                            break
                        end
                        Wait(0)
                    end
                    SetStreamedTextureDictAsNoLongerNeeded('timerbars')
                end)
            end)
        end
    end

    requestControl = function(entity, timeout)
        if not entity or DoesEntityExist(entity) then return end
        local timeout = GetGameTimer() + (timeout or 5000)
        while not NetworkHasControlOfEntity(entity) and GetGameTimer() < timeout do
            NetworkRequestControlOfEntity(entity)
            Wait(10)
        end
        return NetworkHasControlOfEntity(entity)
    end

    registerKeybind = function(data)
        RegisterCommand('+rm_' .. data.name, function()
            if data.onPressed and type(data.onPressed) == 'function' then if IsPauseMenuActive() then data.onPressed(false) else data.onPressed(true) end end
        end)
        RegisterCommand('-rm_' .. data.name, function()
            if data.onReleased and type(data.onReleased) == 'function' then if IsPauseMenuActive() then data.onReleased(false) else data.onReleased(true) end end
        end)
        if data.default:match('mouse') or data.default:match('iom') then
            RegisterKeyMapping('+rm_' .. data.name, data.description, 'mouse_button', data.default:lower())
        else
            RegisterKeyMapping('+rm_' .. data.name, data.description, 'keyboard', data.default:lower())
        end

        Wait(500)
        TriggerEvent('chat:removeSuggestion', ('/+rm_%s'):format(data.name))
        TriggerEvent('chat:removeSuggestion', ('/-rm_%s'):format(data.name))
    end

    local specialChars = {
        ['116'] = 'WheelMouseMove.Up',
        ['115'] = 'WheelMouseMove.Up',
        ['100'] = 'MouseClick.LeftClick',
        ['101'] = 'MouseClick.RightClick',
        ['102'] = 'MouseClick.MiddleClick',
        ['103'] = 'MouseClick.ExtraBtn1',
        ['104'] = 'MouseClick.ExtraBtn2',
        ['105'] = 'MouseClick.ExtraBtn3',
        ['106'] = 'MouseClick.ExtraBtn4',
        ['107'] = 'MouseClick.ExtraBtn5',
        ['108'] = 'MouseClick.ExtraBtn6',
        ['109'] = 'MouseClick.ExtraBtn7',
        ['110'] = 'MouseClick.ExtraBtn8',
        ['1015'] = 'AltLeft',
        ['1000'] = 'ShiftLeft',
        ['2000'] = 'Space',
        ['1013'] = 'ControlLeft',
        ['1002'] = 'Tab',
        ['1014'] = 'ControlRight',
        ['140'] = 'Numpad4',
        ['142'] = 'Numpad6',
        ['144'] = 'Numpad8',
        ['141'] = 'Numpad5',
        ['143'] = 'Numpad7',
        ['145'] = 'Numpad9',
        ['200'] = 'Insert',
        ['1012'] = 'CapsLock',
        ['170'] = 'F1',
        ['171'] = 'F2',
        ['172'] = 'F3',
        ['173'] = 'F4',
        ['174'] = 'F5',
        ['175'] = 'F6',
        ['176'] = 'F7',
        ['177'] = 'F8',
        ['178'] = 'F9',
        ['179'] = 'F10',
        ['180'] = 'F11',
        ['181'] = 'F12',
        ['194'] = 'ArrowUp',
        ['195'] = 'ArrowDown',
        ['196'] = 'ArrowLeft',
        ['197'] = 'ArrowRight',
        ['1003'] = 'Enter',
        ['1004'] = 'Backspace',
        ['198'] = 'Delete',
        ['199'] = 'Escape',
        ['1009'] = 'PageUp',
        ['1010'] = 'PageDown',
        ['1008'] = 'Home',
        ['131'] = 'NumpadAdd',
        ['130'] = 'NumpadSubstract',
        ['1002'] = 'CapsLock',
        ['211'] = 'Insert',
        ['210'] = 'Delete',
        ['212'] = 'End',
        ['1055'] = 'Home',
        ['1056'] = 'PageUp',
    }
    getCurrentKeybind = function(name)
        local key = GetControlInstructionalButton(0, joaat('+rm_' .. name) | 0x80000000, true):sub(3)
        if specialChars[key] then key = specialChars[key] end
        return key
    end

    loadAnimDict = function(dict, cb)
        if not HasAnimDictLoaded(dict) then
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemoveAnimDict(dict)
    end

    loadPtfxAsset = function(asset, cb)
        if not HasNamedPtfxAssetLoaded(asset) then
            RequestNamedPtfxAsset(asset)

            while not HasNamedPtfxAssetLoaded(asset) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemovePtfxAsset(asset)
    end

    loadAnimSet = function(set, cb)
        if not HasAnimSetLoaded(set) then
            RequestAnimSet(set)

            while not HasAnimSetLoaded(asset) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemoveAnimSet(asset)
    end

    loadTextureDict = function(dict, cb)
        if not HasStreamedTextureDictLoaded(dict) then
            RequestStreamedTextureDict(dict)

            while not HasStreamedTextureDictLoaded(dict) do
                Wait(1)
            end
        end

        if cb then cb() end
    end

    requestModel = function(model, cb)
        model = type(model) == 'number' and model or joaat(model)
        if model and IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)

                while not HasModelLoaded(model) do
                    Wait(0)
                end

                if cb then cb(true) end
                Wait(100)
                SetModelAsNoLongerNeeded(model)
            else
                if cb then cb(true) end
                Wait(100)
                SetModelAsNoLongerNeeded(model)
            end
        else
            print('Model (' .. model .. ') is not valid!')
            if cb then cb(false) end
        end
    end

    spawnObject = function(model, coords, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        requestModel(model, function()
            local obj = CreateObject(model, coords.xyz, not isLocal, true, false)
            SetEntityAsMissionEntity(obj, true, false)
            SetModelAsNoLongerNeeded(model)

            if DoesEntityExist(obj) then
                if cb then cb(obj) else return obj end
            end
        end)
    end

    spawnPed = function(model, coords, heading, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        requestModel(model, function()
            local ped = CreatePed(0, model, coords.xyz, heading, not isLocal, false)
            SetEntityAsMissionEntity(ped, true, false)

            if DoesEntityExist(ped) then
                if cb then cb(ped) else return ped end
            end
        end)
    end

    spawnVehicle = function(model, coords, heading, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        requestModel(model, function()
            local vehicle = CreateVehicle(model, coords.xyz, heading, not isLocal, true)
            local timeout = 0

            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleModKit(vehicle, 0)
            SetVehRadioStation(vehicle, 'OFF')
            SetModelAsNoLongerNeeded(model)
            RequestCollisionAtCoord(coords.xyz)

            repeat
                Wait(0)
                timeout = timeout + 1
            until (HasCollisionLoadedAroundEntity(vehicle) or timeout > 2000)

            if DoesEntityExist(vehicle) then
                if cb then cb(vehicle) else return vehicle end
            end
        end)
    end

    getClosestPlayers = function(coords, maxDistance)
        local players = GetActivePlayers()
        local ped = PlayerPedId()
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local maxDistance = maxDistance or 10
        local closePlayers = {}
        for _, player in pairs(players) do
            local target = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(target)
            if maxDistance >= #(targetCoords - coords) then
                closePlayers[#closePlayers + 1] = player
            end
        end
        return closePlayers
    end

    getClosestPlayer = function(coords, maxDistance)
        local ped = PlayerPedId()
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local closestPlayers = getClosestPlayers(coords, maxDistance)
        local closestDistance, closestPlayer = false
        for i = 1, #closestPlayers, 1 do
            local p = closestPlayers[i]
            if p and p ~= playerId then
                local target = GetPlayerPed(p)
                local targetCoords = GetEntityCoords(target)
                local distance = #(targetCoords - coords)
                if not closestDistance or closestDistance > distance then
                    closestPlayer = p
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end

    getClosestPeds = function(coords, maxDistance, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local peds = GetGamePool('CPed')
        local maxDistance = maxDistance or 10
        local closestPeds = {}
        for i = 1, #peds, 1 do
            local p = peds[i]
            if not ignoreEntities[p] and not IsPedAPlayer(p) then
                local pedCoords = GetEntityCoords(p)
                if maxDistance >= #(pedCoords - coords) then
                    closestPeds[#closestPeds + 1] = p
                end
            end
        end
        return closestPeds
    end

    getClosestPed = function(coords, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local peds = getClosestPeds(coords, 10, ignoreEntities)
        local closestDistance, closestPed = false
        for i = 1, #peds, 1 do
            local p = peds[i]
            if not ignoreEntities[p] and not IsPedAPlayer(p) then
                local pedCoords = GetEntityCoords(p)
                local distance = #(pedCoords - coords)
                if not closestDistance or closestDistance > distance then
                    closestPed = p
                    closestDistance = distance
                end
            end
        end
        return closestPed, closestDistance
    end

    getClosestVehicles = function(coords, maxDistance, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local vehicles = GetGamePool('CVehicle')
        local maxDistance = maxDistance or 10
        local closestVehicles = {}
        for i = 1, #vehicles, 1 do
            local v = vehicles[i]
            if not ignoreEntities[v] then
                local vehicleCoords = GetEntityCoords(v)
                if maxDistance >= #(vehicleCoords - coords) then
                    closestVehicles[#closestVehicles + 1] = v
                end
            end
        end
        return closestVehicles
    end

    getClosestVehicle = function(coords, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local vehicles = getClosestVehicles(coords, 10, ignoreEntities)
        local closestDistance, closestVehicle = false
        for i = 1, #vehicles, 1 do
            local v = vehicles[i]
            if not ignoreEntities[v] then
                local vehicleCoords = GetEntityCoords(v)
                local distance = #(vehicleCoords - coords)
                if not closestDistance or closestDistance > distance then
                    closestVehicle = v
                    closestDistance = distance
                end
            end
        end
        return closestVehicle, closestDistance
    end

    getClosestObjects = function(coords, maxDistance, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local objects = GetGamePool('CObject')
        local maxDistance = maxDistance or 10
        local closestObjects = {}
        for i = 1, #objects, 1 do
            local o = objects[i]
            if not ignoreEntities[o] then
                local objectCoords = GetEntityCoords(o)
                if maxDistance >= #(objectCoords - coords) then
                    closestObjects[#closestObjects + 1] = o
                end
            end
        end
        return closestObjects
    end

    getClosestObject = function(coords, ignoreEntities)
        local ped = PlayerPedId()
        ignoreEntities = ignoreEntities and ignoreEntities or {}
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local objects = getClosestObjects(coords, 10, ignoreEntities)
        local closestDistance, closestObject = false
        for i = 1, #objects, 1 do
            local o = objects[i]
            if not ignoreEntities[o] then
                local objectCoords = GetEntityCoords(o)
                local distance = #(objectCoords - coords)
                if not closestDistance or closestDistance > distance then
                    closestObject = o
                    closestDistance = distance
                end
            end
        end
        return closestObject, closestDistance
    end
else
    local serverCallbacks = {}

    local manifestFile = LoadResourceFile(resourceName, 'fxmanifest.lua')
    local loadSqlFuncs = manifestFile:find('/lib/MySQL.lua') and true or false
    if loadSqlFuncs then
        sql = {}
        sql.async = {}
        sql.sync = {}
        if GetResourceState('oxmysql') == 'started' then
            CreateThread(function()
                while not MySQL do
                    Wait(1)
                end

                sql.sync.query = MySQL.query.await
                sql.sync.insert = MySQL.insert.await
                sql.sync.update = MySQL.update.await
                sql.sync.scalar = MySQL.scalar.await

                sql.async.query = MySQL.query
                sql.async.insert = MySQL.insert
                sql.async.update = MySQL.update
                sql.async.scalar = MySQL.scalar
            end)
        elseif GetResourceState('mysql-async') == 'started' then
            CreateThread(function()
                while not MySQL do
                    Wait(1)
                end

                MySQL.ready(function()
                    sql.sync.query = MySQL.Sync.fetchAll
                    sql.sync.insert = MySQL.Sync.insert
                    sql.sync.update = MySQL.Sync.execute
                    sql.sync.scalar = MySQL.Sync.fetchScalar

                    sql.async.query = MySQL.Async.fetchAll
                    sql.async.insert = MySQL.Async.insert
                    sql.async.update = MySQL.Async.execute
                    sql.async.scalar = MySQL.Async.fetchScalar
                end)
            end)
        end
    end

    notification = function(src, str, type, length)
        TriggerClientEvent(resourceName .. ':client:notification', src, str, type, length)
    end

    registerCallback = function(name, cb)
        serverCallbacks[name] = cb
    end

    local triggerCallback = function(name, src, cb, ...)
        if serverCallbacks[name] then
            serverCallbacks[name](src, cb, ...)
        else
            print('This callback(^2' .. name .. '^0) is not registered!')
        end
    end

    RegisterNetEvent(resourceName .. ':server:triggerCallback', function(name, ...)
        local src = source

        triggerCallback(name, src, function(...)
            TriggerClientEvent(resourceName .. ':client:triggerCallback', src, name, ...)
        end, ...)
    end)

    getIdentifiers = function(src, identifierTypes)
        local identifiers = GetPlayerIdentifiers(src)
        local response = {}
        if identifierTypes then
            if type(identifierTypes) == 'table' then
                for _, type in pairs(identifierTypes) do
                    for _, identifier in pairs(identifiers) do
                        if identifier:find(type) then
                            response[type] = identifier
                        end
                    end
                end
            else
                for _, identifier in pairs(identifiers) do
                    if identifier:find(identifierTypes) then
                        return identifier
                    end
                end
            end
        else
            for _, identifier in pairs(identifiers) do
                if identifier:find('steam') then
                    return identifier
                end
            end
        end
        return response
    end
end
