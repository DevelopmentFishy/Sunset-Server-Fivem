
Config = {}
Config.Framework = 'qb'  -- esx, oldesx, qb, oldqb or autodetect
Config.InteractionHandler = 'drawtext' -- drawtext, ox_target, qb_target, qb_textui, esx_textui 
Config.Coords = vector3(-551.41, -201.74, 38.23)
Config.Blip = {
    show = true, -- if you want to disable the blip, set this to false
    sprite = 407, 
    color  = 3,
    scale = 0.6,
}
Config.Jobs = {

    {
        name = 'garbage',
        label = 'Vuilnis man/vrouw',
        desc = 'Maak je handen maar vuil',
        payAmountLabel = 75,
        startCoords = vector3(-337.08, -1533.47, 27.72),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
    {
        name = 'bus',
        label = 'Bus',
        desc = 'Kom jij wel op tijd?.',
        payAmountLabel = 75,
        startCoords = vector3(-263.70, -967.10, 31.2),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
    {
        name = 'taxi',
        label = 'Taxi',
        desc = 'Word jij de snelste taxi? En ben je altijd optijd wanneer een klant dit verwacht? Dan is dit de job voor jou!.',
        payAmountLabel = 75,
        startCoords = vector3(896.63, -177.0, 74.69),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'taxi.svg', --html\assets\jobicons
        },
    },
    {
        name = 'trucker',
        label = 'Trucker',
        desc = 'Lever jij je lading veilig af ?.',
        payAmountLabel = 75,
        startCoords = vector3(1207.22, -3114.13, 7.10),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
    {
        name = 'security',
        label = 'Security',
        desc = 'Beveilig jij het geld tijdens het transport ?.',
        payAmountLabel = 75,
        startCoords = vector3(-194.05, -834.93, 32.00),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
    {
        name = 'postop',
        label = 'Post dienst',
        desc = 'Hoe snel kan jij de pakjes leveren?.',
        payAmountLabel = 75,
        startCoords = vector3(1196.41, -3255.62, 7.10),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
    {
        name = 'bouwvakker',
        label = 'Bouw Vakker',
        desc = 'Maak jij onze gebouwen af?.',
        payAmountLabel = 75,
        startCoords = vector3(926.37, -1560.22, 30.74),
        playersCount = 0, -- dont touch
        theme = {
            bgColor = '#6079FF',
            icon = 'Bus-logo.png', --html\assets\jobicons
        },
    },
}