Config = Config or {}

Config.Inventory = 'qb' -- ox / ps / lj / qb
Config.PoliceJobs = {
    'police',
    'swat',
    'leo',
    'bcso'
}
Config.HackingItem = 'hacking_laptop'
Config.Dispatch = 'ps' -- ps = ps-dispatch / cd = cd_dispatch
Config.CoolDown = 30 -- minutes till any job can be done again by any player
Config.Notifications = 'qb' -- qb / ox
Config.Phone = {
    resource = 'qs', -- qb / gks /qs / lb
    items = {
        'green_phone',
        'black_phone',
        'red_phone',
        'white_phone',
        'purple_phone',
        'blue_phone',
        'gold_phone',
        
    },
}
Config.LesterMinigame = {
    game = 'path', -- Game you want to use from within - glow minigame in the readme
    minigame = { -- Settings for the minigames within glow minigames
        -- Creates a grid (19x19) squares
        -- Max gridsize is 31 and should be an odd number
        ['path'] = {
            gridSize = 19,
            lives = 3,
            timeLimit = 13000,
        },
        -- Max gridsize is 10
        -- Available charSet: numeric, alphabet, alphanumeric, greek, runes, braille
        ['spot'] = {
            gridSize = 6,
            timeLimit = 8000,
            charSet = 'alphabet',
            required = 10,
        },
        ['math'] = {
            timeLimit = 300000,
        },
    },
}

