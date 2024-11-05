-- Fishing Net Settings
Config.CheckCitizenID = true -- If true, only the person spawn the fishingnet can collect the same fishing net

Config.RemoveFishingnet = false -- If true, every time player uses, the script removes the fishingnet

Config.FishingnetBroke = true -- If true have a minimal chance of fishingnet broke

Config.BrokeChance = 20 -- 20% 0-100 to fishingnet broke

Config.FishingnetAnimation = { -- Settings of animation on progressbar collecting the fishingnet
    animDict = "mini@repair",
    anim = "fixing_a_player",
}

Config.PossibleFishs = { -- List of possible fish appear on fishingnet
    "a_c_fish",
    "a_c_stingray",
}

Config.FishingnetZones = {
    [1] = {
        coords = vector3(-1817.0, -951.94, 1.31),
        radius = 20,
        blip = { enable = false, sprite = 148, colour = 3, scale = 0.8, transparency = 75, name = "Fishingnet Zone" }
    },
    [2] = {
        coords = vector3(81.31, 682.62, 197.04),
        radius = 20,
        blip = { enable = false, sprite = 148, colour = 3, scale = 0.8, transparency = 75, name = "Fishingnet Zone" }
    },
}

-- Settings for fishingnet
Config.FishingnetSettings = {
    ["fishnet1"] = {
        timeProgressbar = 5000, -- Time of the progressbar when placing the fishingnet
        timeCollect = 5000, -- Time it takes before the player can collect the fish
        prop = "prop_m_fishing_net_01", -- Prop for the fishingnet
    },
    ["fishnet2"] = {
        timeProgressbar = 10000, -- Time of the progressbar when placing the fishingnet
        timeCollect = 30000, -- Time it takes before the player can collect the fish
        prop = "prop_m_fishing_net_02", -- Prop for the fishingnet
    },
    ["fishnet3"] = {
        timeProgressbar = 7500, -- Time of the progressbar when placing the fishingnet
        timeCollect = 30000, -- Time it takes before the player can collect the fish
        prop = "prop_m_fishing_net_03", -- Prop for the fishingnet
    },
    ["fishnet4"] = {
        timeProgressbar = 5500, -- Time of the progressbar when placing the fishingnet
        timeCollect = 30000, -- Time it takes before the player can collect the fish
        prop = "prop_m_fishing_net_04", -- Prop for the fishingnet
    },
    ["fishnet5"] = {
        timeProgressbar = 3500, -- Time of the progressbar when placing the fishingnet
        timeCollect = 30000, -- Time it takes before the player can collect the fish
        prop = "prop_m_fishing_net_05", -- Prop for the fishingnet
    },
}

-- Settings for fishingnet
Config.RewardsFishingnet = {
    ["fishnet1"] = {
        amount = math.random(1,2), -- Amount of random fish from the fishList
        amountList = 1, -- How many random items you can receive
        fishList = { -- List of possible fish can get with fishnet level 1
            [1] = {item = "catfish", chance = 40},
            [2] = {item = "mackerel", chance = 40},
            [3] = {item = "cod", chance = 40},
            [4] = {item = "seabass", chance = 40},
        }
    },
    ["fishnet2"] = {
        amount = math.random(2,3), -- Amount of random fish from the fishList
        amountList = 3, -- How many random items you can receive
        fishList = { -- List of possible fish can get with fishnet level 2
            [1] = {item = "catfish", chance = 50},
            [2] = {item = "mackerel", chance = 50},
            [3] = {item = "cod", chance = 50},
            [4] = {item = "seabass", chance = 50},
            [5] = {item = "sole", chance = 50},
            [6] = {item = "stingray", chance = 50},
            [7] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait out of
        }
    },
    ["fishnet3"] = {
        amount = math.random(3,4), -- Amount of random fish from the fishList
        amountList = 4, -- How many random items you can receive
        fishList = { -- List of possible fish can get with fishnet level 3
            [1] = {item = "catfish", chance = 60},
            [2] = {item = "mackerel", chance = 60},
            [3] = {item = "cod", chance = 60},
            [4] = {item = "seabass", chance = 60},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "salmon", chance = 60},
            [8] = {item = "tunafish", chance = 60},
            [9] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait out of
        }
    },
    ["fishnet4"] = {
        amount = math.random(4,5), -- Amount of random fish from the fishList
        amountList = 5, -- How many random items you can receive
        fishList = { -- List of possible fish can get with fishnet level 4
            [1] = {item = "catfish", chance = 60},
            [2] = {item = "mackerel", chance = 60},
            [3] = {item = "cod", chance = 60},
            [4] = {item = "seabass", chance = 60},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "salmon", chance = 60},
            [8] = {item = "tunafish", chance = 60},
            [9] = {item = "sardine", chance = 70},
            [10] = {item = "sardine", chance = 70},
            [11] = {item = "catfish", chance = 70},
            [12] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait out of
        }
    },
    ["fishnet5"] = {
        amount = math.random(5,6), -- Amount of random fish from the fishList
        amountList = 6, -- How many random items you can receive
        fishList = { -- List of possible fish can get with fishnet level 5
            [1] = {item = "catfish", chance = 60},
            [2] = {item = "mackerel", chance = 60},
            [3] = {item = "cod", chance = 60},
            [4] = {item = "seabass", chance = 60},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "salmon", chance = 60},
            [8] = {item = "tunafish", chance = 60},
            [9] = {item = "sardine", chance = 70},
            [10] = {item = "sardine", chance = 70},
            [11] = {item = "catfish", chance = 70},
            [12] = {item = "monkfish", chance = 70},
            [13] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait out of
        }
    }
}