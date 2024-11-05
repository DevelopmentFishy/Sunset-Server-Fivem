Config = {}
Config.minEarn = 100
Config.maxEarn = 450
Config.RegisterEarnings = math.random(Config.minEarn, Config.maxEarn)
Config.MinimumStoreRobberyPolice = 1
Config.resetTime = (60 * 1000) * 15
Config.tickInterval = 1000

Config.Registers = {
    [1] = { vector3(-46.83, -1758.01, 29.42), robbed = false, time = 0, safeKey = 1, camId = 4 },
    [2] = { vector3(-48.58, -1759.21, 29.59), robbed = false, time = 0, safeKey = 1, camId = 4 },
    [3] = { vector3(-1486.26, -378.0, 40.16), robbed = false, time = 0, safeKey = 2, camId = 5 },
    [4] = { vector3(-1222.03, -908.32, 12.32), robbed = false, time = 0, safeKey = 3, camId = 6 },
    [5] = { vector3(-706.08, -915.42, 19.21), robbed = false, time = 0, safeKey = 4, camId = 7 },
    [6] = { vector3(-706.16, -913.5, 19.21), robbed = false, time = 0, safeKey = 4, camId = 7 },
    [7] = { vector3(24.47, -1344.99, 29.49), robbed = false, time = 0, safeKey = 5, camId = 8 },
    [8] = { vector3(24.45, -1347.37, 29.49), robbed = false, time = 0, safeKey = 5, camId = 8 },
    [9] = { vector3(1134.15, -982.53, 46.41), robbed = false, time = 0, safeKey = 6, camId = 9 },
    [10] = { vector3(1165.05, -324.49, 69.2), robbed = false, time = 0, safeKey = 7, camId = 10 },
    [11] = { vector3(1164.7, -322.58, 69.2), robbed = false, time = 0, safeKey = 7, camId = 10 },
    [12] = { vector3(373.14, 328.62, 103.56), robbed = false, time = 0, safeKey = 8, camId = 11 },
    [13] = { vector3(372.57, 326.42, 103.56), robbed = false, time = 0, safeKey = 8, camId = 11 },
    [14] = { vector3(-1818.9, 792.9, 138.08), robbed = false, time = 0, safeKey = 9, camId = 12 },
    [15] = { vector3(-1820.17, 794.28, 138.08), robbed = false, time = 0, safeKey = 9, camId = 12 },
    [16] = { vector3(-2966.46, 390.89, 15.04), robbed = false, time = 0, safeKey = 10, camId = 13 },
    [17] = { vector3(-3041.14, 583.87, 7.9), robbed = false, time = 0, safeKey = 11, camId = 14 },
    [18] = { vector3(-3038.92, 584.5, 7.9), robbed = false, time = 0, safeKey = 11, camId = 14 },
    [19] = { vector3(-3244.56, 1000.14, 12.83), robbed = false, time = 0, safeKey = 12, camId = 15 },
    [20] = { vector3(-3242.24, 999.98, 12.83), robbed = false, time = 0, safeKey = 12, camId = 15 },
    [21] = { vector3(549.42, 2669.06, 42.15), robbed = false, time = 0, safeKey = 13, camId = 16 },
    [22] = { vector3(549.05, 2671.39, 42.15), robbed = false, time = 0, safeKey = 13, camId = 16 },
    [23] = { vector3(1165.9, 2710.81, 38.15), robbed = false, time = 0, safeKey = 14, camId = 17 },
    [24] = { vector3(2676.02, 3280.52, 55.24), robbed = false, time = 0, safeKey = 15, camId = 18 },
    [25] = { vector3(2678.07, 3279.39, 55.24), robbed = false, time = 0, safeKey = 15, camId = 18 },
    [26] = { vector3(1958.96, 3741.98, 32.34), robbed = false, time = 0, safeKey = 16, camId = 19 },
    [27] = { vector3(1960.13, 3740.0, 32.34), robbed = false, time = 0, safeKey = 16, camId = 19 },
    [28] = { vector3(1728.86, 6417.26, 35.03), robbed = false, time = 0, safeKey = 17, camId = 20 },
    [29] = { vector3(1727.85, 6415.14, 35.03), robbed = false, time = 0, safeKey = 17, camId = 20 },
    [30] = { vector3(-161.07, 6321.23, 31.5), robbed = false, time = 0, safeKey = 18, camId = 27 },
    [31] = { vector3(160.52, 6641.74, 31.6), robbed = false, time = 0, safeKey = 19, camId = 28 },
    [32] = { vector3(162.16, 6643.22, 31.6), robbed = false, time = 0, safeKey = 19, camId = 29 },
    [33] = { vector3(1696.37, 4923.79, 42.06), robbed = false, time = 0, safeKey = 20, camId = 27 },-- Grapeseed 2006
    [34] = { vector3(1698.08, 4922.87, 42.06), robbed = false, time = 0, safeKey = 20, camId = 27 },-- Grapeseed 2006
    [35] = { vector3(1392.87, 3606.49, 34.98), robbed = false, time = 0, safeKey = 0, camId = 0 },-- Sandy 3026
    [36] = { vector3(2557.83, 381.64, 108.62), robbed = false, time = 0, safeKey = 21, camId = 0 },-- Snelweg Kas 1
    [37] = { vector3(2555.71, 381.36, 108.62), robbed = false, time = 0, safeKey = 21, camId = 0 },-- Snelweg Kas 2
    [38] = { vector3(-344.06, -1477.36, 30.76), robbed = false, time = 0, safeKey = 22, camId = 42 },-- LTD aan de vuilnisjob
    [39] = { vector3(-345.89, -1477.35, 30.76), robbed = false, time = 0, safeKey = 22, camId = 42 },-- LTD aan de vuilnisjob
    [40] = { vector3(644.8, 261.55, 103.3), robbed = false, time = 0, safeKey = 23, camId = 43 },-- LTD aan de vinewood
    [41] = { vector3(646.33, 260.73, 103.3), robbed = false, time = 0, safeKey = 23, camId = 43 },-- LTD aan de vinewood
}

