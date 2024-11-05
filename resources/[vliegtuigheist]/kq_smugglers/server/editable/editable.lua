
RegisterServerEvent('kq_smugglers:server:buyHint')
AddEventHandler('kq_smugglers:server:buyHint', function()
    local _source = source
    
    local price = Config.hint.price
    if CanPlayerAfford(_source, price) then
        if AddPlayerItem(_source, Config.items.hint) then
            RemovePlayerMoney(_source, price)
            TriggerClientEvent('kq_smugglers:client:hintPurchased', _source)
        else
            TriggerClientEvent('kq_smugglers:client:showTooltip', _source, L('~r~Not enough inventory space'))
        end
    else
        TriggerClientEvent('kq_smugglers:client:showTooltip', _source, L('~r~You can not afford this'))
    end
end)

RegisterServerEvent('kq_smugglers:server:sendDispatch')
AddEventHandler('kq_smugglers:server:sendDispatch', function(coords, early)
    TriggerClientEvent('kq_smugglers:client:sendDispatch', -1, coords, early)
end)

function RewardPoliceInRadius(coords, looted)
    if not Config.securing.reward.enabled then
        return
    end
    
    local cops = {}
    
    for _, playerId in ipairs(GetPlayers()) do
        playerId = tonumber(playerId)
        if IsPlayerPolice(playerId) then
            local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z)
    
            if distance < Config.securing.reward.radius then
                table.insert(cops, playerId)
            end
        end
    end
    
    local rewardTotal = Config.securing.reward.amount
    if not looted then
        rewardTotal = rewardTotal * Config.securing.reward.unlootedMultiplier
    end
    
    local rewardPerCop = math.ceil(rewardTotal / #cops)
    for _, playerId in pairs(cops) do
        AddPlayerMoney(tonumber(playerId), rewardPerCop, Config.securing.reward.account)
        TriggerClientEvent('kq_smugglers:client:showTooltip', playerId, L('~g~You\'ve received a monetary bonus of ~h~${AMOUNT}~h~ for helping secure the crash site'):gsub('{AMOUNT}', rewardPerCop))
    end
end

RegisterServerEvent('kq_smugglers:server:sell')
AddEventHandler('kq_smugglers:server:sell', function(sellingKey)
    local _source = source
    local selling = Config.selling[sellingKey]
    
    if not DoesPlayerHaveItem(_source, selling.item) then
        TriggerClientEvent('kq_smugglers:client:showTooltip', _source, L('~r~You do not have anything to sell here'))
        return
    end
    
    local amount = GetPlayerItemAmount(_source, selling.item)
    
    RemovePlayerItem(_source, selling.item, amount)
    local reward = amount * selling.price
    AddPlayerMoney(_source, reward)
    TriggerClientEvent('kq_smugglers:client:showTooltip', _source, L('~g~You sold {AMOUNT} {ITEM} for ~h~${MONEY}'):gsub('{AMOUNT}', amount):gsub('{ITEM}', selling.itemLabel):gsub('{MONEY}', reward))
end)

function GetDistanceBetweenCoords(x, y, z, x2, y2, z2)
    return ((x2 - x) ^ 2 + (y2 - y) ^ 2 + (z2 - z) ^ 2) ^ 0.5
end
