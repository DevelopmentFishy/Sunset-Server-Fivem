
RegisterServerEvent('kq_ped_loot:server:collect')
AddEventHandler('kq_ped_loot:server:collect', function(netId)
    local _source = source
    local entity = NetworkGetEntityFromNetworkId(netId)
    HandleLootCollection(entity, _source)
end)

function HandleLootCollection(prop, player)
    if Entity(prop).state.kq_ped_loot_collected then
        return
    end
    
    local drop = Entity(prop).state.kq_ped_loot_data
    
    local collected = false
    
    if drop.item then
        local amount = 1
        if drop.item.min and drop.item.max then
            amount = math.random(drop.item.min, drop.item.max)
        end
        local added = AddPlayerItem(player, drop.item.name, amount)
        if added then
            collected = true
        else
            TriggerClientEvent('kq_ped_loot:client:notify', player, L('~r~You have no room for this item'))
        end
    end
    
    if drop.money then
        local amount = math.random(drop.money.min, drop.money.max)
        AddPlayerMoney(player, amount)
        TriggerClientEvent('kq_ped_loot:client:notify', player, L('~g~You collected ~h~${amount}~h~'):gsub('{amount}', amount))
        collected = true
    end
    
    if collected then
        Entity(prop).state.kq_ped_loot_collected = true
        DeleteEntity(prop)
    end
end

------------------------------
--- EXPORTS
------------------------------
function SetEntityLootPool(entity, newLootPool)
    Entity(entity).state.kq_ped_loot_overwrite_pool = newLootPool
end

function SetEntityCanDropLoot(entity, bool)
    Entity(entity).state.kq_ped_loot_ability = bool
end

exports('SetEntityLootPool', SetEntityLootPool)
exports('SetEntityCanDropLoot', SetEntityCanDropLoot)

