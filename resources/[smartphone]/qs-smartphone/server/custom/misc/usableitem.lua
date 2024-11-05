if Config.Framework == 'esx' then
    ESX.RegisterUsableItem(Config.RepairWetPhone, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local phone_module = xPlayer.getInventoryItem(Config.RepairWetPhone)
        for k, v in pairs(Config.PhonesProps) do
            local phoneitem = xPlayer.getInventoryItem('wet_' .. k)
            if phoneitem and phoneitem.count >= 1 then
                if phone_module and phone_module.count >= 1 then
                    TriggerClientEvent('qs-smartphone:repairPhone', source)
                    xPlayer.removeInventoryItem(Config.RepairWetPhone, 1)
                    xPlayer.removeInventoryItem('wet_' .. k, 1)
                    Wait(7500)
                    xPlayer.addInventoryItem(k, 1)
                    break
                end
            end
        end
    end)
elseif Config.Framework == 'qb' then
    QBCore.Functions.CreateUseableItem(Config.RepairWetPhone, function(source)
        local xPlayer = GetPlayerFromIdFramework(source)
        local phone_module = xPlayer.Functions.GetItemByName(Config.RepairWetPhone)
        for k, v in pairs(Config.PhonesProps) do
            local phoneitem = xPlayer.Functions.GetItemByName('wet_' .. k)
            if phoneitem and phoneitem.amount >= 1 then
                if phone_module and phone_module.amount >= 1 then
                    TriggerClientEvent('qs-smartphone:repairPhone', source)
                    xPlayer.Functions.RemoveItem(Config.RepairWetPhone, 1)
                    xPlayer.Functions.RemoveItem('wet_' .. k, 1)
                    Wait(7500)
                    xPlayer.Functions.AddItem(k, 1)
                    break
                end
            end
        end
    end)
end

if Config.Framework == 'esx' and Config.EnableBattery then
    ESX.RegisterUsableItem(Config.PowerBank, function(src)
        local player = ESX.GetPlayerFromId(src)
        local battery = GetBatteryFromIdentifier(player.identifier)
        if powerbankCharge[player.identifier] then
            TriggerClientEvent('qs-smartphone:sendMessage', src, Lang('BATTERY_FULL'), 'success')
        end
        local existPhone = GetExistPhone(player)
        if not existPhone then
            return TriggerClientEvent('qs-smartphone:sendMessage', src, Lang('BATTERY_NO_PHONE'), 'error')
        end
        TriggerClientEvent('qs-smartphone:client:notify', src, {
            title = Lang('SETTINGS_TITLE'),
            text = Lang('BATTERY_PROGRESS'),
            icon = './img/apps/settings.png',
        })
        powerbankCharge[player.identifier] = {
            owner = player.identifier,
            src = src,
            battery = battery
        }
        if Config.RemoveItemPowerBank then
            player.removeInventoryItem(Config.PowerBank, 1)
        end
    end)
elseif Config.Framework == 'qb' and Config.EnableBattery then
    QBCore.Functions.CreateUseableItem(Config.PowerBank, function(src)
        local player = GetPlayerFromIdFramework(src)
        local battery = GetBatteryFromIdentifier(player.identifier)
        if powerbankCharge[player.identifier] then
            TriggerClientEvent('qs-smartphone:sendMessage', src, Lang('BATTERY_FULL'), 'success')
        end
        local existPhone = GetExistPhone(player)
        if not existPhone then
            return TriggerClientEvent('qs-smartphone:sendMessage', src, Lang('BATTERY_NO_PHONE'), 'error')
        end
        TriggerClientEvent('qs-smartphone:client:notify', src, {
            title = Lang('SETTINGS_TITLE'),
            text = Lang('BATTERY_PROGRESS'),
            icon = './img/apps/settings.png',
        })
        powerbankCharge[player.identifier] = {
            owner = player.identifier,
            src = src,
            battery = battery
        }
        if Config.RemoveItemPowerBank then
            player.Functions.RemoveItem(Config.PowerBank, 1)
        end
    end)
end
