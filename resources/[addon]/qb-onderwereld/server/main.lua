local QBCore = exports['qb-core']:GetCoreObject()
local Ontploft = false


QBCore.Functions.CreateUseableItem("telefoonnummerprints", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-onderwereld:client:start:wapen-call', source)
    end
end)

QBCore.Functions.CreateCallback('qb-onderwereld:server:blueprintnummer', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("telefoonnummerprints")

    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateUseableItem("drugdealernumber", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-onderwereld:client:start:drugs-call', source)
    end
end)

RegisterNetEvent('qb-onderwereld:server:removenummerwapens', function(number)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('telefoonnummerprints', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['telefoonnummerprints'], "remove")
end)


RegisterNetEvent('qb-onderwereld:server:removenummer', function(number)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('drugdealernumber', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['drugdealernumber'], "remove")
end)

RegisterNetEvent('qb-onderwereld:server:planten', function()
    local src = source
	TriggerClientEvent('qb-onderwereld:client:startcount', src)
end)

RegisterNetEvent('qb-onderwereld:server:propje', function(cashProp)
    local src = source
	TriggerClientEvent('qb-onderwereld:client:target',src ,cashProp)
end)


RegisterNetEvent('qb-onderwereld:server:removebomb', function(number)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('zfmbomb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['zfmbomb'], "remove")
end)

RegisterNetEvent('qb-onderwereld:server:loot', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  for _ = 1, math.random(1, Config.MaxItemsReceived), 1 do
    local randItem = Config.ItemTableNPCloot[math.random(1, #Config.ItemTableNPCloot)]
    local amount = math.random(Config.MinItemReceivedQty, Config.MaxItemReceivedQty)
    Player.Functions.AddItem(randItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
    Wait(500)
  end

  local chance = math.random(1, 100)
  if chance < 7 then
    Player.Functions.AddItem(Config.ChanceItem, 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ChanceItem], 'add')
  end

  local luck = math.random(1, 10)
  local odd = math.random(1, 10)
  if luck == odd then
    local random = math.random(1, 3)
    Player.Functions.AddItem(Config.LuckyItem, random)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LuckyItem], 'add')
  end
end)

RegisterNetEvent('qb-onderwereld:server:lootdrugs', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  for _ = 1, math.random(1, Config.MaxdrugItemsReceived), 1 do
    local randItem = Config.ItemTabledrug[math.random(1, #Config.ItemTabledrug)]
    local amount = math.random(Config.MindrugItemReceivedQty, Config.MaxdrugItemReceivedQty)
    Player.Functions.AddItem(randItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
    Wait(500)
  end

  local chance = math.random(1, 100)
  if chance < 7 then
    Player.Functions.AddItem(Config.ChancedrugItem, 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ChancedrugItem], 'add')
  end

  local luck = math.random(1, 10)
  local odd = math.random(1, 10)
  if luck == odd then
    local random = math.random(1, 3)
    Player.Functions.AddItem(Config.LuckydrugItem, random)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LuckydrugItem], 'add')
  end
end)


---//bankautomaat overvallen\\--
RegisterNetEvent("qb-onderwereld:server:zetstatus", function (fase, staat, k)
    Config.automaaten[k][fase] = staat
    TriggerClientEvent("qb-onderwereld:client:krijgstatus", -1, fase, staat, k)
end)

RegisterNetEvent("qb-onderwereld:server:ZetDefectTijd", function (s)
    if not Ontploft then
        Ontploft = true
        CreateThread(function ()
            Wait(Config.downtime.WachtTijd)
            for k, v in pairs(Config.automaaten) do
                Config.automaaten[k]["defect"] = false
                TriggerClientEvent("qb-onderwereld:client:krijgstatus", -1, 'defect', false, k)
            end
            Ontploft = false
        end)
    end
end)

RegisterNetEvent("qb-onderwereld:server:lootmoney", function ()
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.AddItem('geldrol', math.random(Config.hoeveelheid.MoneyRollMin, Config.hoeveelheid.MoneyRollMax), false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['geldrol'], "add")
end)


--//BLACKMARKET\\--



RegisterNetEvent('qb-blackmarket:server:updateDealerItems', function(itemData, amount)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.Products[itemData.slot].amount - 1 >= 0 then
        Config.Products[itemData.slot].amount =
            Config.Products[itemData.slot].amount - amount
        TriggerClientEvent('qb-blackmarke:client:setDealerItems', -1, itemData, amount)
    else
        --Player.Functions.RemoveItem(itemData.name, amount)
       -- Player.Functions.AddMoney('cash', amount * Config.Products[itemData.slot].price)

        TriggerClientEvent("QBCore:Notify", src, Lang:t("Niet beschikbaar"), "error")
    end
end)


-- --//KOPERDIEFSTAL\\--

-- local defect = false

-- RegisterNetEvent("qb-onderwereld:server:koperloot", function ()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if not Player then return end
--     if Player.Functions.AddItem("koperdraad", Config.koperdraad) then
--         TriggerClientEvent('inventory:client:itembox', src, QBCore.Shared.Items['koperdraad'], "add")
-- 	else
--         TriggerClientEvent('qbcore:notify', src, 'u bent te zwaar geladen..', 'error')
--     end	
-- end)

-- RegisterNetEvent("qb-onderwereld:server:gesmoltenkoper", function (xkoper)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if not Player then return end
--     if  Player.Functions.AddItem('copper', xkoper) then
--         TriggerClientEvent('inventory:client:itembox', src, QBCore.Shared.Items['copper'], "add")
-- 	else
--         TriggerClientEvent('qbcore:notify', src, 'u bent te zwaar geladen..', 'error')
--     end	
-- end)

-- QBCore.Functions.CreateCallback("qb-onderwereld:checkitem", function(source, cb, itemname, count)
--     local xPlayer = qbcore.functions.getPlayer(source)
--     local item = xPlayer.functions.getitembyname(itemname)
--     if item and item.amount >= count then
--         cb(true)
--     else
--         cb(false)
--     end
-- end)

-- RegisterNetEvent('qb-onderwereld:smeltkoper', function(amount)
--     local src = source
--     local Player = qbcore.functions.getPlayer(src)
--     if not Player then return end
--     Player.functions.removeitem('koperdraad', amount)
--     TriggerClientEvent('inventory:client:itembox', src, qbcore.shared.items['koperdraad'], "remove")
-- 	TriggerClientEvent("qb-onderwereld:client:startsmelt",src,amount)
-- end)

-- RegisterNetEvent("qb-onderwereld:server:koperdief:zetstatus", function (fase, staat, k)
--     Config.paaltjes[k][fase] = staat
--     TriggerClientEvent("qb-onderwereld:koperdief:krijgstatus", -1, fase, staat, k)
-- end)


-- RegisterNetEvent("qb-onderwereld:server:koperdief:zetdefecttijd", function (s)
--     --if not defect then
--       --  defect = true
-- 	    print("paaltjes reset")
--         CreateThread(function ()
--             Wait(Config.downtimepaal.wachttijd)
--             for k, v in pairs(Config.paaltjes) do
--                 Config.paaltjes[k]["defect"] = false
--                 TriggerClientEvent("qb-onderwereld:koperdief:krijgstatus", -1, 'defect', false, k)
--             end
--         --    defect = false
--         end)
--    -- end
-- end)



-- --//Witwassen\\--
RegisterNetEvent('qb-onderwereld:server:startVask', function(amount,percent)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    Player.Functions.RemoveItem("geldrol", amount)
    local rolWaarde = math.random(1, 1)
    amount = amount * (rolWaarde-percent)
    local howlong

    if percent == Config.Options[1] then
        howlong = Config.TimeWait[1]

    end

    MySQL.Async.insert('INSERT INTO wash_database (citizenid, amount, time, howlong) VALUES (?, ?, ?, ?)', {
        citizenid,
        amount,
        currentTime,
        howlong,
    })

end)

RegisterNetEvent("qb-onderwereld:server:hentPenger", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    MySQL.query('SELECT * FROM wash_database WHERE citizenid = ?', {citizenid}, function(result)
        if result ~= nil and result[1] ~= nil then
            local timeDiff = currentTime - result[1].time
            local howLong = result[1].howlong

            TriggerClientEvent("qb-onderwereld:client:showDisplay",src,result,timeDiff)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_started"), "error")
        end
    end)

end)

RegisterNetEvent("qb-onderwereld:server:fullforVask",function(args)
    local src = source
    local result = args.result
    local number = args.number
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    local timeDiff = currentTime - result[number].time
    local howLong = result[number].howlong
    if timeDiff >= howLong then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.wash") ..result[number].amount.. "!", "success")
        MySQL.query('SELECT * FROM wash_database WHERE citizenid = ?', {citizenid}, function(result)
            if result ~= nil and result[1] ~= nil then
                local idToDelete = result[number].ID
                MySQL.Async.execute("DELETE FROM wash_database WHERE id = @id", { ['@id'] = idToDelete }, function()
                    Player.Functions.AddMoney("cash", result[number].amount, "Washed cash")

                end)
            end
        end)

        -- MySQL.Async.execute("DELETE FROM wash_database WHERE citizenid = @citizenid", { ['@citizenid'] = citizenid }, function()
        --     Player.Functions.AddMoney("cash", result[number].amount, "Vasket penger")
        -- end)
    else
        local total_seconds = howLong - timeDiff
        local hours = math.floor(total_seconds / 3600)
        local minutes = math.floor((total_seconds % 3600) / 60)
        local seconds = total_seconds % 60
        local output = ""
        if hours ~= 0 then
          output = hours .. Lang:t("label.hours")
        end
        if minutes ~= 0 then
          output = output .. minutes ..Lang:t("label.minutes")
        end
        if seconds ~= 0 then
          output = output .. seconds .. Lang:t("label.seconds")
        end                
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.cannot_collect")..result[number].amount.."!".. Lang:t("error.have_to_wait") .. output, "error")
    end
end)

