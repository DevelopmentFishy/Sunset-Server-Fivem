Config = {}

Config.TimeToOpen = 15000 --Time to open a case

Config.MainHackIcons = 3 --Amount of icons on hack
Config.MainHackSpeed = 5000 --Time they have to fill in color at keypad with each icon
Config.RequiredForMainHack = 'electronickit' --Item required to start mainhack

Config.KeypadIcons = 3 --Amount of icons on hack
Config.KeypadSpeed = 5000 --Time they have to fill in color at keypad with each icon
Config.KeyPadMaxTries = 3 --Max tries they have to hack the keypad / cashier

Config.RequiredCops = 0 --Amount of cops on duty before you can start

Config.Hacking = false --⚠️ DONT CHANGE
Config.Stopped = false --⚠️ DONT CHANGE

Config.Cooldown = 45 --Time of cooldown in minutes

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
                pos = vector3(3.64, -1107.35, 29.8),
                length = 1.5, 
                width = 0.2,
                name = 'bigBox1',
                heading = 340,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [2] = {
            box = {
                pos = vector3(4.06, -1105.97, 29.8),
                length = 1.5, 
                width = 0.2,
                name = 'bigBox2',
                heading = 340,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [3] = {
            box = {
                pos = vector3(4.58, -1104.68, 29.8),
                length = 1.4, 
                width = 0.2,
                name = 'bigBox3',
                heading = 340,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [4] = {
            box = {
                pos = vector3(5.07, -1103.32, 29.8),
                length = 1.4, 
                width = 0.2,
                name = 'bigBox4',
                heading = 340,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [5] = {
            box = {
                pos = vector3(14.73, -1104.47, 29.8),
                length = 1.5, 
                width = 0.2,
                name = 'bigBox5',
                heading = 70,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [6] = {
            box = {
                pos = vector3(16.04, -1104.95, 29.8),
                length = 1.5, 
                width = 0.2,
                name = 'bigBox6',
                heading = 70,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [7] = {
            box = {
                pos = vector3(17.37, -1105.42, 29.8),
                length = 1.4, 
                width = 0.2,
                name = 'bigBox7',
                heading = 70,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [8] = {
            box = {
                pos = vector3(18.69, -1105.91, 29.8),
                length = 1.4, 
                width = 0.2,
                name = 'bigBox8',
                heading = 70,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [9] = {
            box = {
                pos = vector3(22.0, -1107.14, 29.8),
                length = 1.4, 
                width = 0.2,
                name = 'bigBox9',
                heading = 70,
                minZ = 28.95,
                maxZ = 31.75,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'weld'
        },
        [10] = {
            box = {
                pos = vector3(10.5, -1103.43, 29.8),
                length = 2.2, 
                width = 0.4,
                name = 'armorBox1',
                heading = 70,
                minZ = 28.8,
                maxZ = 31.4,
                debug = false,
            },
            type = 'armor',
            opened = false,
            anim = 'weld'
        },
        [11] = {
            box = {
                pos = vector3(12.59, -1104.18, 29.8),
                length = 2.2, 
                width = 0.4,
                name = 'armorBox2',
                heading = 70,
                minZ = 28.8,
                maxZ = 31.4,
                debug = false,
            },
            type = 'armor',
            opened = false,
            anim = 'weld'
        },
        [12] = {
            box = {
                pos = vector3(14.43, -1112.49, 29.8),
                length = 1.2, 
                width = 1.0,
                name = 'smallBox1',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'attachment',
            opened = false,
            anim = 'smash'
        },
        [13] = {
            box = {
                pos = vector3(7.18, -1109.86, 29.8),
                length = 1.2, 
                width = 0.95,
                name = 'smallBox2',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'attachment',
            opened = false,
            anim = 'smash'
        },
        [14] = {
            box = {
                pos = vector3(8.65, -1106.84, 29.8),
                length = 1.05, 
                width = 1.05,
                name = 'triangleBox1',
                heading = 340,
                minZ = 28.75,
                maxZ = 29.95,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
        [15] = {
            box = {
                pos = vector3(9.0, -1105.83, 29.8),
                length = 1.05, 
                width = 1.1,
                name = 'triangleBox2',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
        [16] = {
            box = {
                pos = vector3(16.62, -1108.3, 29.8),
                length = 2.4, 
                width = 1.05,
                name = 'counterBox1',
                heading = 70,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
        [17] = {
            box = {
                pos = vector3(19.9, -1107.7, 29.8),
                length = 2.35, 
                width = 1.05,
                name = 'counterBox2',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
        [18] = {
            box = {
                pos = vector3(19.34, -1109.29, 29.8),
                length = 1.05, 
                width = 1.05,
                name = 'counterBox3',
                heading = 340,
                minZ = 28.8,
                maxZ = 30.0,
                debug = false,
            },
            type = 'weapon',
            opened = false,
            anim = 'smash'
        },
    },
    ["keypad"] = {
        [1] = {
            box = {
                pos = vector3(10.77, -1111.28, 29.8),
                length = 0.2, 
                width = 0.2,
                name = 'keypadBox',
                heading = 340,
                minZ = 29.55,
                maxZ = 29.85,
                debug = false,
            },
            type = 'keypad',
            hacked = false,
            tries = 0,
            busy = false
        }
    },
    ["katana"] = {
        [1] = {
            box = {
                pos = vector3(13.84, -1107.7, 29.8),
                length = 1.95, 
                width = 1.05,
                name = 'katanaBox1',
                heading = 340,
                minZ = 30.1,
                maxZ = 30.7,
                debug = false,
            },
            type = 'katana',
            opened = false,
            anim = 'weld',
            visible = false
        }
    },
}