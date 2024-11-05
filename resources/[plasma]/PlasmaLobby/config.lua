HaveTeamDeathMatch = true
HaveCaptureTheOrbs =  false
HaveRandomWeapon   = true
-- HaveBurningMode    = false NOT IMPLEMENTED

MaxPlayerPerTeam = 10
MaxRound = 10

GunName = "WEAPON_PLASMAP" --The Gun used in game. You can have weird issue if you use classic GTA Weapon, I recommend to use modded ADDON (no replace) gun.
GunDamage = 10.0 -- The damage that the gun Deal. You have to put here the damage that the gun deal, its used to heal player after taking a shot.

ShowBlips = true

UseThirdEye = false      -- Use targetting system instead of marker
WhichThirdEye = "qb"     -- Which targetting system "ox" or "qb" (only OX_target and QB-Target are available, but you can edit target.lua file to add your own targetting system)


LstGun = {
	 "WEAPON_PLASMAP",
	 "WEAPON_RAZORBACK",
	 "WEAPON_NEEDLER2",
	 "WEAPON_RAYSHOTGUN"
}

PlasmaWeaponToHash = {
	["WEAPON_PLASMAP_BLUE"]     =  `WEAPON_PLASMAP_BLUE`   ,
	["WEAPON_PLASMAP_RED"]      =  `WEAPON_PLASMAP_RED`    ,
	["WEAPON_RAZORBACK_BLUE"]   =  `WEAPON_RAZORBACK_BLUE` ,
	["WEAPON_RAZORBACK_RED"]    =  `WEAPON_RAZORBACK_RED`  ,
	["WEAPON_NEEDLER2_BLUE"]    =  `WEAPON_NEEDLER2_BLUE`  ,
	["WEAPON_NEEDLER2_RED"]     =  `WEAPON_NEEDLER2_RED`   ,
	["WEAPON_RAYSHOTGUN_BLUE"]  =  `WEAPON_RAYSHOTGUN_BLUE`,
	["WEAPON_RAYSHOTGUN_RED"]   =  `WEAPON_RAYSHOTGUN_RED` ,
}

HashToPlasmaWeapon = {
	[`WEAPON_PLASMAP_BLUE`]      =  "WEAPON_PLASMAP_BLUE",   
	[`WEAPON_PLASMAP_RED`]       =  "WEAPON_PLASMAP_RED"  , 
	[`WEAPON_RAZORBACK_BLUE`]    =  "WEAPON_RAZORBACK_BLUE", 
	[`WEAPON_RAZORBACK_RED`]     =  "WEAPON_RAZORBACK_RED" ,
	[`WEAPON_NEEDLER2_BLUE`]     =  "WEAPON_NEEDLER2_BLUE"  ,
	[`WEAPON_NEEDLER2_RED`]      =  "WEAPON_NEEDLER2_RED"  ,
	[`WEAPON_RAYSHOTGUN_BLUE`]   =  "WEAPON_RAYSHOTGUN_BLUE",
	[`WEAPON_RAYSHOTGUN_RED`]    =  "WEAPON_RAYSHOTGUN_RED"
}

