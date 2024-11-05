local lastRob = 0
ESX, QBCore = nil
Citizen.CreateThread(function()
    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        pcall(function() ESX = exports[Config['VangelicoHeist']['framework']['scriptName']]:getSharedObject() end)
        if not ESX then
            TriggerEvent(Config['VangelicoHeist']['framework']['eventName'], function(library) 
                ESX = library 
            end)
        end
        ESX.RegisterServerCallback('vangelico:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = ESX.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = ESX.GetPlayerFromId(players[i])
                if player['job']['name'] == Config['VangelicoHeist']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['VangelicoHeist']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
            TriggerClientEvent('vangelico:client:showNotification', src, Strings['need_police'])
            end
        end)
        ESX.RegisterServerCallback('vangelico:server:checkTime', function(source, cb)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            
            if (os.time() - lastRob) < Config['VangelicoHeist']['nextRob'] and lastRob ~= 0 then
                local seconds = Config['VangelicoHeist']['nextRob'] - (os.time() - lastRob)
                TriggerClientEvent('vangelico:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
                cb({status = false})
            else
                cb({status = true})
            end
        end)
        ESX.RegisterServerCallback('vangelico:server:hasItem', function(source, cb, data)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            local playerItem = player.getInventoryItem(data.itemName)
        
            if player and playerItem ~= nil then
                if playerItem.count >= 1 then
                    cb({status = true, label = playerItem.label})
                else
                    cb({status = false, label = playerItem.label})
                end
            else
                print('[rm_vangelicofinal] you need add required items to server database')
            end
        end)
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        while not QBCore do
            pcall(function() QBCore =  exports[Config['VangelicoHeist']['framework']['scriptName']]:GetCoreObject() end)
            if not QBCore then
                pcall(function() QBCore =  exports[Config['VangelicoHeist']['framework']['scriptName']]:GetSharedObject() end)
            end
            if not QBCore then
                TriggerEvent(Config['VangelicoHeist']['framework']['eventName'], function(obj) QBCore = obj end)
            end
            Citizen.Wait(1)
        end
        QBCore.Functions.CreateCallback('vangelico:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = QBCore.Functions.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = QBCore.Functions.GetPlayer(players[i])
                if player.PlayerData.job.name == Config['VangelicoHeist']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['VangelicoHeist']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
               TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error") --Fishy ADDONS
            end
        end)
        QBCore.Functions.CreateCallback('vangelico:server:checkTime', function(source, cb, index)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)

            if (os.time() - lastRob) < Config['VangelicoHeist']['nextRob'] and lastRob ~= 0 then
                local seconds = Config['VangelicoHeist']['nextRob'] - (os.time() - lastRob)
                TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])-- FishyCode
                cb({status = false})
            else
                cb({status = true})
            end
        end)
        QBCore.Functions.CreateCallback('vangelico:server:hasItem', function(source, cb, data)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)
            local playerItem = player.Functions.GetItemByName(data.itemName)
        
            if player then 
                if playerItem ~= nil then
                    if playerItem.amount >= 1 then
                        cb({status = true, label = data.itemName})
                    end
                else
                    cb({status = false, label = data.itemName})
                end
            end
        end)
    end
end)

RegisterServerEvent('vangelico:server:setTime')
AddEventHandler('vangelico:server:setTime', function()
    local src = source
    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        lastRob = os.time()
        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Vangelico Heist Final!')
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        lastRob = os.time()
        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' started the Vangelico Heist Final!')
    end
end)

RegisterServerEvent('vangelico:server:removeItem')
AddEventHandler('vangelico:server:removeItem', function(item)
    local src = source
    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        if player then
            player.removeInventoryItem(item, 1)
        end
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        if player then
            player.Functions.RemoveItem(item, 1)
        end 
    end
end)

