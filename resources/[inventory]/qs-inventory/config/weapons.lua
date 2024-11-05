--[[
    Weapon configuration.
    Here you can configure all the throwable weapons,
    long weapons and more, their durability, their amounts
    of bullets, and even the attachments they will use.
]]

Config.LimitAmmo = false                    -- If you enable this feature, it will only allow one full magazine per weapon
Config.ReloadTime = math.random(4000, 6000) -- Reload progressbar

Config.RemoveTintAfterRemoving = false      -- Remove tint once you remove them from the gun?

-- This will make the durability of weapons down
Config.DurabilityBlockedWeapons = {
    'weapon_stungun',
    'weapon_nightstick',
    'weapon_flashlight',
    'weapon_unarmed',
}

-- Shipable items here
Config.Throwables = {
    'ball',
    'bzgas',
    'flare',
    'grenade',
    'molotov',
    'pipebomb',
    'proxmine',
    'smokegrenade',
    'snowball',
    'stickybomb',
}

-- Durability multiplier, the more the quantity is, the faster it is broken
Config.DurabilityMultiplier = {
    -- Melee
    ['weapon_dagger']                = 0.10,
    ['weapon_bat']                   = 0.10,
    ['weapon_bottle']                = 0.10,
    ['weapon_crowbar']               = 0.10,
    ['weapon_golfclub']              = 0.10,
    ['weapon_hammer']                = 0.10,
    ['weapon_hatchet']               = 0.10,
    ['weapon_knuckle']               = 0.10,
    ['weapon_knife']                 = 0.10,
    ['weapon_machete']               = 0.10,
    ['weapon_switchblade']           = 0.10,
    ['weapon_wrench']                = 0.10,
    ['weapon_battleaxe']             = 0.10,
    ['weapon_poolcue']               = 0.10,
    ['weapon_briefcase']             = 0.10,
    ['weapon_briefcase_02']          = 0.10,
    ['weapon_garbagebag']            = 0.10,
    ['weapon_handcuffs']             = 0.10,
    ['weapon_bread']                 = 0.10,
    ['weapon_stone_hatchet']         = 0.10,

    -- Handguns
    ['weapon_pistol']                = 0.10,
    ['weapon_pistol_mk2']            = 0.10,
    ['weapon_pistolxm3']             = 0.10,
    ['weapon_combatpistol']          = 0.10,
    ['weapon_appistol']              = 0.10,
    ['weapon_pistol50']              = 0.10,
    ['weapon_snspistol']             = 0.10,
    ['weapon_heavypistol']           = 0.10,
    ['weapon_vintagepistol']         = 0.10,
    ['weapon_flaregun']              = 0.10,
    ['weapon_marksmanpistol']        = 0.10,
    ['weapon_revolver']              = 0.10,
    ['weapon_revolver_mk2']          = 0.10,
    ['weapon_doubleaction']          = 0.10,
    ['weapon_snspistol_mk2']         = 0.10,
    ['weapon_raypistol']             = 0.10,
    ['weapon_ceramicpistol']         = 0.10,
    ['weapon_navyrevolver']          = 0.10,
    ['weapon_gadgetpistol']          = 0.10,

    -- Submachine Guns
    ['weapon_microsmg']              = 0.10,
    ['weapon_smg']                   = 0.10,
    ['weapon_smg_mk2']               = 0.10,
    ['weapon_assaultsmg']            = 0.10,
    ['weapon_combatpdw']             = 0.10,
    ['weapon_machinepistol']         = 0.10,
    ['weapon_minismg']               = 0.10,
    ['weapon_raycarbine']            = 0.10,

    -- Shotguns
    ['weapon_pumpshotgun']           = 0.10,
    ['weapon_sawnoffshotgun']        = 0.10,
    ['weapon_assaultshotgun']        = 0.10,
    ['weapon_bullpupshotgun']        = 0.10,
    ['weapon_musket']                = 0.10,
    ['weapon_heavyshotgun']          = 0.10,
    ['weapon_dbshotgun']             = 0.10,
    ['weapon_autoshotgun']           = 0.10,
    ['weapon_pumpshotgun_mk2']       = 0.10,
    ['weapon_combatshotgun']         = 0.10,

    -- Assault Rifles
    ['weapon_assaultrifle']          = 0.10,
    ['weapon_assaultrifle_mk2']      = 0.10,
    ['weapon_carbinerifle']          = 0.10,
    ['weapon_carbinerifle_mk2']      = 0.10,
    ['weapon_tacticalrifle']         = 0.10,
    ['weapon_advancedrifle']         = 0.10,
    ['weapon_specialcarbine']        = 0.10,
    ['weapon_bullpuprifle']          = 0.10,
    ['weapon_compactrifle']          = 0.10,
    ['weapon_specialcarbine_mk2']    = 0.10,
    ['weapon_bullpuprifle_mk2']      = 0.10,
    ['weapon_militaryrifle']         = 0.10,
    ['weapon_heavyrifle']            = 0.10,

    -- Light Machine Guns
    ['weapon_mg']                    = 0.10,
    ['weapon_combatmg']              = 0.10,
    ['weapon_gusenberg']             = 0.10,
    ['weapon_combatmg_mk2']          = 0.10,

    -- Sniper Rifles
    ['weapon_sniperrifle']           = 0.10,
    ['weapon_heavysniper']           = 0.10,
    ['weapon_marksmanrifle']         = 0.10,
    ['weapon_remotesniper']          = 0.10,
    ['weapon_heavysniper_mk2']       = 0.10,
    ['weapon_marksmanrifle_mk2']     = 0.10,

    -- Heavy Weapons
    ['weapon_rpg']                   = 0.10,
    ['weapon_grenadelauncher']       = 0.10,
    ['weapon_grenadelauncher_smoke'] = 0.10,
    ['weapon_emplauncher']           = 0.10,
    ['weapon_minigun']               = 0.10,
    ['weapon_firework']              = 0.10,
    ['weapon_railgun']               = 0.10,
    ['weapon_hominglauncher']        = 0.10,
    ['weapon_compactlauncher']       = 0.10,
    ['weapon_rayminigun']            = 0.10,

    -- Throwables
    ['weapon_grenade']               = 0.10,
    ['weapon_bzgas']                 = 0.10,
    ['weapon_molotov']               = 0.10,
    ['weapon_stickybomb']            = 0.10,
    ['weapon_proxmine']              = 0.10,
    ['weapon_snowball']              = 0.10,
    ['weapon_pipebomb']              = 0.10,
    ['weapon_ball']                  = 0.10,
    ['weapon_smokegrenade']          = 0.10,
    ['weapon_flare']                 = 0.10,

    -- Miscellaneous
    ['weapon_petrolcan']             = 0.10,
    ['weapon_fireextinguisher']      = 0.10,
    ['weapon_hazardcan']             = 0.10,
    ['weapon_fertilizercan']         = 0.10,

    -- Custom Weapons NoobySloth (it is possible that some weapon is broken)
    -- ref: https://github.com/NoobySloth/Custom-Weapons
    ['weapon_ak47']                  = 0.15,
    ['weapon_de']                    = 0.15,
    ['weapon_fnx45']                 = 0.15,
    ['weapon_glock17']               = 0.15,
    ['weapon_m4']                    = 0.15,
    ['weapon_hk416']                 = 0.15,
    ['weapon_mk14']                  = 0.15,
    ['weapon_m110']                  = 0.15,
    ['weapon_huntingrifle']          = 0.20,
    ['weapon_ar15']                  = 0.15,
    ['weapon_m9']                    = 0.15,
    ['weapon_m70']                   = 0.15,
    ['weapon_m1911']                 = 0.15,
    ['weapon_mac10']                 = 0.15,
    ['weapon_uzi']                   = 0.15,
    ['weapon_mp9']                   = 0.15,
    ['weapon_mossberg']              = 0.15,
    ['weapon_remington']             = 0.15,
    ['weapon_scarh']                 = 0.15,
    ['weapon_shiv']                  = 0.15,
    ['weapon_katana']                = 0.15,
    ['weapon_sledgehammer']          = 0.15,
    ['weapon_mp5']                   = 0.15,
    ['weapon_glock18c']              = 0.15,
    ['weapon_glock22']               = 0.15,
    ['weapon_aks74']                 = 0.15,
    ['weapon_ak74']                  = 0.15,
}

