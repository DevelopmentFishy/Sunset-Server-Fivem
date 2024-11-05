Config                       = {}

Config.Framework             = 'qb'      -- esx, oldesx, qb, oldqb
Config.SQL                   = "oxmysql" -- oxmysql, ghmattimysql, mysql-async

Config.ExampleProfilePicture =
"https://cdn.discordapp.com/attachments/983471660684423240/1147567519712940044/example-pp.png"

Config.InteractionHandler    = 'qb-target' --  qb-target, drawtext,ox-target

Config.CurrencyUnit          = '€'        --    € $ £ ¥ ₺

Config.CodemTextUi           = false      -- true or false -- Config.InteractionHandler    = 'drawtext'


Config.AddLevelCommands    = 'addlevelgarbage'
Config.RemoveLevelCommands = 'removelevelgarbage'
Config.ResetJobPlayer      = 'resetjobgarbage'


-- ██████╗░██████╗░░█████╗░░██╗░░░░░░░██╗███╗░░░███╗░█████╗░██████╗░██╗░░██╗███████╗██████╗░
-- ██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║████╗░████║██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗
-- ██║░░██║██████╔╝███████║░╚██╗████╗██╔╝██╔████╔██║███████║██████╔╝█████═╝░█████╗░░██████╔╝
-- ██║░░██║██╔══██╗██╔══██║░░████╔═████║░██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗░██╔══╝░░██╔══██╗
-- ██████╔╝██║░░██║██║░░██║░░╚██╔╝░╚██╔╝░██║░╚═╝░██║██║░░██║██║░░██║██║░╚██╗███████╗██║░░██║
-- ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
Config.DrawMarkerSettings  = {
    ['deleteVehicleDrawMarker'] = true,

}
-- ██╗░░░██╗███████╗██╗░░██╗██╗░█████╗░██╗░░░░░███████╗██╗░░██╗███████╗██╗░░░██╗
-- ██║░░░██║██╔════╝██║░░██║██║██╔══██╗██║░░░░░██╔════╝██║░██╔╝██╔════╝╚██╗░██╔╝
-- ╚██╗░██╔╝█████╗░░███████║██║██║░░╚═╝██║░░░░░█████╗░░█████═╝░█████╗░░░╚████╔╝░
-- ░╚████╔╝░██╔══╝░░██╔══██║██║██║░░██╗██║░░░░░██╔══╝░░██╔═██╗░██╔══╝░░░░╚██╔╝░░
-- ░░╚██╔╝░░███████╗██║░░██║██║╚█████╔╝███████╗███████╗██║░╚██╗███████╗░░░██║░░░
-- ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░

Config.Vehiclekey          = true
Config.VehicleSystem       = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys          = true
Config.RemoveVehicleSystem = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey      = function(plate, model) -- you can change vehiclekeys export if you use another vehicle key system
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
Config.RemoveVehiclekey    = function(plate, model)
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


-- ███████╗██╗░░░██╗███████╗██╗░░░░░  ░██████╗██╗░░░██╗░██████╗████████╗███████╗███╗░░░███╗
-- ██╔════╝██║░░░██║██╔════╝██║░░░░░  ██╔════╝╚██╗░██╔╝██╔════╝╚══██╔══╝██╔════╝████╗░████║
-- █████╗░░██║░░░██║█████╗░░██║░░░░░  ╚█████╗░░╚████╔╝░╚█████╗░░░░██║░░░█████╗░░██╔████╔██║
-- ██╔══╝░░██║░░░██║██╔══╝░░██║░░░░░  ░╚═══██╗░░╚██╔╝░░░╚═══██╗░░░██║░░░██╔══╝░░██║╚██╔╝██║
-- ██║░░░░░╚██████╔╝███████╗███████╗  ██████╔╝░░░██║░░░██████╔╝░░░██║░░░███████╗██║░╚═╝░██║
-- ╚═╝░░░░░░╚═════╝░╚══════╝╚══════╝  ╚═════╝░░░░╚═╝░░░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝

-- Config.UseLegacyFuel  = GetResourceState("LegacyFuel") ~= "missing" -- true enabled -- false disabled
Config.FuelSystem = "LegacyFuel"                      -- LegacyFuel / x-fuel

