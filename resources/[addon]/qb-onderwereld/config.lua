Config = Config or {}

-- This is the handler for the cop count, you can change this to anything you want as this is by default the qb-policejob event
RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

Config.MinimumbankautomaatPolice = 2
Config.MinimumkoperPolice = 0
Config.MinimumContainerPolice = 2

--//DRUG RUNS CONTAINERS\\--
Config.dealernaam = 'Brayen Diaz'
Config.locatienaam = 'Haven'
Config.car = 'dominator'
Config.npc = 'G_M_Y_MexGang_01'
Config.weapon = "weapon_pistol50" 
Config.spawn1 = vector3(979.47, -3106.03, 5.9)
Config.spawn2 = vector3(901.21, -2958.65, 5.9)
Config.spawn3 = vector3(860.32, -3113.29, 5.9)
Config.spawn4 = vector3(938.88, -2958.58, 5.9)
Config.spawn5 = vector3(1129.55, -3005.43, 5.9)

--//LOOT NPC\\--
Config.MaxItemsReceived 	= 2
Config.MinItemReceivedQty 	= 1
Config.MaxItemReceivedQty 	= 2
Config.ChanceItem 	= "bpcombatpistol"
Config.LuckyItem 	= "bpcombatpistol"
Config.ItemTableNPCloot = {
    [1] = "weapon_snspistol",
	[2] = "security_card_02",
	[3] = "pistol_ammo",
}
-----------------

--//LOOT CONTAINER\\--
Config.MaxdrugItemsReceived 	= 3
Config.MindrugItemReceivedQty 	= 1
Config.MaxdrugItemReceivedQty 	= 2
Config.ChancedrugItem 	= "bpcombatpistol"
Config.LuckydrugItem 	= "bpheavypistol"
Config.ItemTabledrug = {
    [1] = "pistol_ammo",
	[2] = "snsblauwprint",
	[3] = "kthermite",
    [4] = "goldbar",
    [5] = "security_card_02",
}
-----------------

Config.containers = {
    locations = {
		[1] = vector3(896.3, -3047.51, 5.9),
        [2] = vector3(910.48, -3085.61, 5.9),
        [3] = vector3(909.5, -3098.77, 5.9),
        [4] = vector3(965.23, -2984.65, 5.9),
        [5] = vector3(993.1, -2985.38, 5.9),
        [6] = vector3(1094.16, -2992.25, 5.9),
        [7] = vector3(1094.23, -2994.84, 5.9),
        
		--You can add more locations here
    }
}

--//BANK AUTOMAAT OVERVALLEN\\--
Config.hoeveelheid = {
    MoneyRollMin = 10000,
    MoneyRollMax = 15000
} --Hoeveelheid blackmoney als item

Config.downtime = {
    WachtTijd = 400000
}


Config.ATmModels = {
    -870868698,
    -1126237515	 -- ATM models, do not remove any
}


