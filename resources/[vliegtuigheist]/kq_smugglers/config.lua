Config = {}

Config.debug = false


-------------------------------------------------
--- FRAMEWORK SETTINGS
-------------------------------------------------
Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,

    -- Money account used when picking up cash or selling off items
    moneyAccount = 'black_money',
}

Config.qbSettings = {
    enabled = true,
    -- Whether or not to use the new QBCore export method
    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it

    -- Money account used when picking up cash or selling off items
    moneyAccount = 'cash',
}


-------------------------------------------------
--- BASE SETTINGS
-------------------------------------------------
Config.target = {
    enabled = true,
    system = 'qb-target' -- 'qtarget' or 'qb-target' or 'ox_target'  (Other systems might work as well)
}

-- List of police jobs
Config.policeJobs = {
  'police',
  'lspd',
  'bcso',
}

-- The minimum amount of officers online needed to trigger the heist. If the amount is not met
-- the ATC screen will say that no unmarked planes have been detected
Config.minimumPoliceOnline = 3

Config.items = {
    radioEncoder = 'kq_radio_encoder',
    hint = 'kq_plane_hint',
}

-- Font scale of the ATC monitor. Do not touch unless the text is overflowing on the atc monitor. Unsure why this happens on some servers.
Config.atcFontScale = 1.0

-- Font scale of 3d text
Config.fontScale = 1.0

-- Time in minutes
Config.minimumTimeBetweenHeists = 60

-- Time in minutes, time for which the crashed plane and the loot area will be available for (after this time the plane will be deleted
Config.planeTimeout = 25


-- Duration before the plane actually gets spawned (aka enters the airspace) (in seconds)
Config.flightDuration = 220

-------------------------------------------------
--- KEYBINDS
-------------------------------------------------
-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    interact = {
        label = 'E',
        input = 38,
    },
    exit = {
        label = 'G',
        input = 58,
    },
}


-------------------------------------------------
--- HINT
-------------------------------------------------
Config.hint = {
    enabled = true,  -- Setting to enable the hint feature
    location = {x = 1962.79, y = 3751.1, z = 32.25, h = 304.6},  -- Coordinates for the hint location
    model = 'u_m_o_taphillbilly',  -- NPC model for the hint
    npcScenario = 'WORLD_HUMAN_TOURIST_MAP',  -- NPC scenario for the hint
    -- price of the hint
    price = 2000,  -- Price for the hint

    npcShouting = false,  -- Setting for whether the NPC should shout random stuff when the player is nearby
    blip = {
        alwaysShowBlip = false,  -- Setting to always show the hint blip on the map
        showWhenNearby = false,  -- Setting to show the hint blip on the map when the player is nearby
        nearbyDistance = 50.0,  -- Distance at which the hint blip should appear when the player is nearby

        -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 66,  -- Sprite for the hint blip
        color = 6,  -- Color for the hint blip
        scale = 0.7  -- Scale for the hint blip
    },

    playerScenario = {
        enabled = true,  -- Setting to enable the player scenario for the hint
        scenario = 'WORLD_HUMAN_CLIPBOARD'  -- Player scenario for the hint
    },
}


-------------------------------------------------
--- ATC
-------------------------------------------------
-- Rerolls odds of the plane being available every 5 minutes (When planes are unavailable heist will not be possible to be started)
-- Value between 0 and 100 (0 heist will never be available, 100 heist will always be available)
Config.planeFoundOdds = 100

-- Time for which the ATC scanner data will be valid for. This is the time players will have to scan, drive to the radio tower and enter the IP address to hack the plane.
-- After this time, the IP will no longer be valid. Set this to a lower value to require players to have a friend waiting at the radio tower ready to hack the IP. Higher values mean
-- that players can drive from the ATC tower to a radio tower and hack it themselves if they're quick enough (default = 90, allows for solo hack if they're decently quick).
-- Time in seconds.
Config.atcScanLifetime = 90

