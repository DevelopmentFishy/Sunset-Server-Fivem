local QBCore = exports['qb-core']:GetCoreObject()

local pcHacked = false
local accessComputer = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if Config.Inventory == 'ox' then
        Wait(500)
        exports.ox_inventory:displayMetadata({
            worth = 'Worth',
        })
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        if Config.Inventory == 'ox' then
            Wait(500)
            exports.ox_inventory:displayMetadata({
                worth = 'Worth',
            })
        end
    end
end)

CreateThread(function ()
    exports['qb-target']:AddBoxZone('lester-computer', vector3(-1052.76, -230.97, 44.02), 1.2, 1, {
        name= 'lester-computer',
        heading= 298,
        debugPoly= false,
        minZ= 42.82,
        maxZ= 45.62,
        }, {
            options = {
                {
                    num = 1,
                    icon = 'fas fa-laptop-code',
                    label = 'Connect Laptop',
                    item = Config.HackingItem,
                    canInteract = function()
                        return not pcHacked
                    end,
                    action = function(entity)
                        ConnectLaptop()
                    end,
                },
                {
                    num = 2,
                    icon = 'fas fa-laptop-code',
                    label = 'Access Computer',
                    canInteract = function()
                        return pcHacked
                    end,
                    action = function(entity)
                        lib.callback('kevin-banktrucks:checkjob', false, function(hasJob)
                            if not hasJob then
                                ShowMenu(entity)
                            else
                                Notification('Already on a job..', 8000, 'error')
                            end
                        end)
                    end,
                },
                {
                    num = 3,
                    icon = 'fas fa-circle-xmark',
                    label = 'Cancel',
                    canInteract = function()
                        local hasJob = lib.callback.await('kevin-banktrucks:checkjob', false)
                        return hasJob
                    end,
                    action = function(entity)
                        TriggerServerEvent('kevin-banktrucks:canceljob')
                    end,
                },
            },
        distance = 2.0
    })
end)

function ConnectLaptop()
    local player = PlayerPedId()
    QBCore.Functions.Progressbar('search_body', 'Connecting Laptop', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        Wait(500)
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        QBCore.Functions.Progressbar('search_body', 'Accessing', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@heists@ornate_bank@hack',
            anim = 'hack_loop',
            flags = 1,
        }, {
            model = 'hei_prop_hst_laptop',
            coords = { x = 0.18, y = 0.053, z = 0.02 },
            rotation = { x = 190.0, y = 0.0, z = 80.0 },
        }, {}, function() -- Done
            local settings = MiniGameSettings()
            exports['glow_minigames']:StartMinigame(function(success)
                if success then
                    ClearPedTasks(player)
                    pcHacked = true
                    TriggerServerEvent('kevin-banktrucks:removelaptop')
                else
                    ClearPedTasks(player)
                    QBCore.Functions.Notify('Failed to brute force.. Alarms triggered', 'error')
                end
            end, Config.LesterMinigame.game, settings)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled?', 'error')
            ClearPedTasks(player)
        end)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled?', 'error')
        ClearPedTasks(player)
    end)
end

function ShowMenu(entity)
    if not entity then return end
    lib.callback('kevin-banktrucks:checkpolice', false, function(copCount)
        if copCount then
            local availableOptions = {}
            local unavailableOptions = {}
            local registeredMenu = {
                id = 'fleeca_truckmenu',
                title = 'Beschikbare jobs',
                options = {},
            }
            
            for job, jobData in pairs(Config.Jobs) do
                local canUnlockJob = copCount >= jobData.copsneeded
                if canUnlockJob then
                    table.insert(availableOptions, CreateOption(job, jobData))
                else
                    table.insert(unavailableOptions, {
                        title = job,
                        disabled = true,
                        icon = 'fas fa-truck-front',
                        iconColor = '#ff432e',
                        description = 'Can\'t perfrom currently..',
                        options = {},
                    })
                end
            end
        
            for _, option in ipairs(availableOptions) do
                table.insert(registeredMenu.options, option)
            end
        
            for _, option in ipairs(unavailableOptions) do
                table.insert(registeredMenu.options, option)
            end
        
            lib.registerContext(registeredMenu)
            lib.showContext('fleeca_truckmenu')
        end
    end)
end

function CreateOption(job, jobData)
    local option = {
        title = job,
        description = jobData.description,
        icon = 'fas fa-truck-front',
        iconColor = '#00ff66',
        serverEvent = 'kevin-banktrucks:takejob',
        args = {
            data = jobData,
            job = job,
        },
    }
    return option
end