Config.Safes = {
    [1] = { vector4(-43.43, -1748.3, 29.42, 52.5), type = 'keypad', robbed = false, camId = 4 },
    [2] = { vector4(-1478.94, -375.5, 39.16, 229.5), type = 'padlock', robbed = false, camId = 5 },
    [3] = { vector4(-1220.85, -916.05, 11.32, 229.5), type = 'padlock', robbed = false, camId = 6 },
    [4] = { vector4(-709.74, -904.15, 19.21, 229.5), type = 'keypad', robbed = false, camId = 7 },
    [5] = { vector3(31.19, -1339.31, 29.50), type = 'keypad', robbed = false, camId = 8 },--fix gabz
    [6] = { vector3(1126.77, -980.1, 45.41), type = 'padlock', robbed = false, camId = 9 },
    [7] = { vector3(1159.46, -314.05, 69.2), type = 'keypad', robbed = false, camId = 10 },
    [8] = { vector3(381.04, 332.60, 103.57), type = 'keypad', robbed = false, camId = 11 },--fix gabz
    [9] = { vector3(-1829.27, 798.76, 138.19), type = 'keypad', robbed = false, camId = 12 },
    [10] = { vector3(-2959.64, 387.08, 14.04), type = 'padlock', robbed = false, camId = 13 },
    [11] = { vector3(-3048.67, 588.58, 7.91), type = 'keypad', robbed = false, camId = 14 },-- fix gabz
    [12] = { vector3(-3249.66, 1007.36, 12.83), type = 'keypad', robbed = false, camId = 15 }, -- fix gabz
    [13] = { vector3(543.75, 2662.58, 42.16), type = 'keypad', robbed = false, camId = 16 },-- fix gabz
    [14] = { vector3(1169.31, 2717.79, 37.15), type = 'padlock', robbed = false, camId = 17 },
    [15] = { vector3(2674.22, 3289.22, 55.24), type = 'keypad', robbed = false, camId = 18 },-- fix gabz
    [16] = { vector3(1961.77, 3750.26, 32.34), type = 'keypad', robbed = false, camId = 19 }, -- fix gabz
    [17] = { vector3(1737.46, 6419.40, 35.04), type = 'keypad', robbed = false, camId = 20 },-- fix gabz
    [18] = { vector3(-168.40, 6318.80, 30.58), type = 'padlock', robbed = false, camId = 27 },
    [19] = { vector3(170.93, 6642.52, 31.70), type = 'keypad', robbed = false, camId = 30 },
    [20] = { vector3(1707.79, 4920.45, 42.06), type = 'keypad', robbed = false, camId = 27 },-- fix gabz
    [21] = { vector3(2549.48, 387.85, 108.62), type = 'keypad', robbed = false, camId = 0 },-- snelweg
    [22] = { vector3(-355.37, -1480.96, 30.76), type = 'keypad', robbed = false, camId = 8  },-- LTD aan de vuilnisjob
    [23] = { vector3(656.25, 259.14, 103.3), type = 'keypad', robbed = false, camId = 43 },-- LTD aan de vinewood
}
