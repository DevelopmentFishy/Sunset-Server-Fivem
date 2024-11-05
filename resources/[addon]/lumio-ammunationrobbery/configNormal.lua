Config = {}

Config.TimeToOpen = 15000 --Time to open a case

Config.MainHackIcons = 3 --Amount of icons on hack
Config.MainHackSpeed = 10000 --Time they have to fill in color at keypad with each icon
Config.RequiredForMainHack = 'hacking_laptop' --Item required to start mainhack


Config.RequiredCops = 3 --Amount of cops on duty before you can start

Config.Hacking = false --⚠️ DONT CHANGE
Config.Stopped = false --⚠️ DONT CHANGE

Config.Cooldown = 30 --Time of cooldown in minutes

Config.MapDestination = vector4(872.02, -1145.92, 25.99, 140.33) --Location of the ped with katana

Config.Minigame = {
    game = 'path', -- Game you want to use from within - glow minigame in the readme
    minigame = { -- Settings for the minigames within glow minigames
        -- Creates a grid (19x19) squares
        -- Max gridsize is 31 and should be an odd number
        ['path'] = {
            gridSize = 19,
            lives = 3,
            timeLimit = 12000,
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

Config.Minigame2 = {
    game = 'spot', -- Game you want to use from within - glow minigame in the readme
    minigame = { -- Settings for the minigames within glow minigames
        -- Creates a grid (19x19) squares
        -- Max gridsize is 31 and should be an odd number
        ['path'] = {
            gridSize = 19,
            lives = 3,
            timeLimit = 15000,
        },
        -- Max gridsize is 10
        -- Available charSet: numeric, alphabet, alphanumeric, greek, runes, braille
        ['spot'] = {
            gridSize = 6,
            timeLimit = 10000,
            charSet = 'alphabet',
            required = 5,
        },
        ['math'] = {
            timeLimit = 300000,
        },
    },
}
Config.Locations = {
    ['info'] = {
        isActive = false,
        hackLocation = vector3(5.89, -1114.03, 28.82),
        animPos = vector3(6.08, -1112.83, 29.70),
        animHeading = 341.65,
    },
    ['mainhack'] = {
        [1] = {
            box = {
                pos = vector3(6.18, -1113.03, 28.67),
                length = 2.0, 
                width = 0.9,
                name = 'mainBox',
                heading = 70,
                minZ = 27.67,
                maxZ = 29.87,
                debug = false,
            },
            hacked = false,
            busy = false,
        },
    },
    ['boxes'] = {
        [1] = {
            box = {
                pos = vector3(17.15, -1111.79, 29.8),
                length = 2.1, 
                width = 0.6,
                name = 'oldBox1',
                heading = 340,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
        [2] = {
            box = {
                pos = vector3(17.75, -1109.83, 29.8),
                length = 2.05, 
                width = 0.75,
                name = 'oldBox2',
                heading = 340,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'attachment',
            opened = false,
            anim = 'smash'
        },
        [3] = {
            box = {
                pos = vector3(20.46, -1105.44, 29.8),
                length = 2.05, 
                width = 0.75,
                name = 'oldBox3',
                heading = 70,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'armor',
            opened = false,
            anim = 'smash'
        },
        [4] = {
            box = {
                pos = vector3(22.37, -1106.12, 29.8),
                length = 2.05, 
                width = 0.75,
                name = 'oldBox4',
                heading = 70,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'throwable',
            opened = false,
            anim = 'smash'
        },
        [5] = {
            box = {
                pos = vector3(23.14, -1107.84, 29.8),
                length = 2.05, 
                width = 0.75,
                name = 'oldBox5',
                heading = 70,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'attachment',
            opened = false,
            anim = 'smash'
        },
        [6] = {
            box = {
                pos = vector3(23.18, -1109.58, 29.8),
                length = 1.8, 
                width = 0.55,
                name = 'oldBox6',
                heading = 25,
                minZ = 28.8,
                maxZ = 29.9,
                debug = false,
            },
            type = 'melee',
            opened = false,
            anim = 'smash'
        },
    },
    ["keypad"] = {
        [1] = {
            box = {
                pos = vector3(23.66, -1106.57, 29.8),
                length = 0.7, 
                width = 0.75,
                name = 'oldKeypadBox',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.2,
                debug = false,
            },
            type = 'keypad',
            hacked = false,
            tries = 0,
            busy = false
        },
        [2] = {
            box = {
                pos = vector3(18.17, -1108.56, 29.8),
                length = 0.7, 
                width = 0.75,
                name = 'oldKeypadBox2',
                heading = 340,
                minZ = 29.8,
                maxZ = 30.2,
                debug = false,
            },
            type = 'keypad',
            hacked = false,
            tries = 0,
            busy = false
        }
    },
}