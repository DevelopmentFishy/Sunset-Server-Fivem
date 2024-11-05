local QBCore = exports['qb-core']:GetCoreObject()

local jobData = nil
local job = nil
local sphere = nil
local guardCoords = nil
local truckCoords = nil
local meetBlip = 0
local fleecaGuard = nil
local alerted = false
local targetBusy = false
local truckBlip = 0
local fleecaTruck = nil
local fleecaDriver = nil
local fleecaPassenger = nil
local guard1 = nil
local guard2 = nil
local thermiteAttempts = 0
local canLoot = false
local canUseThermite = false
local safeCode = nil

RegisterNetEvent('kevin-banktrucks:takeconvoy', function (data)
    if not data then return end
    jobData = data.data
    job = data.job
    guardCoords = GetRandomData(jobData.guardlocations)
    truckCoords = GetRandomData(jobData.trucklocations)

    meetBlip = AddBlipForCoord(guardCoords.x, guardCoords.y, guardCoords.z)
    SetBlipSprite(meetBlip, 1)
    SetBlipColour(meetBlip, 2)
    SetBlipRoute(meetBlip, true)
    SetBlipRouteColour(meetBlip, 2)
    SetBlipAsShortRange(meetBlip, false)
    SetBlipScale(meetBlip, 0.75)

    local title = 'Lester\'s Computer'
    local subject = 'Job Info'
    local message = 'Hey ik heb dat recept voor je meet me op de locatie en neem de gps ik zie je binnen de 2 minuten'
    SendMail(title, subject, message)

    local hasPhone = HasPhoneItem()
    if not hasPhone then
        Notification('Informatie verzonden naar je telefoon..', 6000, 'primary')
    end
    
    Wait(2000)
    Notification('Haast je naar de locatie voor lester er is', 8000, 'primary')

    sphere = lib.zones.sphere({
        coords = vec3(guardCoords.x, guardCoords.y, guardCoords.z),
        radius = 45,
        debug = false,
        onEnter = CreateGuard,
    })
end)

function CreateGuard()
    local player = PlayerPedId()
    local hash = `s_m_m_armoured_02`
    lib.requestModel(hash)
    fleecaGuard = CreatePed( 0, hash, guardCoords.x, guardCoords.y, guardCoords.z, guardCoords.w, true, true)
    if DoesEntityExist(fleecaGuard) then
        sphere:remove()
        RemoveBlip(meetBlip)
        local guardBlip = AddBlipForEntity(fleecaGuard)
        SetBlipSprite(guardBlip, 304)
        SetBlipColour(guardBlip, 2)
        SetBlipScale(guardBlip, 0.75)
        SetEntityAsMissionEntity(fleecaGuard)
        TaskWanderInArea(fleecaGuard, guardCoords.x, guardCoords.y, guardCoords.z, 1.0, 2, 0.2)

        exports['qb-target']:AddTargetEntity(fleecaGuard, {
            options = {
                {
                    icon = 'fas fa-circle',
                    label = 'Doorzoek lijk',
                    canInteract = function(entity)
                        return IsEntityDead(entity) and not targetBusy
                    end,
                    action = function(entity)
                        SearchGuard(entity)
                    end,
                }
            },
            distance = 2.0
        })
        
        CreateThread(function ()
            while DoesEntityExist(fleecaGuard) do
                local pCoords = GetEntityCoords(player)
                local gCoords = GetEntityCoords(fleecaGuard)
                local dist = #(pCoords - gCoords)
                if dist < 20.0 and not alerted then
                    alerted = true
                    TaskSmartFleePed(fleecaGuard, player, 500.0, -1, true, true)
                    Notification('Je liet de bewaker schrikken vermoord hem voor hij de politie belt', 8000, 'error')
                end
                Wait(1000)
            end
        end)
    end
end

