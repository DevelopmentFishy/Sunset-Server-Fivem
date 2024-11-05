local Translations = {
    error = {
        minimum_store_robbery_police = "Niet genoeg politie (%{MinimumStoreRobberyPolice} Required)",
        not_driver = "Je bent niet de bestuurder",
        demolish_vehicle = "Je mag nu geen voertuigen slopen",
        process_canceled = "Proces geannuleerd..",
        you_broke_the_lock_pick = "Je hebt de lockpick gebroken",
    },
    text = {
        the_cash_register_is_empty = "De kassa is leeg",
        try_combination = "~g~E~w~ - Probeer Combinatie",
        safe_opened = "Kluis Gopened",
        emptying_the_register= "Kassa aan het leeg halen..",
        safe_code = "Kluis Code: "
    },
    email = {
        shop_robbery = "10-31 | Shop Robbery",
        someone_is_trying_to_rob_a_store = "Someone Is Trying To Rob A Store At %{street} (CAMERA ID: %{cameraId1})",
        storerobbery_progress = "Storerobbery in progress"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
