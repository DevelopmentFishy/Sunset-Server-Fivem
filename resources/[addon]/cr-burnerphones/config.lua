Config = {}
function Lcl(txt, ...) if BurnerPhonesLocales[txt] then return string.format(BurnerPhonesLocales[txt], ...) else print('Locale Error, Contact Server Admin. ('..txt..')') end end

Config.Framework = {
    Framework = "QBCore", --"QBCore" | "ESX"
    Interaction = {
        UseTarget = GetConvar('UseTarget', 'false') == 'true', -- Leave true if you are using qb-target. Set to false to disable targetting and enable DrawText for all interactions
        Target = "qb-target", -- "qb-target" | "oxtarget"
        OxLibDistanceCheck = false -- If true, most distance checks are done via oxlib, if false distance checks are done via built-in functions.
    },
    --Framework Overrides (You can change specific framework related functions to ones from other scripts.)
    UseOxInv = false, -- For ESX and QBCore. Lets ESX users utilize the battery usage configuration (Uses Item Metadata).
    Notifications = "qb", -- "okok" | "mythic" | "tnj" | "oxlib" | "qb" | "ESX" | "chat" | NEEDS TO BE SPECIFIED
    ProgressUI = "", -- "oxlib" | "mythic" | "rprogress" (Custom Settings at the bottom) |  Otherwise leave blank ("") to use Framework Settings.
    DrawText = "oxlib", -- "oxlib" | "okok" | "psui" | Otherwise leave blank ("") to use Framework Settings.
}

--General Config.
Config.DevMode = false -- Set to 'true' if you are Testing the Resource (Resets local cooldowns and other StateBags)
Config.Debug = false -- Prints Debug Lines in the console
Config.Logs = false -- True = Logs Enabled | False = Logs Disabled
Config.InteractKey = "G" -- Key to press when interacting with things (Default : G | See Config.KeyList to know which string to change this value to.)
Config.DisableVersionCheck = false -- Disables Version Checking when the script starts

-- VPN Item (Stops police from being called if option enabled)
Config.VPNItem = "burnerphonevpn" -- Item used for the VPN (If not wanting to use the provided VPN)

-- Tsunami Specific Configurations
Config.ServerStartCooldown = false -- true = Cooldown Enabled On Server Start | false = Cooldown Disabled On Server Start
Config.ServerStartCooldownTime = 5 -- Server Start Specific Cooldown (Time Is In Minutes | Cooldown is GLOBAL)

--Police & Dispatch Settings
Config.Police = {
    PoliceJobs = {"police"}, -- Name of the police jobs| Can support multiple jobs
    Dispatch = "qb-policejob", -- "qb-policejob" = qb-policeJob | "cd" = Code Design's Dispatch | "core" = Core Dispatch | "ps-dispatch" | "ESX" = ESX
    TenCode = "911", -- 10-code used for the robbery call (CD Dispatch + Core Dispatch)
}

Config.WaitTime = { -- Time before receiving the drop location after ordering an item
    min = 20,
    max = 45,
}

