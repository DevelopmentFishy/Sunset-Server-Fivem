local QBCore = exports[Config.Settings.Core]:GetCoreObject()

Config.CraftWeapons = {
    ["weapon_snspistol"] = { -- Code of the weapon
        hash = "weapon_snspistol", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_snspistol"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 5 },
            [2] = { item = "weapon_metal", amount = 5 },
            [3] = { item = "snsblauwprint", amount = 1 },
        }
    },
    ["weapon_heavypistol"] = { -- Code of the weapon
        hash = "weapon_heavypistol", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_heavypistol"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 10 },
            [2] = { item = "weapon_metal", amount = 10 },
            [3] = { item = "bpheavypistol", amount = 1 },
        }
    },
    ["weapon_pistol50"] = { -- Code of the weapon
        hash = "weapon_pistol50", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_pistol50"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 10 },
            [2] = { item = "weapon_metal", amount = 10 },
            [3] = { item = "bpdeagle", amount = 1 },
        }
    },
    ["weapon_compactrifle"] = { -- Code of the weapon
        hash = "weapon_compactrifle", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_compactrifle"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 10 },
            [2] = { item = "weapon_metal", amount = 10 },
            [3] = { item = "bpcompactrifle", amount = 1 },
        }
    },
    ["weapon_machinepistol"] = { -- Code of the weapon
        hash = "weapon_machinepistol", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_machinepistol"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 10 },
            [2] = { item = "weapon_metal", amount = 10 },
            [3] = { item = "bptec9", amount = 1 },
        }
    },
    ["weapon_combatpistol"] = { -- Code of the weapon
        hash = "weapon_combatpistol", -- Code of the weapon
        label = QBCore.Shared.Items["weapon_combatpistol"].label, -- Label of the weapon
        level = 0, -- If you use Config.Settings.Level then here you can put how much XP need's
        materials = {
            [1] = { item = "weapon_pieces", amount = 10 },
            [2] = { item = "weapon_metal", amount = 5 },
            [3] = { item = "bpcombatpistol", amount = 1 },
        }
    },
}