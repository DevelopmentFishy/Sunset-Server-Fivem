Config = {}

-- Framework.ESX
-- Framework.QBCORE
Config.Framework = Framework.ESX

Config.Locale = "en"

Config.SeeOwnLabel = true

Config.TextSize = 0.8
Config.Offset = vector3(0, 0, 1.2)
Config.NearCheckWait = 500

Config.GroupLabels = {
    ESX = {
        -- group system that used to work on numbers only
        [1] = {
            [1] = "HELPER",
            [2] = "~g~MODERATOR",
            [3] = "~b~ADMINISTRATOR",
            [4] = "~r~ADMINISTRATOR",
            [5] = "~r~ADMINISTRATOR",
        },
        -- group system that works on name
        [2] = {
            helper = "HELPER",
            mod = "~g~MODERATOR",
            admin = "~b~ADMINISTRATOR",
            superadmin = "~r~ADMINISTRATOR",
        },
    },

    QBCore = {
        -- group system that works on ACE
        [1] = {
            god = "~r~ADMINISTRATOR",
            admin = "~b~ADMINISTRATOR",
            mod = "~g~MODERATOR",
        },
    }
}