Config.SetVehicleFuel = function(vehicle, fuel_level) -- you can change LegacyFuel export if you use another fuel system
    if Config.FuelSystem == 'LegacyFuel' then
        return exports["LegacyFuel"]:SetFuel(vehicle, fuel_level)
    elseif Config.FuelSystem == 'x-fuel' then
        return exports["x-fuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end


-- ██████╗░██╗░░░██╗░██████╗░░░░░██╗░█████╗░██████╗░
-- ██╔══██╗██║░░░██║██╔════╝░░░░░██║██╔══██╗██╔══██╗
-- ██████╦╝██║░░░██║╚█████╗░░░░░░██║██║░░██║██████╦╝
-- ██╔══██╗██║░░░██║░╚═══██╗██╗░░██║██║░░██║██╔══██╗
-- ██████╦╝╚██████╔╝██████╔╝╚█████╔╝╚█████╔╝██████╦╝
-- ╚═════╝░░╚═════╝░╚═════╝░░╚════╝░░╚════╝░╚═════╝░
Config.GarbagejobSettings = {

    ['coords'] = {
        ['intreactionCoords'] = vector3(-337.08, -1533.47, 27.72),
        ['ped'] = true,
        ['pedCoords'] = vector3(-337.08, -1533.47, 27.72),
        ['pedHeading'] = 2.39,
        ['pedHash'] = 0xF0EC56E2,
    },
    ['blip'] = {
        show = true,
        blipName = 'Garbage Job',
        blipType = 631,
        blipColor = 2,
        blipScale = 0.55
    },

    ['job'] = 'all', --- 'all' or your perm

    ['trashvehicle'] = 'trash2',

    ['garbageTruckSpawnCoords'] = {
        vector4(-332.82, -1522.81, 27.29, 268.34)
    },
    ['badge'] = {
        { name = "badge1", level = 25, nickname = 'VM BEGINNER' },
        { name = "badge2", level = 45, nickname = 'VM APPRENTICE' },
        { name = "badge3", level = 60, nickname = 'VM MASTER' },
    },

    ['jobDeliverTheVehicleCoords'] = vector3(-329.34, -1522.17, 27.11),

    ['dailyMission'] = {

        {
            name = 'transportpassenger',
            header = 'Transport 250 Trash',
            label = 'Transport at least 250 trash through the Los Santos',
            count = 250,
            xp = 2500,
        },
        {
            name = 'completeoneroute',
            header = 'Complete One Route',
            label = 'Complete at least one route on thee LS.',
            xp = 1000,
            count = 1,
        },
        {
            name = 'earninoneroute',
            header = 'Earn $2000 in routes',
            label = 'Earn at least $2000 in routes.',
            count = 2000,
            xp = 1500,
        },

    },
    ['garbageRouteSettings'] = {
        { name = 'southside',       label = 'Southside',       xp = 2500, level = 1 },
        { name = 'portoflossantos', label = 'Port of LS',      xp = 2500, level = 15 },
        { name = 'vespucci',        label = 'Vespucci',        xp = 2500, level = 25 },
        { name = 'rockfordhills',   label = 'Rockford Hills',  xp = 2500, level = 35 },
        { name = 'downtown',        label = 'Downtown',        xp = 2500, level = 45 },
        { name = 'eastlossantos',   label = 'East Los Santos', xp = 2500, level = 55 },
        { name = 'vinewood',        label = 'Vinewood',        xp = 2500, level = 65 },
    },

    ['garbageStop'] = {
        ['southside'] = {
            {

                coords = vector3(-242.53, -1473.06, 31.48),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },

            {

                coords = vector3(-161.8, -1670.03, 33.18),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(42.31, -1877.51, 22.43),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(131.06, -1886.57, 23.48),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(252.56, -1820.79, 26.83),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(196.11, -1771.51, 29.21),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(140.57, -1578.4, 29.26),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(121.23, -1540.49, 29.32),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(97.31, -1523.95, 29.37),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(117.47, -1463.4, 29.3),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(138.44, -1362.7, 29.32),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(2.59, -1351.42, 29.35),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(-28.06, -1352.26, 29.31),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(-38.62, -1352.08, 29.32),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(-50.47, -1350.7, 29.33),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            },
            {

                coords = vector3(-138.77, -1361.61, 29.3),
                garbageCount = math.random(1, 1),
                garbagePrice = math.random(50, 100),
            }
        },

        ['portoflossantos'] = {
            {

                coords = vector3(414.19, -2012.9, 23.42),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(721.23, -2096.44, 29.26),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(151.84, -2477.66, 6.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-47.71, -2527.87, 6.05),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-65.83, -2511.76, 6.11),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-285.71, -2617.25, 6.01),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-374.31, -2734.24, 6.04),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-497.12, -2913.98, 6.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-353.59, -2768.08, 6.03),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-338.84, -2787.02, 5.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-319.02, -2727.42, 6.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            }


        },
        ['vespucci'] = {
            {

                coords = vector3(-542.99, -1221.81, 18.45),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-715.73, -1169.94, 10.61),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-709.22, -1140.17, 10.81),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-714.2, -1133.9, 10.73),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-849.29, -1112.34, 7.06),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1197.09, -1342.98, 4.84),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1277.49, -1210.22, 4.73),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1332.45, -1193.44, 4.88),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1325.38, -1215.4, 4.83),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1291.5, -1149.52, 5.53),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1324.09, -1086.37, 6.95),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1238.95, -1037.75, 8.31),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-1251.38, -1281.05, 4.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            }


        },
        ['rockfordhills'] = {
            {
                coords = vector3(-956.61, -404.99, 37.83),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-964.47, -183.97, 37.8),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-888.78, -212.95, 39.1),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-712.7, -65.75, 37.7),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-694.73, -1.0, 38.27),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-548.01, -43.28, 42.66),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-407.61, -32.79, 46.58),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-434.6, -97.88, 40.2),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-458.76, -93.79, 39.48),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-507.1, -164.72, 38.21),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-356.88, -343.06, 31.14),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-245.5, -577.0, 34.44),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-254.96, -733.33, 33.14),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },

            {

                coords = vector3(-258.39, -882.46, 30.86),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-233.42, -962.62, 29.29),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            }


        },
        ['downtown'] = {
            {

                coords = vector3(-181.43, -916.78, 29.15),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-202.97, -871.31, 29.28),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-219.9, -864.82, 29.96),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-237.01, -859.61, 30.55),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-268.4, -848.56, 31.64),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-262.45, -820.8, 31.77),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-245.69, -763.97, 32.79),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-233.02, -741.55, 33.32),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-232.09, -726.26, 33.54),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-226.0, -721.65, 33.6),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-221.65, -711.59, 33.68),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-222.11, -700.09, 33.66),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-196.81, -702.09, 34.07),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-187.24, -706.04, 34.25),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-163.6, -713.24, 34.61),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-145.09, -731.91, 34.58),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-164.36, -785.77, 31.4),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-174.17, -815.0, 31.24),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-200.14, -822.3, 30.92),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-198.15, -828.82, 30.77),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-193.83, -837.19, 30.71),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-189.46, -842.24, 29.99),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-196.0, -858.8, 29.36),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-72.3, -949.76, 29.23),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-7.54, -929.29, 29.36),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(85.68, -802.74, 31.51),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(99.21, -816.35, 31.39),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(99.68, -816.9, 31.37),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(114.6, -819.9, 31.32),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(19.8, -953.08, 29.36),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {

                coords = vector3(-111.02, -1114.93, 25.78),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            }


        },
        ['eastlossantos'] = {
            {
                coords = vector3(371.98, -868.65, 29.29),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(915.26, -855.3, 43.57),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1128.4, -976.45, 46.55),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1148.8, -1013.89, 44.57),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1217.65, -1186.8, 36.67),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1216.57, -1205.07, 36.32),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1231.61, -1235.28, 35.59),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1167.29, -1373.98, 34.93),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1183.37, -1377.65, 35.08),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1219.41, -1381.45, 35.27),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(984.09, -1376.96, 31.45),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(814.46, -1625.68, 31.35),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(812.05, -1725.72, 29.27),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(916.84, -1781.7, 30.8),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(1314.67, -1656.76, 51.24),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(838.92, -1881.09, 29.04),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(866.9, -1577.56, 30.73),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(857.57, -1562.02, 30.16),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(770.45, -1423.9, 27.28),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(304.58, -1290.13, 30.64),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
        },
        ['vinewood'] = {
            {
                coords = vector3(-580.08, 189.97, 71.31),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-615.83, 208.3, 74.19),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-639.4, 237.68, 81.88),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-592.25, 245.02, 82.4),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-579.71, 240.95, 82.63),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-522.5, 120.86, 63.15),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-404.06, 116.95, 64.71),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-365.25, 104.36, 66.11),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-314.01, 105.54, 67.6),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-302.83, 103.43, 67.96),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-287.1, 103.61, 68.47),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-276.6, 103.81, 68.83),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-267.83, 104.24, 69.1),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-206.03, 219.49, 88.0),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-181.09, 243.24, 92.78),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-120.37, 217.82, 94.6),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(-101.9, 45.52, 71.61),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(33.73, 231.58, 109.44),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(101.77, 318.32, 112.09),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(218.12, 343.09, 105.6),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(188.01, 218.0, 105.65),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(156.67, 92.14, 86.98),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(119.99, -7.65, 67.71),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(55.95, -140.74, 55.09),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(140.11, -204.99, 54.41),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(277.46, -167.63, 60.12),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(299.9, -61.9, 70.2),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(399.82, 217.36, 103.05),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(382.55, 236.57, 103.04),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(394.84, 269.68, 103.02),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(523.85, 247.75, 103.11),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(524.65, 156.48, 98.94),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(455.04, 7.4, 85.34),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(351.43, -196.06, 57.23),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(256.71, -215.7, 53.87),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(183.31, -320.15, 43.97),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            },
            {
                coords = vector3(149.72, -389.67, 41.67),
                garbageCount = math.random(1, 4),
                garbagePrice = math.random(50, 100)
            }
        }

    }
}