-- Repair coordinates, add the ones you want
Config.WeaponRepairPoints = {
    [1] = {
        coords = vector3(485.38, -3383.51, 6.07),
        IsRepairing = false,
        RepairingData = {},
    }
}

-- Price for repair of each type of weapon
Config.WeaponRepairCosts = {
    ['pistol'] = 15000,
    ['smg'] = 25000,
    ['mg'] = 4000,
    ['rifle'] = 45000,
    ['sniper'] = 7000,
    ['shotgun'] = 6000
}

--[[
    System to steal weapons and return random items, this system
    is open code on your server/custom/misc/SetInventoryData.lua,
    you can edit it to your liking, but here is the basic configuration!
]]

Config.CanStealWeaponParts = false
Config.WeaponPartStealChance = 20 -- 1 to 100 (percentage)
Config.AvailableWeaponParts = {
    'lockpick',
    'screwdriverset',
    'electronickit',
    'radioscanner',
    'gatecrack',
    'handcuffs',
    'repairkit',
    'pistol_ammo',
    'ironoxide',
    'aluminumoxide',
    'armor',
    'drill'
    -- Add here more names of items according to your needs
}

--[[
    Configuration of weapon accessories.
    Please read each line slowly and refer to the following
    website: https://wiki.rage.mp/index.php?title=Weapons_Components
]]

