Config = Config or {}

Config.UsingPsHousing = false
Config.UsingDefaultQBApartments = true
Config.OnlyShowOnDuty = true
Config.UseCQCMugshot = true

-- Front, Back Side. Use 4 for both sides, we recommend leaving at 1 for default.
Config.MugPhotos = 1

-- If set to true = Fine gets automatically removed from bank automatically charging the player.
-- If set to false = The fine gets sent as an Invoice to their phone and it us to the player to pay for it, can remain unpaid and ignored.
Config.BillVariation = true

-- If set to false (default) = The fine amount is just being removed from the player's bank account
-- If set to true = The fine amount is beeing added to the society account after being removed from the player's bank account
Config.QBBankingUse = false

-- Set up your inventory to automatically retrieve images when a weapon is registered at a weapon shop or self-registered.
-- If you're utilizing lj-inventory's latest version from GitHub, no further modifications are necessary. 
-- However, if you're using a different inventory system, please refer to the "Inventory Edit | Automatic Add Weapons with images" section in ps-mdt's README.
Config.InventoryForWeaponsImages = "lj-inventory"

-- "LegacyFuel", "lj-fuel", "ps-fuel"
Config.Fuel = "ps-fuel"

-- Google Docs Link
Config.sopLink = {
    ['police'] = '',
    ['ambulance'] = '',
    ['bcso'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',
}

-- Google Docs Link
Config.RosterLink = {
    ['police'] = 'https://docs.google.com/spreadsheets/d/15l6mmfltD-eJf9E16PpGxFZIeyKb825gklKPc88494U/edit#gid=0',
    ['ambulance'] = 'https://docs.google.com/spreadsheets/d/1-1bYvtswZebQlRSjjTkeVKmmixxA6bczVLYDRsD1vFI/edit#gid=0',
    ['bcso'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',	
}

Config.PoliceJobs = {
    ['police'] = true,
    ['lspd'] = true,
    ['bcso'] = true,
    ['sast'] = true,
    ['sasp'] = true,
    ['doc'] = true,
    ['lssd'] = true,
    ['sapr'] = true,
    ['pa'] = true
}

Config.AmbulanceJobs = {
    ['ambulance'] = true,
    ['doctor'] = true
}

Config.DojJobs = {
    ['judge'] = true,
    ['wapendealer'] = true,

}

-- This is a workaround solution because the qb-menu present in qb-policejob fills in an impound location and sends it to the event. 
-- If the impound locations are modified in qb-policejob, the changes must also be implemented here to ensure consistency.

Config.ImpoundLocations = {
    [1] = vector4(436.68, -1007.42, 27.32, 180.0),
    [2] = vector4(-436.14, 5982.63, 31.34, 136.0),
}

-- Support for Wraith ARS 2X. 

Config.UseWolfknightRadar = false
Config.WolfknightNotifyTime = 5000 -- How long the notification displays for in milliseconds (30000 = 30 seconds)
Config.PlateScanForDriversLicense = false -- If true, plate scanner will check if the owner of the scanned vehicle has a drivers license

-- IMPORTANT: To avoid making excessive database queries, modify this config to true 'CONFIG.use_sonorancad = true' setting in the configuration file located at 'wk_wars2x/config.lua'. 
-- Enabling this setting will limit plate checks to only those vehicles that have been used by a player.

Config.LogPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[9] = true,
        [10] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveIncidentPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.Remove = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[9] = true,
        [10] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveReportPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveWeaponsPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[8] = true,
        [9] = true,
        [10] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}
Config.PenalCodeTitles = {
    [1] = 'MISDRIJVEN TEGEN PERSONEN',
    [2] = 'DIEFSTAL',
    [3] = 'FRAUDE',
    [4] = 'MISDRIJVEN TEGEN DE OPENBARE ORDE',
    [5] = 'MISDRIJVEN TEGEN DE OPENBARE VEILIGHEID',
    [6] = 'MISDRIJVEN INZAKE VERBODEN MIDDELEN',
    [7] = 'MISDRIJVEN TIJDENS HET BESTUREN VAN EEN VOERTUIG',
    [8] = 'MISDRIJVEN INZAKE MILIEU EN LEEFOMGEVING',
}

Config.PenalCode = {
    [1] = {
        [1] = {title = 'Aanval zonder wapen', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 180, color = 'green', description = 'Vrijwillig of onvrijwillig aanvallen van een andere persoon zonder hierbij gebruik te maken van een slag- steek- of vuurwapen'},
        [2] = {title = 'Aanval met een slagwapen', class = 'Overtreding', id = 'K.B. 203.5', months = 2, fine = 300, color = 'green', description = 'Vrijwillig of onvrijwillig aanvallen van een andere persoon met een slagwapen'},
        [3] = {title = 'Aanval met een steekwapen', class = 'Overtreding', id = 'K.B. 5.21', months = 4, fine = 450, color = 'green', description = 'Vrijwillig of onvrijwillig aanvallen van een andere persoon met een steekwapen'},
        [4] = {title = 'Aanval met een vuurwapen', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 12, fine = 1300, color = 'orange', description = 'Schieten op een andere persoon'},
        [5] = {title = 'Doodslag - Medeplichtig', class = 'Wanbedrijf', id = 'K.B. 25.369', months = 7, fine = 400, color = 'orange', description = 'Actief getuige zijn, of het aanmoedigen van een gevecht met de dood tot gevolg'},
        [6] = {title = 'Doodslag - Onvrijwillig', class = 'Misdaad', id = 'K.B. 25.369', months = 15, fine = 800, color = 'red', description = 'Slagen en verwondingen met de dood tot gevolg'},
        [7] = {title = 'Moord - Medeplichtig', class = 'Wanbedrijf', id = 'K.B. 25.369', months = 10, fine = 1500, color = 'orange', description = 'Actief getuige zijn, of het aanmoedigen van een Moord'},
        [8] = {title = 'Moord', class = 'Misdaad', id = 'K.B. 25.369', months = 20, fine = 3000, color = 'red', description = 'Al dan niet met voorbedachte rade iemand van het leven beroven met een steek- of vuurwapen'},
        [9] = {title = 'Aanval op een Ambtenaar in functie', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 8, fine = 450, color = 'green', description = 'Een ambtenaar aanvallen zonder hierbij gebruik te maken van een slag- steek- of vuurwapen'},
        [10] = {title = 'Moordpoging Ambtenaar in functie', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 15, fine = 1500, color = 'orange', description = 'Aanvallen van een ambtenaar met een slag- of steekwapen, met zware verwondingen of de dood als gevolg'},
        [11] = {title = 'Schieten op een Ambtenaar in functie', class = 'Misdaad', id = 'K.B. 5.21', months = 20, fine = 3500, color = 'orange', description = 'Gericht schieten op een ambtenaar in functie, al dan niet met de dood tot gevolg'},
        [12] = {title = 'Moord Ambtenaar in functie', class = 'Misdaad', id = 'K.B. 25.369', months = 20, fine = 6000, color = 'red', description = 'Opzettelijke slagen en verwondingen toebrengen aan / Schieten op / een ambtenaar in functie met de dood tot gevolg'},
        [13] = {title = 'Bedreiging', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 200, color = 'green', description = 'Een burger of ambtenaar bedreigen met geweld'},
        [14] = {title = 'Gijzelneming - Medeplichtig', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 5, fine = 500, color = 'orange', description = 'Actief getuige zijn, of het aanmoedigen van gijzelneming'},
        [15] = {title = 'Gijzelneming', class = 'Misdaad', id = 'K.B. 25.369', months = 1, fine = 2000, color = 'red', description = 'Het nemen van één of meerdere gijzelaars'},
        [16] = {title = 'Gijzelneming Ambtenaar in functie', class = 'Misdaad', id = 'K.B. 25.369', months = 15, fine = 5000, color = 'red', description = 'Het gijzelen van een ambtenaar in functie'},
    },
    [2] = {
        [1] = {title = 'Voertuig diefstal - Poging tot', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 150, color = 'green', description = 'Poging tot stelen van een auto, brommer, fiets, ... '},
        [2] = {title = 'Voertuig diefstal', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 5, fine = 300, color = 'orange', description = 'Stelen van een fiets, auto, brommer, ...'},
        [3] = {title = 'Inbraak - Poging of medeplichtig', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 2, fine = 800, color = 'green', description = 'Poging Inbraak in een woning of openbaar gebouw, of medeplichtig zijn hieraan'},
        [4] = {title = 'Inbraak', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 10, fine = 1500, color = 'orange', description = 'Inbraak in een woning of openbaar gebouw'},
        [5] = {title = 'Winkel overval - Poging of medeplichtig', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 0, fine = 200, color = 'green', description = 'Poging tot winkel overval, of medeplichtig zijn hieraan'},
        [6] = {title = 'Winkel overval', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 5, fine = 1200, color = 'orange', description = 'Het overvallen van een winkel'},
        [7] = {title = 'Juwelieroverval - Medeplichtig', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 12, fine = 25000, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [8] = {title = 'Juwelieroverval', class = 'Misdaad', id = 'K.B. 5.21', months = 23, fine = 35000, color = 'orange', description = 'Het, al dan niet succesvol, overvallen van een juwelier'},
        [9] = {title = 'Bankoverval - Medeplichtig', class = 'Wanbedrijf', id = 'K.B. 25.369', months = 5, fine = 5000, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [10] = {title = 'Bankoverval Fleeca', class = 'Misdaad', id = 'K.B. 25.369', months = 17, fine = 15000, color = 'orange', description = 'Persoon was aanwezig in de bank tijdens een, al dan niet succesvolle, overval'},
        [11] = {title = 'Bankoverval Paleto', class = 'Misdaad', id = 'K.B. 25.369', months = 25, fine = 25000, color = 'orange', description = 'Persoon was aanwezig in de bank tijdens een, al dan niet succesvolle, overval'},
        [12] = {title = 'Bankoverval Pacific', class = 'Misdaad', id = 'K.B. 25.369', months = 30, fine = 50000, color = 'red', description = 'Persoon was aanwezig in de bank tijdens een, al dan niet succesvolle, overval'},
        [13] = {title = 'Atm overval - Medeplichtig', class = 'Misdaad', id = 'K.B. 25.369', months = 0, fine = 500, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [14] = {title = 'Atm overval', class = 'Misdaad', id = 'K.B. 25.369', months = 10, fine = 1500, color = 'orange', description = 'Persoon is op heterdaad betrapt en is gezien bij de atm overal toen hij het geld stal of de atm stal'},
        [15] = {title = 'Container overval - Medeplichtig', class = 'Misdaad', id = 'K.B. 25.369', months = 5, fine = 1000, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [16] = {title = 'Container overval', class = 'Misdaad', id = 'K.B. 25.369', months = 15, fine = 2000, color = 'orange', description = 'Persoon is opgepakt bij een containeroverval'},
        [17] = {title = 'Apple winkel overval - Medeplichtig', class = 'Misdaad', id = 'K.B. 25.369', months = 5, fine = 1250, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [18] = {title = 'Apple winkel overval', class = 'Misdaad', id = 'K.B. 25.369', months = 10, fine = 2000, color = 'orange', description = 'Persoon is opgepakt bij een applewinkel'},
        [19] = {title = 'Wapenwinkel overval - Medeplichtig', class = 'Misdaad', id = 'K.B. 25.369', months = 5, fine = 1500, color = 'green', description = 'Het assisteren voor, tijdens, of na een overval (Bijvoorbeeld: inzittende van aangekoppeld voertuig tijdens achtervolging)'},
        [20] = {title = 'Wapenwinkel overval', class = 'Misdaad', id = 'K.B. 25.369', months = 15, fine = 3000, color = 'orange', description = 'Persoon is opgepakt bij een wapenwinkel'},
    },
    [3] = {
        [1] = {title = 'Het niet verstrekken van de identiteit', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 120, color = 'green', description = 'Het niet opgeven van de identiteit, of het niet op zak hebben van een geldig identiteitsbewijs'},
        [2] = {title = 'Zich voordoen als een andere burger', class = 'Overtreding', id = 'K.B. 203.5', months = 5, fine = 650, color = 'orange', description = 'Zich voordoen als een ambtenaar, in of uit functie'},
        [3] = {title = 'Identiteitsdiefstal', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 15, fine = 7500, color = 'orange', description = 'Het op zak hebben van de identiteitskaart van een andere persoon'},
        [4] = {title = 'Zich voordoen als een ambtenaar', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 5, fine = 2500, color = 'red', description = 'zich voordoen als een ambtenaar in, of uit functie'},
        [5] = {title = 'Dragen van een masker', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 569, color = 'green', description = 'Het dragen van een masker'},
        [6] = {title = 'Omkopen van een ambtenaar', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 0, color = 'green', description = 'Onze korps is niet corrupt, smijt deze vis maar terug'},
        [7] = {title = 'Witwassen van geld', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 12, fine = 1200, color = 'orange', description = 'Zwart geld witwassen: de persoon heeft grote aantallen geldrollen, of veel cash geld op zak'},
        [8] = {title = 'Afpersing', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 8, fine = 2100, color = 'red', description = 'Het afpersen of overvallen van een persoon, indien met geweld: toevoegen van straffen onder MISDRIJVEN TEGEN PERSONEN'},

    },
    [4] = {
        [1] = {title = 'Sluikstorten', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 30, color = 'green', description = 'Het op straat, of in openbare gebouwen, achterlaten van kleine bruine zakjes'},
        [2] = {title = 'Vandalisme', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 120, color = 'green', description = 'Vernielng van voertuigen, vuilbakken, verkeerslichten, ... BOETE VERMEERDEREN MET SCHADE'},
        [3] = {title = 'Brandstichting', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 0, fine = 250, color = 'orange', description = 'Het uit de hand lopen van een BBQ'},
        [4] = {title = 'Bevel negeren', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 260, color = 'orange', description = 'Niet gehoorzamen aan een amnbtenaar in functie'},
        [5] = {title = 'Valse aangifte doen', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 145, color = 'orange', description = 'Liegen tegen een ambetnaar in functie'},
        [6] = {title = 'Rondhangen', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 220, color = 'green', description = 'Doelloos rondhangen op openbaar terrein of openbare gebouwen'},
        [7] = {title = 'Stalking', class = 'Overtreding', id = 'K.B. 203.5', months = 5, fine = 500, color = 'red', description = 'Het achtervolgen of lastigvallen van andere personen'},
        [8] = {title = 'Verstoren van de vrede', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 160, color = 'green', description = 'Lawaai maken of overlast bezorgen op openbaar of privédomein'},
    },
    [5] = {
        [1] = {title = 'Bezit van een Slagwapen', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 0, color = 'green', description = 'Ga jij nooit golfen of honkballen? Heb jij geen hobbies ofzo?'},
        [2] = {title = 'Bezit van een steekwapen', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 0, color = 'green', description = 'Hoe smeer je anders je boterhammetjes?'},
        [3] = {title = 'Holster dragen', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 12, fine = 2500, color = 'orange', description = 'Dragen van een holster zonder vuurwapen'},
        [4] = {title = 'Vuurwapenbezit', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 12, fine = 5000, color = 'red', description = 'Bezit van een vuurwapen of kogels'},
        [5] = {title = 'Herbergen van een voortvluchtige', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 10, fine = 3500, color = 'green', description = 'Het herbergen of assisteren van een voortvluchtige'},
        [6] = {title = 'Ontsnapping - medeplichtig', class = 'Wanbedrijf', id = 'K.B. 25.369', months = 12, fine = 6000, color = 'orange', description = 'Medeplichtigheid aan het helpen van een ontsnapping uit voorlopige hechtenis, het HB of de gevangenis'},
        [7] = {title = 'Ontsnapping', class = 'Misdaad', id = 'K.B. 25.369', months = 20, fine = 14000, color = 'red', description = 'Ontsnappen uit voorlopige hechtenis, het HB of de gevangenis'},
        [8] = {title = 'Wapenhandel', class = 'Misdaad', id = 'K.B. 25.369', months = 40, fine = 120000, color = 'red', description = 'Verkoop van vuurwapens'},
    },
    [6] = {
        [1] = {title = 'Bezit - Wiet', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 120, color = 'green', description = 'bezit van wietzaden, planten, of zakjes'},
        [2] = {title = 'Bezit - Coke of Meth', class = 'Overtreding', id = 'K.B. 203.5', months = 3, fine = 300, color = 'orange', description = 'bezit van coca bladeren, chemicaliën, of zakjes'},
        [3] = {title = 'Bezit - Heroïne of Crack', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 120, color = 'orange', description = 'bezit van papaver of zakjes'},
        [4] = {title = 'Bezit - Overig ', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 80, color = 'green', description = 'bezit van LSD, XTC, Paddo, of andere verdovende middelen'},
        [5] = {title = 'Dealen - Wiet', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 850, color = 'green', description = 'Straatverkoop'},
        [6] = {title = 'Dealen - Coke of Meth', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 850, color = 'orange', description = 'Straatverkoop'},
        [7] = {title = 'Dealen - Heroïne of Crack', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 850, color = 'orange', description = 'Straatverkoop'},
        [8] = {title = 'Dealen - Overig ', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 850, color = 'orange', description = 'Verkoop van LSD, XTC, Paddo, of andere verdovende middelen'},
    },
    [7] = {
        [1] = {title = 'Negeren van een rood licht', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 80, color = 'green', description = 'Door het rood rijden'},
        [2] = {title = 'Negeren van (stop)borden', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 53, color = 'green', description = 'Het negeren van borden en/of van de wegmarkering'},    
        [3] = {title = 'Roekeloos rijden', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 160, color = 'orange', description = 'Het potentieel in gevaar brengen van anderen door diens rijgedrag'},   
        [4] = {title = 'Levensgevaarlijk rijgedrag', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 320, color = 'red', description = 'Omverrijden van hersenlozen'}, 
        [5] = {title = 'Rijden onder invloed', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 180, color = 'green', description = 'Alcohol of drugs op zijn persoon hebben tijdens het besturen van een voertuig'},
        [6] = {title = 'Snelheidsovertreding', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 52, color = 'green', description = 'meer dan 50 km/h te snel rijden'},
        [7] = {title = 'Snelheidsovertreding', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 200, color = 'orange', description = 'meer dan 100 km/h te snel rijden'},
        [8] = {title = 'Snelheidsovertreding', class = 'Overtreding', id = 'K.B. 203.5', months = 15, fine = 500, color = 'red', description = 'meer dan 150 km/h te snel rijden'},
        [9] = {title = 'Vluchten van politie', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 150, color = 'green', description = 'Vluchten van politie'},
    },
    [8] = {
        [1] = {title = 'Jagen buiten jachtgebied', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 0, color = 'green', description = 'Jagen buiten het jachtgebied, VERGUNNING AFNEMEN VOOR 1 DAG'},
        [2] = {title = 'Jagen zonder vergunning', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 400, color = 'green', description = 'Jagen zonder vergunning - WAPEN AFNEMEN'},
        [3] = {title = 'Vissen op bedreigde soorten', class = 'Overtreding', id = 'K.B. 203.5', months = 0, fine = 0, color = 'green', description = 'Vissen op Haai, Schildpad, Piranha, ... VERGUNNING AFNEMEN VOOR 1 DAG'},
        [4] = {title = 'Verkoop van bedreigde visen', class = 'Wanbedrijf', id = 'K.B. 203.5', months = 0, fine = 6500, color = 'red', description = 'Verkoop van beschermde vissen - Zie lijst bij VISSEN OP BEDREIGDE SOORTEN'},
        [5] = {title = 'Dierenmishandeling', class = 'Wanbedrijf', id = 'K.B. 5.21', months = 0, fine = 1400, color = 'orange', description = 'Het, al dan niet moedwillig, mishandelen van dieren'},
    },
}

Config.AllowedJobs = {}
for index, value in pairs(Config.PoliceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.AmbulanceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.DojJobs) do
    Config.AllowedJobs[index] = value
end

Config.ColorNames = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

Config.ColorInformation = {
    [0] = "black",
    [1] = "black",
    [2] = "black",
    [3] = "darksilver",
    [4] = "silver",
    [5] = "bluesilver",
    [6] = "silver",
    [7] = "darksilver",
    [8] = "silver",
    [9] = "bluesilver",
    [10] = "darksilver",
    [11] = "darksilver",
    [12] = "matteblack",
    [13] = "gray",
    [14] = "lightgray",
    [15] = "black",
    [16] = "black",
    [17] = "darksilver",
    [18] = "silver",
    [19] = "utilgunmetal",
    [20] = "silver",
    [21] = "black",
    [22] = "black",
    [23] = "darksilver",
    [24] = "silver",
    [25] = "bluesilver",
    [26] = "darksilver",
    [27] = "red",
    [28] = "torinored",
    [29] = "formulared",
    [30] = "blazered",
    [31] = "gracefulred",
    [32] = "garnetred",
    [33] = "desertred",
    [34] = "cabernetred",
    [35] = "candyred",
    [36] = "orange",
    [37] = "gold",
    [38] = "orange",
    [39] = "red",
    [40] = "mattedarkred",
    [41] = "orange",
    [42] = "matteyellow",
    [43] = "red",
    [44] = "brightred",
    [45] = "garnetred",
    [46] = "red",
    [47] = "red",
    [48] = "darkred",
    [49] = "darkgreen",
    [50] = "racingreen",
    [51] = "seagreen",
    [52] = "olivegreen",
    [53] = "green",
    [54] = "gasolinebluegreen",
    [55] = "mattelimegreen",
    [56] = "darkgreen",
    [57] = "green",
    [58] = "darkgreen",
    [59] = "green",
    [60] = "seawash",
    [61] = "midnightblue",
    [62] = "darkblue",
    [63] = "saxonyblue",
    [64] = "blue",
    [65] = "blue",
    [66] = "blue",
    [67] = "diamondblue",
    [68] = "blue",
    [69] = "blue",
    [70] = "brightblue",
    [71] = "purpleblue",
    [72] = "blue",
    [73] = "ultrablue",
    [74] = "brightblue",
    [75] = "darkblue",
    [76] = "midnightblue",
    [77] = "blue",
    [78] = "blue",
    [79] = "lightningblue",
    [80] = "blue",
    [81] = "brightblue",
    [82] = "mattedarkblue",
    [83] = "matteblue",
    [84] = "matteblue",
    [85] = "darkblue",
    [86] = "blue",
    [87] = "lightningblue",
    [88] = "yellow",
    [89] = "yellow",
    [90] = "bronze",
    [91] = "yellow",
    [92] = "lime",
    [93] = "champagne",
    [94] = "beige",
    [95] = "darkivory",
    [96] = "brown",
    [97] = "brown",
    [98] = "lightbrown",
    [99] = "beige",
    [100] = "brown",
    [101] = "brown",
    [102] = "beechwood",
    [103] = "beechwood",
    [104] = "chocoorange",
    [105] = "yellow",
    [106] = "yellow",
    [107] = "cream",
    [108] = "brown",
    [109] = "brown",
    [110] = "brown",
    [111] = "white",
    [112] = "white",
    [113] = "beige",
    [114] = "brown",
    [115] = "brown",
    [116] = "beige",
    [117] = "steel",
    [118] = "blacksteel",
    [119] = "aluminium",
    [120] = "chrome",
    [121] = "wornwhite",
    [122] = "offwhite",
    [123] = "orange",
    [124] = "lightorange",
    [125] = "green",
    [126] = "yellow",
    [127] = "blue",
    [128] = "green",
    [129] = "brown",
    [130] = "orange",
    [131] = "white",
    [132] = "white",
    [133] = "darkgreen",
    [134] = "white",
    [135] = "pink",
    [136] = "pink",
    [137] = "pink",
    [138] = "orange",
    [139] = "green",
    [140] = "blue",
    [141] = "blackblue",
    [142] = "blackpurple",
    [143] = "blackred",
    [144] = "darkgreen",
    [145] = "purple",
    [146] = "darkblue",
    [147] = "black",
    [148] = "purple",
    [149] = "darkpurple",
    [150] = "red",
    [151] = "darkgreen",
    [152] = "olivedrab",
    [153] = "brown",
    [154] = "tan",
    [155] = "green",
    [156] = "silver",
    [157] = "blue",
    [158] = "black",
}

Config.ClassList = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

function GetJobType(job)
	if Config.PoliceJobs[job] then
		return 'police'
	elseif Config.AmbulanceJobs[job] then
		return 'ambulance'
	elseif Config.DojJobs[job] then
		return 'doj'
	else
		return nil
	end
end