-- ██╗░░░░░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░███╗░░██╗██████╗░██╗░░██╗██████╗░
-- ██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗████╗░██║██╔══██╗╚██╗██╔╝██╔══██╗
-- ██║░░░░░█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░███████║██╔██╗██║██║░░██║░╚███╔╝░██████╔╝
-- ██║░░░░░██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██╔══██║██║╚████║██║░░██║░██╔██╗░██╔═══╝░
-- ███████╗███████╗░░╚██╔╝░░███████╗███████╗██║░░██║██║░╚███║██████╔╝██╔╝╚██╗██║░░░░░
-- ╚══════╝╚══════╝░░░╚═╝░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░░░░░

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
    [50] = 25500,
    [51] = 26500,
    [52] = 27500,
    [53] = 28500,
    [54] = 29500,
    [55] = 30500,
    [56] = 31500,
    [57] = 32500,
    [58] = 33500,
    [59] = 34500,
    [60] = 35500,
    [61] = 36500,
    [62] = 37500,
    [63] = 38500,
    [64] = 39500,
    [65] = 40500,
    [66] = 41500,
    [67] = 42500,
    [68] = 43500,
    [69] = 44500,
    [70] = 45500,

}


-- ███╗░░██╗░█████╗░████████╗██╗███████╗██╗░█████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗
-- ████╗░██║██╔══██╗╚══██╔══╝██║██╔════╝██║██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
-- ██╔██╗██║██║░░██║░░░██║░░░██║█████╗░░██║██║░░╚═╝███████║░░░██║░░░██║██║░░██║██╔██╗██║
-- ██║╚████║██║░░██║░░░██║░░░██║██╔══╝░░██║██║░░██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║
-- ██║░╚███║╚█████╔╝░░░██║░░░██║██║░░░░░██║╚█████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
-- ╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
Config.NotificationText = {
    ['garbagecount'] = {
        text = "Van de %s vuilniszakken zijn er nog maar %s over",
        type = "success"
    },
    ['nextposition'] = {
        text = "Ga naar de volgende locatie.",
        type = "success"
    },
    ['deliveryvehicle'] = {
        text = "lever het voertuig af en ontvang uw geld",
        type = "success"
    },
    ['completedailymission'] = {
        text = "Je hebt je dagelijkse missie voltooid. Je hebt %s xp verdiend",
        type = "success"
    },
    ['missioninprogress'] = {
        text = "Je hebt een missie in uitvoering, je kunt geen nieuwe beginnen.",
        type = "error"
    },
    ['newxp'] = {
        text = "Je hebt %s XP, Garbage JOB verdiend",
        type = "success"
    },
    ['maxlevel'] = {
        text = "Je hebt het maximale niveau bereikt.",
        type = "error"
    },
    ['vehicleNotFound'] = {
        text = "Het voertuig is niet gevonden.",
        type = "error"
    },
    ['routenotfound'] = {
        text = "Route is niet gevonden.",
        type = "error"
    },
    ['coordnotfound'] = { 
        text = "Geen geschikte coÃ¶rdinaten gevonden.",
        type = "error"
    },
    ['wrongjob'] = {
        text = "Je kan deze job niet doen.",
        type = "error"
    }
} 

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 3500)
        end
    end
end
