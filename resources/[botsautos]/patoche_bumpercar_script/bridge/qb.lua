if Framework ~= 'QBCore' then return end
print('Framework QBCore detected')
QBCore = QBCore or exports['qb-core']:GetCoreObject()

local server = IsDuplicityVersion()

-- EVENTS
if server then
    QBCore.Functions.CreateCallback('patoche_bumpercar:qb:getPlayerItem', function(source, cb, quantity)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local itemCount = xPlayer.Functions.GetItemByName(Config.item)
        if not itemCount then
            TriggerClientEvent('QBCore:Notify', source, locale("noCoin"), 'error')
            cb(false)
        elseif itemCount.amount < quantity then
            TriggerClientEvent('QBCore:Notify', source, locale("notEnoughCoins"), 'error')
            cb(false)
        end
        cb(itemCount and itemCount.amount > 0 or false)
    end)

    RegisterServerEvent('patoche_bumpercar:qb:addItem', function(quantity, method)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local bumptonCost = quantity * Config.tokenPrice
        local paid = xPlayer.Functions.RemoveMoney(method, bumptonCost, "buy_bumpton")
        if paid then
            xPlayer.Functions.AddItem(Config.item, quantity)
        end
    end)

    RegisterServerEvent('patoche_bumpercar:qb:removeItem', function(quantity)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local itemCount = xPlayer.Functions.GetItemByName(Config.item)
        if itemCount.amount >= quantity then
            xPlayer.Functions.RemoveItem(Config.item, quantity)
        else
            TriggerClientEvent('QBCore:Notify', src, locale("notEnoughCoins"), 'error')
        end
    end)

    QBCore.Functions.CreateCallback('patoche_bumpercar:qb:haveMoneyCash', function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then cb(0) return end
        local playerCash = xPlayer.Functions.GetMoney("cash")
        cb(playerCash)
    end)

    QBCore.Functions.CreateCallback('patoche_bumpercar:qb:haveMoneyBank', function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then cb(0) return end
        local playerBank = xPlayer.Functions.GetMoney("bank")
        cb(playerBank)
    end)
end

-- FUNCTIONS
function haveItem(quantity)
    local result
    QBCore.Functions.TriggerCallback('patoche_bumpercar:qb:getPlayerItem', function(haveItem)
        result = haveItem
    end, quantity)
    repeat Wait(0) until result ~= nil
    return result
end

function haveMoney(quantity, method)
    if method == 'cash' then
        local cashResult
        QBCore.Functions.TriggerCallback('patoche_bumpercar:qb:haveMoneyCash', function(playerCash)
            cashResult = playerCash
        end)
        repeat Wait(0) until cashResult ~= nil
        if quantity <= cashResult then
            return true
        else
            return false
        end
    elseif method == 'bank' then
        local bankResult
        QBCore.Functions.TriggerCallback('patoche_bumpercar:qb:haveMoneyBank', function(playerBank)
            bankResult = playerBank
        end)
        repeat Wait(0) until bankResult ~= nil
        if quantity <= bankResult then
            return true
        else
            return false
        end
    end
end

function addItem(quantity, method)
    print(quantity, method)
    TriggerServerEvent('patoche_bumpercar:qb:addItem', quantity, method)
    debugPrint("Give Bumpton to player")
    return true
end

function removeItem(quantity)
    TriggerServerEvent('patoche_bumpercar:qb:removeItem', quantity)
    return true
end

function notifyPlayer(msg)
    TriggerEvent('QBCore:Notify', msg, 'error')
end