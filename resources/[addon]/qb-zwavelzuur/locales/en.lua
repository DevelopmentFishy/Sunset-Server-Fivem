local Translations = {
    error = {
    },
    success = {
    },
    info = {

    },
    progressbar = {
        collecting = "Verzamelen......",
    },
    items = {
        sulfuric_acid = "Zwavelzuur",
    },
    target = {
        pickSulfuric = "Neem zwavelzuur",

    },
   
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
