Config = {}
Config.Framework = 'newqb' -- esx - oldqb - newqb
Config.NewESX = false -- true enabled -- false disabled
Config.Mysql = 'oxmysql' -- mysql-async, ghmattimysql, oxmysql
Config.Job = true -- true enabled -- false disabled
Config.JobName = "taxi" -- Job name
Config.TaxiMeterItem = 'taximeter'
Config.KmPrice = 3.1
Config.InteractionHandler = "drawtext" -- bt-target, qb-target -- drawtext -- ox_target
Config.ESXLoadedEvent = 'esx:playerLoaded'
Config.QBCoreLoadedEvent = 'QBCore:Server:OnPlayerLoaded'
Config.FinishCommand = 'finishtaxijob' -- command for finish job
Config.Debug = false

----------------- DEPOSIT TAXI PRICE ------------------

Config.DepositeVehicle = {
    ['deposite'] = false,   -- true enabled -- false disabled
    ['depositePrice'] = 1500,
    ['depositePriceAccount'] = 'cash' -- bank and cash
}

--------------------- VEHICLE KEY ------------------

Config.Vehiclekey = true
Config.VehicleSystem = "qb-vehiclekeys" -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys = true
Config.RemoveVehicleSystem = "qb-vehiclekeys" -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey = function(plate , model) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if Config.VehicleSystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:GiveKeys(plate, model)
        elseif Config.VehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        end
    end
end

Config.RemoveVehiclekey = function(plate, model)
    if Config.Removekeys then
        if Config.RemoveVehicleSystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.RemoveVehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif Config.RemoveVehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif Config.RemoveVehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end
--------------------- FUEL SYSTEM ------------------

Config.UseLegacyFuel = GetResourceState("LegacyFuel") ~= "missing" -- true enabled -- false disabled

