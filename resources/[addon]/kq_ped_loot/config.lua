Config = {}

Config.debug = false

-------------------------------------------------
--- FRAMEWORK SETTINGS
-------------------------------------------------
Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,

    -- Enable this if you're using a very old version of ESX
    oldEsx = false,

    moneyAccount = 'black_money',
}

Config.qbSettings = {
    enabled = true,

    moneyAccount = 'cash',
}

Config.target = {
    enabled = false,
    system = 'qb-target' -- 'qtarget' or 'qb-target' or 'ox_target'  (Other systems might work as well)
}

-- When not using target
-- '3d-text', 'top-left', 'help-text'
Config.inputType = '3d-text'

-- Font used for the 3d text
Config.textFont = 4

-- Scale used for the 3d text
Config.textScale = 1.0


-----------------------------
--- LOOT SETTINGS
-----------------------------
-- Duration for which the loot will be available on the ground after killing the ped
-- Time in seconds
Config.lootLifespan = 90

Config.dropOnRagdoll = {
    -- When true, peds will drop their loot when ragdoll
    -- When false, peds will only drop their loot when dead
    enabled = true,

    -- Chance of dropping loot when ragdolling (instead of death) (0 - 100)
    chance = 50,
}



-----------------------------
--- PICKUP OPTIONS
-----------------------------
-- Max pickup distance
Config.pickupDistance = 1.4

-- Keybinds. Only when not using targeting
Config.keybinds = {
    pickup = {
        label = 'E',
        input = 38,
    }
}

Config.animation = {
    duration = 1,
    dict = 'mp_take_money_mg',
    anim = 'put_cash_into_bag_loop',
    flag = 1,

    -- Whether the prop should get attached to the hand on pickup
    holdProp = true,
}

-- Outline of the items
Config.outline = {
    enabled = true,
    color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255,
    }
}

-----------------------------
--- GLOBAL LOOT
-----------------------------
-- Loot which can be dropped by all human peds
Config.globalLoot = {
    ['nothing'] = {
        chance = 20,
    },
    ['wallet'] = {
        chance = 20,
        money = {
            min = 2,
            max = 25,
        },
        props = {
            'prop_ld_wallet_pickup',
            'prop_ld_wallet_01',
            'prop_ld_wallet_02',
            'prop_ld_purse_01',
        },
    },
    ['iphone'] = {
        chance = 10,
        item = {
            name = 'iphone',
        },
        props = {
            'p_amb_phone_01',
            'prop_amb_phone',
        },
    },
    ['lockpick'] = {
        chance = 10,
        item = {
            name = 'lockpick',
        },
        props = {
            'prop_paper_bag_small',
        },
    },
    ['weed'] = {
        chance = 5, 
        item = {
            name = 'weed_ak47',
            min = 1,
            max = 2,
        },
        props = {
            'prop_weed_block_01',
        },
    },
    ['coke'] = {
        chance = 5,
        item = {
            name = 'cokebaggy',
            min = 1,
            max = 2,
        },
        props = {
            'xm3_prop_xm3_bag_coke_01a',
        },
    },
    ['meth'] = {
        chance = 5,
        item = {
            name = 'meth',
            min = 1,
            max = 2,
        },
        props = {
            'bkr_prop_meth_smallbag_01a',
        },
    },
    ['beats'] = {
        chance = 10,
        item = {
            name = 'beats',
            min = 1,
            max = 1,
        },
        props = {
            'sf_prop_sf_headphones_dj',
        },
    },
    ['geldrol'] = {
        chance = 25,
        item = {
            name = 'geldrol',
            min = 50,
            max = 70,
        },
        props = {
            'bkr_prop_bkr_cash_roll_01',
        },
    },
}

-----------------------------
--- LOOT PER TYPE
-----------------------------

