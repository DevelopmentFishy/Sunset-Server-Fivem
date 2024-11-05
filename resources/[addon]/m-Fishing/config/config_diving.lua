Config.maskModel = `p_d_scuba_mask_s` -- Mask model
Config.tankModel = `p_s_scuba_tank_s` -- Tank model
Config.OxygenMaxLevel = 200 -- Max capacity of the tank

-- Sell Corals
Config.SellCoralsBlip = { enable = true, sprite = 120, colour = 3, scale = 0.8, name = "Sell Corals" }
Config.SellCoralsPed = vector3(3311.14, 5176.33, 19.61) -- Location of the ped fishing shop
Config.SellCoralsPedHeading = 235.46 -- Heading of the ped
Config.SellCoralsPedModel = "a_m_y_runner_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.SellCoralsType = "cash" -- "cash" or "bank"
Config.Cops = {
    enable = true, -- Enable call cops when you sell corals?
}
Config.SellCoralsSetgins = {
    [1] = { item = "babyblue_coral",    priceMin = 120, priceMax = 360, labelName = "Babyblue Coral" },
    [2] = { item = "blue_coral",        priceMin = 120, priceMax = 360, labelName = "Blue Coral" },
    [3] = { item = "green_coral",       priceMin = 120, priceMax = 360, labelName = "Green Coral" },
    [4] = { item = "pink_coral",        priceMin = 120, priceMax = 360, labelName = "Pink Coral" },
    [5] = { item = "red_coral",         priceMin = 120, priceMax = 360, labelName = "Red Coral" },
    [6] = { item = "yellow_coral",      priceMin = 120, priceMax = 360, labelName = "Yellow Coral" },
}

Config.DivingAnimation = {
    animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
    anim = "plant_floor",
}

Config.TreasureChest = {
    enable = true, -- Enable drop treasure chest when people are collecting coral?
    chance = 5, -- Chance to get the treasure chest [5%]
}

Config.DivingLocations = {
    --[[[1] = {
        coords = vector3(-1887.41, -1187.53, -21.05), -- Location where prop has gona be spawned
        prop = "prop_m_coral_01", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },
    [2] = {
        coords = vector3(-1934.45, -1116.15, -34.22), -- Location where prop has gona be spawned
        prop = "prop_m_coral_02", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },
    [3] = {
        coords = vector3(-1974.85, -1062.28, -26.55), -- Location where prop has gona be spawned
        prop = "prop_m_coral_03", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },
    [4] = {
        coords = vector3(-2088.26, -1031.36, -44.12), -- Location where prop has gona be spawned
        prop = "prop_m_coral_04", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },
    [5] = {
        coords = vector3(-2076.2, -884.86, -39.32), -- Location where prop has gona be spawned
        prop = "prop_m_coral_05", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },
    [6] = {
        coords = vector3(-2205.43, -822.74, -35.62), -- Location where prop has gona be spawned
        prop = "prop_m_coral_06", -- Prop spawned
        searched = false, -- Don't touch
        rewardAmount = math.random(1,2), -- Amount of the item random from the list below
        reward = { -- List of possible drops on this location
            "red_coral"
        }
    },--]]
}