Config.SetVehicleFuel = function(vehicle,fuel_level) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["LegacyFuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end

-------------------- Control Key System ----------------

Config.MenuOpenKey = {
    ['AddExtraKey'] = { -- Keys Reference : https://docs.fivem.net/docs/game-references/controls/
        ['key'] = 303, -- H
        ['label'] = 'U'
    },
    ['ActiveTaximeter'] = { -- Keys Reference : https://docs.fivem.net/docs/game-references/controls/
        ['key'] = 311, -- K
        ['label'] = 'K'-- staat goed
    },
    ['CabMenuKey'] = { -- Keys Reference : https://docs.fivem.net/docs/game-references/controls/
        ['key'] = 82, -- M
        ['label'] = ';'
    },
    ['ResetPrice'] = { -- Keys Reference : https://docs.fivem.net/docs/game-references/controls/
        ['key'] = 74, -- U
        ['label'] = 'H'
    }
}

Config.SpotData = {
    {
        name = "DOWNTWON",
        mission = "downtwon",
        level = 1,
        wayText = "This route only in the downtown.",
        possibleEarningsMin = 5,
        possibleEarningsMax = 150,
        possibleEXPMin = 50,
        possibleEXPMax = 100,
        spotImage = "spot-image",
        spotActiveImage = "spot-image-active",
    },
    {
        name = "SANDY SHORES",
        mission = "sandy",
        level = 20,
        wayText = "This route between Downtown and Sandy Shores.",
        possibleEarningsMin = 5,
        possibleEarningsMax = 150,
        possibleEXPMin = 50,
        possibleEXPMax = 200,
        spotImage = "spot-image-sandy",
        spotActiveImage = "spot-image-active-sandy",
    },
    {
        name = "PALETO BAY",
        mission = "paleto",
        level = 50,
        wayText = "This route between Downtown and Paleto Bay.",
        possibleEarningsMin = 5,
        possibleEarningsMax = 150,
        possibleEXPMin = 150,
        possibleEXPMax = 1500,
        spotImage = "spot-image-paleto",
        spotActiveImage = "spot-image-active-paleto",
    },
}

Config.SpotVehicle = {
    {
        name = "DOWNTWON",
        mission = "downtwonvehicle",
        vehicle = "taxi",
        image = 'taxi',
        taxiText = 'You will use Downtown Taxi',
        imageActive = "taxi-active",
        level = 1
    },
    {
        name = "MY OWN CAR",
        mission = "ownervehicle",
        vehicle = "t20",
        image = 'ownercar',
        taxiText = 'You will use your own car.',
        imageActive = "ownercar-active",
        level = 0
    },
}

Config.taxiLaptopPropCoord ={
    ['hash'] = "prop_cs_tablet",
    ['laptopcoords'] =vector3(895.926, -177.00, 75.3003),
    ['rotate'] = -90.0,
    ['rotate2'] = 60.0,
}

Config.DefaultVehicle = 'taxi'

Config.WhitelistVehicle = {
   ['taxi'],
}

Config.SpawnTaxiCoords = {
    ['spawn'] = {
        ['x'] = 920.54,
        ['y'] = -163.46,
        ['z'] = 74.42,
        ['h'] = 105.71,
    },
    ['delete'] = { --vector3(911.52, -177.73, 74.3)
        ['x'] = 911.52,
        ['y'] = -177.73,
        ['z'] = 74.3,
    }
}

Config.Achievements = {
    {
        name = 'WELCOME TO CAB',
        description = 'Do your first job',
        price = 1500,
        image = 'achievements1',
        activeImage = 'achievements1-active',
        mission = 'mission1',
        missionReady = false,
        missionComplete = false,

    },
    {
        name = 'BECOME A REAL CAB',
        description = 'Transport 50 custom',
        price = 3500,
        image = 'achievements2',
        activeImage = 'achievements2-active',
        mission = 'mission2',
        missionReady = false,
        missionComplete = false,

    },
    {
        name = 'ROUTE TO 68',
        description = 'Unlock Downtown - Sandy Shores destination route',
        price = 6000,
        image = 'achievements3',
        activeImage = 'achievements3-active',
        mission = 'mission3',
        missionReady = false,
        missionComplete = false,
    },
    {
        name = 'EYES ON CLOCK',
        description = 'Drive a 40000 miles taxi',
        price = 15000,
        image = 'achievements4',
        activeImage = 'achievements4-active',
        mission = 'mission4',
        missionReady = false,
        missionComplete = false,

    },
    {
        name = 'KINDA SUS',
        description = 'Add at least 50000 $ extra to the taximeter',
        price = 12500,
        image = 'achievements5',
        activeImage = 'achievements5-active',
        mission = 'mission5',
        missionReady = false,
        missionComplete = false,

    },
    {
        name = 'THE CAB GURU',
        description = 'Reach Lv.50',
        price = 25000,
        image = 'achievements6',
        activeImage = 'achievements6-active',
        mission = 'mission6',
        missionReady = false,
        missionComplete = false,

    },
}

Config.OpenTrigger = function()
    local blip = AddBlipForCoord(Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y, Config.taxiLaptopPropCoord.laptopcoords.z)
    local jobname = nil if Config.Job then jobname = Config.JobName else jobname = "all" end
    SetBlipSprite (blip, 198)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipColour (blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Taxi')
    EndTextCommandSetBlipName(blip)
    if Config.InteractionHandler == "qb-target" then

        exports['qb-target']:AddBoxZone("codem-taxi", Config.taxiLaptopPropCoord['laptopcoords'], 1.25, 0.55, {
            name = "codem-taxi",
            heading = 0.0,
            debugPoly = false,
            minZ = Config.taxiLaptopPropCoord['laptopcoords'].z,
            maxZ = Config.taxiLaptopPropCoord['laptopcoords'].z+2.0,

            }, {
                options = {
                    {
                        type = "client",
                        event = "codem-taxi:client:openMenu",
                        icon = "fas fa-sign-in-alt",
                        label = "Open Tablet",
                        job = jobname,
                    },
                },
            distance = 3.0
        })

        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local wait = 2000

            local dist = #(coords - Config.taxiLaptopPropCoord.laptopcoords)
            if dist < 3 and not success then
                success = true
                prop = CreateObject(GetHashKey(Config.taxiLaptopPropCoord.hash), Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y, Config.taxiLaptopPropCoord.laptopcoords.z,  true,  true, true)
                FreezeEntityPosition(prop, true)
                SetEntityRotation(prop, 0.0, Config.taxiLaptopPropCoord.rotate, Config.taxiLaptopPropCoord.rotate2, 0.0)
            else
                if dist > 4 then
                    success = false
                    DeleteObject(prop)
                end
            end
            Citizen.Wait(wait)
        end
   
    elseif Config.InteractionHandler == "bt-target" then

        exports['bt-target']:AddBoxZone("codem-taxi", Config.taxiLaptopPropCoord['laptopcoords'], 1.25, 0.55, {
            name = "codem-taxi",
            heading = 0.0,
            debugPoly = false,
            minZ = Config.taxiLaptopPropCoord['laptopcoords'].z,
            maxZ = Config.taxiLaptopPropCoord['laptopcoords'].z+2.0,
            }, {
                options = {
                    {
                        event = "codem-taxi:client:openMenu",
                        icon = "fa-solid fa-shop",
                        label = "Open Tablet",

                    },
                },
            distance = 3.0,
            job = {jobname}
        })

        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local wait = 2000

            local dist = #(coords - Config.taxiLaptopPropCoord.laptopcoords)
            if dist < 3 and not success then
                success = true
                prop = CreateObject(GetHashKey(Config.taxiLaptopPropCoord.hash), Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y, Config.taxiLaptopPropCoord.laptopcoords.z,  true,  true, true)
                FreezeEntityPosition(prop, true)
                SetEntityRotation(prop, 0.0, Config.taxiLaptopPropCoord.rotate, Config.taxiLaptopPropCoord.rotate2, 0.0)
            else
                if dist > 4 then
                    success = false
                    DeleteObject(prop)
                end
            end
            Citizen.Wait(wait)
        end
    elseif Config.InteractionHandler == "ox_target" then

        local parameters = {
            name = 'CodeM Taxi',
            coords = Config.taxiLaptopPropCoord['laptopcoords'],
            options = {
                {
                    onSelect = function()
                    TriggerEvent("codem-taxi:client:openMenu")
                    end,
                    icon = "fas fa-taxi",
                    label = "Open Tablet",
                    groups = {jobname},
                    distance = 3.0
                },
            }
        }

        exports.ox_target:addBoxZone(parameters)

        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local wait = 2000

            local dist = #(coords - Config.taxiLaptopPropCoord.laptopcoords)
            if dist < 3 and not success then
                success = true
                prop = CreateObject(GetHashKey(Config.taxiLaptopPropCoord.hash), Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y, Config.taxiLaptopPropCoord.laptopcoords.z,  true,  true, true)
                FreezeEntityPosition(prop, true)
                SetEntityRotation(prop, 0.0, Config.taxiLaptopPropCoord.rotate, Config.taxiLaptopPropCoord.rotate2, 0.0)
            else
                if dist > 4 then
                    success = false
                    DeleteObject(prop)
                end
            end
            Citizen.Wait(wait)
        end

    elseif Config.InteractionHandler == "drawtext" then
        counter = 0
        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local wait = 2000
       

            local dist = #(coords - Config.taxiLaptopPropCoord.laptopcoords)
            if dist < 3 and not success then
                success = true
                prop = CreateObject(GetHashKey(Config.taxiLaptopPropCoord.hash), Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y, Config.taxiLaptopPropCoord.laptopcoords.z,  true,  true, true)
                FreezeEntityPosition(prop, true)
                SetEntityRotation(prop, 0.0, Config.taxiLaptopPropCoord.rotate, Config.taxiLaptopPropCoord.rotate2, 0.0)
            else
                if dist > 4 then
                    success = false
                    DeleteObject(prop)
                end
            end

            if  dist < 3 then
                wait = 0
                DrawText3D(Config.taxiLaptopPropCoord.laptopcoords.x, Config.taxiLaptopPropCoord.laptopcoords.y,Config.taxiLaptopPropCoord.laptopcoords.z+0.30, Config.Locale['OPENTABLET'])
                if IsControlJustPressed(0, 38) then
                    if Config.Job then
                        if GetJob() == Config.JobName then
                            while not response do
                                Citizen.Wait(0)
                            end
                            if openmenu then
                                counter = counter + 1
                                Citizen.Wait(500)
                                if counter == 1 then 
                                    local playerTaxiData = Callback('codem-taxi:server:getTaxiData')
                                    SendNUIMessage({
                                        action = 'OPEN_MENU',
                                        playerTaxiData = playerTaxiData,
                                    })
                                    SetNuiFocus(true, true)
                                    Citizen.Wait(150)
                                    counter = 0
                             
                              
                                end
                            else
                                 TriggerEvent('codem-taxi:notify', Config.Locale['FINISHEDINST'])
                            end
                        end
                    else
                        while not response do
                            Citizen.Wait(0)
                        end
                        if openmenu then
                            counter = counter + 1
                            Citizen.Wait(500)
                            if counter == 1 then 
                                local playerTaxiData = Callback('codem-taxi:server:getTaxiData')
                                SendNUIMessage({
                                    action = 'OPEN_MENU',
                                    playerTaxiData = playerTaxiData,
                                })
                                SetNuiFocus(true, true)
                                Citizen.Wait(150)
                                counter = 0
                         
                          
                            end
                        else
                             TriggerEvent('codem-taxi:notify', Config.Locale['FINISHEDINST'])
                        end
                    end
                 
                end

            end
            Citizen.Wait(wait)
        end
    elseif Config.InteractionHandler == "custom" then
        -- Your code here
    end
end
Config.NpcHash= {
    ---https://wiki.rage.mp/index.php?title=Peds
    --Random NPC
    0xF0EC56E2,
    0x6D1E15F7,
    0x0703F106,
    0x26C3D079,
    0x68709618,
    0xABEF0004,
    0xE5A11106,
    0x303638A7,
    0xD1FEB884,
    0xA039335F,
    0xFA389D4F,
    0x8B7D3766,
    0xAD9EF1BB,
}

Config.startPoint = {
    ['downtwon'] = {
        {
            ['startCoord'] = vector4(587.832, 72.2097, 93.7427,165.71),
            ['finishCoord'] =   vector3(-117.02, 100.258, 72.0329),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(413.858, -307.93, 50.7339,320.39),
            ['finishCoord'] =   vector3(110.060, 215.840, 107.607),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(159.444, -599.42, 43.7307,346.76),
            ['finishCoord'] =   vector3(158.702, -26.377, 67.8214),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(25.8853, -743.88, 44.1795,253.45),
            ['finishCoord'] =   vector3(314.622, -869.34, 29.2916),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(-243.31, -888.26, 30.3968,341.31),
            ['finishCoord'] =  vector3(-211.43, -1409.3, 31.2847),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(-569.39, -670.47, 33.1482,347.98),
            ['finishCoord'] =  vector3(-606.01, -1242.6, 12.6118),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(-594.03, -331.16, 34.9108,31.33),
            ['finishCoord'] = vector3(-1455.3, -72.951, 51.6612),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(-516.21, -73.059, 39.9870,155.4),
            ['finishCoord'] = vector3(-958.21, 273.472, 69.5823),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
        {
            ['startCoord'] = vector4(-436.00, 136.259, 64.8133,180.64),
            ['finishCoord'] = vector3(561.326, 81.0092, 95.6172),
            ['time'] = 1,
            ['price'] = math.random(150,450),
        },
    },
    ['paleto'] = {
        {
            ['startCoord'] = vector4(904.148, 62.5465, 79.0399,49.09),
            ['finishCoord'] =   vector3(-126.28, 6549.11, 29.4287),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-1297.4, -482.46, 33.1162,185.47),
            ['finishCoord'] =   vector3(-230.01, 6166.27, 31.3130),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(82.9346, -1670.9, 29.0593,73.82),
            ['finishCoord'] =   vector3(-416.82, 6258.83, 30.3966),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-639.31, -307.98, 35.0286,124.27),
            ['finishCoord'] =   vector3(-405.56, 6042.10, 31.3261),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-140.34, 265.428, 95.0592,151.02),
            ['finishCoord'] =   vector3(-355.14, 6323.73, 29.8197),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },


        {
            ['startCoord'] = vector4(-309.59, 6348.84, 30.3592,44.76),
            ['finishCoord'] =   vector3(-3.5902, 471.574, 145.710),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-33.428, 6628.50, 30.3910,217.11),
            ['finishCoord'] =   vector3(-202.54, 414.127, 109.691),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(216.929, 6574.90, 32.0208,190.88),
            ['finishCoord'] =   vector3(-482.39, 261.969, 83.0186),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-7.0644, 6349.39, 31.3848,46.04),
            ['finishCoord'] =   vector3(-495.44, 137.726, 63.6187),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
        {
            ['startCoord'] = vector4(-73.089, 6319.80, 31.3384,254.37),
            ['finishCoord'] =   vector3(-760.72, -35.328, 37.8318),
            ['time'] = 10,
            ['price'] = math.random(500,1500),
        },
    },
    ['sandy'] = {
        {
            ['startCoord'] = vector4(-1631.5, -278.71, 52.3948,255.07),
            ['finishCoord'] =   vector3(1662.48, 3557.50, 35.4562),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(-1668.1, -586.96, 33.6712,328.62),
            ['finishCoord'] =   vector3(1709.09, 3748.47, 33.8176),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(-1155.4, -698.79, 21.6686,306.59),
            ['finishCoord'] =   vector3(1736.89, 3842.03, 34.7609),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(-852.88, -689.33, 27.7631,79.49),
            ['finishCoord'] =   vector3(1873.86, 3894.77, 33.0433),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(-941.57, -443.85, 37.7032,1347.89),
            ['finishCoord'] =   vector3(1932.81, 3749.01, 32.2705),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },


        {
            ['startCoord'] = vector4(1955.30, 3792.05, 32.3326,187.82),
            ['finishCoord'] =   vector3(1375.81, -1761.8, 64.8168),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(2024.81, 3753.47, 32.1753,33.23),
            ['finishCoord'] =   vector3(1022.53, -1751.3, 35.4894),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(1879.06, 3687.48, 33.4129,212.43),
            ['finishCoord'] =   vector3(765.927, -1985.9, 29.2849),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(1695.80, 3578.24, 35.5056,201.28),
            ['finishCoord'] =   vector3(230.773, -1801.6, 27.8289),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
        {
            ['startCoord'] = vector4(1375.89, 3584.27, 34.8926,215.47),
            ['finishCoord'] =   vector3(119.907, -1457.4, 29.2944),
            ['time'] = 10,
            ['price'] = math.random(1000,1500),
        },
    }
}

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