Config.atc = {
    location = {
        x = 1701.6, y = 3289.7, z = 48.9  -- Coordinates for the ATC location
    },
    blips = {
        alwaysShowBlips = false,  -- Setting to always show the ATC blips on the map
        showBlipsAfterHintUse = true,  -- Setting to show the ATC blips on the map after hint use

        -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 767,  -- Sprite for the ATC blips
        color = 67,  -- Color for the ATC blips
        scale = 0.9  -- Scale for the ATC blips
    },
    -- <!> BEWARE <!> Changing the password will not change it on the hint, you may want to communicate the new
    -- password to your players somehow or update the hint file in html/img/hint.png
    password = 'plane',  -- Password for the ATC
}


-------------------------------------------------
--- RADIO TOWERS
-------------------------------------------------
Config.radio = {
    model = 'xm_prop_x17_powerbox_01',  -- Model for the radio
    encoderModel = 'v_res_fa_radioalrm',  -- Model for the encoder
    locations = {
        {x = 747.79, y = 2576.5, z = 75.0, h = 153.07},
        {x = 1000.274, y = 3582.9, z = 33.3, h = 179.0},
        {x = 1868.84, y = 3714.43, z = 32.7, h = 210.0},
        {x = 2327.0, y = 2948.927, z = 46.8, h = 1.0},
        {x = 751.89, y = 1275.605, z = 359.9, h = 180.0},
    },
    blips = {
        alwaysShowBlips = false,  -- Setting to always show the radio blips on the map
        showBlipsAfterATCUse = true,  -- Setting to show the radio blips on the map after ATC use

        -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 767,  -- Sprite for the radio blips
        color = 6,  -- Color for the radio blips
        scale = 0.7  -- Scale for the radio blips
    },
    hacking = {
        lockCount = 8,  -- Number of locks to complete during the hacking process
        time = 60,  -- Time limit for the hacking process, in seconds
    }
}


-------------------------------------------------
--- RADIO ENCODERS
-------------------------------------------------
Config.radioEncoder = {
    location = {x = 2381.0, y = 3060.0, z = 55.0},  -- Coordinates for the radio encoder
    radius = 25.0,  -- Radius around the radio encoder within which encoders can be spawned
    respawnTime = 1200,  -- Time in seconds for the radio encoder to respawn after being picked up
    spawnCount = 3,  -- Number of radio encoders that can be spawned within the specified radius

    blip = {
        blipVisible = false,  -- Setting to make the radio encoder blip visible on the map
        areaVisible = true,  -- Setting to make the area around the radio encoder visible on the map

        -- https://docs.fivem.net/docs/game-references/blips/
        icon = 459,  -- Icon for the radio encoder blip
        color = 39,  -- Color for the radio encoder blip
        scale = 0.9,  -- Scale for the radio encoder blip
    },

    -- Whether to remove the encoder from players inventory after use
    removeEncoderFromInventory = true,
}

-------------------------------------------------
--- DISPATCH
-------------------------------------------------
Config.dispatch = {
    system = 'ps-dispatch',  -- Setting for the dispatch system to use ('default' for the built-in system or 'cd-dispatch', 'core-dispatch-old', 'core-dispatch-new' or 'ps-dispatch' for external systems)
    policeCode = '10-8',  -- Police code for the plane crash event
    eventName = 'Smokkel vliegtuig crash',  -- Name of the plane crash event
    description = 'Een smokkel vliegtuig is net neergestort ga eens kijken!',  -- Description of the plane crash event

    earlyNotification = false, -- Whether to send an early police dispatch. This is when the plane enters the airspace
    earlyDescription = 'Een smokkel vliegtuig is het luchtruim binnen gevlogen en maakt zich klaar voor de "landing"',  -- Description of the plane crash event

    blip = {
        sprite = 582,  -- Sprite for the plane crash blip
        color = 59,  -- Color for the plane crash blip
        scale = 1.2,  -- Scale for the plane crash blip

        timeout = 300,  -- Time in seconds for the blip to disappear after the plane crash event is over

        showRadar = true,  -- Setting to show the plane crash blip on the radar
    },
}