Config.Jobs = {
    ['Truck Convoy'] = {
        event = 'kevin-banktrucks:takeconvoy', -- DO NOT CHANGE
        description = 'Onderschep een fleeca banktruck', -- description shown on the menu for the job
        copsneeded = 4, -- cops needed to be able to do the job
        timer = {
            cleanup = 2, -- minutes after looting the truck until the job is cleaned up
        },
        guardlocations = { -- location the fleeca guard is spawned at
            vector4(459.34, -1870.86, 26.91, 160.04),
            vector4(-524.98, -2239.63, 6.39, 211.93),
            vector4(-864.49, -1262.11, 5.15, 261.39),
            vector4(-959.99, -1109.2, 2.15, 60.79),
            vector4(-1349.33, -760.18, 22.46, 293.35),
            vector4(-661.47, 171.98, 73.24, 292.83),
            vector4(-154.03, -21.37, 58.21, 246.75),
            vector4(243.91, 11.0, 84.13, 42.58),
            vector4(817.54, -492.37, 30.54, 337.99),
            vector4(1061.3, -786.4, 58.26, 211.26),
            vector4(1136.78, -2036.25, 30.98, 344.04),
        },
        trucklocations = { -- locations the fleeca truck spawns at
            vector4(-40.57, -1626.32, 28.97, 319.05),
            vector4(259.61, -967.91, 28.84, 341.91),
            vector4(-274.45, -195.45, 38.54, 359.96),
            vector4(-209.34, 125.7, 69.24, 86.87),
            vector4(327.92, -269.04, 53.48, 248.84),
            vector4(817.87, -55.74, 80.18, 55.88),
            vector4(386.17, 138.25, 102.48, 69.65),
            vector4(290.16, -57.26, 69.94, 162.62),
            vector4(796.79, -813.59, 25.84, 90.06),
            vector4(789.38, -1416.16, 26.78, 179.8)
        },
        blips = {
            [1] = { sprite = 1, scale = 0.75, color = 2, label = 'Fleeca bewakerlocatie', },
            [2] = { sprite = 304, scale = 0.75, color = 2, label = 'Fleeca bewaker', },
            [3] = { sprite = 67, scale = 0.75, color = 2, label = 'Fleeca Truck', },
        },
        safe = {
            codelength = 8, -- length of the code needed to open the safe for cash
            cash = { -- rewards in cash given from the safe
                min = 10000,
                max = 20000,
            },
        },
        guarditem = 'gps-device', -- item given from killing the guard to locate the truck location
        itemneeded = 'kthermite', -- thermite item needed to plant on the back of the truck doors
        thermitetime = 1, -- mintues until doors blow off
        thermite = {
            time = 1, -- minutes till thermite blows doors off
            attempts = 3, -- amount of failed attempts on thermite minigame before removing the item
            minigame = {
                time = 45,
                gridsize = 5,
                incorrectblocks = 3,
            },
        },
        progressbartimer = { -- timers for progressbars in ms
            searchingguard = 5000, -- time taken to search the guard after killing him
            plantingthermite = 5000, -- time taken to plant the thermite on the back doors of the truck
            looting = 10000, -- time take to grab the loot after killing the guards 
        },
        truckhash = `stockade`,
        driver = {
            health = 100,
            armor = 50,
            suffercriticalhits = false,
            drivingspeed = 20.0,
            drivingstyle = 262144
        },
        guards = {
            health = 200,
            armor = 150,
            suffercriticalhits = false,
            weapon = `weapon_microsmg`,
            weaponaccuracy = 30.0,
            canragdoll = false,
        },
        reward = {
            pool = {
                [1] = {
                    item = 'geldrol', -- dirty money item must be an item in your server
                    worth = {min = 1000, max = 1000}, -- worth amount set for the item, random amount between the both numbers
                    amount = math.random(100000, 125000), -- amount of the items given 
                },
                [2] = {
                    item = 'snsblauwprint', -- dirty money item must be an item in your server
                    worth = {min = 0, max = 0}, -- worth amount set for the item, random amount between the both numbers
                    amount = 1, -- amount of the items given 
                },
                [3] = {
                    item = 'pistol_extendedclip', -- dirty money item must be an item in your server
                    worth = {min = 0, max = 0}, -- worth amount set for the item, random amount between the both numbers
                    amount = 1, -- amount of the items given 
                },
                -- [2] = {
                --     item = 'smallbands',
                --     worth = {min = 1000, max = 1000},
                --     amount = 7000,
                -- },
                -- [3] = {
                --     item = 'bigbands',
                --     worth = {min = 5000, max = 12500},
                --     amount = 10,
                -- },
            },
        },
        rare = {
            chance = 33, -- % chance to get the rare item
            pool = {
                [1] = {
                    item = 'laptop_red', -- change to whatever you want your rare item to be
                    amount = 1, -- amount of the item given
                },
                [2] = {
                    item = 'weapon_snspistol_mk2',
                    amount = 1,
                },
                [3] = {
                    item = 'laptop_blue',
                    amount = 1,
                },
                [4] = {
                    item = 'security_card_02',
                    amount = 1,
                },
            },
        },
    },
    ['Truck Delivery'] = {
        event = 'kevin-banktrucks:takedelivery', -- DO NOT CHANGE
        description = 'Zoek en breng te banktruck naar een locatie.',
        copsneeded = 4, -- cops needed to do the job
        pedhash = `s_m_y_winclean_01`, -- hash model of the ped at the drop location
        gpstime = {min = 2, max = 5}, -- time until the player get a location to drop off the truck since entering
        trucklocations = { -- locations the truck is spawned at
            vector4(-1318.02, -591.91, 28.35, 305.08),
            vector4(306.95, 364.92, 104.87, 249.48),
            vector4(1034.76, -142.68, 73.8, 313.86),
            vector4(2712.85, 4133.49, 43.55, 352.79),
            vector4(2397.17, 3321.58, 47.28, 40.17),
            vector4(1210.63, -1255.9, 34.83, 359.23),
            vector4(982.83, -1944.85, 30.61, 358.53),
            vector4(890.62, -2210.7, 30.11, 355.37),
            vector4(375.04, -2746.85, 5.63, 1.0),
            vector4(-62.62, -2559.98, 5.61, 55.52),
            vector4(-414.97, -1489.09, 18.33, 175.4),
            vector4(-702.76, -763.55, 33.66, 90.91),
        },
        droplocations = {
            vector4(-510.26, -2221.68, 6.39, 258.03),
            vector4(-1164.38, -2022.24, 13.16, 125.45),
            vector4(181.15, 3087.08, 43.26, 79.0),
            vector4(710.79, 4185.49, 41.08, 190.07),
            vector4(-361.08, 6102.77, 31.5, 277.53),
            vector4(-118.01, 6347.98, 31.49, 15.83),
            vector4(1527.36, 6324.62, 24.17, 290.77),
        },
        cashreward = {
            min = 25000,
            max = 50000,
        },
        rare = {
            chance = 33, -- % chance to get the rare item
            pool = {
                [1] = {
                    item = 'laptop_red', -- change to whatever you want your rare item to be
                    amount = 1, -- amount of the item given
                },
                [2] = {
                    item = 'weapon_combatpistol',
                    amount = 2,
                },
                [3] = {
                    item = 'laptop_blue',
                    amount = 1,
                },
                [4] = {
                    item = 'security_card_02',
                    amount = 1,
                },
            },
        },
    },
}