function SearchGuard(entity)
    local player = PlayerPedId()
    targetBusy = true
    TaskTurnPedToFaceEntity(player, entity, -1)
    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    Wait(2500)
    lib.requestAnimDict('amb@medic@standing@kneel@base')
    lib.requestAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(player, 'amb@medic@standing@kneel@base' ,'base' ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(player, 'anim@gangops@facility@servers@bodysearch@' ,'player_search' ,8.0, -8.0, -1, 49, 0, false, false, false )
    QBCore.Functions.Progressbar('search_body', 'Searching', jobData.progressbartimer.searchingguard, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        ClearPedTasks(player)
        targetBusy = false
        local netId = NetworkGetNetworkIdFromEntity(entity)
        TriggerServerEvent('kevin-banktrucks:givegpsdevice', netId, jobData)
        DeleteEntity(entity)
    end, function() -- Cancel
        targetBusy = false
        ClearPedTasks(player)
        Notification('Cancelled?', 6000, 'error')
    end)
end

RegisterNetEvent('kevin-banktrucks:getconvoytruck', function (hasJob, jobName, code, item)
    if not hasJob and jobName == job then return end
    QBCore.Functions.Progressbar("use_device", "Booting Up", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        safeCode = code
        truckBlip = AddBlipForCoord(truckCoords.x, truckCoords.y, truckCoords.z)
        SetBlipSprite(truckBlip, jobData.blips[3].sprite)
        SetBlipScale(truckBlip, jobData.blips[3].scale)
        SetBlipColour(truckBlip, jobData.blips[3].color)
        SetBlipRoute(truckBlip, true)
        SetBlipRouteColour(truckBlip, jobData.blips[3].color)
        
        sphere = lib.zones.sphere({
            coords = vec3(truckCoords.x, truckCoords.y, truckCoords.z),
            radius = 100,
            debug = false,
            onEnter = CreateFleecaTruck,
        })

        TriggerServerEvent('kevin-banktrucks:removegps', item)
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled?", 'error')
    end)
    
end)

function CreateFleecaTruck()
    if not jobData then return end
    local player = PlayerPedId()
    local hash = jobData.truckhash
    lib.requestModel(hash)
    fleecaTruck = CreateVehicle(`stockade`, truckCoords.x, truckCoords.y, truckCoords.z, truckCoords.w, true, true)
    if DoesEntityExist(fleecaTruck) then
        sphere:remove()
        RemoveBlip(truckBlip)
        SetEntityAsMissionEntity(fleecaTruck)
        local truckBlip = AddBlipForEntity(fleecaTruck)
        SetBlipSprite(truckBlip, jobData.blips[3].sprite)
        SetBlipScale(truckBlip, jobData.blips[3].scale)
        SetBlipColour(truckBlip, jobData.blips[3].color)
        SetBlipFlashes(truckBlip, true)

        local guardHash = `s_m_m_armoured_02`
        lib.requestModel(guardHash)
        fleecaDriver = CreatePedInsideVehicle(fleecaTruck, 26, guardHash, -1, true, true)
        fleecaPassenger = CreatePedInsideVehicle(fleecaTruck, 26, guardHash, 0, true, true)
        SetPedRelationshipGroupHash(fleecaPassenger, `HATES_PLAYER`)
        GiveWeaponToPed(fleecaPassenger, jobData.guards.weapon, 250, true, true)
        SetEntityInvincible(fleecaPassenger, true)
        SetPedSuffersCriticalHits(fleecaDriver, jobData.driver.suffercriticalhits)
        SetPedSuffersCriticalHits(fleecaPassenger, jobData.guards.suffercriticalhits)
        SetPedCanRagdoll(fleecaPassenger, jobData.guards.canragdoll)
        TaskVehicleDriveWander(fleecaDriver, fleecaTruck, jobData.driver.drivingspeed, jobData.driver.drivingstyle)
        
        local truckBones = {
            'seat_dside_r',
            'seat_pside_r'
        }
        exports['qb-target']:AddTargetBone(truckBones, {
            options = {
                {
                    num = 1,
                    type = 'client',
                    icon = 'fas fa-bomb',
                    label = 'Plant Thermite',
                    item = jobData.itemneeded,
                    action = function(entity)
                        PlantThermite(entity, truckBlip)
                    end,
                    canInteract = function()
                        local canPlant = CheckCanPlantThermite(fleecaDriver, fleecaPassenger, fleecaTruck)
                        return canPlant and not canUseThermite
                    end,
                },
                {
                    num = 2,
                    type = 'client',
                    icon = 'fas fa-money-bill-1-wave',
                    label = 'Neem geld',
                    action = function(entity)
                        lib.callback('kevin-banktrucks:checkcanloot', false, function(canDo)
                            if not canDo then
                                GrabLoot(entity)
                            else
                                Notification('Already Looted', 6000, 'error')
                            end
                        end)
                    end,
                    canInteract = function()
                        return IsEntityDead(guard1) and IsEntityDead(guard2) and canLoot
                    end,
                },
                {
                    num = 3,
                    type = 'client',
                    icon = 'fas fa-vault',
                    label = 'Open Safe',
                    action = function(entity)
                        lib.callback('kevin-banktrucks:checkcanopensafe', false, function(canDo)
                            if not canDo then
                                ShowInputMenu()
                            else
                                Notification('Safe already opended', 6000, 'error')
                            end
                        end)
                    end,
                    canInteract = function()
                        return IsEntityDead(guard1) and IsEntityDead(guard2) and canLoot
                    end,
                }
            },
            distance = 1.5,
        })
        CreateThread(function ()
            while DoesEntityExist(fleecaTruck) do
                if IsEntityDead(fleecaDriver) then
                    if IsVehicleStopped(fleecaTruck) then
                        SetEntityInvincible(fleecaPassenger, false)
                        TaskLeaveVehicle(fleecaPassenger, fleecaTruck, 256)
                        TaskCombatPed(fleecaPassenger, player, 0, 16)
                        SetPedAsEnemy(fleecaPassenger, true)
                        break
                    end
                end
                Wait(1000)
            end
        end)
    end
end

function ShowInputMenu()
    local player = PlayerPedId()
    local input = lib.inputDialog('Fleeca Safe Numpad', {
        {type = 'input', label = 'Combination', description = '', required = true,},
    })
    if not input then return end
    local inputCode = input[1]
    if inputCode == safeCode then
        QBCore.Functions.Progressbar('search_body', 'Looting', jobData.progressbartimer.searchingguard, false, false, {
            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
        }, {
            animDict = 'oddjobs@shop_robbery@rob_till',
            anim = 'loop',
            flags = 1,
        }, {}, {}, function() -- Done
            ClearPedTasks(player)
            local bool = true
            TriggerServerEvent('kevin-banktrucks:givesafecash', bool, jobData, inputCode)
        end, function() -- Cancel
            ClearPedTasks(player)
            Notification('Cancelled?', 6000, 'error')
        end)
    else
        Notification('Incorrect Combination', 6000, 'error')
    end
end

function PlantThermite(entity, truckBlip)
    local player = PlayerPedId()
    local vehiclehealth = GetVehicleBodyHealth(entity)
    if vehiclehealth > 0 then
        targetBusy = true
        TaskTurnPedToFaceEntity(player, fleecaTruck, 4500)
        SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
        Wait(1500)
        local x, y, z = table.unpack(GetEntityCoords(player))
        local thermiteProp = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z + 0.2, true, true, true)
        AttachEntityToEntity(thermiteProp, player, GetPedBoneIndex(player, 60309), 0.06, 0.0, 0.06, 90.0,0.0, 0.0, true, true, false, true, 1, true)
        lib.requestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
        TaskPlayAnim(player, 'anim@heists@ornate_bank@thermal_charge_heels', 'thermal_charge', 3.0, -8,-1, 63, 0, 0, 0, 0)
        QBCore.Functions.Progressbar('search_body', 'Setting Timer', jobData.progressbartimer.plantingthermite, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local time = jobData.thermite.minigame.time
            local gridSize = jobData.thermite.minigame.gridsize
            local incorrectBlocks = jobData.thermite.minigame.incorrectblocks
            local item = jobData.itemneeded
            exports['ps-ui']:Thermite(function(success)
                if success then
                    targetBusy = false
                    canUseThermite = true
                    RemoveBlip(truckBlip)
                    TriggerServerEvent('kevin-banktrucks:removethermite', item)
                    ClearPedTasks(player)
                    DetachEntity(thermiteProp)
                    AttachEntityToEntity(thermiteProp, fleecaTruck, GetEntityBoneIndexByName(fleecaTruck, 'door_pside_r'), -0.7, 0.0,0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                    Notification('Wacht tot de deuren openblazen', 3000, 'primary')
                    
                    TriggerAlert()
                    Wait(jobData.thermite.time * 60000)
                    Notification('Truck security measures will be activated shortly..', 8000, 'error')
                    canLoot = true
                    SetVehicleDoorBroken(fleecaTruck, 2, false)
                    SetVehicleDoorBroken(fleecaTruck, 3, false)
                    local tCoords = GetEntityCoords(thermiteProp)
                    AddExplosion(tCoords.x, tCoords.y, tCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
                    ApplyForceToEntity(fleecaTruck, 0, tCoords.x, tCoords.y, tCoords.z, 0.0, 0.0, 0.0, 1, false,true, true, true, true)
                    SetVehicleUndriveable(fleecaTruck, true)
                    CreateTruckGuards()
                else
                    local maxAttempts = jobData.thermite.attempts
                    targetBusy = false
                    thermiteAttempts = thermiteAttempts + 1
                    if thermiteAttempts == maxAttempts then
                        TriggerServerEvent('kevin-banktrucks:removethermite', item)
                        thermiteAttempts = 0
                    end
                    DetachEntity(thermiteProp)
                    ClearPedTasks(player)
                    Notification('Failed to brute force.. Alarms triggered', 8000, 'error')
                    TriggerAlert()
                end
            end, time, gridSize, incorrectBlocks)
        end, function() -- Cancel
            targetBusy = false
            Notification('Cancelled?', 8000, 'error')
            DetachEntity(thermiteProp)
            ClearPedTasks(player)
        end)
    else
        Notification('Truck is destroyed', 8000, 'error')
    end
end

function CreateTruckGuards()
    local player = PlayerPedId()
    local hash = `s_m_m_armoured_02`
    local health = jobData.guards.health
    local armor = jobData.guards.armor
    local suffercriticalhits = jobData.guards.sufferriticalhits
    local weapon = jobData.guards.weapon
    local weaponaccuracy = jobData.guards.weaponaccuracy
    local canRagDoll = jobData.guards.canragdoll
    lib.requestModel(hash)
    guard1 = CreatePedInsideVehicle(fleecaTruck, 26, hash, 1, true, true)
    guard2 = CreatePedInsideVehicle(fleecaTruck, 26, hash, 2, true, true)
    TaskLeaveVehicle(guard1, fleecaTruck, 0)
    SetEntityAsMissionEntity(guard1)
    SetEntityVisible(guard1, true)
    SetPedMaxHealth(guard1, health)
    SetPedArmour(guard1, armor)
    SetPedCanSwitchWeapon(guard1, true)
    SetPedDropsWeaponsWhenDead(guard1, false)
    SetPedRelationshipGroupHash(guard1, `HATES_PLAYER`)
    SetPedAccuracy(guard1, weaponaccuracy)
    SetPedFleeAttributes(guard1, 0, false)
    GiveWeaponToPed(guard1, weapon, 250, true, true)
    SetPedSuffersCriticalHits(guard1, suffercriticalhits)
    SetPedCanRagdoll(guard1, canRagDoll)

    TaskLeaveVehicle(guard2, fleecaTruck, 0)
    SetEntityAsMissionEntity(guard2)
    SetEntityVisible(guard2, true)
    SetPedRelationshipGroupHash(guard2, `HATES_PLAYER`)
    SetPedAccuracy(guard2, weaponaccuracy)
    SetPedArmour(guard2, armor)
    SetPedMaxHealth(guard2, health)
    SetPedCanSwitchWeapon(guard2, true)
    SetPedDropsWeaponsWhenDead(guard2, false)
    SetPedFleeAttributes(guard2, 0, false)
    GiveWeaponToPed(guard2, weapon, 250, true, true)
    SetPedSuffersCriticalHits(guard2, suffercriticalhits)
    SetPedCanRagdoll(guard2, canRagDoll)
    TaskCombatPed(guard2, player, 0, 16)
    TaskCombatPed(guard1, player, 0, 16)

    exports['qb-target']:AddTargetEntity(guard1, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Doorzoek lijk',
                canInteract = function(entity)
                    return IsEntityDead(entity) and not targetBusy
                end,
                action = function(entity)
                    GetSafeCode(entity)
                end,
            }
        },
        distance = 2.0
    })
