Config = {}

Config.Core = "qb-core" -- Your qb-core folder name
Config.Display = "target" -- "target" or "showHelpText"
Config.Target = "qb" -- "qb" or "ox"
Config.Inventory = "qb" -- "qb" or "ox"
Config.Menu = "ox" -- "qb" or "ox"
Config.Notify = "qb" -- "qb" or "okok" or "ox" ( open code on config_functions.lua )
Config.HelpText = "ox" -- "qb" or "ox" ( open code on config_functions.lua )
Config.EmoteMenu = "rp" -- "rp" or "dp" ( open code on config_functions.lua )
Config.VehicleKeys = "qb" -- "qb" or "qs" or "renewed" ( open code on config_functions.lua )
Config.Dispatch = 'ps-dispatch' -- "ps-dispatch" or "cd_dispatch" or "qs-dispatch"
Config.InventoryLink = "qs-inventory/html/images/"
Config.Minigame = true -- Enable minigame?
Config.MinigameType = "ox_lib" -- "ps-ui" or "bl_ui" or "ox_lib" ( open code on config_functions.lua )
Config.Fuel = "LegacyFuel" -- "LegacyFuel" or "okokFuel" or "ox_fuel" or "ti_fuel" or "qs-fuel" ( open code on config_functions.lua )
Config.Debug = true -- If true, some prints happen on console

Config.License = {
    enable = true, -- If true, the script check if player have license to fishing
    cost = 1000, -- Cost of license
    type = "bank", -- "cash" or "bank"
}

-- Fishing Shop
Config.FishingShopBlip = { enable = true, sprite = 729, colour = 3, scale = 0.5, name = "Fishing Shop" }
Config.FishingShopPed = vector3(-1687.41, -1071.51, 13.15) -- Location of the ped fishing shop
Config.FishingShopPedHeading = 51.52 -- Heading of the ped
Config.FishingShopPedModel = "a_m_y_runner_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.FishingShopItems = { -- Items people can buy on shop
    [1] = { name = "fishbait",      price = 5, amount = 1000, info = {}, type = "item", slot = 1 },
	[2] = { name = "anchor",        price = 5, amount = 10, info = {}, type = "item", slot = 2 },
    [3] = { name = "bonfire",       price = 5, amount = 10, info = {}, type = "item", slot = 3 },
    [4] = { name = "fishingrod1",   price = 75, amount = 10, info = {}, type = "item", slot = 4 },
    [5] = { name = "fishnet1",      price = 90, amount = 10, info = {}, type = "item", slot = 5 },
    [6] = { name = "diving_gear",   price = 125, amount = 10, info = {}, type = "item", slot = 6 },
    [7] = { name = "diving_fill",   price = 125, amount = 10, info = {}, type = "item", slot = 7 },
    [8] = { name = "knife",   price = 150, amount = 1, info = {}, type = "item", slot = 8 },
}

-- Selling Legal Fishg
Config.FishingSellBlip = { enable = true, sprite = 751, colour = 3, scale = 0.5, name = "Verkoop vis" }
Config.FishingSellPed = vector3(-1834.78, -1189.99, 14.31) -- Location of the ped fishing shop
Config.FishingSellPedHeading = 237 -- Heading of the ped
Config.FishingSellPedModel = "a_m_m_hillbilly_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.FishingSellType = "cash" -- "cash" or "bank"
Config.SettingsSell = {
    [1] = { item = "catfish",   priceMin = 5, priceMax = 20, labelName = "Catfish" },
    [2] = { item = "cod",       priceMin = 5, priceMax = 20, labelName = "Cod" },
    [3] = { item = "mackerel",  priceMin = 5, priceMax = 20, labelName = "Mackerel" },
    [4] = { item = "monkfish",  priceMin = 5, priceMax = 20, labelName = "Monkfish" },
    [5] = { item = "salmon",    priceMin = 5, priceMax = 20, labelName = "Salmon" },
    [6] = { item = "sardine",   priceMin = 5, priceMax = 20, labelName = "Sardine" },
    [7] = { item = "stingray",  priceMin = 5, priceMax = 20, labelName = "Stingray" },
    [8] = { item = "tunafish",  priceMin = 5, priceMax = 20, labelName = "Tunafish" },
    [9] = { item = "sole",      priceMin = 5, priceMax = 20, labelName = "Sole" },
    [10] = { item = "seabass",  priceMin = 5, priceMax = 20, labelName = "Seabass" },
}

