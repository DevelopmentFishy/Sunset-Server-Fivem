local Translations = {
    error = {
        not_started = "Je bent nog niet begonnen met wassen!",
        cannot_collect = "U kunt niet opnemen",
        have_to_wait = " U moet wachten ",
        not_enough = "Je hebt niet genoeg geldrollen!",
        not_value = "Ongeldig bedrag!",
      
    },
    success = {
        wash = "U heeft ",
        started_wash = "Je bent gestart met het wassen van  ",
        wash_start = " EURO!",
    },
    label = {
        hours = " uur, ",
        minutes = " minuten, ",
        seconds = " seconden",
        ready = "Klaar om opgehaald te worden!",
        quit = "Sluiten",
        header = "Was menu",
        send = "Verstuur",
        amount = "Bedrag",
        method = "Was methode",
        option1 = "Snelle was",
        option2 = "1 dag",
        option3 = "2 dagen",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})