print("Lst Gun : "..tostring(#LstGun))
Maps = {
	["Patoche"] = { -- first map  -- PLASMAGAME
	["resourceName"] = "patoche_plasmagame",
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x = 727.26947021484, y = -57.796955108643, z = -7.562906265259},
	["redCoords"] = 	{x = 791.17260742188, y = -37.611629486084, z = -7.562920570374},
	
	["redFlagCoords"] ={x = 778.71, y = -60.81, z = -6.1519818305969, h = 357.63375854492},
	["blueFlagCoords"] = {x = 743.34, y = -35.11, z = -6.1519837379456, h = 174.22836303711},
	
	
	["mapRedOutCoords"] = {{x = 791.65753173828, y = -43.847557067871, z = -6.0906481742859, h = 182.64358520508}},
	["mapBlueOutCoords"] = {{x = 727.22729492188, y = -52.124340057373, z = -6.0906472206116, h = 5.8564867973328}},
	},

	["Patochemap2"] = { -- Dust2 remake -- PLASMAGAME DLC
	["resourceName"] = "patoche_plasmagame_dlc",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,

	["blueCoords"] = 	{x = 74.784973144531, y = -119.52577972412, z = -17.27610874176},
	["redCoords"] = 	{x = 112.1410369873, y = -21.153541564941, z = -24.57123336792},
	
	["blueFlagCoords"] ={x = 116.05665588379, y = -107.01374053955, z = -19.808429718018, h = 358.05819702148},
	["redFlagCoords"] = {x = 85.895530700684, y = -28.812915802002, z = -22.654676437378, h = 180.63604736328},
	["mapRedOutCoords"] = {{x = 118.5997543335, y = -21.150943756104, z = -23.007064819336, h = 270.60363769531}},
	["mapBlueOutCoords"] = {{x = 69.294631958008, y = -120.09935760498, z = -15.805656433105, h = 88.750877380371}},
	},

	["Patochemap3"] = { -- DUST1 remake -- PLASMAGAME DLC
	["resourceName"] = "patoche_plasmagame_dlc",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = false, -- Is Team Death Match available on this map ?
	["Random Weapon"] = false, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = false, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x = 350.2121887207, y = -120.7619934082, z = 22.235120773315},
	["redCoords"] = 	{x = 412.88388061523, y = -9.0091714859009, z = 17.84805679321},
	
	["blueFlagCoords"] ={x = 382.87677001953, y = -113.54433441162, z = 23.514802932739, h = 52.952838897705},
	["redFlagCoords"] = {x = 384.62536621094, y = -6.4026737213135, z = 22.273731231689, h = 93.630226135254},
	["mapRedOutCoords"] = {{x = 412.97286987305, y = -14.521446228027, z = 19.348915100098, h = 182.09194946289}},
	["mapBlueOutCoords"] = {{x = 345.22955322266, y = -120.76171875, z = 23.735120773315, h = 95.426963806152}},
	},

	["Patochemap4"] = { --AZTEC -- PLASMAGAME
	["resourceName"] = "patoche_plasmagame",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,

	["blueCoords"] = 	{x = 675.65295410156, y = 172.72929382324, z = -5.640287399292},
	["redCoords"] = 	{x = 826.62786865234, y = 151.69847106934, z = -5.0124621391296},
	["blueFlagCoords"] ={x = 693.35198974609, y = 180.04196166992, z = -6.4188938140869, h = 292.39993286133},
	["redFlagCoords"] = {x = 804.82305908203, y = 169.37675476074, z = -5.6491899490356, h = 210.43151855469},
	["mapRedOutCoords"] = {{x = 826.42022705078, y = 146.07556152344, z = -3.5465016365051, h = 180.75238037109}},
	["mapBlueOutCoords"] = {{x = 675.73675537109, y = 179.12219238281, z = -4.2321949005127, h = 358.99374389648}},
	},

	["Patochemap5"] = { -- MAP central hole -- PLASMAGAME DLC
	["resourceName"] = "patoche_plasmagame_dlc",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x = 519.92504882813, y = -38.650482177734, z = 21.23295211792},
	["redCoords"] = 	{x = 599.53155517578, y = -46.045372009277, z = 21.449098587036},
	["blueFlagCoords"] ={x = 528.97174072266, y = -28.715986251831, z = 22.919332504272, h = 275.74838256836},
	["redFlagCoords"] = {x = 589.87457275391, y = -56.316993713379, z = 22.919334411621, h = 86.168746948242},
	["mapRedOutCoords"] = {{x = 599.60321044922, y = -51.788963317871, z = 22.919628143311, h = 175.14045715332}},
	["mapBlueOutCoords"] = {{x = 519.64624023438, y = -33.069152832031, z = 22.696926116943, h = 359.39224243164}},
	},

    
	["Patochemap6"] = { -- DLC02 map 6 -- PLASMAGAME DLC 02
	["resourceName"] = "patoche_plasmagame_dlc_02",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x = 42.121936798096, y = 226.25904846191, z = 19.7534868240356},
	["redCoords"] = 	{x = 54.578414916992, y = 281.8798828125, z = 19.7534589767456},
	["blueFlagCoords"] ={x = 41.86, y = 242.61, z = 21.00, h = 271.5817565918},
	["redFlagCoords"] = {x = 55.24, y = 264.89, z = 21.00, h = 111.56325531006},
	["mapRedOutCoords"] = {{x = 60.015254974365, y = 281.79263305664, z = 21.000242233276, h = 271.72247314453}},
	["mapBlueOutCoords"] = {{x = 36.827301025391, y = 226.18185424805, z = 21.000514984131, h = 92.464065551758}},
	},

        
	["Patochemap7"] = { -- DLC02 map 67 -- PLASMAGAME DLC 02
	["resourceName"] = "patoche_plasmagame_dlc_02",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x = -212.49885559082, y = -27.204858779907, z = 19.535011291504},
	["redCoords"] = 	{x = -201.08345031738, y = 27.871784210205, z = 19.534721374512},
	["blueFlagCoords"] ={x = -194.31382751465, y = -17.381534576416, z = 23.800003051758, h = 354.47616577148},
	["redFlagCoords"] = {x = -217.89831542969, y = 17.261335372925, z = 23.800006866455, h = 176.24815368652},
	["mapRedOutCoords"] = {{x = -194.5411529541, y = 27.902280807495, z = 21.000221252441, h = 271.48126220703}},
	["mapBlueOutCoords"] = {{x = -217.79374694824, y = -27.816095352173, z = 21.00050163269, h = 88.133201599121}},
	},

         
	["Patochemap8"] = { -- container map -- PLASMAGAME
	["resourceName"] = "patoche_plasmagame",
	["Available"] = false,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,

	["blueCoords"] = 	{x = 727.38684082031, y = 416.98202514648, z = -7.463135147095},
	["redCoords"] = 	{x = 791.36090087891, y = 437.15896606445, z = -7.463116073608},
	["blueFlagCoords"] ={x = 742.38, y = 423.96, z = -5.9510579109192, h = 1.3461245298386},
	["redFlagCoords"] = {x = 774.07, y = 442.12, z = -5.951060295105, h = 24.58472442627},

	["mapRedOutCoords"] = {{x = 791.72, y = 431.04, z = -6.0905818939209, h = 182.73483276367}},
	["mapBlueOutCoords"] = {{x = 727.37298583984, y = 422.99465942383, z = -6.0905818939209, h = 90.489059448242}},
	},
	
}

