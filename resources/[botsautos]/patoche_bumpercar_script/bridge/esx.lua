if Framework ~= 'ESX' then return end
print('Framework ESX detected')
ESX = ESX or exports.es_extended:getSharedObject()

local server = IsDuplicityVersion()

-- Inventory Check
local inventory = 'default'

local isOxInventoryStarted = GetResourceState('ox_inventory'):find('start')
local isDefaultInventoryStarted = ESX.GetConfig('EnableDefaultInventory')

if server then
    if isOxInventoryStarted and isDefaultInventoryStarted then
        print('^1[PATOCHE:BUMPER-CAR] ERROR: You are running ox_inventory and ESX default inventory at the same time!^7')
    end
    if not isDefaultInventoryStarted and not isOxInventoryStarted then
        print('^1[PATOCHE:BUMPER-CAR] ERROR: Only default ESX inventory and ox_inventory are supported!^7')
    end
end

if isOxInventoryStarted then
    inventory = 'ox'
end


-- SERVER EVENTS
if server then
    ESX.RegisterServerCallback('patoche_bumpercar:esx:getPlayerItem', function(source, cb, quantity)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local itemCount = xPlayer.getInventoryItem(Config.item).count
        if not itemCount then
            xPlayer.showNotification(locale('noCoin'))
            cb(false)
        elseif itemCount < quantity then
            xPlayer.showNotification(locale('notEnoughCoins'))
            cb(false)
        end
        cb(itemCount and itemCount > 0 or false)
    end)

    RegisterServerEvent('patoche_bumpercar:esx:addItem', function(quantity, method)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local bumptonCost = quantity * Config.tokenPrice

        if inventory == 'ox' then
            if method == "cash" then
                xPlayer.removeMoney(bumptonCost)
            elseif method == "bank" then
                xPlayer.removeAccountMoney("bank", bumptonCost)
            end
            exports.ox_inventory:AddItem(src, Config.item, quantity)
        elseif inventory == 'default' then
            if Config.canCarry then
                if xPlayer.canCarryItem(Config.item, quantity) then
                    if method == "cash" then
                        xPlayer.removeMoney(bumptonCost)
                    elseif method == "bank" then
                        xPlayer.removeAccountMoney("bank", bumptonCost)
                    end
                    xPlayer.addInventoryItem(Config.item, quantity)
                else
                    xPlayer.showNotification(locale('noInventorySpace'))
                end
            else
                if method == "cash" then
                    xPlayer.removeMoney(bumptonCost)
                elseif method == "bank" then
                    xPlayer.removeAccountMoney("bank", bumptonCost)
                end
                xPlayer.addInventoryItem(Config.item, quantity)
            end
        end

    end)
    
    RegisterServerEvent('patoche_bumpercar:esx:removeItem', function(quantity)
        local src = source
        if inventory == 'ox' then
            local items = exports.ox_inventory:Search(src, 'count', {Config.item})
            print(items)
            if items >= quantity then
                exports.ox_inventory:RemoveItem(src, Config.item, quantity)
            end
        elseif inventory == 'default' then
            local xPlayer = ESX.GetPlayerFromId(src)
            local itemCount = xPlayer.getInventoryItem(Config.item).count
            if itemCount >= quantity then
                xPlayer.removeInventoryItem(Config.item, quantity)
            end
        end
    end)

    ESX.RegisterServerCallback('patoche_bumpercar:esx:haveMoneyCash', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then cb(0) return end
        local playerCash = xPlayer.getMoney()
        cb(playerCash)
    end)

    ESX.RegisterServerCallback('patoche_bumpercar:esx:haveMoneyBank', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then cb(0) return end
        local playerBank = xPlayer.getAccount('bank').money
        cb(playerBank)
    end)
    
end

-- FUNTIONS
function haveItem(quantity)
    if inventory == 'ox' then
        local count = exports.ox_inventory:Search('count', Config.item)
        if count > 0 then
            return true
        else
            return false
        end
    elseif inventory == 'default' then
        local result
        ESX.TriggerServerCallback('patoche_bumpercar:esx:getPlayerItem', function(haveItem)
            result = haveItem
        end, quantity)
        repeat Wait(0) until result ~= nil
        return result
    end
end

function haveMoney(quantity, method)
    if method == 'cash' then
        local cashResult
        ESX.TriggerServerCallback('patoche_bumpercar:esx:haveMoneyCash', function(playerCash)
            cashResult = playerCash
        end)
        repeat Wait(0) until cashResult ~= nil
        if quantity <= cashResult then
            return true
        else
            notifyPlayer(locale('noEnoughMoney'))
            return false
        end
    elseif method == 'bank' then
        local bankResult
        ESX.TriggerServerCallback('patoche_bumpercar:esx:haveMoneyBank', function(playerBank)
            bankResult = playerBank
        end)
        repeat Wait(0) until bankResult ~= nil
        if quantity <= bankResult then
            return true
        else
            notifyPlayer(locale('noEnoughMoney'))
            return false
        end
    end
end

function addItem(quantity, method)
    TriggerServerEvent('patoche_bumpercar:esx:addItem', quantity, method)
end

function removeItem(quantity)
    TriggerServerEvent('patoche_bumpercar:esx:removeItem', quantity)
end

function notifyPlayer(msg)
    ESX.ShowNotification(msg)
end