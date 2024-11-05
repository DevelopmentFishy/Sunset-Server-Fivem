local Translations = {
    success = {
        you_have_been_clocked_in = "Je bent nu aan het werk",
    },
    text = {
        point_enter_warehouse = "[E] Ga naar binnen",
        enter_warehouse= "Enter Warehouse",
        exit_warehouse= "Exit Warehouse",
        point_exit_warehouse = "[E] Ga naar buiten",
        clock_out = "Afmelden",
        clock_in = "Aanmelden",
        hand_in_package = "Lever pakket in",
        point_hand_in_package = "Lever pakket in",
        get_package = "Neem pakket",
        point_get_package = "Neem pakket",
        picking_up_the_package = "Pakket nemen",
        unpacking_the_package = "Uitpakken van pakket",
        volgende = "Neem snel je volgende pakket!",
    },
    error = {
        you_have_clocked_out = "Je bent afgemeld van het werk"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})