Config.Burnerphones = {
    -- You can add as man phone items as you want by following the first burnerphone's template
    ['burnerphone'] = { -- Item used to call

        -- Cops
        CopsNeeded = 0, -- Cops needed to be on duty to be able to order from this phone
        CallCops = true, -- When true, has a chance to call cops when ordering with this phone
        VPNEnabled = false, -- Set true if you want the VPN Item to work with this phone, disabling the cop call.
        CallCopsChance = 100, -- Chance for the police to be called when using the phone without a VPN.

        -- Battery
        BatteryType = "chance", -- "chance" = Phones has a random chance to die everytime it's used | "uses" = (FOR QBCORE OR OXINV ONLY) Phone has a predetermined amount of uses
        UseBatteryWhenCooldownActive = true, -- When true, uses phone battery even if the cooldown is active.
        BreakChance = 50, -- if BatteryType == "chance, chance of the phone breaking after using it (is a %)
        Uses = {min = 1, max = 3}, -- if BatteryType == "uses", number of uses the phone can have before breaking.

        -- Cooldown
        CooldownTime = 2, -- Cooldown time for this specific phone.
        LocalCooldown = true, -- When true, the cooldown is specific to the player ordering, meaning multiple people can order from this type of phone at the same time.
        SharedCooldown = true,  -- When true, this phone shares a cooldown with other phones utilizing the shared cooldown option.

        DropOffLocations = { -- Drop Off Locations for this phone. (Can be shared with other phones)
            -- You can add as many locations as you want.
            vector3(-2176.83, 4275.75, 49.1),
            vector3(-1472.19, -150.21, 48.82),
            vector3(167.96, 2231.09, 90.79),
            vector3(-567.95, 5244.17, 70.47),
            vector3(2541.52, 2596.85, 37.94),
            vector3(2545.1, 364.02, 108.61),
            vector3(501.39, -656.02, 24.75),
            vector3(-543.51, 1983.62, 127.03),
            vector3(412.84, -339.29, 46.99),
            vector3(-310.73, 2793.12, 59.48),
            vector3(2288.1, 2074.51, 122.89),
            vector3(2408.68, 3031.7, 48.15),
            vector3(1522.48, 3917.22, 31.67),
            vector3(3336.16, 5164.48, 18.3),
            vector3(2913.33, 4293.5, 50.41),
            vector3(2511.7, 3777.37, 52.97),
            vector3(523.5, 200.99, 104.74),
            vector3(-40.91, 369.07, 112.43),
            vector3(-621.11, 326.89, 82.26),
            vector3(-895.29, -777.94, 15.91),
            vector3(-849.56, -1102.94, 2.16),
            vector3(1138.34, -2344.15, 31.35),
            vector3(1455.27, -1662.46, 66.06),
            vector3(1113.07, -647.58, 56.82),
            vector3(-859.9, -354.12, 38.68)
        },

        Rewards = {
            -- You can add as many items as you want.
            -- Change the quantity with the 'qty' value.
            -- Uses Stacked Probability system. Each item's probability is compared & reward is chosen accordingly. Total prob doesn't need to be round.
            -- You can chose which prop is used for the pickup for each item, simply enter an item hash in the prop section.
            -- Item Hashs can be found here : https://forge.plebmasters.de/objects
            -- You can chose the emote played when searching the item (From RPEmotes).
            [1] = {item = 'lockpick', qty = {min = 1, max = 5}, prob = 3/5, prop = "prop_cs_package_01", emote = "mechanic4"},
            [2] = {item = 'bandage', qty = {min = 1, max = 15}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
            [3] = {item = 'van_necklace', qty = {min = 1, max = 2}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
            [4] = {item = 'coke_figure', qty = {min = 2, max = 6}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
            [5] = {item = 'weed_package', qty = {min = 7, max = 25}, prob = 5/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
            [6] = {item = 'geldrol', qty = {min = 531, max = 1925}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
            [7] = {item = 'meth_bag', qty = {min = 5, max = 10}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
        }
    },
    ['burnerphone_wep'] = { -- Item used to call

        -- Cops
        CopsNeeded = 0, -- Cops needed to be on duty to be able to order from this phone
        CallCops = true, -- When true, has a chance to call cops when ordering with this phone
        VPNEnabled = false, -- Set true if you want the VPN Item to work with this phone, disabling the cop call.
        CallCopsChance = 50, -- Chance for the police to be called when using the phone without a VPN.

        -- Battery
        BatteryType = "uses", -- "chance" = Phones has a random chance to die everytime it's used | "uses" = (FOR QBCORE OR OXINV ONLY) Phone has a predetermined amount of uses
        UseBatteryWhenCooldownActive = true, -- When true, uses phone battery even if the cooldown is active.
        BreakChance = 50, -- if BatteryType == "chance, chance of the phone breaking after using it (is a %)
        Uses = {min = 1, max = 3}, -- if BatteryType == "uses", number of uses the phone can have before breaking.

        -- Cooldown
        CooldownTime = 10, -- Cooldown time for this specific phone.
        LocalCooldown = true, -- When true, the cooldown is specific to the player ordering, meaning multiple people can order from this type of phone at the same time.
        SharedCooldown = true,  -- When true, this phone shares a cooldown with other phones utilizing the shared cooldown option.

        DropOffLocations = { -- Drop Off Locations for this phone. (Can be shared with other phones)
            -- You can add as many locations as you want.
            vector3(-2176.83, 4275.75, 49.1),
            vector3(-1472.19, -150.21, 48.82),
            vector3(167.96, 2231.09, 90.79),
            vector3(-567.95, 5244.17, 70.47),
            vector3(2541.52, 2596.85, 37.94),
            vector3(2545.1, 364.02, 108.61),
            vector3(501.39, -656.02, 24.75),
            vector3(-543.51, 1983.62, 127.03),
            vector3(412.84, -339.29, 46.99),
            vector3(-310.73, 2793.12, 59.48),
            vector3(2288.1, 2074.51, 122.89),
            vector3(2408.68, 3031.7, 48.15),
            vector3(1522.48, 3917.22, 31.67),
            vector3(3336.16, 5164.48, 18.3),
            vector3(2913.33, 4293.5, 50.41),
            vector3(2511.7, 3777.37, 52.97),
            vector3(523.5, 200.99, 104.74),
            vector3(-40.91, 369.07, 112.43),
            vector3(-621.11, 326.89, 82.26),
            vector3(-895.29, -777.94, 15.91),
            vector3(-849.56, -1102.94, 2.16),
            vector3(1138.34, -2344.15, 31.35),
            vector3(1455.27, -1662.46, 66.06),
            vector3(1113.07, -647.58, 56.82),
            vector3(-859.9, -354.12, 38.68)
        },

        Rewards = {
            -- You can add as many items as you want.
            -- Change the quantity with the 'qty' value.
            -- Uses Stacked Probability system. Each item's probability is compared & reward is chosen accordingly. Total prob doesn't need to be round.
            -- You can chose which prop is used for the pickup for each item, simply enter an item hash in the prop section.
            -- Item Hashs can be found here : https://forge.plebmasters.de/objects
            -- You can chose the emote played when searching the item (From RPEmotes).
            [1] = {item = 'weapon_bat', qty = {min = 1, max = 1}, prob = 3/5, prop = "prop_cs_package_01", emote = "mechanic4"},
            [2] = {item = 'weapon_dagger', qty = {min = 1, max = 1}, prob = 1/5, prop = "prop_pizza_box_01", emote = "mechanic4"},
        }
    },
}

Config.KeyList = { -- List of usable keys
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Options for custom progress bar if using RProgress
Config.RProgressUI = {
    Async = true,
    cancelKey = 178,        -- Custom cancel key
    x = 0.5,                -- Position on x-axis
    y = 0.5,                -- Position on y-axis
    Radius = 60,            -- Radius of the dial
    Stroke = 10,            -- Thickness of the progress dial
    Cap = 'butt',           -- or 'round'
    Padding = 0,            -- Padding between the progress dial and the background dial
    MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
    Rotation = 0,           -- 2D rotation of the dial in degrees
    Width = 300,            -- Width of bar in px if Type = 'linear'
    Height = 40,            -- Height of bar in px if Type = 'linear'
    ShowTimer = true,       -- Shows the timer countdown within the radial dial
    ShowProgress = false,   -- Shows the progress % within the radial dial    
    Easing = "easeLinear",
    LabelPosition = "right",
    Color = "rgba(255, 255, 255, 1.0)",
    BGColor = "rgba(0, 0, 0, 0.4)",
    ZoneColor = "rgba(51, 105, 30, 1)",
}