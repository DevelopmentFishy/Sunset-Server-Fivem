--Client config only
CConfig = {}

CConfig.AddonTables = {
    --[1] = { coords = vector3(-571.03, -1044.25, 22.34), heading = 268 },-- deze test was in het uwu café
    --[2] = { coords = vector3(1990.92, 3066.04, 47.04), heading = 0.00 },
}

CConfig.ShotTime = 30
CConfig.ProximityToGame = 5.0    -- Proximy to move in a zone of 10 when you created a game
CConfig.ProximityToAccept = 5.0  -- Distance to accept a game
CConfig.UsingTarget = false      -- If you use qtarget or not
CConfig.TargetName = 'qb-target' -- Name of the target resource (They are compatible)
CConfig.UsingNewOx = false       -- If you use the new ox_target or not
CConfig.Bets = {
    min_bet = 1,
    max_bet = 100000000000,
}
CConfig.DisplayRadarOnFinish = true -- This option is for servers which hide radar out of vehicle, disable it if it is your case!

CConfig.ValuesToHit = {
    [1] = 100,
    [2] = 200,
    [3] = 500,
    [4] = 700,
}

CConfig.Reach0Start = {
    [1] = 201,
    [2] = 301,
    [3] = 501,
    [4] = 701,
}

CConfig.ShakeLevel = 4      -- The average shake level

CConfig.ShakeMin = -6       -- The minimum shake
CConfig.ShakeMax = 6        -- The maximum shake

CConfig.DoubleToWin = true -- If you want a more realistic game using real rules

CConfig.UsingOxMenu = true
