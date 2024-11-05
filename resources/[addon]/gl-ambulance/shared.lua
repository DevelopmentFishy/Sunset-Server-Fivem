Config = {}
Config.AllowedStretcherVehicles = {"merc_spr_hvz_kempen"}

Config.UseBeds = false
Config.NancyPos = vector3(0, -0, 0)
Config.NancyCost = 150

Config.BedLocs = {-- Add more Beds here to be Tp'd into when using Nancy
    vector4(309.54, -577.50, 43.3, 339.0),
    vector4(314.03, -579.20, 43.3, 339.0),
    vector4(319.48, -581.13, 43.3, 339.0)
}

-- Config.Guns = {453432689, 3219281620, 1593441988, -1716589765, -1076751822, -771403250, 137902532, -598887786, -1045183535, 584646201, 911657153, 1198879012, 324215364, -619010992, 736523883, 2024373456, -270015777, 171789620, -1660422300, 2144741730, 3686625920, 1627465347, -1121678507, -1074790547, 961495388, -2084633992, 4208062921, -1357824103, -1063057011, 2132975508, 1649403952, 100416529, 205991906, 177293209, -952879014, 487013001, 2017895192, -1654528753, -494615257, -1466123874, 984333226, -275439685, 317205821, -1568386805, -1312131151, 1119849093, 2138347493, 1834241177, 1672152130, 1305664598, 125959754}
-- Config.Melee = {-1569615261, -1716189206, 1737195953, 1317494643, -1786099057, -2067956739, 1141786504, -102323637, -1834847097, -102973651, -656458692, -581044007, -1951375401, -538741184, -1810795771, 419712736, -853065399}
-- Config.Explosions = {-1813897027, 741814745, -1420407917, -1600701090, 615608432, 101631238, 883325847, 1233104067, 600439132, 126349499, -37975472, -1169823560}

Config.Guns = {
    -- Handguns
    `weapon_pistol`,  
    `weapon_pistol_mk2`, 
    `weapon_combatpistol`, 
    `weapon_appistol`, 
    `weapon_stungun`,  
    `weapon_pistol50`,  
    `weapon_snspistol`,  
    `weapon_snspistol_mk2`,  
    `weapon_heavypistol`,  
    `weapon_vintagepistol`,  
    `weapon_flaregun`,  
    `weapon_marksmanpistol`,  
    `weapon_revolver`, 
    `weapon_revolver_mk2`, 
    `weapon_doubleaction`,  
    `weapon_raypistol`, 
    `weapon_ceramicpistol`, 
    `weapon_navyrevolver`, 
    `weapon_gadgetpistol`,  
    --`weapon_stungun_mp`,

    -- Submachine Guns
    `weapon_microsmg`,
    `weapon_smg`, 
    `weapon_smg_mk2`,
    `weapon_assaultsmg`, 
    `weapon_combatpdw`,  
    `weapon_machinepistol`,  
    `weapon_minismg`, 
    `weapon_raycarbine`, 

    -- Shotguns
    `weapon_pumpshotgun`, 
    `weapon_pumpshotgun_mk2`, 
    `weapon_sawnoffshotgun`, 
    `weapon_assaultshotgun`,  
    `weapon_bullpupshotgun`,  
    `weapon_musket`,  
    `weapon_heavyshotgun`,  
    `weapon_dbshotgun`,  
    `weapon_autoshotgun`,
    `weapon_combatshotgun`,

    -- Assault Rifles
    `weapon_assaultrifle`, 
    `weapon_assaultrifle_mk2`, 
    `weapon_carbinerifle`,  
    `weapon_carbinerifle_mk2`,  
    `weapon_advancedrifle`,  
    `weapon_specialcarbine`,  
    `weapon_specialcarbine_mk2`, 
    `weapon_bullpuprifle`,  
    `weapon_bullpuprifle_mk2`, 
    `weapon_compactrifle`,  
    `weapon_militaryrifle`, 
    `weapon_heavyrifle`,

    -- Light Machine Guns
    `weapon_mg`, 
    `weapon_combatmg`,  
    `weapon_combatmg_mk2`,  
    `weapon_gusenberg`,

    -- Sniper Rifles
    `weapon_sniperrifle`, 
    `weapon_heavysniper`,
    `weapon_heavysniper_mk2`,
    `weapon_marksmanrifle`,
    `weapon_marksmanrifle_mk2`,
    `weapon_remotesniper`,

    -- Heavy Weapons
    -- `weapon_rpg`,
    -- `weapon_grenadelauncher`,
    -- `weapon_grenadelauncher_smoke`,
    -- `weapon_minigun`, 
    -- `weapon_firework`, 
    -- `weapon_railgun`, 
    -- `weapon_hominglauncher`,
    -- `weapon_compactlauncher`,
    -- `weapon_rayminigun`,
    -- `weapon_emplauncher`,
}

Config.Melee = {
    `weapon_unarmed`,
    `weapon_dagger`,
    `weapon_bat`,
    `weapon_bottle`,
    `weapon_crowbar`,
    `weapon_flashlight`,
    `weapon_golfclub`,
    `weapon_hammer`,
    `weapon_hatchet`,
    `weapon_knuckle`,
    `weapon_knife`,
    `weapon_machete`,
    `weapon_switchblade`,
    `weapon_nightstick`,
    `weapon_wrench`,
    `weapon_battleaxe`,
    `weapon_poolcue`,
    `weapon_briefcase`,
    `weapon_briefcase_02`,
    `weapon_garbagebag`,
    `weapon_handcuffs`,
    `weapon_bread`,
    `weapon_stone_hatchet`,
}

Config.Explosions = {
    `weapon_grenade`,
    `weapon_stickybomb`,
    `weapon_proxmine`,
    `weapon_bzgas`,
    `weapon_molotov`,
    `weapon_fireextinguisher`,
    `weapon_petrolcan`,
    `weapon_flare`,
    `weapon_smokegrenade`,
    `weapon_pipebomb`,
    `weapon_fire`,
    `weapon_explosion`,
}

Config.Grandmas = true -- A Blackmarket place for crims to revive
Config.GrandmasCost = 1500
Config.GrandmaCoords = vector3(509.01, 3099.71, 41.31)
