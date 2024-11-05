Config = {}

Config.Job = true -- If false, everyone can do ALL. Buy blueprints, get pieces, craft weapons etc
Config.Prefix = "m-Ammunation" -- If you want duplicate the resource, change this to other name to change the events
Config.Settings = {
    Core = "qb-core", -- Your folder qb-core
    Menu = "qb-menu", -- Your folder qb-menu
    Target = "qb-target", -- Your folder qb-target
    Phone = "qs-smartphone", --- @param Available: "qb-phone" / "qs-smartphone"  / "gksphone" / "roadphone" / "d-phone" / "renewed-phone" / "jpr-phone" or "notify"
    Webhook = "", -- Your webhook link
    Job = "wapendealer", -- Job needed to work on ammunation
    Inventory = "qs-inventory/html/images/", -- Your directory images of your inventory
    JimPayments = true, -- Use jim-payments?
    Debug = false, -- Enable some prints and polyzones?
}

Config.Peds = {
    [1] = { type = 4, hash = GetHashKey("s_m_y_ammucity_01"), x = 1109.79,  y = -2325.65,  z = 30.39, h = 178.32},
    -- [2] = { type = 4, hash = GetHashKey("s_m_y_ammucity_01"), x = 818.40,  y = -2156.78,  z = 28.62, h = 46.58},
}

Config.Pieces = {
    MaxCollect = 5, -- 5 Times player can collect random pieces
    Time = 5000, -- Time of progressbar
    animDict = "mini@repair", -- animDict of collecting progressbar
    anim = "fixing_a_ped", -- anim of collecting progressbar
    Location = vector3(1221.16, -3005.63, 5.87), -- Location where you get pieces
    PropLocation = vector3(1221.2, -3005.46, 4.87), -- Location where prop spawns
    Prop = `prop_box_wood02a_pu`, -- Prop spawn where you get pieces
    Amount = { min = 30, max = 50 }, -- Min & Max amount receive of list of drops
    Drops = { -- List of drops when goes collect pieces
        "weapon_metal",
        "weapon_pieces",
    }
}

Config.TestingTime = 5 -- 30 Seconds ( 30 x 1000 )
Config.TestWeapons = {
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
	{ coords = vector3(0,0,0), },
}

--- @param AddMoreWeapons | If you gona add more weapons you need add on config_functions too on function: GiveWeapon(option)

Config.WeaponsAvailable = { -- List of weapons available for testing
    "weapon_pistol50",
    "weapon_snspistol",
    "weapon_combatpistol",
    "weapon_heavypistol",
    "weapon_machinepistol",
    "weapon_compactrifle",

    -- You can add more weapons here
}

Config.LevelSystem = {
    Enable = false, -- Enable level system? https://github.com/MrZainRP/mz-skills
    XP_Name = "AmmuNation", -- Name of XP you have on config of mz-skills
    CraftWeapons = { 
        min = 1, -- Min amount of XP earn after crafting a weapon
        max = 3, -- Max amount of XP earn after crafting a weapon
    },
}