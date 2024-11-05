local Translations = {
    ui = {
        last_location = "Laaste locatie",
        confirm = "Bevestigen",
        where_would_you_like_to_start = "Waar wil je beginnen?",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