Config.RequiredXP = {
    [1] = 1000,
    [2] = 1500,
    [3] = 2000,
    [4] = 2500,
    [5] = 3000,
    [6] = 3500,
    [7] = 4000,
    [8] = 4500,
    [9] = 5000,
    [10] = 5500,
    [11] = 6000,
    [12] = 6500,
    [13] = 7000,
    [14] = 7500,
    [15] = 8000,
    [16] = 8500,
    [17] = 9000,
    [18] = 9500,
    [19] = 10000,
    [20] = 10500,
    [21] = 11000,
    [22] = 11500,
    [23] = 12000,
    [24] = 12500,
    [25] = 13000,
    [26] = 13500,
    [27] = 14000,
    [28] = 14500,
    [29] = 15000,
    [30] = 15500,
    [31] = 16000,
    [32] = 16500,
    [33] = 17000,
    [34] = 17500,
    [35] = 18000,
    [36] = 18500,
    [37] = 19000,
    [38] = 19500,
    [39] = 20000,
    [40] = 20500,
    [41] = 21000,
    [42] = 21500,
    [43] = 22000,
    [44] = 22500,
    [45] = 23000,
    [46] = 23500,
    [47] = 24000,
    [48] = 24500,
    [49] = 25000,
    [50] = 250000000,
}