-- Selling ILegal Fishg
Config.IllegalFishingSellBlip = { enable = false, sprite = 751, colour = 3, scale = 0.5, name = "Sell Illegal Fish" }
Config.IllegalFishingSellPed = vector3(269.92, -3075.73, 5.77) -- Location of the ped fishing shop
Config.IllegalFishingSellPedHeading = 223.78 -- Heading of the ped
Config.IllegalFishingSellPedModel = "s_m_m_migrant_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.IllegalFishingSellType = "cash" -- "cash" or "bank"
Config.IllegalSettingsSell = {
    [1] = { item = "dolphin",       priceMin = 400, priceMax = 550, labelName = "Dolphin" },
    [2] = { item = "tigershark",    priceMin = 400, priceMax = 550, labelName = "Tigershark" },
    [3] = { item = "whale",         priceMin = 400, priceMax = 550, labelName = "Whale" },
    [4] = { item = "hammershark",   priceMin = 400, priceMax = 550, labelName = "Hammershark" },
}


-- Rent a Boat
Config.RentBoatBlip = { enable = true, sprite = 404, colour = 3, scale = 0.5, name = "Rent a Boat" }
Config.RentBoatPed = vector3(-1815.52, -956.16, 1.45) -- Location of the ped fishing shop
Config.RentBoatPedHeading = 101.93 -- Heading of the ped
Config.RentBoatPedModel = "a_m_y_runner_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.SpawnBoat = vector3(-1829.92, -958.59, -0.3) -- Locationto spawn the boat
Config.SpawnBoatHeading = 101.62 -- Heading of the boat
Config.SpawnAfterDelete = vector3(-1814.27, -957.47, 1.59)
Config.Boats = {
    [1] = {boat = "dinghy", experience = 100 },
    [2] = {boat = "jetmax", experience = 400 },
    [3] = {boat = "toro", experience = 1000 },
}

-- Experience system
Config.CommandCheckXP = "fishingxp"
Config.CommandDescription = "Bekijk je vis-xp"
Config.ExperienceSettings = {
    Legal_Fishing = {
        min = 1, -- min experience player earn when fishing 
        max = 2, -- max experience player earn when fishing 
    },
    Illegal_Fishing = {
        min = 2, -- min experience player earn when illegal fishing 
        max = 4, -- max experience player earn when illegal fishing 
    },
    Fishingnet = {
        min = 1, -- min experience player earn when use fishingnet
        max = 2, -- max experience player earn when use fishingnet
    },
}

-- Illegal bait settings
Config.IllegalBait = {
    needMinigame = false, -- cl_utils.lua
    needItem = false, -- Required item to make illegalbait?
    onlyIllegalZones = false, -- Player only can make illegalbait on illegalzones?
    itemNeeded = "knife", -- Item required
    timeProg = 5000, -- Time of progressbar when you use the item
    itemUsed = "tigershark", -- Item used to get illegalbait
    receiveAmount = { -- min & max amount of illegail bait people can get from one tigershark
        min = 3,
        max = 6,
    },
}

-- Cooking settings
Config.CookingProp = "prop_beach_fire" -- Prop will spawned with bonfire item
Config.AnimationCooking = {
    placing = {
        animDict = "anim@narcotics@trash",
        anim = "drop_front"
    },
    saving = {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
    }
}

-- Cooking items
Config.CookingItems = {
    [1] = {
        name = "cookedcod", -- Item player will cooking
        receive = 1, -- Amount of item receiving
        itemsNeed = { -- List of items needed to craft
            [1] = {item = "cod", amount = 1 },
        }
    },
    [2] = {
        name = "cookedmackerel", -- Item player will cooking
        receive = 1, -- Amount of item receiving
        itemsNeed = { -- List of items needed to craft
            [1] = {item = "mackerel", amount = 1 },
        }
    },
}

-- Usable cooked items
Config.CookingUsable = {
    [1] = {
        item = "cookedcod", -- Item consumable
        effects = "health", -- "health" or "armour" or "both"
        values = {
            min = 10, -- Min value player will receive of effects when eating the cookedcod
            max = 20, -- Max value player will receive of effects when eating the cookedcod
        }
    },
    [2] = {
        item = "cookedmackerel", -- Item consumable
        effects = "health", -- "health" or "armour" or "both"
        values = {
            min = 10, -- Min value player will receive of effects when eating the cookedcod
            max = 20, -- Max value player will receive of effects when eating the cookedcod
        }
    },
}

-- Treasure Chest
Config.Treasure = {
    Rewards = {
        [1] = {item = "goldbar", chance = 20 },
        [2] = {item = "snspistol_body", chance = 10 },
        [3] = {item = "lockpick", chance = 50 },
        [5] = {item = "illegalfishbait", chance = 60 },
        [6] = {item = "plastic", chance = 70 },
    }
}