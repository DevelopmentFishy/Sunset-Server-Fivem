local QBCore = exports['qb-core']:GetCoreObject()
local robberyActive = false
local cooldown = false
local cooldown2 = false

rewards = {
    ['weapon'] = {
        [1] = {
            name = 'snsblauwprint',
            maxAmount = 1
        },
        [2] = {
            name = 'bpcombatpistol',
            maxAmount = 1
        },
        [3] = {
            name = 'bpdeagle',
            maxAmount = 1
        },
        [4] = {
            name = 'pistol_ammo',
            maxAmount = 1
        },
        [5] = {
            name = 'snsblauwprint',
            maxAmount = 1
        },
        [6] = {
            name = 'bpheavypistol',
            maxAmount = 1
        },
    },
    ['attachment'] = {
        [1] = {
            name = 'snsblauwprint',
            maxAmount = 1
        },
        [2] = {
            name = 'pistol_suppressor',
            maxAmount = 1
        },
        [3] = {
            name = 'pistol_extendedclip',
            maxAmount = 2
        },
        [4] = {
            name = 'pistol_ammo',
            maxAmount = 10
        },
        [5] = {
            name = 'gold_weapontint',
            maxAmount = 1
        },
        [6] = {
            name = 'pink_weapontint',
            maxAmount = 1
        },
    },
    ['armor'] = {
        [1] = {
            name = 'armor',
            maxAmount = 2
        },
    },
    ['katana'] = {
        [1] = {
            name = 'bpcompactrifle',
            maxAmount = 1
        },
    },
    ['throwable'] = {
        [1] = {
            name = 'handcuffs',
            maxAmount = 1
        },
        [2] = {
            name = 'laptop_green',
            maxAmount = 1
        },   
        [3] = {
            name = 'weapon_knuckle',
            maxAmount = 1
        }, 
        [4] = {
            name = 'laptop_blue',
            maxAmount = 1
        },
        [5] = {
            name = 'bpcombatpistol',
            maxAmount = 1
        }, 
        [6] = {
            name = 'pistol_ammo',
            maxAmount = 5
        }, 
    },
    ['melee'] = {
        [1] = {
            name = 'pistol_ammo',
            maxAmount = 5
        },
        [2] = {
            name = 'weapon_machete',
            maxAmount = 1
        },   
        [3] = {
            name = 'weapon_knife',
            maxAmount = 1
        }, 
        [4] = {
            name = 'laptop_green',
            maxAmount = 1
        },
        [5] = {
            name = 'weapon_knife',
            maxAmount = 1
        }, 
        [6] = {
            name = 'weapon_switchblade',
            maxAmount = 1
        }, 
        [7] = {
            name = 'weapon_bat',
            maxAmount = 1
        }, 
    },
}

RegisterNetEvent('lumio-ammunationrobbery:server:setCaseState', function(boxtype, i)
    Config.Locations[boxtype][i].opened = true
    TriggerClientEvent('lumio-ammunationrobbery:client:setCaseState', -1, boxtype, i)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:setAmmState', function(state)
    if not robberyActive then
        Config.Locations["info"].isActive = state
        TriggerClientEvent('lumio-ammunationrobbery:client:setAmmState', -1, state)
    end
    robberyActive = true
end)

RegisterNetEvent('lumio-ammunationrobbery:server:keypadtries', function(i, tries)
    Config.Locations["keypad"][i].tries = tries + 1
    
    local updatedTries = tries += 1
    TriggerClientEvent('lumio-ammunationrobbery:client:keypadtries', -1, i, updatedTries)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:keypadstate', function(i, state)
    Config.Locations["keypad"][i].busy = state
    TriggerClientEvent('lumio-ammunationrobbery:client:keypadstate', -1, i, state)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:keypadhacked', function(i, state)
    Config.Locations["keypad"][i].hacked = state
    Config.Locations["katana"][i].visible = state
    TriggerClientEvent('lumio-ammunationrobbery:client:keypadhacked', -1, i, state)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:keypadhacked2', function(i, state)
    Config.Locations["keypad"][i].hacked = state
    TriggerClientEvent('lumio-ammunationrobbery:client:keypadhacked2', -1, i, state)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:givemap', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('geldrol', math.random(15000, 25000))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['geldrol'], "add")
end)

RegisterNetEvent('lumio-ammunationrobbery:server:mainhackstate', function(i, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Config.Locations["mainhack"][i].busy = state


    TriggerClientEvent('lumio-ammunationrobbery:client:mainhackstate', -1, i, state)
end)


RegisterNetEvent('lumio-ammunationrobbery:server:mainhackhacked', function(i, state)
    Config.Locations["mainhack"][i].hacked = state
    TriggerClientEvent('lumio-ammunationrobbery:client:mainhackhacked', -1, i, state)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:verwijderlaptop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('hacking_laptop', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['hacking_laptop'], "remove")
end)

RegisterNetEvent('lumio-ammunationrobbery:server:enablekatana', function(i)
    TriggerClientEvent('lumio-ammunationrobbery:client:enablekatana', -1, i)
end)

RegisterNetEvent('lumio-ammunationrobbery:server:givereward', function(casetype)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local index = math.random(#rewards[casetype])
    local item = rewards[casetype][index].name
    local amount = math.random(rewards[casetype][index].maxAmount)

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
end)

QBCore.Functions.CreateCallback('lumio-ammunationrobbery:server:amountOfCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateUseableItem('secret_map', function(source, item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("lumio-ammunationrobbery:client:useMap", src)
	end
end)

RegisterNetEvent('lumio-ammunationrobbery:server:exchangeMap', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveItem('secret_map', 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['secret_map'], "remove")
        Player.Functions.AddItem('weapon_katana', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_katana'], "add")
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:server:setCooldown', function()
    if not cooldown then
        cooldown = true
        CreateThread(function()
            Wait(1000 * 60 * Config.Cooldown)

            robberyActive = false
            Config.Locations['info'].isActive = false
            Config.Locations['mainhack'][1].hacked = false
            Config.Locations['keypad'][1].hacked = false
            Config.Locations['keypad'][1].tries = 0
            Config.Locations['katana'][1].opened = false
            Config.Locations['katana'][1].visible = false

            Config.Hacking = false
            Config.Stopped = false

            for k, v in pairs(Config.Locations['boxes']) do
                v.opened = false
            end

            TriggerClientEvent('lumio-ammunationrobbery:client:resetall', -1)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "ammunition", false)

            cooldown = false
        end)
    end
end)

RegisterNetEvent('lumio-ammunationrobbery:server:setCooldown2', function()
    if not cooldown2 then
        cooldown2 = true
        CreateThread(function()
            Wait(1000 * 60 * Config.Cooldown)

            robberyActive = false
            Config.Locations['info'].isActive = false
            Config.Locations['mainhack'][1].hacked = false
            Config.Locations['keypad'][1].hacked = false
            Config.Locations['keypad'][1].tries = 0

            Config.Hacking = false
            Config.Stopped = false

            for k, v in pairs(Config.Locations['boxes']) do
                v.opened = false
            end

            TriggerClientEvent('lumio-ammunationrobbery:client:resetall2', -1)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "ammunition", false)

            cooldown2 = false
        end)
    end
end)