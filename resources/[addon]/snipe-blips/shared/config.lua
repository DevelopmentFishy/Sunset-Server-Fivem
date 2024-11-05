Config = {}


Config.Core = "QBCore" -- ESX or QBCore
Config.CoreFolderName = "qb-core"  -- es_extended || qb-core

Config.PlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded" -- esx:playerLoaded || QBCore:Client:OnPlayerLoaded
Config.PlayerUnloadEvent = "QBCore:Client:OnPlayerUnload" -- esx:onPlayerLogout || QBCore:Client:OnPlayerUnload   
Config.JobUpdateEvent = "QBCore:Client:OnJobUpdate" -- esx:setJob || QBCore:Client:OnJobUpdate
Config.GangUpdateEvent = "QBCore:Client:OnGangUpdate" -- only for QBCore 


Config.UseFrameworkDutySystem = true -- if you use an external script for onduty system, make sure to edit it in cl_framework.lua.
Config.ShowOwnBlip = true -- if you want to show your own blip on the map, set this to true. If you want to hide your own blip, set this to false.

-- if the radio channel is 100 or above, it wont show on the blip
Config.ShowRadioChannelOnBlip = true -- if you want to show radio channel on the blip, set this to true. If you want to hide radio channel, set this to false.

Config.FlashingBlips = true
Config.FlashingBlipsTimer = 100 -- default speed (every 100ms it will toggle between color and flashing_color)

Config.TrackerItems = {
    enabled = true, -- if you want to enable tracker items, set this to true. If you want to disable tracker items, set this to false.
    jobItemName = "tracker", -- item name to use to enable blips for jobs
    gangItemName = "gangtracker", -- item name to use to enable blips for gangs
}

Config.NotifyAllOtherMembers = true -- this will notify other members of the group/job/gang when the tracker is removed from the player. If you want to disable this, set this to false.

-- if player change callsign in game, they need to toggle duty for the new callsign to take effect!
Config.ShowCallSign = true -- if you want to show callsign in the blip name, set this to true. If you want to hide callsign, set this to false.

Config.Blips = {
    ["police"] = {
        color = 3, -- blip color for police
        flashing_color = 1, -- blip color for flashing police (will toggle between color and flashing_color)
    },
    ["ambulance"] = {
        color = 5, -- blip color for ambulance
        flashing_color = 1, -- blip color for flashing ambulance (will toggle between color and flashing_color)
    }
}

Config.GroupJobs = { -- here you can create groups so you can have police job people able to see ambulance blips and vice versa
-- if you add same job to two groups, it will only pick the first that it finds while iterating through the loop and add them to that group so make sure you dont add same job to two groups 
-- also make sure the group name is not a job to avoid race conditions
    ["policegroup"] = {"police", "ambulance"},
}


Config.GangBlips = {
    -- only for QBCore (if you use esx, you will have to edit a bunch of things to make it compatible with your own gang system)
    -- in ESX, gangs are jobs, so just add them on top
    ["ballas"] = {
        color = 7
    }
}

Config.Sprites = {
    bike = 559, -- blip to show when player is on bike
    boat = 427, -- blip to show when player is on boat
    heli = 43, -- blip to show when player is on heli
    plane = 423, -- blip to show when player is on plane
    car = 672, -- blip to show when player is on car
    foot = 1, -- blip to show when player is on foot
}


Config.ShortRangeBlips = true
Config.ShowCone = false