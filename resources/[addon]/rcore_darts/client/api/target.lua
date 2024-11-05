local function loadTarget()
    if CConfig.UsingTarget then
        if CConfig.UsingNewOx then
            local models = {'prop_dart_bd_cab_01'}
            local options = {}
            table.insert(options, { event = 'darts:game:create', icon = 'fas fa-dice-four', label = 'Set up a darts game', distance = 2.5 })
            exports.ox_target:addModel(models, options)
        else
            exports[CConfig.TargetName]:AddTargetModel({-1113392619}, {
                options = {
                    {
                        event = 'darts:game:create',
                        icon = 'fas fa-dice-four',
                        label = 'Set up a darts game',
                    },
                },
                distance = 5.5
            })
        end

        local function handleCreation(data)
            local entity = data.entity
            local coords = GetEntityCoords(entity)
            OpenGameCreation(coords)
        end
        RegisterNetEvent('darts:game:create', handleCreation)
    end
end

CreateThread(function ()
    Wait(500)
    if CConfig.UsingTarget then
        if pcall(loadTarget) then
            dbg.info('Loaded target')
        else
            dbg.critical('Failed to load target with resource name ' .. CConfig.TargetName)
        end
    end
end)