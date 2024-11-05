Config.ShellCollectTime = 5000 -- Time of progressbar when player are collecting
Config.ShellMinigame = false -- https://github.com/Project-Sloth/ps-ui

Config.ShellAnimation = "world_human_gardener_plant" -- Animation collecting seashell

Config.SeashellLocations = {
    --[1] = { coords = vector3(-1812.87, -923.98, 2.6), prop = "prop_m_shell_01" },
    --[2] = { coords = vector3(-1817.07, -918.73, 2.58), prop = "prop_m_shell_02" },
    --[3] = { coords = vector3(-1817.99, -911.1, 2.63), prop = "prop_m_shell_01" },
    --[4] = { coords = vector3(-1823.53, -904.14, 2.46), prop = "prop_m_shell_02" },
    --[5] = { coords = vector3(-1826.76, -895.23, 2.54), prop = "prop_m_shell_02" },
    --[6] = { coords = vector3(-1832.54, -888.54, 2.7), prop = "prop_m_shell_01" },
}

-- Settings rewards
Config.SeashellRewards = {
    [1] = { item = "conch", amount = math.random(1,2) },
    [2] = { item = "sea_snail", amount = math.random(1,2) },
    [3] = { item = "conch_shell", amount = math.random(1,2) },
    [4] = { item = "conch", amount = math.random(1,2) },
}

-- Selling Seashells
Config.SeashellsBlip = { enable = true, sprite = 108, colour = 3, scale = 0.8, name = "Sell Seashell" }
Config.SeashellsPed = vector3(-1665.74, -979.0, 8.16) -- Location of the ped fishing shop
Config.SeashellsPedHeading = 50.39 -- Heading of the ped
Config.SeashellsPedModel = "a_m_m_hillbilly_01" -- Ped model https://docs.fivem.net/docs/game-references/ped-models/
Config.SeashellsType = "cash" -- "cash" or "bank"
Config.SeashellsSell = {
    [1] = { item = "conch",     priceMin = 2, priceMax = 4, labelName = "Conch" },
    [2] = { item = "shell",     priceMin = 2, priceMax = 4, labelName = "Shell" },
    [3] = { item = "sea_snail", priceMin = 2, priceMax = 4, labelName = "Seasnail" },
    [4] = { item = "starfish",  priceMin = 2, priceMax = 4, labelName = "Starfish" },
}