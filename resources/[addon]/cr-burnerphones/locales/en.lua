BurnerPhonesLocales = {

    ["title_OrderSuccessful"] = "Bestelling succesvol!", -- When a player succesfully orders something
        ["notif_OrderSuccessful"] = "Wacht even, we sturen u de locatie voor de afleverlocatie.",

    ["title_LocSent"] = "GPS bijgewerkt", -- When the player GPS's gets updated with the drop location
        ["notif_LocSent"] = "Je hebt de afleverlocatie ontvangen..",

    ["title_Searching"] = "Zoeken...", -- When a player is seatching the drop off
        ["notif_Searching"] = "Je kijkt zorgvuldig in het pakket",

    ["title_ItemFound"] = "Iets gevonden!", -- When a player finds something in the package
        ["notif_ItemFound"] = "Je hebt iets gevonden!",

    ["title_BatteryOut"] = "Batterij leeg!", -- When the phone has no uses left.
        ["notif_BatteryOut"] = "De telefoon stierf!",

    ["title_CooldownActive"] = "Geen antwoord.", -- When ordering is on Cooldown 
        ["notif_CooldownActive"] = "De telefoon neemt niet op.",

    ["title_Error"] = "Fout...", -- If the player loses their phone while they're ordering something
        ["notif_MissingPhone"] = "Waar is je telefoon!?",

    ["title_EmptyBox"] = "Er is niets...", -- If there is nothing inside the drop off (Someone took it already)
        ["notif_Empty"] = "De doos is leeg",

    ["title_Cancelled"] = "Geannuleerd.", -- When a player cancells their interaction
        ["notif_Cancelled"] = "Je stopt met waar je mee bezig was.",

    ['title_CantCarry'] = "Te zwaar...",
        ['notif_CantCarry'] = "Je kunt dit niet dragen",

    ['dispatch_title'] = "Verdacht pakket afgeleverd", -- Dispatch Call
    ['dispatch_message'] = "Een bezorgde burger was er zojuist getuige van dat iemand een verdacht pakketje afleverde.", -- Dispatch Message

    ['progbar_calling'] = "Snelkiezen bellen...", -- Calling Progress bar
    ['progbar_vpnconnect'] = "Verbinding maken met de VPN...", -- VPN Progress bar 1
    ['progbar_network'] = "Netwerk bereiken...", -- VPN Progress bar 2
    ['progbar_searchingpackage'] = "Pakket doorzoeken...",

    ['interact_searchbox'] = "Zoek doos", -- Interaction to search the drop offf (Target or DrawText)

    ['logs_ItemPickedUp'] = "Artikel opgehaald", -- Title
    ['logs_BurnerphoneBroke'] = "Burnertelefoon kapot", -- Title
    ['logs_BurnerPhoneUsed'] = "Burnertelefoon gebruikt (%s)", -- Phone Used (%s = item)
    ['logs_Player'] = "Burger", -- Player
    ['logs_Item'] = "Item", -- Item
    ['logs_Amount'] = "Hoeveelheid", -- Amount

    ['debug_SettingUpUses'] = "Burnerphone-gebruik instellen", -- When a burnerphone gets used for the first time
    ['debug_ErrorSelecting'] = "Fout bij selecteren van nieuwe locatie. Alle locaties lijken momenteel bezet te zijn", -- If the loop that selects new locations times out
    ['debug_PlayingEmote'] = "Emote spelen (%s)", -- When the player plays an emote ("%s = Emote played")
    ['debug_uses'] = "Burnerphone-gebruik: %s / %s", -- Uses Left on the Burnerphone (First %s = Uses Left, Second %s = Max Uses)
    ['debug_AnimError'] = "Animatie onjuist ingesteld voor item #%s (Telefoon: %s). Informeer het personeelsteam van uw server om dit probleem op te lossen." -- Animation Error (1st %s = Item. 2nd %s = Phone)
}