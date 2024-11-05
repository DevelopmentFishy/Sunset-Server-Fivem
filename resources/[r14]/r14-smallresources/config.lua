QBCore = exports['qb-core']:GetCoreObject()

Config = {}

------------------------------------------------------------------------------------------------------------
------------------------------------------  CAMERA IMPROVEMENTS --------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.CameraImprovements = {
    ForceFirstPerson = {
        Enabled = false, 
        WhileDriving = false, -- force first person when in a vehicle
        DuringDriveby = false, -- force first person while aiming/shooting from a vehicle
        WhileAiming = false, -- force first person while aiming at any time
    },
    Peek = true -- set this true to allow players to 'peek' through their eyes while holding the camera change keybind
}

------------------------------------------------------------------------------------------------------------
------------------------------------------  VEHICLE IMPROVEMENTS -------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.VehicleImprovements = {
    DisableAirControl = { -- set to true to disable flipping/leaning cars while in the air
        Enabled = false,
        ExemptList = { -- a list of cars to exempt, do not need to add BIKES, PLANES, OR HELICOPTERS, these are exempt by default
            [`deluxo`] = true, -- use the hash of the vehicle
        }        
    }, 
    DisableAutoStart = false, -- set to true if you do not want peds to automaticaly start cars when getting in them
    DisableAutoOff = false, -- set to true if you do not want peds to automatically turn cars off when getting in them
    LiveryCommand = {
	    Enabled = false, -- set to true if you want the livery command to be available
        AllowMod = false, -- set to true if you want player with the mod permission to be able to use it
	    AllowEmergency = false, -- set to true if you want the livery command to only be available to police/esm
	    AllowAll = false, -- set to true if you want everyone to be able to use the command
    },
    SeatCommand = {
        Enabled = false,
        CheckHarness = false, -- set to true if you want to check if a player has a harness before switching
        HarnessCheck = function() -- if you have a third party seatbelt resource, use this function to retrieve the current harness status
            return exports['qb-smallresources']:HasHarness()
        end,
    },
    DoorCommand = true,  -- this will enable to door, hood, and trunk commands
    DomeLightCommand = false, -- this will allow player to toggle the dome light in their car
    WindowCommand = true, -- will allow player to roll windows up and down
}

------------------------------------------------------------------------------------------------------------
--------------------------------------------  PED IMPROVEMENTS ---------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.PedImprovements = {
    DisableActionMode = true, -- set this true if you want to disable Action Mode, aka walking around like an asshole after shooting
    DisableMeleeKeybind = true, -- set this if you want to disable R to melee (does not disable click to melee) 
    DisableHelmetArmor = true, -- disabled armor from helmets
    DisableBikeAndAicraftHelmets = true, -- set to true if you do not want your ped to automatically put on a bike or aicraft helmet
    KeepPropsOnDamage = true, -- set to true if you want peds to keep hats/glasses if hit
    KeepHatsInVehicle = true, -- keep hats when entering or spawning in vehicles
    DisableIdleCam = true, -- disable idle camera when inactive for ~30 seconds
    RelaxedMotorcyclePosture = { -- sets config flag for player to ride motorcycles in a relaxed posture when under 55 mph
        Enabled = true, -- enable relaxed riding style, will not be set by default
        Command = 'riderelaxed', -- set to false to disable command
    }, 
    EnableNightvision = { 
        Enabled = true, -- set to true if you want to enable nightvision for nightvision helmets
        RequireItem = true, -- set to true if you want night vision to only turn on if the player has a specific item, set items below
        Hats = { -- set the hats in your clothing that should enable night vision
            [`MP_F_FREEMODE_01`] = {
                [117] = false, -- four tube NVG's from base game
                [115] = true, -- two tube NVG's from base game
            },
            [`MP_M_FREEMODE_01`] = {
                [118] = false, -- four tube NVG's from base game
                [116] = true, -- two tube NVG's from base game
            },
        },
        Items = {
            ['nachtkijker'] = true, -- set the items that are required if a player wants a night vision hat to enable night vision
            -- ['nvg'] = true, -- this is not an existing item, just an example
            --['nightvision_tube'] = true, -- this is not an existing item, just an example
        },
    }
}

