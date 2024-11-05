
-- Fishing Settings
Config.FishingZones = {
    [1] = {
        coords = vector3(-1817.0, -951.94, 1.31),
        radius = 150,
        type = "legal", -- "legal" | "illegal" | "all"
        blip = { enable = true, sprite = 148, colour = 3, scale = 1.0, transparency = 75, name = "Fishing Zone" },
    },
    [2] = {
        coords = vector3(-348.1313, -3946.0527, 0.7608),
        radius = 50,
        type = "legal", -- "legal" | "illegal" | "all" 
        blip = { enable = true, sprite = 148, colour = 3, scale = 5.0, transparency = 75, name = "Fishing Zone" },
    },
    [3] = {
        coords = vector3(4377.8867, 4887.9336, 4.0352),
        radius = 50,
        type = "legal", -- "legal" | "illegal" | "all"
        blip = { enable = true, sprite = 148, colour = 3, scale = 5.0, transparency = 75, name = "Fishing Zone" },
    },
    [4] = {
        coords = vector3(-970.3435, 7019.8716, 0.5698),
        radius = 50,
        type = "illegal", -- "legal" | "illegal" | "all" 
        blip = { enable = true, sprite = 148, colour = 3, scale = 5.0, transparency = 75, name = "Fishing Zone" },
    },
}

-- Settings for the fishingrods
Config.FishingrodSettings = {
    ["fishingrod1"] = {
        timeProgressbar = 12500, -- Time it takes to catch a fish
        prop = "prop_m_fishingrod_1", -- Prop for fishingrod level 1
    },
    ["fishingrod2"] = {
        timeProgressbar = 10000, -- Time it takes to catch a fish
        prop = "prop_m_fishingrod_2", -- Prop for fishingrod level 2
    },
    ["fishingrod3"] = {
        timeProgressbar = 7500, -- Time it takes to catch a fish
        prop = "prop_m_fishingrod_3", -- Prop for fishingrod level 3
    },
    ["fishingrod4"] = {
        timeProgressbar = 5500, -- Time it takes to catch a fish
        prop = "prop_m_fishingrod_4", -- Prop for fishingrod level 4
    },
    ["fishingrod5"] = {
        timeProgressbar = 3500, -- Time it takes to catch a fish
        prop = "prop_m_fishingrod_5", -- Prop for fishingrod level 5
    },
}

-- Settings for legal fishing
Config.LegalFishing = {
    ["fishingrod1"] = {
        amount = math.random(1,2), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 1
            [1] = {item = "catfish", chance = 40},
            [2] = {item = "mackerel", chance = 40},
            [3] = {item = "cod", chance = 40},
            [4] = {item = "seabass", chance = 40},
            [5] = {item = "tigershark", chance = 15},
        }
    },
    ["fishingrod2"] = {
        amount = math.random(2,3), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 2
            [1] = {item = "catfish", chance = 50},
            [2] = {item = "mackerel", chance = 50},
            [3] = {item = "cod", chance = 50},
            [4] = {item = "seabass", chance = 50},
            [5] = {item = "sole", chance = 50},
            [6] = {item = "stingray", chance = 50},
            [7] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait
            [8] = {item = "fishingkey", chance = 15},
            [9] = {item = "treasurechest", chance = 5},
            [10] = {item = "tigershark", chance = 15}, -- This is the item to open the treasure chest
        }
    },
    ["fishingrod3"] = {
        amount = math.random(3,4), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 3
            [1] = {item = "catfish", chance = 60},
            [2] = {item = "mackerel", chance = 60},
            [3] = {item = "cod", chance = 60},
            [4] = {item = "seabass", chance = 60},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "salmon", chance = 60},
            [8] = {item = "tunafish", chance = 60},
            [9] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait
            [10] = {item = "fishingkey", chance = 20},
            [11] = {item = "treasurechest", chance = 5},
            [12] = {item = "tigershark", chance = 15}, -- This is the item to open the treasure chest
        }
    },
    ["fishingrod4"] = {
        amount = math.random(4,5), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 4
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
            [12] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait
            [13] = {item = "fishingkey", chance = 25},
            [14] = {item = "treasurechest", chance = 5},
            [15] = {item = "tigershark", chance = 15}, -- This is the item to open the treasure chest
        }
    },
    ["fishingrod5"] = {
        amount = math.random(5,6), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 5
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
            [13] = {item = "tigershark", chance = 10}, -- This item is the fish you can make illegalbait
            [14] = {item = "fishingkey", chance = 30},
            [15] = {item = "treasurechest", chance = 5},
            [16] = {item = "tigershark", chance = 15}, -- This is the item to open the treasure chest
        }
    }
}

-- Settings for illegal fishing
Config.IllegalFishing = {
    ["fishingrod1"] = {
        amount = math.random(3,4), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 1
            [1] = {item = "hammershark", chance = 40},
            [2] = {item = "whale", chance = 40},
            [3] = {item = "tigershark", chance = 40},
            [4] = {item = "dolphin", chance = 40},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "treasurechest", chance = 5},
        }
    },
    ["fishingrod2"] = {
        amount = math.random(5,6), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 2
            [1] = {item = "hammershark", chance = 40},
            [2] = {item = "whale", chance = 40},
            [3] = {item = "tigershark", chance = 40},
            [4] = {item = "dolphin", chance = 40},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "treasurechest", chance = 5},
        }
    },
    ["fishingrod3"] = {
        amount = math.random(7,8), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 3
            [1] = {item = "hammershark", chance = 40},
            [2] = {item = "whale", chance = 40},
            [3] = {item = "tigershark", chance = 40},
            [4] = {item = "dolphin", chance = 40},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "treasurechest", chance = 5},
        }
    },
    ["fishingrod4"] = {
        amount = math.random(9,11), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 4
            [1] = {item = "hammershark", chance = 40},
            [2] = {item = "whale", chance = 40},
            [3] = {item = "tigershark", chance = 40},
            [4] = {item = "dolphin", chance = 40},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "treasurechest", chance = 5},
        }
    },
    ["fishingrod5"] = {
        amount = math.random(12,13), -- Amount of random fish from the fishList
        fishList = { -- List of possible fish can get with fishingrod level 5
            [1] = {item = "hammershark", chance = 40},
            [2] = {item = "whale", chance = 40},
            [3] = {item = "tigershark", chance = 40},
            [4] = {item = "dolphin", chance = 40},
            [5] = {item = "sole", chance = 60},
            [6] = {item = "stingray", chance = 60},
            [7] = {item = "treasurechest", chance = 5},
        }
    }
}