PaintBallShop = {
	-- ["PlasmaGame"] = {
	-- 	["Blip"] = {x=-1084.7562255859,y=-1280.9090576172,z=5.6599960327148,sprite=650,scale=0.8,colour=2},
		
	-- 	["Create"] = {{x=-1092.87,y=-1269.56,z=5.85, h=64.02}},
	-- 	["Join"] = 	{
	-- 				{x=-1098.5012207031,y=-1270.7672119141,z=5.8445701599121},
	-- 				{x=-1087.3604736328,y=-1264.7006835938,z=5.8445706367493}
	-- 				},
	-- 	["Out"] = {x=-1095.38,y=-1262.1,z=4.85,h=90.0},
	-- 	["MapAvailable"] = {"Patoche","Patochemap4","Patochemap8"},
		
	
	-- },

	["Lasershooting"] = {
		["Blip"] = {x=-2249.6872558594,y=197.3249206543,z=174.60237121582,h=115.09670257568,sprite=650,scale=0.8,colour=1},
		

		["Create"] = {{x=-2235.82,y=204.54,z=174.85,h=326.47}},
		["Join"] = 	{
					{x=-2236.6467285156,y=210.18165588379,z=174.84729003906,h=23.64063835144},
					{x=-2231.1970214844,y=198.7681427002,z=174.84747314453,h=285.80697631836},
					},
		["Out"] = {x=-2239.7763671875,y=206.87864685059,z=174.84732055664,h=299.00036621094},
		["MapAvailable"] = {"Patoche","Patochemap4","Patochemap8"},
		
	},
	
}

FemaleOutfit = {
[3] = {model = 8, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 98, colorA = 2, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 71, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 8, colorA = 0, colorB = 0},       --Undershirt / T-Shirt
[9] = {model = 0, colorA = 0, colorB = 0},       --Kevlar
[11] = {model = 254, colorA = 2, colorB = 1}     --Tops / Veste
                                                
}                                                
                                                
MaleOutfit = {                              
[3] = {model = 7, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 95, colorA = 2, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 68, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 15, colorA = 0, colorB = 0},      --Undershirt / T-Shirt
[9] = {model = 0, colorA = 0, colorB = 0},       --Kevlar
[11] = {model = 246, colorA = 2, colorB = 1},    --Tops / Veste
}


--Custom Mask :
useCustomMask = true

FemaleMask = {
[1]={model = 107, colorA = 7, colorB = 1},
[2]={model = 108, colorA = 0, colorB = 1}
}

MaleMask = {
[1]={model = 246, colorA = 0, colorB = 1},
[2]={model = 245, colorA = 0, colorB = 1}
}