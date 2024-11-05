-- UNDER DEVELOPMENT
-- UNDER DEVELOPMENT
-- UNDER DEVELOPMENT
-- UNDER DEVELOPMENT
-- UNDER DEVELOPMENT


Config.MaxWaitingTime = 10 -- 10 minutes waiting time to enter on tournament
Config.MaxParticipants = 20 -- 20 Players can join in
Config.PaymentTournament = "cash" -- "cash" or "bank"
Config.BaitUsing = "legal" -- "legal" or "illegal" | This is the bait removed when people fishing during the tournament
Config.TournamentMinigame = false 

Config.BlipTournament = { -- Blip settins when tournamed has created
    Sprite = 104,
    Scale = 0.8,
    Colour = 3,
    Name = "Fishing Tournament:",
}

Config.Commands = {
    -- Create tournament
    createTournament = "createtournament",
    helpCreate = "Create a fishing tournament",
    rankCreate = "admin", -- "user" / "admin" / "god"

    -- End tournament
    endTournament = "endtournament",
    helpEndTournament = "Ent a tournament",
    rankEndTournament = "admin",

    -- Check your own tournament
    checkTournament = "checktournament", -- You need put the name of tournament after the command
    helpCheck = "Check your own tournament",
    nameCheck = "Name of Tournament",
    rankCheck =  "admin", -- "user" / "admin" / "god"

    -- Leaderboard tournament
    checkLeaderboard = "topplayers", -- You need put the name of tournament after the command
    helpCheckLeader = "List the top 5 players with the most points in tournaments",
    nameCheckLeader = "Name of the tournament",
    rankCheckLeader = "user", -- "user" / "admin" / "god"
}

Config.RewardsTournament = { -- This is the rewards settigns when people are fishing during the tournament active
    amount = math.random(1,2),
    fish = {
        "catfish",
        "mackerel",
        "cod"
    }
}

Config.PedsTournament = { -- List of possible npcs players can choose to enter on tournament
    "s_m_m_cntrybar_01",
    "s_m_m_gentransport",
    "s_m_m_strvend_01",
    "a_m_y_salton_01",
    "a_m_y_runner_01",
}