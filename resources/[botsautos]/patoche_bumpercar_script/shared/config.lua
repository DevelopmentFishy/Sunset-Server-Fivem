Config = {}

Config.locale = "en"
Config.debug = false -- Show debug print in client/server consoles
Config.displayBlips = true -- Show Blip on the map
Config.displayMarker = true -- Show Marker for the menu
Config.drawDistance = 5 -- Distance to display the markers
Config.item = 'bumpton' -- The item name needed to launch a bumpercar session
Config.sessionTimer = 60 -- Session duration for 1 coin insertion (in seconds)
Config.vehicleSpawnDelay = 1000 -- If vehicles are not spawning increase the value (in milliseconds)
Config.tokenPrice = 1 -- Price of the Bumpton.
Config.canCarry = false -- If true, enable the esx check if player has enough space in his inventory to carry items.

Config.car_bumper = {
  ["position"] = {
    ["Blip"] = {
        title = "Car Bumper",
        scale = 0.8,
        colour = 1,
        sprite = 147,
        coord = vector3(-1784.76, -1082.79, 14.26)
    },
    ["Shop"] = {
        id = 36,
        r = 255,
        g = 0,
        b = 0,
        scale = 0.7,
        coord = vector3(-1784.76, -1082.79, 14.26)
    },
    ["entitySet"] = {
        id = 32,
        r = 255,
        g = 0,
        b = 0,
        scale = 0.7,
        coord = vector3(-1786.81, -1081.17, 14.26)
    },
  },
}

-- Model of the vehicle you want use.
Config.vehicle_model = "bumpercar"

-- Position of each availables vehicles.
Config.spawnPositions = {
    vec4(-1805.2116699219, -1069.4427490234, 13.282070159912, 49.569038391113),
    vec4(-1802.0295410156, -1072.2222900391, 13.282468795776, 49.569038391113),
    vec4(-1798.5151367188, -1075.1979980469, 13.281814575195, 49.569038391113),
    vec4(-1794.8309326172, -1078.4685058594, 13.280694007874, 49.569038391113),
    vec4(-1772.3796386719, -1096.888671875, 13.280816078186, 229.56057739258),
    vec4(-1775.9572753906, -1093.8162841797, 13.282161712646, 229.56057739258),
    vec4(-1779.4265136719, -1090.7821044922, 13.281734466553, 229.56057739258),
    vec4(-1783.2387695313, -1087.73828125, 13.282382965088, 229.56057739258),
}

Config.entitySet = {
    {
        name = "default", -- DO NOT TOUCH
        label = "Default" -- Name of the scene display on the menu
    },
    {
        name = "game1", -- DO NOT TOUCH
        label = "Game 1" -- Name of the scene display on the menu
    },
    {
        name = "game2", -- DO NOT TOUCH
        label = "Game 2" -- Name of the scene display on the menu
    }
}