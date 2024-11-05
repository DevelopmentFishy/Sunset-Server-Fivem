if Config.qbSettings.enabled then
    
    QBCore = exports['qb-core']:GetCoreObject()
    
    function AddPlayerMoney(player, amount, account)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        if not xPlayer then
            return false
        end
        
        xPlayer.Functions.AddMoney(account or Config.qbSettings.moneyAccount, amount)
    end
    
    function AddPlayerItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'add', amount or 1)

        return xPlayer.Functions.AddItem(item, amount or 1)
    end
end
