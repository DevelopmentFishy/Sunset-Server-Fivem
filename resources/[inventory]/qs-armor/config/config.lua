Config = {}
Locales = {}

--[[ 
    The first thing will be to choose our main language, here you can choose 
    between the default languages that you will find within locales/*, 
    if yours is not there, feel free to create it!
]]

Config.Language = 'en'
Config.Framework = 'qb' -- 'esx' or 'qb'

--[[  
    General configuration of the resource!
    Configure each part as you wish.
]]

Config.Progressbar = { -- Progressbar Timer.
    UseArmor = 2500,
    UseHeavyArmor = 2500,
    ResetArmor = 2500
}

Config.SetPedArmour = { -- SetPedArmour Quantity.
    UseArmor = 50,
    UseHeavyArmor = 100,
    ResetArmor = 0
}

Config.ResetArmor = 'removearmor' -- Command to remove your vest.

--[[  
    Check vest?
]]

Config.VestTexture = true -- Use Vest texture?
Config.CheckVest = { -- Check if the person has a vest, if they have a vest but do not have it equipped, they put it on automatically
    check = false, -- True = Yes || False = No
    time = 30000 -- If check = true How often do you check? in milliseconds, If check = false ignore this
}

Config.Vest = {
    male = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    },
    female = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    },

    maleHeavy = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    },

    femaleHeavy = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    }
}


--[[  
    Editable functions!
]]

function SetVest() -- If VestTexture = true
    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
end

function SetHeavyVest() -- If VestTexture = true
    SetPedComponentVariation(PlayerPedId(), 9, 62, 0, 0)
end

function RemoveVest()
    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
end

--[[ 
    Debug mode, you can see all kinds of prints/logs using debug, 
    but it's only for development.
]]

Config.Debug = false