end

function GrabLoot(entity)
    if not entity then return end
    local player = PlayerPedId()
    targetBusy = true
    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    ClearPedTasks(player)
    Wait(1500)
    QBCore.Functions.Progressbar('start_looting', 'Looting', jobData.progressbartimer.looting, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@heists@ornate_bank@grab_cash_heels',
        anim = 'grab',
        flags = 49,
    }, {
        model = 'prop_cs_heist_bag_02',
        bone = 57005,
        coords = { x = -0.004, y = 0.00, z = -0.14 },
        rotation = { x = 235.0, y = -25.0, z = 0.0 },
    }, {}, function() -- Done
        targetBusy = false
        local bool = true
        TriggerServerEvent('kevin-banktrucks:giveloot', bool, jobData)
    end, function() -- Cancel
        targetBusy = false
        Notification('Cancelled', 6000, 'error')
    end)
end

function GetSafeCode(entity)
    if not entity then return end
    local player = PlayerPedId()
    targetBusy = true
    TaskTurnPedToFaceEntity(player, entity, -1)
    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    Wait(2500)
    lib.requestAnimDict('amb@medic@standing@kneel@base')
    lib.requestAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(player, 'amb@medic@standing@kneel@base' ,'base' ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(player, 'anim@gangops@facility@servers@bodysearch@' ,'player_search' ,8.0, -8.0, -1, 49, 0, false, false, false )
    QBCore.Functions.Progressbar('search_body', 'Searching', jobData.progressbartimer.searchingguard, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        ClearPedTasks(player)
        targetBusy = false
        local safeCodeAlert = lib.alertDialog({
            header = 'Fleeca Safe Combination',
            content = 'Safe Code:  \n'.. safeCode,
            centered = true,
        })
        print(safeCodeAlert)
    end, function() -- Cancel
        targetBusy = false
        ClearPedTasks(player)
        Notification('Cancelled', 6000, 'error')
    end)
end

RegisterNetEvent('kevin-banktrucks:clearconvoy', function ()
    jobData = nil
    job = nil
    sphere = nil
    guardCoords = nil
    truckCoords = nil
    meetBlip = 0
    fleecaGuard = nil
    alerted = false
    targetBusy = false
    truckBlip = 0
    fleecaTruck = nil
    fleecaDriver = nil
    fleecaPassenger = nil
    guard1 = nil
    guard2 = nil
    thermiteAttempts = 0
    canLoot = false
    canUseThermite = false
    safeCode = nil
end)

RegisterNetEvent('kevin-banktrucks:cancelconvoy', function ()
    if sphere then
        sphere:remove()
    end
    if DoesEntityExist(fleecaTruck) then
        SetEntityAsMissionEntity(fleecaTruck, true, true)
        NetworkRequestControlOfEntity(fleecaTruck)
        DeleteEntity(fleecaTruck)
    end
    if DoesEntityExist(fleecaDriver) then
        SetEntityAsMissionEntity(fleecaDriver, true, true)
        NetworkRequestControlOfEntity(fleecaDriver)
        DeleteEntity(fleecaDriver)
    end
    if DoesEntityExist(fleecaPassenger) then
        SetEntityAsMissionEntity(fleecaPassenger, true, true)
        NetworkRequestControlOfEntity(fleecaPassenger)
        DeleteEntity(fleecaPassenger)
    end
    if DoesEntityExist(fleecaGuard) then
        SetEntityAsMissionEntity(fleecaGuard, true, true)
        NetworkRequestControlOfEntity(fleecaGuard)
        DeleteEntity(fleecaGuard)
    end
    if DoesEntityExist(guard1) then
        SetEntityAsMissionEntity(guard1, true, true)
        NetworkRequestControlOfEntity(guard1)
        DeleteEntity(guard1)
    end
    if DoesEntityExist(guard2) then
        SetEntityAsMissionEntity(guard2, true, true)
        NetworkRequestControlOfEntity(guard2)
        DeleteEntity(guard2)
    end

    if DoesBlipExist(meetBlip) then
        RemoveBlip(meetBlip)
    end
    if DoesBlipExist(truckBlip) then
        RemoveBlip(truckBlip)
    end

    TriggerEvent('kevin-banktrucks:clearconvoy')
    QBCore.Functions.Notify("Job Cancelled..", 'error')
end)