RegisterServerEvent('vangelico:server:rewardItem')
AddEventHandler('vangelico:server:rewardItem', function(item, count)
    local src = source

    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        local whitelistItems = {}

        if player then
            local sourcePed = GetPlayerPed(src)
            local sourceCoords = GetEntityCoords(sourcePed)
            local dist = #(sourceCoords - Config['VangelicoSetup']['doors'][1]['coords'])
            if dist > 100.0 then
                print('[rm_vangelicofinal] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            end
            
            for k, v in pairs(Config['VangelicoHeist']['requiredItems']) do
                whitelistItems[v] = true
            end

            for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
                whitelistItems[v['item']] = true
            end

            whitelistItems[Config['VangelicoSetup']['bigGlass']['glass']['itemName']] = true

            if whitelistItems[item] then
                player.addInventoryItem(item, count)
                discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain ' .. item .. ' x' .. count .. ' on Vangelico Heist Final!')
            else
                print('[rm_vangelicofinal] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            end
        end
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        local whitelistItems = {}

        if player then
            local sourcePed = GetPlayerPed(src)
            local sourceCoords = GetEntityCoords(sourcePed)
            local dist = #(sourceCoords - Config['VangelicoSetup']['doors'][1]['coords'])
            if dist > 100.0 then
                print('[rm_vangelicofinal] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            end
            
            for k, v in pairs(Config['VangelicoHeist']['requiredItems']) do
                whitelistItems[v] = true
            end

            for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
                whitelistItems[v['item']] = true
            end

            whitelistItems[Config['VangelicoSetup']['bigGlass']['glass']['itemName']] = true

            if whitelistItems[item] then
                player.Functions.AddItem(item, count)
                discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. item .. ' x' .. count .. ' on Vangelico Heist Final!')
            else
                print('[rm_vangelicofinal] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            end
        end
    end
end)

RegisterServerEvent('vangelico:server:sellRewardItems')
AddEventHandler('vangelico:server:sellRewardItems', function()
    local src = source

    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        local totalMoney = 0

        if player then
            for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
                local playerItem = player.getInventoryItem(v['item'])
                if playerItem.count >= 1 then
                    player.removeInventoryItem(v['item'], playerItem.count)
                    if Config['VangelicoHeist']['black_money']['status'] then
                        player.addAccountMoney('black_money', playerItem.count * v['sellPrice'])
                    else
                        if Config['VangelicoHeist']['moneyItem']['status'] then
                            player.addInventoryItem(Config['VangelicoHeist']['moneyItem']['itemName'], playerItem.count * v['sellPrice'])
                        else
                            player.addMoney(playerItem.count * v['sellPrice'])
                        end
                    end
                    totalMoney = totalMoney + (playerItem.count * v['sellPrice'])
                end
            end

            local necklaceItem = player.getInventoryItem(Config['VangelicoSetup']['bigGlass']['glass']['itemName'])
            if necklaceItem.count >= 1 then
                player.removeInventoryItem(Config['VangelicoSetup']['bigGlass']['glass']['itemName'], necklaceItem.count)
                if Config['VangelicoHeist']['black_money']['status'] then
                    player.addAccountMoney('black_money', necklaceItem.count * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                else
                    if Config['VangelicoHeist']['moneyItem']['status'] then
                        player.addInventoryItem(Config['VangelicoHeist']['moneyItem']['itemName'], necklaceItem.count * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                    else
                        player.addMoney(necklaceItem.count * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                    end
                end
                totalMoney = totalMoney + (necklaceItem.count * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
            end
            
            discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain $' .. math.floor(totalMoney) .. ' on the Vangelico Heist Final Buyer!')
            TriggerClientEvent('vangelico:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        end
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        local totalMoney = 0

        if player then
            for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
                local playerItem = player.Functions.GetItemByName(v['item'])
                if playerItem ~= nil and playerItem.amount > 0 then
                    player.Functions.RemoveItem(v['item'], playerItem.amount)
                    if Config['VangelicoHeist']['black_money']['status'] then
                        player.Functions.AddItem(Config['VangelicoHeist']['black_money']['itemName'], playerItem.amount * v['sellPrice'])
                    else
                        player.Functions.AddMoney('cash', playerItem.amount * v['sellPrice'])
                    end
                    totalMoney = totalMoney + (playerItem.amount * v['sellPrice'])
                end
            end

            local necklaceItem = player.Functions.GetItemByName(Config['VangelicoSetup']['bigGlass']['glass']['itemName'])
            if necklaceItem ~= nil and necklaceItem.amount > 0 then
                player.RemoveItem(Config['VangelicoSetup']['bigGlass']['glass']['itemName'], necklaceItem.amount)
                if Config['VangelicoHeist']['black_money']['status'] then
                    player.Functions.AddItem(Config['VangelicoHeist']['black_money']['itemName'], necklaceItem.amount * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                else
                    if Config['VangelicoHeist']['moneyItem']['status'] then
                        player.AddItem(Config['VangelicoHeist']['moneyItem']['itemName'], necklaceItem.amount * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                    else
                        player.AddMoney('cash', necklaceItem.amount * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
                    end
                end
                totalMoney = totalMoney + (necklaceItem.amount * Config['VangelicoSetup']['bigGlass']['glass']['sellPrice'])
            end

            discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain $' .. math.floor(totalMoney) .. ' on the Vangelico Heist Final Buyer!')
            TriggerClientEvent('vangelico:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        end
    end
end)

RegisterCommand('pdvangelicofinal', function(source, args)
    local src = source

    if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        
        if player then
            if player['job']['name'] == Config['VangelicoHeist']['setjobForPolice'] then
                TriggerClientEvent('vangelico:client:sync', -1, 'resetHeist')
            else
                TriggerClientEvent('vangelico:client:showNotification', src, Strings['not_cop'])
            end
        end
    elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
    
        if player then
            if player.PlayerData.job.name == Config['VangelicoHeist']['setjobForPolice'] then
                TriggerClientEvent('vangelico:client:sync', -1, 'resetHeist')
            else
                TriggerClientEvent('vangelico:client:showNotification', src, Strings['not_cop'])
            end
        end
    end
end)

RegisterServerEvent('vangelico:server:sync')
AddEventHandler('vangelico:server:sync', function(type, args)
    TriggerClientEvent('vangelico:client:sync', -1, type, args)
end)