Config.automaaten = {
    --winkels--

	[1] = {
        ["coords"] = vector3(33.55, -1344.97, 29.5),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[2] = {
        ["coords"] = vector3(-56.79, -1752.25, 29.42),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[3] = {
        ["coords"] = vector3(-717.61, -915.71, 19.22),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[4] = {
        ["coords"] = vector3(381.78, 326.55, 103.57),
        ["defect"] = false,
        ["IsBezet"] = false,
		-- 
    },
	[5] = {
        ["coords"] = vector3(1153.64, -326.77, 69.21),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[6] = {
        ["coords"] = vector3(2555.24, 389.82, 108.62),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[7] = {
        ["coords"] = vector3(2680.32, 3288.37, 55.24),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
	[8] = {
        ["coords"] = vector3(1966.59, 3746.47, 32.34),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [9] = {
        ["coords"] = vector3(1171.52, 2702.38, 38.18),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [10] = {
        ["coords"] = vector3(1172.52, 2702.59, 38.17),
        ["defect"] = false,
        ["IsBezet"] = false,
		-- 
    },
    [11] = {
        ["coords"] = vector3(540.49, 2667.9, 42.16),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [12] = {
        ["coords"] = vector3(1702.97, 4933.55, 42.06),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [13] = {
        ["coords"] = vector3(1736.9, 6413.35, 35.04),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [14] = {
        ["coords"] = vector3(-3243.85, 1009.17, 12.83),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [15] = {
        ["coords"] = vector3(-3043.91, 592.35, 7.91),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [16] = {
        ["coords"] = vector3(-1827.24, 784.85, 138.3),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    ---pacific bank
    [17] = {
        ["coords"] = vector3(236.54, 219.71, 106.29),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [18] = {
        ["coords"] = vector3(236.98, 218.78, 106.29),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [19] = {
        ["coords"] = vector3(237.47, 217.82, 106.29),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [20] = {
        ["coords"] = vector3(237.94, 216.85, 106.29),
        ["defect"] = false,
        ["IsBezet"] = false,
	
    },
    [21] = {
        ["coords"] = vector3(238.34, 215.85, 106.29),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [22] = {
        ["coords"] = vector3(633.19, 9.62, 82.74),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [23] = {
        ["coords"] = vector3(650.34, 271.80, 103.30),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [24] = {
        ["coords"] = vector3(-343.80, -1488.92, 30.76),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    },
    [25] = {
        ["coords"] = vector3(318.30, -580.84, 43.27),
        ["defect"] = false,
        ["IsBezet"] = false,
		
    }
 
}



--//Zwarte markt\\---

Config.Locations = {        -- Locations of where the ped spawns. Chosen randomly every night at 22:00. Add as many as you like.
    [1] = vector4(-1936.8, 2051.05, 139.83, 78.32),
    [2] = vector4(-621.95, 312.62, 82.93, 170.51),
    [3] = vector4(1355.33, -531.25, 72.89, 332.25),
    [4] = vector4(-1811.22, -1212.58, 18.17, 272),
	
	
	
	[5] = vector4(813.14, -2398.67, 22.66, 174.56),
}

Config.Model = 'A_F_Y_RurMeth_01' -- The model of the ped.

Config.Dealers = {

}

Config.Products = {
    [1] = {
        name = "zfmbomb",
        price = 5000,
        amount = 10,
        info = {},
        type = "item",
        slot = 1,
        minrep = 0,
    },
	[2] = {
        name = "bomb",
        price = 10000,
        amount = 1,
        info = {},
        type = "item",
        slot = 2,
        minrep = 0,
    },
	[3] = {
        name = "laserdrill",
        price = 7500,
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
        minrep = 0,
    },
	[4] = {
        name = "pistol_ammo",
        price = 250,
        amount = 10,
        info = {},
        type = "item",
        slot = 4,
        minrep = 0,
    },
	[5] = {
        name = "drugdealernumber",
        price = 7500,
        amount = 1,
        info = {},
        type = "item",
        slot = 5,
        minrep = 0,
    },
	[6] = {
        name = "telefoonnummerprints",
        price = 40000,
        amount = 1,
        info = {},
        type = "item",
        slot = 6,
        minrep = 0,
    },
    [7] = {
        name = "rifle_ammo",
        price = 750,
        amount = 10,
        info = {},
        type = "item",
        slot = 7,
        minrep = 0,
    },
    [8] = {
        name = "laptop_green",
        price = 5000,
        amount = 1,
        info = {},
        type = "item",
        slot = 8,
        minrep = 0,
    },
    [9] = {
        name = "hacking_laptop",
        price = 15000,
        amount = 1,
        info = {},
        type = "item",
        slot = 9,
        minrep = 0,
    },
    [10] = {
        name = "laptop_blue",
        price = 30000,
        amount = 1,
        info = {},
        type = "item",
        slot = 10,
        minrep = 0,
    },
}

-- Config.Malemask = {
--     [231] = true, [230] = true, [229] = true, [227] = true, [8] = true, [15] = true, [16] = true, [29] = true, [30] = true, [37] = true, [50] = true, [52] = true, [54] = true, [56] = true, [57] = true, [58] = true, [95] = true,
-- }
-- Config.Femalemask = {
--     [2] = true, [8] = true, [15] = true, [16] = true, [29] = true, [30] = true, [37] = true, [50] = true, [54] = true, [56] = true, [57] = true, [58] = true, [95] = true,
-- }
-----------------
--Wapen ophalen--
-----------------
Config.RandomLocation = {
	[1] =  {Name = "OG",Amount = "",ItemName = "Guns",Street = "Vliegen", coords = vector4(-1423.56, -3305.1, 13.94, 129.43)},
    [2] =  {Name = "OG",Amount = "",ItemName = "Guns",Street = "Observatorium", coords = vector4(-479.41, 1136.79, 320.1, 166.48)},

}

Config.wapens = {
    [1] = {
        name = "weapon_snspistol",
        price = 0,
        amount = 1,
        info = {},
        type = "item",
        slot = 1,
    },
}
---------------------
-- SHOP OPEN/CLOSE --
---------------------

Config.Open = 20
Config.Close = 5 

---------------------
-- WITWAS --
---------------------
Config.OpenWitwas = 20
Config.CloseWitwas = 6 
Config.ModelWitwas = 'a_f_o_genstreet_01'

Config.LocationsWitwas = {     
    [1] = vector4(2576.0, 304.95, 107.61, 3.62),
    [2] = vector4(-1453.36, -387.27, 37.19, 30.32),
    [3] = vector4(1172.66, -1384.71, 33.81, 50.92),
    [4] = vector4(-564.16, -2235.39, 4.87, 140.89),
}

Config.Options = {
    0.0, --option1
    -- 0.15, --option2
    -- 0.1, --option3
}

--in seconds
Config.TimeWait = {
    0,--option1
    -- 86400,--option2
    -- 172800,--option3
}

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
---------------------
--- Koper diefstal---
---------------------
Config.koperdraad = 1
-- Config.downtimepaal = {
--     WachtTijd = 40000
-- }
Config.smelttijd = 10 --seconden
Config.aantalkoper = 5 --antal koper per gesmolten draad

Config.smeltbad = {
	[1] = {
        ["coords"] = vector3(1088.1, -2004.08, 31.38),
		["smelted"] = vector3(1087.42, -2001.56, 30.88),
    },
}

Config.paaltjes = {
	[1] = {
        ["coords"] = vector3(2566.76, -112.56, 93.18),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[2] = {
        ["coords"] = vector3(2625.24, 83.58, 93.56),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[3] = {
        ["coords"] = vector3(2471.36, -271.41, 93.2),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[4] = {
        ["coords"] = vector3(2436.3, -333.72, 93.71),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[5] = {
        ["coords"] = vector3(2182.16, -619.7, 96.28),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[6] = {
        ["coords"] = vector3(2126.26, -651.54, 96.53),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[7] = {
        ["coords"] = vector3(2067.64, -709.36, 96.77),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[8] = {
        ["coords"] = vector3(2058.78, -702.48, 96.78),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[9] = {
        ["coords"] = vector3(1987.99, -750.46, 96.92),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[10] = {
        ["coords"] = vector3(1792.47, -787.1, 91.35),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[11] = {
        ["coords"] = vector3(1780.7, -807.67, 89.73),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[12] = {
        ["coords"] = vector3(1721.75, -834.4, 84.95),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[13] = {
        ["coords"] = vector3(1687.17, -872.14, 81.06),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[14] = {
        ["coords"] = vector3(1625.12, -899.81, 75.71),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[15] = {
        ["coords"] = vector3(1519.71, -972.03, 66.32),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[16] = {
        ["coords"] = vector3(1366.44, -944.39, 56.93),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[17] = {
        ["coords"] = vector3(861.37, -478.05, 30.01),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[18] = {
        ["coords"] = vector3(661.55, -661.18, 25.5),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[19] = {
        ["coords"] = vector3(661.29, -753.41, 23.72),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[20] = {
        ["coords"] = vector3(662.17, -793.8, 23.46),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[21] = {
        ["coords"] = vector3(666.69, -793.89, 23.51),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[22] = {
        ["coords"] = vector3(661.38, -824.81, 23.37),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[23] = {
        ["coords"] = vector3(660.49, -850.71, 23.04),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[24] = {
        ["coords"] = vector3(666.94, -850.92, 23.1),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[25] = {
        ["coords"] = vector3(673.54, -927.6, 22.08),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[26] = {
        ["coords"] = vector3(652.79, -927.49, 21.83),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[27] = {
        ["coords"] = vector3(672.72, -1060.51, 22.51),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[28] = {
        ["coords"] = vector3(671.47, -1125.54, 24.42),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[29] = {
        ["coords"] = vector3(656.76, -1197.4, 24.09),
		["defect"] = false,
        ["IsBezet"] = false,
    },
	[30] = {
        ["coords"] = vector3(662.41, -1197.09, 24.15),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[31] = {
        ["coords"] = vector3(877.41, -1117.07, 23.51),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
	[32] = {
        ["coords"] = vector3(888.94, -1117.87, 23.8),
        ["defect"] = false,
        ["IsBezet"] = false,
    },
}


