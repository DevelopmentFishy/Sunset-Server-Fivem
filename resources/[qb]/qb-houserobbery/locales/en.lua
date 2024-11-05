local Translations = {
    error = {
        ["missing_something"] = "Je mist iets",
        ["not_enough_police"] = "Er is niet genoeg politie.",
        ["door_open"] = "De deur is al open",
        ["process_cancelled"] = "Wees voorzichtig laat geen vingerafdrukken achter!",
        ["didnt_work"] = "Gefaald!",
        ["emty_box"] = "Je hebt niets interessant gevonden",
    },
    success = {
        ["worked"] = "Je hebt de deur opengebroken!",
    },
    info = {
        ["palert"] = "Poging tot huisinbraak",
        ["henter"] = "~g~E~w~ - Om binnen te gaan",
        ["hleave"] = "~g~E~w~ - Om te verlaten",
        ["aint"] = "~g~E~w~ - ",
        ["hsearch"] = "Zoeken..",
        ["hsempty"] = "Je hebt hier al gezocht",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
