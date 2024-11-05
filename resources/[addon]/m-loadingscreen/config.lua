Config = {}
-- For more info check https://codem.gitbook.io/codem-documentation/

Config.Theme = 'mango' --  sky, blvck, cherry, kush, mango, proxima
Config.Logo = 'default' -- Default or URL link
Config.BackgroundImage = 'background.png' -- default or custom image/video
-- Backgrounds can be found in html/assets/background/
-- Config.BackgroundImage = 'background.png'
Config.PlayMusicByDefault = true -- if true plays the music when loading screen is active

--html\assets\music
Config.Musics = {
    "music.mp3",

}

-- To display on left menu (must be an image)
-- Supports max 2 images
Config.AlbumsThumbnail = {
    {
        source = 'https://media.discordapp.net/attachments/1191002982477746217/1214657712076357642/screenshot.jpg?ex=65f9e925&is=65e77425&hm=dd8fadec005dac572ad93c4b8467bcb3904a56a8f5374a0266b9ba47271bcbb6&=&format=webp&width=1193&height=671', -- Must be a link
    },
    {
        source = 'https://media.discordapp.net/attachments/1191002982477746217/1213478038411419708/screenshot.jpg?ex=65f59e7d&is=65e3297d&hm=6b7677365c8a0fb569807dbca2cadd7c09723aadcba3fa2d13820fdef257bf75&=&format=webp&width=1193&height=671', -- Must be a link
    }
}

Config.Albums = {
    {
        source = 'https://media.discordapp.net/attachments/1191002982477746217/1213129927554113576/screenshot.jpg?ex=65f45a49&is=65e1e549&hm=8917e28cf9753262245147a8f6987ea598f4386d5e12c068d25a8a090ce480cf&=&format=webp&width=1193&height=671', -- Must be a link
    },
    {
        source = 'https://media.discordapp.net/attachments/1191002982477746217/1212529619819823205/screenshot.jpg?ex=65fb65b5&is=65e8f0b5&hm=e7fc09f1d8bd238a1353f1f4322b53204d34090568c9bfed4f505a7bd4d0e5e2&=&format=webp&width=1193&height=671', -- Must be a link
    }
}


Config.EnableHintMessages = false
Config.HintMessages = {
    {
        text= 'Wist je dat je kon antwoorden en chatten met staff in een report door opnieuw /Report te doen?',
        time= 8000,
    },
    {
        text= 'Wist je dat je uw hud kan veranderen? Dat kan via /hudsettings',
        time= 3000,
    },
    {

        text= 'Wist je dat je auto kan herstellen als er geen mechanicer in de stad is ga dan even bij bennys.',
        time= 1000,
    }
}


Config.ButtonLinks = {
   -- ["twitter"] = 'https://twitter.com',
   -- ["instagram"] = 'https://www.instagram.com/',
    --["reddit"] = 'https://www.reddit.com/',
    ["discord"] = 'https://discord.gg/',
}

Config.ServerName = 'Sunset'

Config.Language = {
    ["WELCOME"] = 'Welkom op',
    ["INSIDE_CITY"] = 'In de stad',
    ["FOOTAGES"] = 'Leuke fotos van de stad.',
    ["PATCH_NOTES"] = 'Patch Notes',
    ["PATCH_NOTES_VERSION"] = 'Patch Notes v1.0',
    ["LATEST_UPDATES"] = 'Latest updates...',
    ["FOLLOW_CITY"] = 'Follow the city on social!',


    ["CITY_LOADING"] = 'Even wachten we zijn de stad aan het laden...',
    ["SETTINGS"] = 'Instellingen',
    ["ENABLE_MUSIC"] = 'Enable music',
    ["SHOW_MENU"] = 'Show left menu',
    ["SHOW_HINT"] = 'Show hint',
    ["SHOW_ALL"] = 'Show all UI',



    ["KEYBINDS_INFO"] = 'Please click a highlighted key to see binding on the right panel.',
    ["KEYBINDS_INFO_2"] = 'Some keybindings can be changed from in game settings. To change them',
    ["GO_TO"] = 'go to',
    ["FIVEM_SETTINGS"] = 'ESC>Settings>Keybindings>FiveM',
    ["PRESS"] = 'Press',
    ["DOUBLE_PRESS"] = 'Double Press',
    ["COMBINATIONS"] = 'Combinations',
    ["KEYBINDS_INFO_3"] = 'Please click on a key to display binding.',
    ["KEYBINDS_INFO_4"] = 'Be aware that those are settings commands and there are many more commands in game.',

    ["COMMANDS"] = 'Commands',
    ["SHOW_ALL_UI"] = 'Show All Commands',
    ["SELECT_COMMAND"] = 'Please select a command',
    ["DISPLAY_BINDING"] = 'display binding',
    ["COMMANDS_INFO"] = 'Please click on a command to see the function on the right panel.',
    ["HINT"] = 'Hint',

}