-- See constants.lua for the full list of types
Config.lootPerType = {
    ['gangs'] = {
        types = {
            PED_TYPE_GANG_ALBANIAN,
            PED_TYPE_GANG_BIKER_1,
            PED_TYPE_GANG_BIKER_2,
            PED_TYPE_GANG_ITALIAN,
            PED_TYPE_GANG_RUSSIAN,
            PED_TYPE_GANG_RUSSIAN_2,
            PED_TYPE_GANG_IRISH,
            PED_TYPE_GANG_JAMAICAN,
            PED_TYPE_GANG_AFRICAN_AMERICAN,
            PED_TYPE_GANG_KOREAN,
            PED_TYPE_GANG_CHINESE_JAPANESE,
            PED_TYPE_GANG_PUERTO_RICAN,
            PED_TYPE_DEALER,
        },
        loot = {
            ['nothing'] = {
                chance = 70,
            },
            ['cash'] = {
                chance = 10,
                money = {
                    min = 5,
                    max = 50,
                },
                props = {
                    'bkr_prop_moneypack_01a',
                    'bkr_prop_money_unsorted_01',
                    'bkr_prop_money_wrapped_01',
                },
            },
            ['coke'] = {
                chance = 5,
                item = {
                    name = 'coke',
                    min = 1,
                    max = 2,
                },
                props = {
                    'imp_prop_impexp_coke_pile',
                },
            },
            ['weed'] = {
                chance = 15,
                item = {
                    name = 'marijuana',
                    min = 1,
                    max = 3,
                },
                props = {
                    'prop_weed_block_01',
                },
            }
        },
    },
    ['animals'] = {
        types = {
            PED_TYPE_ANIMAL,
        },
        loot = {
            ['nothing'] = {
                chance = 30,
            },
            ['meat'] = {
                amount = {
                    min = 1,
                    max = 3,
                },
                chance = 70,
                item = {
                    name = 'steak',
                },
                props = {
                    'prop_cs_steak',
                },
            },
        },
    },
}

-----------------------------
--- LOOT PER PED MODEL
-----------------------------

-- Ped models list: https://docs.fivem.net/docs/game-references/ped-models/
Config.lootPerModel = {
    ['fancy'] = {
        models = {
            'a_f_y_bevhills_01',
            'a_f_y_bevhills_02',
            'a_f_y_bevhills_03',
            'a_f_y_bevhills_04',
            'a_f_y_business_01',
            'a_f_y_business_02',
            'a_f_y_business_03',
            'a_f_y_business_04',
            'a_m_m_bevhills_01',
            'a_m_m_bevhills_02',
            'a_m_m_business_01',
            'a_m_y_busicas_01',
            'a_m_y_business_01',
            'a_m_y_business_02',
            'a_m_y_business_03',
            'a_m_y_hasjew_01',
            'a_m_y_stbla_02',
            'a_m_y_smartcaspat_01',
        },
        loot = {
            ['nothing'] = {
                chance = 50,
            },
            ['briefcase'] = {
                chance = 10,
                item = {
                    name = 'secret_documents',
                    -- When no min and max values are specified. It will always be just one item
                },
                props = {
                    'prop_ld_case_01',
                    --'prop_ld_suitcase_01',
                },
            },
            ['money_briefcase'] = {
                chance = 1500000,
                money = {
                    min = 120,
                    max = 350,
                },
                props = {
                    'prop_ld_case_01',
                    'prop_ld_suitcase_01',
                },
            },
            ['rich wallet'] = {
                chance = 25,
                money = {
                    min = 100,
                    max = 200,
                },
                props = {
                    'prop_ld_wallet_pickup',
                    'prop_ld_wallet_01',
                    'prop_ld_wallet_02',
                    'prop_ld_purse_01',
                },
            }
        },
    },
    ['zombie'] = {
        models = {
            'u_m_y_zombie_01',
        },
        loot = {
            ['meat'] = {
                chance = 100,
                amount = {
                    min = 2,
                    max = 5,
                },
                item = {
                    name = 'steak',
                },
                props = {
                    'prop_cs_steak',
                },
            },
        },
    },
}