Config.Locale ={
    ['STATUS'] = 'Status',
    ['ADDEXTRA'] = 'Vraag extra',
    ['ACTIVETAXIMETER'] = 'Active Taximeter',
    ['DEACTIVETAXIMETER'] = 'Deactive Taximeter',
    ['CABMENU'] = 'Cab Menu',
    ['RESETPRICE'] = 'Reset Pice',
    ['EXITFROM'] = 'EXIT FROM',
    ['TAXIMENU'] = 'TAXI MENU',
    ['POSSIBLEEANINGS'] = 'Possible Earnings',
    ['POSSIBLEXP'] = 'Possible EXP',
    ['SELECTROUTE'] = 'Select Route',
    ['REQUIRED'] = 'Required',
    ['EDITTAXIMETERPOS'] = 'EDIT TAXIMETER POSITION',
    ['DISABLENPCCABBING'] = 'DISABLE NPC CABBING',
    ['ENABLENPCCABBING'] = 'ENABLE NPC CABBING',
    ['DRAGANDDROP'] = 'Drag and drop taximeter to adjust',
    ['TAXIMETERPOSITION'] = 'taximeter position',
    ['SETTODEFAULT'] = 'Set to deafult',
    ['HELLO'] = 'Hello',
    ['WELCOMEBACK'] = 'welcome back',
    ['PLEASEWAIT'] = 'Plase wait for data to get loaded..',
    ['WITHDRAWMETHOD'] = 'Withdraw Method',
    ['TOMYBANK'] = 'To my bank',
    ['ASCASH'] = 'As cash',
    ['CASH'] = 'Cash',
    ['WITHDRAW'] = 'Withdraw',
    ['SELECTVEHICLE'] = 'Select Vehicle',
    ['GOCAB'] = 'Go Cab',
    ['PROFILE'] = 'PROFILE',
    ['LEVELPROGRESS'] = 'Level Progress',
    ['CHANGEPROFILEPHOTO'] = 'Change Profile Photo',
    ['USEDISCORDPROFILE'] = 'Use Discord Profile Photo',
    ['DELETEPROFILEPHOTO'] = 'Delete Profile Photo',
    ['REWARD'] = 'Reward',
    ['REWARDCLAIMED'] = 'Reward Claimed',
    ['CLAIMREWARD'] = 'Claim Reward',
    ['MILE'] = 'Mile',
    ['EARNING'] = 'Fare',
    ['EXP'] = 'EXP',
    ['YOUWILLUSEDOWNTWON'] = 'You will use Downtown Cab vehicle.',
    ['YOUWILLUSEVEHICLE'] = 'You will use your own vehicle.',
    --NOTIFY-- 
    ['CHOOSEAPAYMENT'] = 'Choose a payment option',
    ['TIMEISUP'] = 'Your time is up. You all get a small amount of money.',
    ['PASSENGERISWAITING'] = 'The passenger is waiting for you.',
    ['YOUNEEDTO'] = 'You need to be level',
    ['TOSTARTMISSION'] = 'to start this mission',
    ['PASSENGERCANUNDER'] = 'The passenger can understand.',
    ['PASSENGERCHEATING'] = 'The passenger realized you were cheating.' ,
    ['PAYMENTOPTION'] = 'The payment option has changed.',
    ['AWARDHASBEEN'] = 'This award has been received',
    ['MISSIONISNOTOVER'] = 'This mission is not finished.',
    ['MONEYHAS'] = 'The money has been credited.',
    ['NOTLEVEL'] = 'Insufficient level',
    ['PLATEDOESNT']  = 'The license plate doesn t match.',
    ['CARRYING'] = 'You are carrying a passenger.',
    ['FINISHEDINST'] = "Tablet not finished the installation yet",
    ['ENOUGHMONEY'] = 'You don t have enough money',
    ['DEPOSITHASBEEN'] = 'The deposit has been paid.',
    ['DEPOSITREFUNDED'] = 'The deposit has been refunded.',
    ['GIVENAVEHICLE'] = 'You were given a vehicle.',
    ['LOCKVEHICLE'] = 'Vehicle doors locked.',
    --DrawText---
    ['PRESSTOGETINCAR'] = 'Press [E] to get in the car.',
    ['OPENTABLET'] = '[E] Open Tablet',
    ['DELETEVEHICLE'] = '[E] Delete Vehicle'
}

function GetIdentifier(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))

        if xPlayer then
            return xPlayer.getIdentifier()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.citizenid
        else
            return "0"
        end
    end
end

function GetName(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end

function GetJob()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        return frameworkObject.PlayerData.job.name
    else
        return frameworkObject.Functions.GetPlayerData().job.name
    end
end