------------------------------------------------------------------------------------------------------------
-------------------------------------------  COMBAT IMPROVEMENTS -------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.CombatImprovements = {
    DisableAutoReload = false, -- set to true to prevent peds from automatically reloading, will require player to reloading
    KeepWeaponFlashlightOn = true, -- set this to true if you want weapon flashlights to remain on when not aiming
    DisableCombatRoll = false, -- disables combat roll (mostly), can still occasionally be done if quickly aiming and mashing spacebar
    RequireAimToFire = true, -- disables firing a weapon without freeaiming 
    SmallReticle = { -- disables default reticle and adds a small one
        Enabled = false,
        Command = 'togglereticle', -- sets command name to toggle reticle
        ScopedWeapons = { -- do not disable reticle for scoped weapons
            [`weapon_sniperrifle`] = true, 
            [`weapon_heavysniper`] = true, 
            [`weapon_heavysniper_mk2`] = true, 
            [`weapon_marksmanrifle`] = true,
            [`weapon_marksmanrifle_mk2`] = true,
        },
    } 
}

------------------------------------------------------------------------------------------------------------
-------------------------------------------   MISC IMPROVEMENTS  -------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.MiscImprovements = {
    Whiteout = {
        Enabled = true, -- set to enable the whiteout command
        ServerStartTrigger = function() -- a function containing the trigger for your weather sync script to set weather to blizzard, change this to match yours
            TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, 'BLIZZARD') -- QBCore
            -- TriggerClientEvent('esx_wsync:updateWeather', -1, 'BLIZZARD') -- ESX
        end,
        ServerEndTrigger = function() -- a function containing the trigger for your weather sync script to return weather to sunny, change this to match yours
            TriggerClientEvent('qb-weathersync:client:SyncWeather', -1, 'EXTRASUNNY') -- QBCore
            -- TriggerClientEvent('esx_wsync:updateWeather', -1, 'EXTRASUNNY') -- ESX
        end,
    }, -- set to true to enable whiteout conditions
    ToggleSnow = true, -- this will enable the toggle snow command
    SnowOnServerStart = false, -- this will make snow on the ground by default on server start
}

------------------------------------------------------------------------------------------------------------
--------------------------------------------  SHARED FUNCTIONS  --------------------------------------------
------------------------------------------------------------------------------------------------------------

Config.Functions = {
    Notify = function(string, notifytype)
        QBCore.Functions.Notify(string, notifytype)
    end,
    Chat = function(args)
        TriggerEvent('chat:addMessage', args)
    end,
    ServerNotify = function(target, string, notifytype)
        TriggerClientEvent('QBCore:Notify', target, string, notifytype)
    end,
}

Config.AuthorizedJobs = {
    LEO = { -- this is for job checks which should only return true for police officers
        Jobs = {['police'] = false, ['fib'] = false, ['sheriff'] = false},
        Types = {['police'] = false, ['leo'] = false},
        Check = function(source)
            local PlyData = nil
            if source then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end
    },
    EMS = { -- this if for job checks which should only return true for ems workers
        Jobs = {['ambulance'] = false, ['fire'] = false},
        Types = {['ambulance'] = false, ['fire'] = false, ['ems'] = false},
        Check = function(source)
            local PlyData = nil
            if source then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.EMS.Jobs[job] or Config.AuthorizedJobs.EMS.Types[jobtype] then return true end
        end
    },
    FirstResponder = { -- do not touch, this is a combined job checking function for emergency services (police and ems)
        Check = function(source)
            local PlyData = nil
            if source then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.LEO.Check(jobtype, job) or Config.AuthorizedJobs.EMS.Check(jobtype, job) then return true end            
        end
    },
}