Config.Tints = {
    ['black_weapontint'] = {
        component = 'black_weapontint',
        label = 'Black Tint',
        item = 'black_weapontint',
        tint = 0,
    },
    ['green_weapontint'] = {
        component = 'green_weapontint',
        label = 'Green Tint',
        item = 'green_weapontint',
        tint = 1,
    },
    ['gold_weapontint'] = {
        component = 'gold_weapontint',
        label = 'Gold Tint',
        item = 'gold_weapontint',
        tint = 2,
    },
    ['pink_weapontint'] = {
        component = 'pink_weapontint',
        label = 'Pink Tint',
        item = 'pink_weapontint',
        tint = 3,
    },
    ['army_weapontint'] = {
        component = 'army_weapontint',
        label = 'Army Tint',
        item = 'army_weapontint',
        tint = 4,
    },
    ['lspd_weapontint'] = {
        component = 'lspd_weapontint',
        label = 'LSPD Tint',
        item = 'lspd_weapontint',
        tint = 5,
    },
    ['orange_weapontint'] = {
        component = 'orange_weapontint',
        label = 'Orange Tint',
        item = 'orange_weapontint',
        tint = 6,
    },
    ['plat_weapontint'] = {
        component = 'plat_weapontint',
        label = 'Platinum Tint',
        item = 'plat_weapontint',
        tint = 7,
    },
    ['url_weapontint'] = {
        component = 'url_weapontint',
        label = 'Custom Tint',
        item = 'url_weapontint',
        tint = 7,
        isUrl = true,
    },
}

