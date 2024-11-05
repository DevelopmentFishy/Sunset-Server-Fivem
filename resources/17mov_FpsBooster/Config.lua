Config = {}

Config.useModernUI = true       -- In march 2023 the script was reworked and the new, modern ui has been released. We're supporting the old version, so you can switch here to old ui. To make it, just set it to false.

Config.GlobalSettings = {
    ["peds"] = false,
    ["vehicles"] = false,
    ["objects"] = false,
    ["particles"] = false,

    ["rain"] = false,
    ["shadows"] = false,
    ["lights"] = false,

    ["broken"] = false,
    ["unnecessary"] = false,
    ["ped"] = false,
    ["lowTexture"] = false,
}

-- 

Config.Key = "F11"
Config.DisableKeybind = false
Config.CommandString = "fpsMenu"

-- Exports:
    -- 1. setSetting:
        -- exports["17mov_FpsBooster"]:setSetting("peds", true)
        

RegisterNetEvent("fpsBooster:OpenMenu", function()
    ExecuteCommand(Config.CommandString)
end)