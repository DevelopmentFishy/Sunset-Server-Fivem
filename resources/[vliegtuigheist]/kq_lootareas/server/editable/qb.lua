if Config.qbSettings.enabled then

    if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'remove', amount or 1)
        
        return xPlayer.Functions.GetItemByName(item).amount >= (amount or 1)
    end

    function RemovePlayerItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        xPlayer.Functions.RemoveItem(item, amount or 1)
    end

    function AddPlayerItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'add', amount or 1)

        return xPlayer.Functions.AddItem(item, amount or 1)
    end
end