-------------------------------------------------
--- POLICE CRASH SECURING
-------------------------------------------------
Config.securing = {
    duration = 15,  -- Time in seconds it will take to secure the crash site

    spawnBarriers = true,  -- Setting to spawn barriers at the crash site after securing it

    reward = {
        enabled = false,  -- Setting to enable rewards for securing the crash site
        radius = 200.0,  -- Radius around the crash site within which officers will receive the reward

        amount = 4000.0,  -- Amount of money that will be given out and shared across all officers in the radius

        unlootedMultiplier = 2,  -- Multiplier of the money amount that the officers will receive after securing an unlooted plane

        account = 'bank',  -- Account in which the reward money will be deposited
    }
}


-------------------------------------------------
--- PLANE LOOTING
-------------------------------------------------
Config.looting = {
    enabled = true,  -- Setting to enable looting of the plane crash site
    duration = 15,  -- Time in seconds it will take to loot the crash site

    money = {
        min = 25000,  -- Minimum amount of money that can be found at the plane crash site
        max = 50000,  -- Maximum amount of money that can be found at the plane crash site
    }
}

-------------------------------------------------
--- SELLING OF LOOTED ITEMS
-------------------------------------------------
Config.selling = {
    {
        name = 'High grade cocaine buyer',
        location = {
            x = 2123.3, y = 4769.47, z = 41.16, h = 105.0,
        },
        pedModel = 'g_m_m_mexboss_01', -- NPC model of the buyer
        duration = 2000, -- selling duration in ms
        item = 'kq_cocaine_brick',
        itemLabel = 'high grade cocaine bricks',


        -- By not putting the math.random into a function the price will be set randomly on each server start/script start
        -- this will result in better or worse days for selling the item
        price = math.random(500, 700),

        blip = {
            showBlip = false,
            -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 440,
            color = 55,
            scale = 0.7
        },
    },
    {
        name = 'Ecstasy buyer',
        location = {
            x = -1415.0, y = -603.59, z = 30.55, h = 358.3,
        },
        pedModel = 'g_f_y_vagos_01', -- NPC model of the buyer
        duration = 2000, -- Selling duration in ms
        item = 'kq_ecstasy', -- Item that will be sold
        itemLabel = 'bags of ecstasy',

        -- By not putting the math.random into a function the price will be set randomly on each server start/script start
        -- this will result in better or worse days for selling the item
        price = math.random(200, 400),

        blip = {
            showBlip = false,

            -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 440,
            color = 55,
            scale = 0.7
        },
    },
    {
        name = 'Tobacco buyer',
        location = {
            x = 1501.37, y = 3695.2, z = 35.21, h = 104.7,
        },
        pedModel = 'a_m_o_salton_01',
        duration = 2000, -- selling duration in ms
        item = 'kq_tobacco',
        itemLabel = 'smuggled tobacco',

        -- By not putting the math.random into a function the price will be set randomly on each server start/script start
        -- this will result in better or worse days for selling the item
        price = math.random(100, 200),

        blip = {
            showBlip = false,

            -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 440,
            color = 55,
            scale = 0.7
        },
    },
    {
        name = 'Smuggled fur buyer',
        location = {
            x = 687.36, y = -961.93, z = 23.34, h = 227.8,
        },
        pedModel = 'cs_drfriedlander',
        duration = 2000, -- selling duration in ms
        item = 'kq_fur',
        itemLabel = 'smuggled fur',

        -- By not putting the math.random into a function the price will be set randomly on each server start/script start
        -- this will result in better or worse days for selling the item
        price = math.random(200, 400),

        blip = {
            showBlip = false,

            -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 440,
            color = 55,
            scale = 0.7
        },
    },
    {
        name = 'Smuggled ivory buyer',
        location = {
            x = 1606.19, y = 6619.54, z = 15.96, h = 87.9,
        },
        pedModel = 'csb_avery',
        duration = 2000, -- selling duration in ms
        item = 'kq_ivory',
        itemLabel = 'smuggled ivory',

        -- By not putting the math.random into a function the price will be set randomly on each server start/script start
        -- this will result in better or worse days for selling the item
        price = math.random(400, 600),

        blip = {
            showBlip = false,

            -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 440,
            color = 55,
            scale = 0.7
        },
    },
}


