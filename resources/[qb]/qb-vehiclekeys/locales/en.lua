local Translations = {
    notify = {
        ydhk = 'Je hebt geen sleutel tot dit voertuig.',
        nonear = 'Er is niemand in de buurt om de sleutels aan te geven.',
        vlock = 'Voertuig vergrendeld!',
        vunlock = 'Voertuig ontgrendeld!',
        vlockpick = 'Je hebt het slot van de deur weten te openen!',
        fvlockpick = 'Het lukt je niet om de sleutels te vinden en je raakt gefrustreerd.',
        vgkeys = 'Je geeft de sleutels over.',
        vgetkeys = 'Je krijgt de sleutels van het voertuig!',
        fpid = 'Vul de speler ID en kentekenargumenten in.',
        cjackfail = 'Autojacking mislukt!',
        vehclose = 'Er is geen dichtbijzijnd voertuig!',
    },
    progress = {
        takekeys = 'Sleutels van het lichaam nemen...',
        hskeys = 'Zoeken naar de autosleutels...',
        acjack = 'Autojacking proberen...',
    },
    info = {
        skeys = '~g~[H]~w~ - Zoek naar sleutels',
        tlock = 'Toggle voertuigvergrendelingen',
        palert = 'Voertuigdiefstal bezig. Type: ',
        engine = 'Toggle motor',
    },
    addcom = {
        givekeys = 'Geef de sleutels aan iemand. Als er geen ID is, geef dan aan de dichtstbijzijnde persoon of iedereen in het voertuig.',
        givekeys_id = 'id',
        givekeys_id_help = 'Speler ID',
        addkeys = 'Voegt sleutels toe aan een voertuig voor iemand.',
        addkeys_id = 'id',
        addkeys_id_help = 'Speler ID',
        addkeys_plate = 'kenteken',
        addkeys_plate_help = 'Kenteken',
        rkeys = 'Verwijder sleutels van een voertuig voor iemand.',
        rkeys_id = 'id',
        rkeys_id_help = 'Speler ID',
        rkeys_plate = 'kenteken',
        rkeys_plate_help = 'Kenteken',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
