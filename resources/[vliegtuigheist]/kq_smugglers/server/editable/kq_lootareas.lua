
function CreateRadioEncoderArea()
    local radioEncoders = {
        name = L('Radio encoders'),
        renderDistance = 20.0,
        coords = Config.radioEncoder.location,
        radius = Config.radioEncoder.radius,
        amount = Config.radioEncoder.spawnCount,
        regrowTime = Config.radioEncoder.respawnTime, -- in seconds
        
        blip = Config.radioEncoder.blip,
        
        items = {
            {
                item = Config.items.radioEncoder,
                chance = 100,
                amount = {
                    min = 1,
                    max = 1,
                },
            }
        },
        props = {
            {
                hash = 'v_res_fa_radioalrm',
                textureVariation = 0,
                minimumDistanceBetween = 1.5,
                offset = {
                    x = 0.0, y = 0.0, z = 0.0,
                },
                animation = {
                    duration = 1, -- in seconds
                    dict = 'mp_take_money_mg',
                    anim = 'put_cash_into_bag_loop',
                    flag = 1,
                },
                labelSingular = L('Radio encoder'),
                labelPlurar = L('Radio encoders'),
                collectMessage = L('Pickup the radio encoder'),
                icon = 'fas fa-signal',
            },
        },
    }
    
    exports['kq_lootareas']:CreateArea('kq_smugglers_radio_encoders', radioEncoders)
end
CreateRadioEncoderArea()

function CreatePlaneCrashArea(coords, hash)
    
    local randomLootEvent = math.random(1, #Config.crash.events)
    local event = Config.crash.events[randomLootEvent]
    
    local planeCrash = {
        name = 'Plane Crash',
        renderDistance = 50.0,
        coords = coords,
        radius = event.lootRadius + 0.0,
        amount = event.lootCount,
        regrowTime = 9999999999, -- never respawn

        event = 'kq_smugglers:server:onPickup',
        eventType = 'server',

        props = event.loot,
    }
    
    exports['kq_lootareas']:CreateArea('kq_smugglers_plane_crash_ ' .. hash, planeCrash)
end

function DeletePlaneCrashArea(hash)
    exports['kq_lootareas']:DeleteArea('kq_smugglers_plane_crash_ ' .. hash)
end

AddEventHandler('kq_smugglers:server:onPickup', function(player, area, propKey, loot)
    if loot == nil then
        print('\n^1 <!> A higher version of kq_lootareas is required for this script to function properly (0.9.8^)! Please update via the keymaster <!>\n')
    end
    
    if not loot.isCash then
        return
    end
    
    local moneyAmount = math.random(loot.moneyAmount.min, loot.moneyAmount.max)
    AddPlayerMoney(player, moneyAmount)
    TriggerClientEvent('kq_smugglers:client:showTooltip', player, L('~g~You picked up ~h~${AMOUNT}'):gsub('{AMOUNT}', moneyAmount))
end)