Config.WeaponAttachments = {
    -- PISTOLS
    ['WEAPON_PISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_PISTOL_CLIP_01',
            item = 'pistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_PISTOL_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP_02',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_PISTOL_VARMOD_LUXE',
            item = 'pistol_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_COMBATPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMBATPISTOL_CLIP_01',
            item = 'combatpistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMBATPISTOL_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER',
            item = 'combatpistol_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_APPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_APPISTOL_CLIP_01',
            item = 'appistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_APPISTOL_CLIP_02',
            item = 'appistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_APPISTOL_VARMOD_LUXE',
            item = 'appistol_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_PISTOL50'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_PISTOL50_CLIP_01',
            item = 'pistol50_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_PISTOL50_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_PISTOL50_VARMOD_LUXE',
            item = 'pistol50_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_REVOLVER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_REVOLVER_CLIP_01',
            item = 'revolver_defaultclip',
        },
        ['vipvariant'] = {
            component = 'COMPONENT_REVOLVER_VARMOD_GOON',
            item = 'revolver_vipvariant',
            type = 'skin',
        },
        ['bodyguardvariant'] = {
            component = 'COMPONENT_REVOLVER_VARMOD_BOSS',
            item = 'revolver_bodyguardvariant',
            type = 'skin',
        },
    },
    ['WEAPON_SNSPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SNSPISTOL_CLIP_01',
            item = 'snspistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SNSPISTOL_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['grip'] = {
            component = 'COMPONENT_SNSPISTOL_VARMOD_LOWRIDER',
            item = 'snspistol_grip',
        },
    },
    ['WEAPON_HEAVYPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYPISTOL_CLIP_01',
            item = 'heavypistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYPISTOL_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_HEAVYPISTOL_VARMOD_LUXE',
            item = 'heavypistol_grip',
        },
    },
    ['WEAPON_VINTAGEPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_VINTAGEPISTOL_CLIP_01',
            item = 'vintagepistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_VINTAGEPISTOL_CLIP_02',
            item = 'vintagepistol_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
            type = 'silencer',
        },
    },
    -- SMG'S
    ['WEAPON_MICROSMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_01',
            item = 'microsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_02',
            item = 'microsmg_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_MICROSMG_VARMOD_LUXE',
            item = 'microsmg_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_SMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SMG_CLIP_01',
            item = 'smg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SMG_CLIP_02',
            item = 'smg_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_SMG_CLIP_03',
            item = 'smg_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO_02',
            item = 'smg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_SMG_VARMOD_LUXE',
            item = 'smg_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_ASSAULTSMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTSMG_CLIP_01',
            item = 'assaultsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTSMG_CLIP_02',
            item = 'assaultsmg_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER',
            item = 'assaultsmg_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_MINISMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MINISMG_CLIP_01',
            item = 'minismg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MINISMG_CLIP_02',
            item = 'minismg_extendedclip',
            type = 'clip',
        },
    },
    ['WEAPON_MACHINEPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_01',
            item = 'machinepistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_02',
            item = 'machinepistol_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_03',
            item = 'machinepistol_drum',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_COMBATPDW'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_01',
            item = 'combatpdw_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_02',
            item = 'combatpdw_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_03',
            item = 'combatpdw_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'combatpdw_grip',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
    },
    -- SHOTGUNS
    ['WEAPON_PUMPSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_SR_SUPP',
            item = 'shotgun_suppressor',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER',
            item = 'pumpshotgun_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_SAWNOFFSHOTGUN'] = {
        ['luxuryfinish'] = {
            component = 'COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE',
            item = 'sawnoffshotgun_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_ASSAULTSHOTGUN'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTSHOTGUN_CLIP_01',
            item = 'assaultshotgun_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTSHOTGUN_CLIP_02',
            item = 'assaultshotgun_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_BULLPUPSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_HEAVYSHOTGUN'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_01',
            item = 'heavyshotgun_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_02',
            item = 'heavyshotgun_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_03',
            item = 'heavyshotgun_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_COMBATSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
    },
    -- RIFLES
    ['WEAPON_ASSAULTRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_01',
            item = 'assaultrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_02',
            item = 'assaultrifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_03',
            item = 'assaultrifle_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_ASSAULTRIFLE_VARMOD_LUXE',
            item = 'assaultrifle_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_CARBINERIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_01',
            item = 'carbinerifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_02',
            item = 'carbinerifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_03',
            item = 'carbinerifle_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_CARBINERIFLE_VARMOD_LUXE',
            item = 'carbinerifle_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_ADVANCEDRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ADVANCEDRIFLE_CLIP_01',
            item = 'advancedrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ADVANCEDRIFLE_CLIP_02',
            item = 'advancedrifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE',
            item = 'advancedrifle_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_SPECIALCARBINE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_01',
            item = 'specialcarbine_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_02',
            item = 'specialcarbine_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_03',
            item = 'specialcarbine_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER',
            item = 'specialcarbine_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_BULLPUPRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_BULLPUPRIFLE_CLIP_01',
            item = 'bullpuprifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_BULLPUPRIFLE_CLIP_02',
            item = 'bullpuprifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_BULLPUPRIFLE_VARMOD_LOW',
            item = 'bullpuprifle_luxuryfinish',
            type = 'tint',
        },
    },
    ['WEAPON_COMPACTRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_01',
            item = 'compactrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_02',
            item = 'compactrifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_03',
            item = 'compactrifle_drum',
            type = 'clip',
        },
    },
    ['WEAPON_HEAVYRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYRIFLE_CLIP_01',
            item = 'bullpuprifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYRIFLE_CLIP_02',
            item = 'bullpuprifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_BULLPUPRIFLE_VARMOD_LOW',
            item = 'bullpuprifle_luxuryfinish',
            type = 'tint',
        },
    },
    -- MACHINE GUNS
    ['WEAPON_GUSENBERG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_GUSENBERG_CLIP_01',
            item = 'gusenberg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_GUSENBERG_CLIP_02',
            item = 'gusenberg_extendedclip',
            type = 'clip',
        },
    },
    -- LAUNCHERS
    ['WEAPON_EMPLAUNCHER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_EMPLAUNCHER_CLIP_01',
            item = 'emplauncher_defaultclip',
            type = 'clip',
        },
    },
    -- SNIPERS
    ['WEAPON_SNIPERRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SNIPERRIFLE_CLIP_01',
            item = 'sniperrifle_defaultclip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE',
            item = 'sniper_scope',
            type = 'scope',
        },
        ['advancedscope'] = {
            component = 'COMPONENT_AT_SCOPE_MAX',
            item = 'snipermax_scope',
            type = 'scope',
        },
    },
    ['WEAPON_HEAVYSNIPER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYSNIPER_CLIP_01',
            item = 'heavysniper_defaultclip',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE',
            item = 'sniper_scope',
            type = 'scope',
        },
        ['advancedscope'] = {
            component = 'COMPONENT_AT_SCOPE_MAX',
            item = 'snipermax_scope',
            type = 'scope',
        },
    },
    ['WEAPON_MARKSMANRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MARKSMANRIFLE_CLIP_01',
            item = 'marksmanrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MARKSMANRIFLE_CLIP_02',
            item = 'marksmanrifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM',
            item = 'marksmanrifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
        ['luxuryfinish'] = {
            component = 'COMPONENT_MARKSMANRIFLE_VARMOD_LUXE',
            item = 'marksmanrifle_luxuryfinish',
            type = 'tint',
        },
    },

    -- Custom Weapons NoobySloth (it is possible that some weapon is broken)
    -- ref: https://github.com/NoobySloth/Custom-Weapons
    ['WEAPON_M9'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_M9_CLIP_01',
            item = 'pistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_M9_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_M1911'] = {
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_DE'] = {
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_FNX45'] = {
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_MP9'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MP9_CLIP_01',
            item = 'microsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MP9_CLIP_02',
            item = 'microsmg_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'pistol_suppressor',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
    },
    ['WEAPON_UZI'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_01',
            item = 'microsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_02',
            item = 'microsmg_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_MAC10'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_01',
            item = 'microsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_02',
            item = 'microsmg_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_AK47'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_AK47_CLIP_01',
            item = 'assaultrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_AK47_CLIP_02',
            item = 'assaultrifle_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'rifle_suppressor',
        },
    },
    ['WEAPON_M70'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_M70_CLIP_01',
            item = 'assaultrifle_defaultclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'rifle_suppressor',
        },
    },
    ['WEAPON_M110'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_M110_CLIP_01',
            item = 'marksmanrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_M110_CLIP_02',
            item = 'marksmanrifle_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
    },
    ['WEAPON_HK416'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HK416_CLIP_01',
            item = 'carbinerifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HK416_CLIP_02',
            item = 'carbinerifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
    },
}