-------------------------------------------------
--- CRASH LOCATIONS
-------------------------------------------------
Config.locations = {
    {
        start = {x = 3902.0, y = 6000.0, z = 600.0, h = 120.0},
        landing = {x = 2839.0, y = 4773.0, z = 45.0, h = 170.0}
    },
    {
        start = {x = 3260.0, y = -1400.0, z = 900.0, h = 30.0},
        landing = {x = 1896.0, y = 295.0, z = 155.0, h = 25.0}
    },
    {
        start = {x = 273.0, y = 8600.0, z = 600.0, h = 188.0},
        landing = {x = 94.0, y = 7064.0, z = 7.0, h = 166.0}
    },
    {
        start = {x = 4300.0, y = 860.0, z = 600.0, h = 80.0},
        landing = {x = 2362.0, y = 1626.0, z = 40.0, h = 60.0}
    },
}


-------------------------------------------------
--- LOOT PICKUP ANIMATION
-------------------------------------------------
Config.pickupAnimation = {
    duration = 2, -- in seconds
    dict = 'mp_take_money_mg',
    anim = 'put_cash_into_bag_loop',
    flag = 1,
}


-------------------------------------------------
--- CRASH EVENTS
-------------------------------------------------
Config.crash = {
    blip = {
        label = 'Geschatte plaats van vliegtuigcrash',

        sprite = 582,
        color = 59,
        scale = 1.3,

        timeout = 60, -- in seconds

        showRadar = true,
    },
    events = {
        {
            name = 'Coke, ecstasy and cash',
            -- Radius around which items will spawn from the crashed plane
            lootRadius = 37.0,
            -- Amount of loot items that will be spawned
            lootCount = 40,
            loot = {
                {
                    hash = 'hei_prop_hei_drug_pack_01a',
                    items = {
                        {
                            item = 'kq_cocaine_brick',
                            chance = 100,
                            amount = {
                                min = 1,
                                max = 1,
                            },
                        }
                    },
                    chance = 30,
                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cocaine brick',
                    labelPlurar = 'Cocaine brick',
                    collectMessage = 'Pickup the cocaine brick',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_drugbags',
                    items = {
                        {
                            item = 'kq_cocaine_brick',
                            chance = 100,
                            amount = {
                                min = 2,
                                max = 3,
                            },
                        }
                    },
                    chance = 15,
                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cocaine brick',
                    labelPlurar = 'Cocaine brick',
                    collectMessage = 'Pickup the cocaine bricks',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_drugbag2',
                    items = {
                        {
                            item = 'kq_cocaine_brick',
                            chance = 100,
                            amount = {
                                min = 4,
                                max = 7,
                            },
                        }
                    },
                    chance = 5,
                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cocaine brick',
                    labelPlurar = 'Cocaine brick',
                    collectMessage = 'Pickup the pile of cocaine bricks',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'hei_prop_pill_bag_01',
                    items = {
                        {
                            item = 'kq_ecstasy',
                            chance = 100,
                            amount = {
                                min = 1,
                                max = 1,
                            },
                        }
                    },
                    chance = 25,
                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.1,
                    },
                    rotation = {
                        x = 90.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Bag of ecstasy pills',
                    labelPlurar = 'Bags of ecstasy pills',
                    collectMessage = 'Pickup the bag of ecstasy pills',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'prop_poly_bag_money',
                    chance = 5,

                    isCash = true,
                    moneyAmount = {
                        min = 3000,
                        max = 5000,
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cash',
                    labelPlurar = 'Cash',
                    collectMessage = 'Pickup cash',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'bkr_prop_duffel_bag_01a',
                    chance = 10,

                    isCash = true,
                    moneyAmount = {
                        min = 600,
                        max = 2000,
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cash',
                    labelPlurar = 'Cash',
                    collectMessage = 'Pickup cash',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'bkr_prop_money_wrapped_01',
                    chance = 10,

                    isCash = true,
                    moneyAmount = {
                        min = 200,
                        max = 500,
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cash',
                    labelPlurar = 'Cash',
                    collectMessage = 'Pickup cash',
                    icon = 'fas fa-box',
                },
            },
        },
        {
            name = 'Tobacco, alcohol and some cash',
            -- Radius around which items will spawn from the crashed plane
            lootRadius = 45.0,
            -- Amount of loot items that will be spawned
            lootCount = 20,
            loot = {
                {
                    hash = 'sm_prop_smug_crate_s_tobacco',
                    chance = 15,

                    items = {
                        {
                            item = 'kq_tobacco',
                            chance = 100,
                            amount = {
                                min = 3,
                                max = 4,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Tobacco product',
                    labelPlurar = 'Tobacco products',
                    collectMessage = 'Pickup crate of tobacco products',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_booze_cigs',
                    chance = 15,

                    items = {
                        {
                            item = 'kq_tobacco',
                            chance = 20,
                            amount = {
                                min = 1,
                                max = 2,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Tobacco product',
                    labelPlurar = 'Tobacco products',
                    collectMessage = 'Pickup tobacco products',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'gr_prop_gr_rsply_crate03a',
                    chance = 45,

                    items = {
                        {
                            item = 'kq_tobacco',
                            chance = 100,
                            amount = {
                                min = 2,
                                max = 3,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Tobacco product',
                    labelPlurar = 'Tobacco products',
                    collectMessage = 'Pickup crate of tobacco products',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'prop_cs_heist_bag_02',
                    chance = 15,

                    isCash = true,
                    moneyAmount = {
                        min = 500,
                        max = 3000,
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cash',
                    labelPlurar = 'Cash',
                    collectMessage = 'Pickup the bag',
                    icon = 'fas fa-box',
                },
            }
        },
        {
            name = 'Fur, ivory and some cash',
            -- Radius around which items will spawn from the crashed plane
            lootRadius = 40.0,
            -- Amount of loot items that will be spawned
            lootCount = 30,
            loot = {
                {
                    hash = 'ex_office_swag_ivory',
                    chance = 30,

                    items = {
                        {
                            item = 'kq_ivory',
                            chance = 100,
                            amount = {
                                min = 1,
                                max = 1,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.02,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Ivory',
                    labelPlurar = 'Ivories',
                    collectMessage = 'Pickup ivory',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_ivory2',
                    chance = 15,

                    items = {
                        {
                            item = 'kq_ivory',
                            chance = 100,
                            amount = {
                                min = 3,
                                max = 4,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Ivory',
                    labelPlurar = 'Ivories',
                    collectMessage = 'Pickup the stack of ivories',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_furcoats2',
                    chance = 30,

                    items = {
                        {
                            item = 'kq_fur',
                            chance = 100,
                            amount = {
                                min = 1,
                                max = 1,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = 0.0,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Expensive fur',
                    labelPlurar = 'Expensive furs',
                    collectMessage = 'Pickup the expensive fur',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'ex_office_swag_furcoats3',
                    chance = 15,

                    items = {
                        {
                            item = 'kq_fur',
                            chance = 100,
                            amount = {
                                min = 2,
                                max = 3,
                            },
                        }
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Expensive fur',
                    labelPlurar = 'Expensive furs',
                    collectMessage = 'Pickup the expensive furs',
                    icon = 'fas fa-box',
                },
                {
                    hash = 'prop_money_bag_01',
                    chance = 10,

                    isCash = true,
                    moneyAmount = {
                        min = 1000,
                        max = 2000,
                    },

                    textureVariation = 0,
                    minimumDistanceBetween = 1.5,
                    offset = {
                        x = 0.0, y = 0.0, z = -0.05,
                    },
                    animation = Config.pickupAnimation,
                    labelSingular = 'Cash',
                    labelPlurar = 'Cash',
                    collectMessage = 'Pickup the bag of money',
                    icon = 'fas fa-box',
                },
            }
        },
    },
}
