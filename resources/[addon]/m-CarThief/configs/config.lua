Config = {}

----------------------
-- UTILITY
----------------------
Config.Core = "qb-core" -- Your Core Name
Config.Phone = "qb-phone" -- "qb-phone" , "gksphone" or "qs-smartphone" or "lb-phone"
Config.Target = "qb" -- "qb" or "ox"
Config.TargetName = "qb-target" -- Only change if you use other name on qb
Config.QBMenu = "qb-menu" -- Your QBMenu Name
Config.Cooldown = 900000 -- 15 minutes ( Time to start another mission )
Config.EnablePolice = true	-- Enable police?
Config.ChanceToCallCops = 95 -- The higher the number, the less chance there is.
Config.TimeObtainMission = 5000 -- Time progressbar to obtain mission
Config.Dispatch = 'ps-dispatch' -- "ps-dispatch" or "cd_dispatch" or "qs-dispatch"

Config.Peds = {
    {type = 4, hash= GetHashKey("cs_jimmyboston"), x = -1117.06,  y = -503.05,  z = 34.81, h = 293.18},
    {type = 4, hash= GetHashKey("cs_jimmyboston"), x = 1726.10,  y = -1553.18,  z = 111.70, h = 205},
}

Config.Blip = {
    Enable = true,
    Location = vector3(-1117.06, -503.05, 34.81),
    Sprite = 663,
    Display = 2,
    Scale = 0.6,
    Colour = 44,
    Name = "Polleke",
}


---------------
-- Rewards
---------------
Config.TypeReward = "blackmoney" -- You can put: blackmoney or cash
Config.NameOfBlackMoney = 'geldrol' -- Name of black money.
Config.AmoutBlackMoney = { min = 0, max = 0 } -- Amount of value of blackmoney
Config.AmoutBagsBlackMoney = { min = 500, max = 1700 } -- Amount of bags of blackmoney.
Config.AmoutNormalMoney = { min = 2500, max = 5000 } -- Amount of normal money.

----------------------
-- Targets
----------------------
Config.TargetStartMission = vector3(-1117.06, -503.05, 34.81) -- Start mission
Config.TargetEndMission = vector3(1726.10, -1553.18, 111.70) -- Delivery car

----------------------
-- Spawn points vehicles
----------------------
Config.PossibleSpawnPoints = { -- Possible spawn points for cars
	{	x =	283.24,		y =	-239.8,		z =	53.61,	h =	69.64},
	{	x =	-1269.74,	y =	233.04,		z =	60.82,	h =	99.8},
	{	x =	-1183.65,	y =	-1268.58,	z =	5.84,	h =	26.37},
	{	x =	-903.75,	y =	1087.5,		z =	220.09,	h =	9.45},
	{	x =	-3003.39,	y =	1456.03,	z =	26.83,	h =	331.48}
}
----------------------
-- Vehicles 
----------------------
Config.PossibleVehicles = {	-- Possible models that can spawn
	{ m = "cogcabrio"},
	{ m = "oracle2"},
	{ m = "zion"},
	{ m = "panto"},
	{ m = "felon"},
	{ m = "jackal"},
	{ m = "windsor2"},
	{ m = "f620"},
	{ m = "ruiner"},
	{ m = "virgo2"},
	{ m = "asea"},
	{ m = "exemplar"}
}
