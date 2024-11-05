local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for i,k in pairs(Config.Locations['mainhack']) do
        exports['qb-target']:AddBoxZone(k.box.name, k.box.pos, k.box.length, k.box.width, {
            name = k.box.name,
            heading = k.box.heading,
            debugPoly = k.box.debug,
            minZ = k.box.minZ,
            maxZ = k.box.maxZ
        }, {
            options = {
                {
                    type = "client",
                    action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not k.hacked then
                            if not k.busy then
                                QBCore.Functions.TriggerCallback('lumio-ammunationrobbery:server:amountOfCops', function(cops)
                                    if cops >= Config.RequiredCops then
                                        TriggerEvent('lumio-ammunationrobbery:client:mainhack', i)
                                    else
                                        QBCore.Functions.Notify(Translations.notify['not_enough_cops'], 'error')
                                    end
                                end)
                            else
                                QBCore.Functions.Notify(Translations.notify['be_patient'], "error", 5000)
                            end
                        else
                            QBCore.Functions.Notify(Translations.notify['already_hacked'], "error", 5000)
                        end
                    end,
                    icon = 'fas fa-laptop-code',
                    label = Translations.target['start_hack'],
                    canInteract = function()
                        if not Config.Locations['info'].isActive then return true end
                        return false 
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:client:mainhack', function(i)
    local result = QBCore.Functions.HasItem(Config.RequiredForMainHack)

    if result then
        Config.Locations['mainhack'][i].busy = true
        TriggerServerEvent('lumio-ammunationrobbery:server:mainhackstate', i, true)

        Config.Stopped = false
        Config.Hacking = true
        hackAnimation()

        local success = exports['howdy-hackminigame']:Begin(Config.MainHackIcons, Config.MainHackSpeed)

        if success then
            Config.Hacking = false
            QBCore.Functions.Notify(Translations.notify['successful'], "success", 5000)
            Config.Locations["mainhack"][i].busy = false
            Config.Locations["mainhack"][i].hacked = true
            -- TriggerServerEvent('police:server:policeAlert', Translations.notify['police_alert'])
            local camId = '35' 
            exports['ps-dispatch']:Ammunationrobbery(camId)
            TriggerServerEvent('lumio-ammunationrobbery:server:mainhackstate', i, false)
            TriggerServerEvent('lumio-ammunationrobbery:server:mainhackhacked', i, true)
            TriggerServerEvent('lumio-ammunationrobbery:server:setAmmState', true)
        else
            Config.Hacking = false
            QBCore.Functions.Notify(Translations.notify['try_again'], "error", 5000)
            Config.Locations["mainhack"][i].busy = false
            TriggerServerEvent('lumio-ammunationrobbery:server:mainhackstate', i, false)
        end
    else
        QBCore.Functions.Notify(Translations.notify['no_item'], 'error')
    end
end)

CreateThread(function()
    for i,k in pairs(Config.Locations['boxes']) do
        exports['qb-target']:AddBoxZone(k.box.name, k.box.pos, k.box.length, k.box.width, {
            name = k.box.name,
            heading = k.box.heading,
            debugPoly = k.box.debug,
            minZ = k.box.minZ,
            maxZ = k.box.maxZ
        }, {
            options = {
                {
                    type = "client",
                    action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not k.opened then
                            -- k.opened = true
                            TriggerServerEvent('lumio-ammunationrobbery:server:setCaseState', 'boxes', i)
                            TriggerEvent('lumio-ammunationrobbery:client:breakopen', k.type, k.opened, k.anim) -- Triggers a client event called testing:event and sends the argument 'test' with it
                        else
                            QBCore.Functions.Notify(Translations.notify['already_open'], "error", 5000)
                        end
                    end,
                    icon = 'fas fa-box-open',
                    label = Translations.target['break_open'],
                    canInteract = function()
                        if Config.Locations['info'].isActive then return true end
                        return false 
                    end,
                }
            },
            distance = 1.5,
        })
    end

    for i,k in pairs(Config.Locations['keypad']) do
        exports['qb-target']:AddBoxZone(k.box.name, k.box.pos, k.box.length, k.box.width, {
            name = k.box.name,
            heading = k.box.heading,
            debugPoly = k.box.debug,
            minZ = k.box.minZ,
            maxZ = k.box.maxZ
        }, {
            options = {
                {
                    type = "client",
                    action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not k.hacked then
                            if not k.busy then
                                if k.tries == Config.KeyPadMaxTries then
                                    QBCore.Functions.Notify(Translations.notify['out_of_tries'], "error", 5000)
                                else
                                    TriggerEvent('lumio-ammunationrobbery:client:insertcode', i)
                                end
                            else
                                QBCore.Functions.Notify(Translations.notify['be_patient'], "error", 5000)
                            end
                        else
                            QBCore.Functions.Notify(Translations.notify['already_inserted'], "error", 5000)
                        end
                    end,
                    icon = 'fas fa-key',
                    label = Translations.target['insert_code'],
                    canInteract = function()
                        if Config.Locations['info'].isActive then return true end
                        return false 
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:client:insertcode', function(i)
    Config.Locations["keypad"][i].busy = true
    TriggerServerEvent('lumio-ammunationrobbery:server:keypadstate', i, true)

    local success = exports['howdy-hackminigame']:Begin(Config.KeypadIcons, Config.KeypadSpeed)
    local tries = Config.Locations["keypad"][i].tries

    if success then
        QBCore.Functions.Notify(Translations.notify['successful2'], "success", 5000)
        Config.Locations["keypad"][i].busy = false
        Config.Locations["keypad"][i].hacked = true
        Config.Locations["katana"][1].visible = true
        TriggerServerEvent('lumio-ammunationrobbery:server:keypadstate', i, false)
        TriggerServerEvent('lumio-ammunationrobbery:server:keypadhacked', i, true)
        TriggerServerEvent('lumio-ammunationrobbery:server:enablekatana', i)
    else
        QBCore.Functions.Notify(Translations.notify['wrong'], "error", 5000)
        TriggerServerEvent('lumio-ammunationrobbery:server:keypadtries', i, tries)
        Config.Locations["keypad"][i].busy = false
        TriggerServerEvent('lumio-ammunationrobbery:server:keypadstate', i, false)
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:client:breakopen', function(casetype, opened, anim)
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)

    if anim == 'weld' then
        TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
        QBCore.Functions.Progressbar("break_open", Translations.progressbar['breaking_open'], Config.TimeToOpen, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('lumio-ammunationrobbery:server:givereward', casetype)
            ClearPedTasks(PlayerPedId())
            TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
            Wait(1)
            ClearPedTasks(PlayerPedId())
        end)
    else
        smashing = true

        QBCore.Functions.Progressbar("break_open", Translations.progressbar['breaking_open'], Config.TimeToOpen, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            smashing = false
            TaskPlayAnim(ped, 'missheist_jewel', "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            TriggerServerEvent('lumio-ammunationrobbery:server:givereward', casetype)
        end)

        CreateThread(function()
            while smashing do
                loadAnimDict('missheist_jewel')
                TaskPlayAnim(ped, 'missheist_jewel', 'smash_case', 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
                Wait(500)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
                loadParticle()
                StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                Wait(2500)
            end
        end)
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:client:setCaseState', function(boxtype, k)
    Config.Locations[boxtype][k].opened = true
end)

RegisterNetEvent('lumio-ammunationrobbery:client:setAmmState', function(state)
    TriggerServerEvent('lumio-ammunationrobbery:server:setCooldown')
    Config.Locations["info"].isActive = state
end)

RegisterNetEvent('lumio-ammunationrobbery:client:keypadtries', function(i, tries)
    Config.Locations["keypad"][i].tries = tries
end)

RegisterNetEvent('lumio-ammunationrobbery:client:keypadstate', function(i, state)
    Config.Locations["keypad"][i].busy = state
end)

RegisterNetEvent('lumio-ammunationrobbery:client:keypadhacked', function(i, state)
    Config.Locations["keypad"][i].hacked = state
    Config.Locations["katana"][i].visible = state
end)

RegisterNetEvent('lumio-ammunationrobbery:client:mainhackstate', function(i, state)
    Config.Locations["mainhack"][i].busy = state
end)

RegisterNetEvent('lumio-ammunationrobbery:client:mainhackhacked', function(i, state)
    Config.Locations["mainhack"][i].hacked = state
end)

RegisterNetEvent('lumio-ammunationrobbery:client:enablekatana', function(i)
    for i,k in pairs(Config.Locations['katana']) do
        exports['qb-target']:AddBoxZone(k.box.name, k.box.pos, k.box.length, k.box.width, {
            name = k.box.name,
            heading = k.box.heading,
            debugPoly = k.box.debug,
            minZ = k.box.minZ,
            maxZ = k.box.maxZ
        }, {
            options = {
                {
                    type = "client",
                    action = function()
                        if not k.opened and Config.Locations['keypad'][i].hacked then
                            TriggerServerEvent('lumio-ammunationrobbery:server:setCaseState', 'katana', i)
                            TriggerEvent('lumio-ammunationrobbery:client:breakopen', k.type, k.opened, k.anim)
                        else
                            QBCore.Functions.Notify(Translations.notify['already_open'], "error", 5000)
                        end
                    end,
                    icon = 'fas fa-box-open',
                    label = Translations.target['break_open'],
                    canInteract = function()
                        if Config.Locations['info'].isActive and k.visible then return true end
                        return false 
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:client:resetall', function()
    Config.Locations['info'].isActive = false
    Config.Locations['mainhack'][1].hacked = false
    Config.Locations['keypad'][1].hacked = false
    Config.Locations['keypad'][1].tries = 0
    Config.Locations['katana'][1].opened = false
    Config.Locations['katana'][1].visible = false

    Config.Hacking = false
    Config.Stopped = false

    for k, v in pairs(Config.Locations['boxes']) do
        v.opened = false
    end
end)