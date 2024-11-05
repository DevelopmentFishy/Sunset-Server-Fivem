Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'en'

Config.useESX = false -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'bahama',
        pos = vector3(-1391.35, -604.97, 31.52),
        requiredJob = nil, -- example: requiredJob = "dj" 
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

}