Config.PatchNotes = {
    "",
    "",
    "",
    "",
}

Config.Keybinds = {
    ["ESC"] = false,
    ["F1"] = {
        ["pressInfo"] = 'Opens the phone',
        ["doublePressInfo"] = false,
    },
    ["F2"] = false,
    ["F3"] = false,
    ["F4"] = false,
    ["F5"] = false,
    ["F6"] = {
        ["pressInfo"] = 'Opens the job interaction menu',
    },
    ["F7"] = false,
    ["F8"] = false,
    ["F9"] = false,
    ["F10"] = false,
    ["F11"] = false,
    ["F12"] = false,
    ["“"] = false,
    ["1"] = {
        ["pressInfo"] = 'Inventory hot key',
    },
    ["2"] = {
        ["pressInfo"] = 'Inventory hot key',

    },
    ["3"] = {
        ["pressInfo"] = 'Inventory hot key',

    },
    ["4"] = {
        ["pressInfo"] = 'Inventory hot key',

    },
    ["5"] = {
        ["pressInfo"] = 'Inventory hot key',

    },
    ["6"] = false,
    ["7"] = false,
    ["8"] = false,
    ["9"] = false,
    ["0"] = false,
    ["-"] = false,
    ["+"] = false,
    ["BACKSPACE"] = false,
    ["TAB"] = false,
    ["Q"] = false,
    ["W"] = false,
    ["E"] = false,
    ["R"] = false,
    ["T"] = {
        ["pressInfo"] = 'Opens the chat',
    },
    ["Y"] = false,
    ["U"] = false,
    ["I"] = false,
    ["O"] = false,
    ["P"] = false,
    ["["] = false,
    ["]"] = false,
    ["ENTER"] = {
        ["pressInfo"] = 'Opens the chat',
    },
    ["CAPS"] = false,
    ["A"] = false,
    ["S"] = false,
    ["D"] = false,
    ["F"] = false,
    ["G"] = false,
    ["H"] = false,
    ["J"] = false,
    ["K"] = false,
    ["L"] =  {
        ["pressInfo"]=  'Locks the vehicle',
        ["doublePressInfo"]=  'Opens the remote UI.',
    },
    [";"] =  false,
    ["@"] =  false,
    ["LSHIFT"] =  {
        ["pressInfo"] = 'Run',
        ["doublePressInfo"] = false,
        ["combinations"] = {
            {
                ["key"] = 'E',
                ["info"] = 'Tackle',
            },
            {
                ["key"] = 'H',
                ["info"] = 'Push vehicle',
            },
            {
                ["key"] = 'G',
                ["info"] = 'Carry on arm',
            },
        },
    },
    ["Z"] =  false,
    ["X"] =  false,
    ["C"] =  false,
    ["V"] =  false,
    ["B"] =  false,
    ["N"] =  false,
    ["M"] =  false,
    ["<"] =  false,
    [">"] =  false,
    ["?"] =  false,
    ["RSHIFT"] =  false,
    ["LCTRL"] =  false,
    ["ALT"] =  false,
    ["SPACE"] = false,
    ["ALTGR"] = false,
    ["RCTRL"] = false,
}
-- add only 2 commands here
Config.PreviewCommands = {
    ["hud"]= 'Opens hud settings.',
    ["notify"]= 'Opens notify settings.',
}

Config.Commands = {
    ["hud"]= 'Opens hud settings.',
    ["notify"]= 'Opens notify settings.',
    ["inventoryfix"]= 'Fixes inventory UI.',
    ["radialfix"]= 'Fixes radial menu UI.',
    ["report"]= 'Opens report menu.',
    ["kill"]= 'Kills the player with specified id.',
    ["admin"]= 'Opens admin menu.',
    ["emotes"]= 'Opens emotes menu.',
    ["pet"]= 'Opens pet menu.',
    ["mdt"]= 'Opens mdt.',
    ["repair"]= 'Fixes the vehicle you are driving.',
}



