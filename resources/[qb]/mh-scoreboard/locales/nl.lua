local Translations = {

    label = {
        ["police"] = "Police",
        ["ambulance"] = "Ambulance",
        ["mechanic"] = "Mechanics",
        ["taxi"] = "Taxi",
        ["mayor"] = "Mayor",
        ["cardealer"] = "Cardealer",
        ["realestate"] = "Realestate",
        ["beanmachine"] = "Catcafe",
        ["whitewidow"] = "Whitewidow",
        ["drivingteacher"] = "Upnatom",
        ["server_info"] = "SERVER INFO",
        ["title_robbery"] = "ROBBERY",
        ["title_status"] = "STATUS",
        ["title_jobs"] = "JOBS",
        ["title_active"] = "ACTIVE",
        ["title_players"] = "PLAYERS",
        ['yes'] = "yes",
        ['no'] = "no",
        ['admin'] = "ADMIN",
        ['god'] = "GOD",
        ['notify_not_supported'] = " Your type of notify choice is not supported.",
        ['open_scoreboard'] = "Open Scoreboard",
    },
    illegal_actions = {
        ["storerobbery"] = "STORE",
        ["atmrobbery"] = "ATM",
        ["ammunitionrobbery"] = "WAPEN WINKEL",
        ["banktruck"] = "TRUCK",
        ["jewellery"] = "VANGELICO",
        ["Fleeca"] = "FLEECA BANK",
        ["Paleto"] = "PALETO BANK",
        ["Pacific"] = "PACIFIC BANK",
        ["vliegtuigheist"] = "VLIEGTUIG HEIST",
    },
    admin = {
        ['enable_id'] = "Your Admin ID is  now enabled!",
        ['disable_id'] = "Your Admin ID is now disabled!",
        
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})