-- Add the hash of the weapons you want to have url_weapontint
Config.WeaponTints = {
    [1] = { name = 'Pistol', hash = '453432689', ytd = 'w_pi_pistol', texture = 'w_pi_pistol' },
    [2] = { name = 'PistolMK2', hash = '3219281620', ytd = 'w_pi_pistolmk2', texture = 'w_pi_pistolmk2' },
    [3] = { name = 'Combat Pistol', hash = '1593441988', ytd = 'w_pi_combatpistol', texture = 'w_pi_combatpistol' },
    [4] = { name = 'Pistol50', hash = '-1716589765', ytd = 'w_pi_pistol50', texture = 'w_pl_pistol50' },
    [5] = { name = 'SNSPistol', hash = '-1076751822', ytd = 'w_pi_sns_pistol', texture = 'w_pi_sns_pistol' },
    [6] = { name = 'HeavyPistol', hash = '-771403250', ytd = 'w_pi_heavypistol', texture = 'w_pi_heavypistol' },
    [7] = { name = 'VintagePistol', hash = '137902532', ytd = 'w_pi_vintage_pistol', texture = 'w_pi_vintage_pistol' },
    [8] = { name = 'MarksmanPistol', hash = '-598887786', ytd = 'w_pi_singleshot', texture = 'w_pi_singleshot_dm' },
    [9] = { name = 'Revolver', hash = '-1045183535', ytd = 'w_pi_revolver', texture = 'w_pi_revolver' },
    [10] = { name = 'StunGun', hash = '911657153', ytd = 'w_pi_stungun', texture = 'w_pi_stungun' },
    [11] = { name = 'MicroSMG', hash = '324215364', ytd = 'w_sb_microsmg', texture = 'w_sb_microsmg' },
    [12] = { name = 'MachinePistol', hash = '-619010992', ytd = 'w_sb_compactsmg', texture = 'w_sb_compactsmg' },
    [13] = { name = 'SMG', hash = '736523883', ytd = 'w_sb_smg', texture = 'w_sb_smg' },
    [14] = { name = 'SMGMk2', hash = '2024373456', ytd = 'w_sb_smgmk2', texture = 'w_sb_smgmk2' },
    [15] = { name = 'AssaultSMG', hash = '-270015777', ytd = 'w_sb_assaultsmg', texture = 'w_sb_assaultsmg' },
    [16] = { name = 'CombatPDW', hash = '171789620', ytd = 'w_sb_pdw', texture = 'w_sb_pdw' },
    [17] = { name = 'MG', hash = '-1660422300', ytd = 'w_mg_mg', texture = 'w_mg_mg' },
    [18] = { name = 'CombatMG', hash = '2144741730', ytd = 'w_mg_combatmg', texture = 'w_mg_combatmg_tint' },
    [19] = { name = 'CombatMGMk2', hash = '3686625920', ytd = 'w_mg_combatmgmk2', texture = 'w_mg_combatmgmk2_l1' },
    [20] = { name = 'Gusenberg', hash = '1627465347', ytd = 'w_sb_gusenberg', texture = 'w_sb_gusenberg' },
    [21] = { name = 'MiniSMG', hash = '-1121678507', ytd = 'w_sb_minismg', texture = 'w_sb_minismg_dm' },
    [22] = { name = 'AssaultRifle', hash = '-1074790547', ytd = 'w_ar_assaultrifle', texture = 'w_ar_assaultrifle' },
    [23] = { name = 'AssaultRifleMk2', hash = '961495388', ytd = 'w_ar_assaultriflemk2', texture = 'w_ar_assaultriflemk2' },
    [24] = { name = 'CarbineRifle', hash = '-2084633992', ytd = 'w_ar_carbinerifle', texture = 'w_ar_carbinerifle' },
    [25] = { name = 'CarbineRifleMk2', hash = '-86904375', ytd = 'w_ar_carbineriflemk2', texture = 'w_ar_carbineriflemk2' },
    [26] = { name = 'SpecialCarbine', hash = '-1063057011', ytd = 'w_ar_specialcarbine', texture = 'w_ar_specialcarbine_tint' },
    [27] = { name = 'BullpupRifle', hash = '2132975508', ytd = 'w_ar_bullpuprifle', texture = 'w_ar_bullpuprifle' },
    [28] = { name = 'CompactRifle', hash = '1649403952', ytd = 'w_ar_assaultrifle_smg', texture = 'w_ar_assaultrifle_smg_d' },
    [29] = { name = 'SniperRifle', hash = '100416529', ytd = 'w_sr_sniperrifle', texture = 'w_sr_sniperrifle' },
    [30] = { name = 'HeavySniper', hash = '205991906', ytd = 'w_sr_heavysniper', texture = 'w_sr_heavysniper' },
    [31] = { name = 'HeavySniperMk2', hash = '177293209', ytd = 'w_sr_heavysnipermk2', texture = 'w_sr_heavysnipermk2' },
    [32] = { name = 'MarksmanRifle', hash = '-952879014', ytd = 'w_sr_marksmanrifle', texture = 'w_sr_marksmanrifle' },
    [33] = { name = 'PumpShotgun', hash = '487013001', ytd = 'w_sg_pumpshotgun', texture = 'w_sg_pumpshotgun' },
    [34] = { name = 'SawnoffShotgun', hash = '2017895192', ytd = 'w_sg_sawnoff', texture = 'w_sg_sawnoff' },
    [35] = { name = 'BullpupShotgun', hash = '-1654528753', ytd = 'w_sg_bullpupshotgun', texture = 'w_sg_bullpupshotgun' },
    [36] = { name = 'AssaultShotgun', hash = '-494615257', ytd = 'w_sg_assaultshotgun', texture = 'w_sg_assaultshotgun' },
    [37] = { name = 'Musket', hash = '-1466123874', ytd = 'w_ar_musket', texture = 'w_ar_musket_d' },
    [38] = { name = 'DoubleBarrelShotgun', hash = '-275439685', ytd = 'w_sg_doublebarrel', texture = 'w_sg_doublebarrel_dm' },
    [39] = { name = 'APPistol', hash = '584646201', ytd = 'w_pi_appistol', texture = 'w_pi_appistol' },
    [40] = { name = 'AdvancedRifle', hash = '-1357824103', ytd = 'w_ar_advancedrifle', texture = 'w_ar_advancedrifle' }
}

for k, v in pairs(Config.WeaponAttachments) do
    for a, x in pairs(Config.Tints) do
        Config.WeaponAttachments[k][a] = x
    end
end

function getConfigWeaponTints()
    return Config.Tints
end

exports('getConfigWeaponTints', getConfigWeaponTints)

RegisterNetEvent('qb-weapons:getWeaponsAttachments', function(cb)
    cb(Config.WeaponAttachments)
end)

exports('GetWeaponTints', function()
    return Config.WeaponTints
end)
