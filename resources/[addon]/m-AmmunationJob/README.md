# m-AmmunationJob script for QB-Core & ESX

- Thank you very much for downloading this product! Hope you have fun!
- If you are intested in recieving updates join the community on **[Discord](https://discord.gg/marcinhu)**! |


# About
* We want to guarantee an ammu-nation work with legal and illegal parts. The script is embedded with 42 blueprints, and configured with some pre-configured weapons in the config.lua file. Menus, targets, locations are all configurable by you. It is possible for players to test weapons in the firing zone behind the shop. To craft weapons you need to gather metal & weapon parts along with purchasing the blueprint associated with the weapon.

# Preview:

- https://www.youtube.com/watch?v=ZZ8vJpSkL1c

# Features
- Optimized
- 0.00ms
- 44 Blueprints Available
- Craft Weapons
- Test Weapons
- Collecting Pieces
- Level System ( mz-skills )
- Compatible Phones: qb-phone / qs-smartphone  / gksphone / roadphone / d-phone / renewed-phone / lb-phone
- All locations customizable
- Language available: PT / EN


# Install the script:

**qb-core/shared/items.lua**
```
    ["weapon_pieces"]           = {["name"] = "weapon_pieces",          ["label"] = "Weapon Pieces",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "weapon_pieces.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["weapon_metal"]            = {["name"] = "weapon_metal",           ["label"] = "Weapon Metal",                 ["weight"] = 50,    ["type"] = "item",  ["image"] = "weapon_metal.png",         ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},

    -- Blueprints
    ["bpadvancedrifle"]         = {["name"] = "bpadvancedrifle",        ["label"] = "BP: Advanced Rifle",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpadvancedrifle.png",      ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpappistol"]              = {["name"] = "bpappistol",             ["label"] = "BP: AP Pistol",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpappistol.png",           ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpassaultrifle"]          = {["name"] = "bpassaultrifle",         ["label"] = "BP: Assault Rifle",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpassaultrifle.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpassaultriflemk2"]       = {["name"] = "bpassaultriflemk2",      ["label"] = "BP: Assault Rifle Mk2",        ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpassaultriflemk2.png",    ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpassaultshotgun"]        = {["name"] = "bpassaultshotgun",       ["label"] = "BP: Assault Shotgun",          ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpassaultshotgun.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpassaultsmg"]            = {["name"] = "bpassaultsmg",           ["label"] = "BP: Assault Smg",              ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpassaultsmg.png",         ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpbullpuprifle"]          = {["name"] = "bpbullpuprifle",         ["label"] = "BP: Bullpup Rifle",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpbullpuprifle.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpbullpupriflemk2"]       = {["name"] = "bpbullpupriflemk2",      ["label"] = "BP: Bullpup Rifle Mk2",        ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpbullpupriflemk2.png",    ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpbullpupshotgun"]        = {["name"] = "bpbullpupshotgun",       ["label"] = "BP: Bullpup Shotgun",          ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpbullpupshotgun.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcarbinerifle"]          = {["name"] = "bpcarbinerifle",         ["label"] = "BP: Carbine Rifle",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcarbinerifle.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcarbineriflemk2"]       = {["name"] = "bpcarbineriflemk2",      ["label"] = "BP: Carbine Rifle Mk2",        ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcarbineriflemk2.png",    ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpceramicpistol"]         = {["name"] = "bpceramicpistol",        ["label"] = "BP: Ceramic Pistol",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpceramicpistol.png",      ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcombatmg"]              = {["name"] = "bpcombatmg",             ["label"] = "BP: Combat Mg",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcombatmg.png",           ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcombatmgmk2"]           = {["name"] = "bpcombatmgmk2",          ["label"] = "BP: Combat Mg Mk2",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcombatmgmk2.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcombatpdw"]             = {["name"] = "bpcombatpdw",            ["label"] = "BP: Combat Pdw",               ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcombatpdw.png",          ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcombatpistol"]          = {["name"] = "bpcombatpistol",         ["label"] = "BP: Combat Pistol",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcombatpistol.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcombatshotgun"]         = {["name"] = "bpcombatshotgun",        ["label"] = "BP: Combat Shotgun",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcombatshotgun.png",      ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpcompactrifle"]          = {["name"] = "bpcompactrifle",         ["label"] = "BP: Compact Rifle",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpcompactrifle.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpgusenberg"]             = {["name"] = "bpgusenberg",            ["label"] = "BP: Gusenberg",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpgusenberg.png",          ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpheavypistol"]           = {["name"] = "bpheavypistol",          ["label"] = "BP: Heavy Pistol",             ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpheavypistol.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpheavyshotgun"]          = {["name"] = "bpheavyshotgun",         ["label"] = "BP: Heavy Shotgun",            ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpheavyshotgun.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpheavysniper"]           = {["name"] = "bpheavysniper",          ["label"] = "BP: Heavy Sniper",             ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpheavysniper.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpheavysnipermk2"]        = {["name"] = "bpheavysnipermk2",       ["label"] = "BP: Heavy Sniper Mk2",         ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpheavysnipermk2.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpmachinepistol"]         = {["name"] = "bpmachinepistol",        ["label"] = "BP: Machine Pistol",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpmachinepistol.png",      ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpmarksmanrifle"]         = {["name"] = "bpmarksmanrifle",        ["label"] = "BP: Marksman Rifle",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpmarksmanrifle.png",      ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpmarksmanriflemk2"]      = {["name"] = "bpmarksmanriflemk2",     ["label"] = "BP: Marksman Rifle Mk2",       ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpmarksmanriflemk2.png",   ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpmicrosmg"]              = {["name"] = "bpmicrosmg",             ["label"] = "BP: Micro Smg",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpmicrosmg.png",           ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpminismg"]               = {["name"] = "bpminismg",              ["label"] = "BP: Mini Smg",                 ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpminismg.png",            ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpmusket"]                = {["name"] = "bpmusket",               ["label"] = "BP: Musket",                   ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpmusket.png",             ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpnavyrevolver"]          = {["name"] = "bpnavyrevolver",         ["label"] = "BP: Heavy Revolver",           ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpnavyrevolver.png",       ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bppistol"]                = {["name"] = "bppistol",               ["label"] = "BP: Pistol",                   ["weight"] = 50,    ["type"] = "item",  ["image"] = "bppistol.png",             ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bppistol50"]              = {["name"] = "bppistol50",             ["label"] = "BP: Pistol 50",                ["weight"] = 50,    ["type"] = "item",  ["image"] = "bppistol50.png",           ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bppistolmk2"]             = {["name"] = "bppistolmk2",            ["label"] = "BP: Pistol Mk2",               ["weight"] = 50,    ["type"] = "item",  ["image"] = "bppistolmk2.png",          ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bppumpshotgun"]           = {["name"] = "bppumpshotgun",          ["label"] = "BP: Pump Shotgun",             ["weight"] = 50,    ["type"] = "item",  ["image"] = "bppumpshotgun.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bppumpshotgunmk2"]        = {["name"] = "bppumpshotgunmk2",       ["label"] = "BP: Pump Shotgun Mk2",         ["weight"] = 50,    ["type"] = "item",  ["image"] = "bppumpshotgunmk2.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bprevolver"]              = {["name"] = "bprevolver",             ["label"] = "BP: Revolver",                 ["weight"] = 50,    ["type"] = "item",  ["image"] = "bprevolver.png",           ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpsawnoffshotgun"]        = {["name"] = "bpsawnoffshotgun",       ["label"] = "BP: Sawnoff Shotgun",          ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpsawnoffshotgun.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpsmg"]                   = {["name"] = "bpsmg",                  ["label"] = "BP: Smg",                      ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpsmg.png",                ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpsniperrifle"]           = {["name"] = "bpsniperrifle",          ["label"] = "BP: Sniper Rifle",             ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpsniperrifle.png",        ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpsnspistol"]             = {["name"] = "bpsnspistol",            ["label"] = "BP: Sns Pistol",               ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpsnspistol.png",          ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpspecialcarbine"]        = {["name"] = "bpspecialcarbine",       ["label"] = "BP: Special Carbine",          ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpspecialcarbine.png",     ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpspecialcarbinemk2"]     = {["name"] = "bpspecialcarbinemk2",    ["label"] = "BP: Special Carbine Mk2",      ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpspecialcarbinemk2.png",  ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
    ["bpspecialcarbinemk2"]     = {["name"] = "bpspecialcarbinemk2",    ["label"] = "BP: Special Carbine Mk2",      ["weight"] = 50,    ["type"] = "item",  ["image"] = "bpspecialcarbinemk2.png",  ["unique"] = false,     ["useable"] = true,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
```

# Job
**qb-core/shared/jobs.lua**

    ['ammunation'] = {
        label = 'Ammu-Nation',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Employee',
                payment = 75
            },
            ['2'] = {
                name = 'Manager',
                payment = 100
            },
            ['3'] = {
                name = 'Chief',
                isboss = true,
                payment = 150
            },
        },
    },

# MZ-Skills 
- Download: https://github.com/MrZainRP/mz-skills

**mz-skills/config.lua**

    Config.Skills = {
        ["AmmuNation"] = {
            ["Current"] = 0,
            ["RemoveAmount"] = 0,
            ["Stat"] = "AmmuNation",
            ['icon'] = 'fas fa-wrench',
        }, 
    }

# Setup Images:

- Copy all images inside of : m-AmmunationJob/images
- Open your inventory and inside of folder html/images drop it

# Dependecies:

- qb-core
- qb-target
- qb-menu
