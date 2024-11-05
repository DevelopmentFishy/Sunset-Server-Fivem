local Translations = {

    label = {
        ["police"] = "Politie",
        ["ambulance"] = "Ambulance",
        ["mechanic"] = "Fast customs",
        ["taxi"] = "Taxi",
        ["mayor"] = "Mayor",
        ["cardealer"] = "Fastart",
        ["realestate"] = "Makelaar",
        ["beanmachine"] = "Catcafe",
        ["lawyer"] = "Advocaat",
        ["drivingteacher"] = "Upnatom",
        ["server_info"] = "SERVER INFO",
        ["title_robbery"] = "Overval",
        ["title_status"] = "STATUS",
        ["title_jobs"] = "JOBS",
        ["title_active"] = "ACTIVE",
        ["title_players"] = "Inwoners",
        ['yes'] = "Ja",
        ['no'] = "Nee",
        ['admin'] = "ADMIN",
        ['god'] = "GOD",
        ['notify_not_supported'] = " Your type of notify choice is not supported.",
        ['open_scoreboard'] = "Open Scoreboard",
    },
    illegal_actions = {
        ["storerobbery"] = "Winkel",
        ["atmrobbery"] = "Atm",
        ["ammunitionrobbery"] = "Wapen",
        ["banktruck"] = "Banktruck",
        ["jewellery"] = "Jewellery",
        ["Fleeca"] = "Bank",
        ["Paleto"] = "Paleto Bank",
        ["Pacific"] = "Pacific Bank",
        ["vliegtuigheist"] = "Vliegtuigheist",
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