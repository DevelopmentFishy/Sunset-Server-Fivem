local active, _PlayerPedId, object, objPos, fPos, forward, heading, z
local workstationData = {}
local loadedModel = ''
local workstationUsableItemName
local maxCorrectionZ = Config.workstationMaxCorrectionZ
local originalZ = 0

function moveWorkstation()

    CreateThread(function()

        _PlayerPedId = PlayerPedId()

        while active do

            Wait(0)

            fPos = GetEntityCoords(_PlayerPedId) + forward
            objPos = vec(fPos.x, fPos.y, z)

            SetEntityCoords(object, objPos)
            SetEntityHeading(object, heading)

            --CANCEL
            if IsControlJustReleased(0, 202) then

                active = false
                DeleteObject(object)
                interface.client.hideText()
            end


            --RIGHT CLICK
            if IsControlJustReleased(0, 25) then

                _PlayerPedId = PlayerPedId()
                heading = GetEntityHeading(_PlayerPedId)
                forward = GetEntityForwardVector(_PlayerPedId) * 2.0;
            end

            --LEFT SHIFT
            if IsControlPressed(0, 131) then

                local c = GetEntityCoords(object)

                --SCROLL
                if IsControlJustReleased(0, 16) or IsControlJustReleased(0, 14) then

                    if originalZ - maxCorrectionZ < z then

                        z = z - 0.05
                    end
                end

                --SCROLL
                if IsControlJustReleased(0, 17) or IsControlJustReleased(0, 15) then

                    if originalZ + maxCorrectionZ > z then

                        z = z + 0.05
                    end
                end
            else

                --SCROLL
                if IsControlJustReleased(0, 16) or IsControlJustReleased(0, 14) then

                    heading = heading - 2.0
                end

                --SCROLL
                if IsControlJustReleased(0, 17) or IsControlJustReleased(0, 15) then

                    heading = heading + 2.0
                end
            end

            -- Context 'E'
            if IsControlJustReleased(1, 38) then


                if object then

                    active = false

                    local pos = GetEntityCoords(object)
                    local w = GetEntityHeading(object)

                    DeleteObject(object)

                    interface.client.hideText()

                    local result, reason = locationAnalysis(pos, ECO.ACE.command)

                    if ECO.ACE.command and Config.copyingPortableDataToClipboard then

                        copyToClipboard(loadedModel, pos, w)
                        interface.client.notify(Lang:t('workplace_data_copied_to_clipboard'), "success")
                    end

                    if result then

                        workstationData.pos = vector4(pos.x, pos.y, z, w)

                        DeleteObject(object)

                        interface.client.hideText()

                        interface.client.progressbar.add("eco_crafting_" .. math.random(1000),
                                Lang:t('workstation_placement'),
                                Config.workstationPlacementTime * 1000,
                                false,
                                true,
                                {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                {
                                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    anim = "machinic_loop_mechandplayer",
                                    flags = 2,
                                }, {}, {},
                                function()

                                    -- Done
                                    TriggerServerEvent('eco_crafting:addWorkstation', workstationData, workstationUsableItemName, GetPlayerServerId(PlayerId()))
                                    ClearPedTasks(_PlayerPedId)
                                end, function()

                                    -- Cancel
                                    ClearPedTasks(_PlayerPedId)
                                    interface.client.notify(Lang:t('canceled'), "error")
                                end)
                    else

                        interface.client.notify(Lang:t(reason), "error")
                    end
                end
            end
        end
    end)
end

function objectCreate(model)

    if DoesEntityExist(object) then

        DeleteObject(object)
    end

    _PlayerPedId = PlayerPedId()

    local coords = GetEntityCoords(_PlayerPedId)
    heading = GetEntityHeading(_PlayerPedId)
    forward = GetEntityForwardVector(_PlayerPedId) * 2.0;

    fPos = coords + forward
    z = coords.z - 1.0
    originalZ = z
    objPos = vec(fPos.x, fPos.y, z)

    if not IsModelInCdimage(model) then

        print('the model does not exist: ', model)
        print('loading base model: prop_table_03b')
        print('update GTA using the Rockstar client')
        model = 'prop_table_03b'
    end

    loadedModel = model
    modelLoader(model)

    object = CreateObject(model, objPos)

    SetEntityHeading(object, heading + 180)
    SetEntityCollision(object, false, true)
    SetEntityAlpha(object, 204, false)

    moveWorkstation()
end

AddEventHandler('onResourceStop', function(resource)

    if resource == GetCurrentResourceName() then

        if DoesEntityExist(object) then

            DeleteObject(object)
        end
    end
end)

RegisterNetEvent('eco_crafting:placePortableWorkstation', function(params, usableItemName)

    active = not active

    if active then

        workstationData = params
        workstationUsableItemName = usableItemName

        local model = params.object.model

        objectCreate(model)

        interface.client.drawText('Cancel: BACKSPACE<br/>Rotation: SCROLL<br/>Up / Down: SHIFT + SCROLL<br/>Front of me: RIGHT CLICK<br/>Place: E', 'left')
    else

        workstationData = {}
        workstationUsableItemName = nil
        DeleteObject(object)
        interface.client.hideText()
    end
end)

RegisterNetEvent('eco_crafting:addWorkstation', function(id, data)

    if LocalPlayer.state['isLoggedIn'] then

        playerData = QBCore.Functions.GetPlayerData()

        local workstation = workstationCheck(data, false)

        if not workstation then
            return false
        end

        local perm = accessManagement(workstation, playerData, ECO.ACE)

        workstation.accessToUse = perm.accessToUse
        workstation.accessToRemove = perm.accessToRemove

        Config.workstations[id] = workstation
    end
end)


-- REMOVAL WORKSTATION
RegisterNetEvent('eco_crafting:workstationRemovalRequest', function(data)

    _PlayerPedId = PlayerPedId()

    local workstationId = inZoneId()

    if workstationId then

        local workstation = Config.workstations[workstationId]

        if type(workstation) ~= 'table' or not workstation.owner then

            interface.client.notify(Lang:t('workstation_cannot_be_removed'), 'error')
            return false
        end

        if type(data) == 'table' and data.immediately then

            TriggerServerEvent('eco_crafting:removeWorkstation', workstationId, GetPlayerServerId(PlayerId()))
        else

            interface.client.progressbar.add("eco_crafting_" .. workstationId .. math.random(1000),
                    Lang:t('workstation_removal'),
                    Config.workstationRemovalTime * 1000,
                    false,
                    true,
                    {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 2,
                    }, {}, {},
                    function()

                        -- Done
                        TriggerServerEvent('eco_crafting:removeWorkstation', workstationId, GetPlayerServerId(PlayerId()))
                        ClearPedTasks(_PlayerPedId)
                    end, function()

                        -- Cancel
                        ClearPedTasks(_PlayerPedId)
                        interface.client.notify(Lang:t('canceled'), "error")
                    end)
        end
    else

        interface.client.notify(Lang:t('not_in_the_workspace'), 'error')
    end
end)

RegisterNetEvent('eco_crafting:removeWorkstation', function(workstationId)

    if LocalPlayer.state['isLoggedIn'] then

        Config.workstations[workstationId] = nil
    end
end)