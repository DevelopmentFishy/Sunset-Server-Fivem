if Config.ox_inventory then
    function GetExistPhone(player)
        if not Config.RequiredPhone then
            return 'classic_phone'
        end

        for k, v in pairs(Config.Phones) do
            local item = exports.ox_inventory:GetItem(player.source, k)
            if item and item.count > 0 then
                return item.name
            end
        end
        return false
    end
elseif Config.codem_inventory then
    function GetExistPhone(player)
        if not Config.RequiredPhone then
            return 'classic_phone'
        end

        for k, v in pairs(Config.Phones) do
            local item = exports['codem-inventory']:CheckItemValid(player.source, k, 1)
            if item then
                return k
            end
        end
        return false
    end
else
    function GetExistPhone(player)
        if not Config.RequiredPhone then
            return 'classic_phone'
        end
        for k, v in pairs(Config.Phones) do
            local hasPhone = GetItem(player, k)
            if hasPhone and GetItemAmount(hasPhone) > 0 then
                return hasPhone.name
            end
        end
        return false
    end
end

exports('GetExistPhone', GetExistPhone)

RegisterServerCallback('qs-smartphone:server:HasPhone', function(source, cb)
    local src = source
    local xPlayer = GetPlayerFromId(src)
    if not xPlayer then
        cb(false)
        return
    end

    local phone = GetExistPhone(xPlayer)
    cb(phone)
end)

function CheckPhone(player)
    if not Config.RequiredPhone then
        return true
    end

    local havePhone = false
    local xPlayer = GetPlayerFromId(player)
    if not xPlayer then return false end

    if GetExistPhone(xPlayer) then
        havePhone = true
    end

    return havePhone
end

if Config.RequiredPhone then
    for k, v in pairs(Config.Phones) do
        if Config.Framework == 'esx' then
            ESX.RegisterUsableItem(k, function(source, item)
                TriggerClientEvent('qs-smartphone:openPhone', source)
            end)
        elseif Config.Framework == 'qb' then
            QBCore.Functions.CreateUseableItem(k, function(source, item)
                TriggerClientEvent('qs-smartphone:openPhone', source)
            end)
        end
    end
end

RegisterServerCallback('qs-smartphone:server:GetCharacterData', function(source, cb, id)
    local src = source or id
    local player = GetPlayerFromIdFramework(src)
    if player then
        local notifies = MySQL.Sync.fetchAll('SELECT * FROM phone_notifies WHERE phone = @phone', { ['@phone'] = player.PlayerData.charinfo.phone })

        for i = 1, #notifies do
            local result2 = MySQL.Sync.fetchAll('SELECT * FROM player_contacts WHERE identifier = @identifier AND number = @number', {
                ['@identifier'] = player.PlayerData.charinfo.phone,
                ['@number'] = notifies[i].msg_head
            })

            if result2[1] then
                notifies[i].msg_head = result2[1].name
            end
        end

        local query = (Config.Framework == 'esx') and 'SELECT phonePos FROM ' .. userColumns .. ' WHERE identifier = ?' or 'SELECT phonePos FROM players WHERE citizenid = ?'
        local coords = MySQL.Sync.fetchAll(query, { player.identifier })
        coords = coords[1].phonePos
        coords = coords == '' and nil or json.decode(coords)
        local pinCode = player.PlayerData.metadata['phone'].Pincode

        cb({
            charinfo = player.PlayerData.charinfo,
            money = (Config.Framework == 'esx') and ESX.GetPlayerFromId(src).getAccount('bank').money or player.PlayerData.money['cash'],
            notifies = notifies or {},
            pinCode = pinCode,
            coords = coords
        })
    else
        print('^4[QS Smartphone] ^3[Debug]^0: player = nil, check qs-base (if you are using es_extended) started correctly and rejoin in the server...')
    end
end)

RegisterServerEvent('qs-smartphone:server:uberPay')
AddEventHandler('qs-smartphone:server:uberPay', function(item, type)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local name = Config.uberItems[item]['item']
        if xPlayer and name then
            if xPlayer.getInventoryItem(name) and xPlayer.getInventoryItem(name).count > 0 then
                xPlayer.removeInventoryItem(name, 1)
                local price = (Config.uberItems[item]['price'] * Config.uberPriceMultiplier)
                if type == 1 then
                    price = price + math.random(Config.uberTipMin, Config.uberTipMax)
                    xPlayer.addMoney(price)
                elseif type == 2 then
                    xPlayer.addMoney(price)
                end
            end
        end
    elseif Config.Framework == 'qb' then
        local xPlayer = GetPlayerFromIdFramework(source)
        local name = Config.uberItems[item]['item']
        if xPlayer and name then
            if xPlayer.Functions.GetItemByName(name) and xPlayer.Functions.GetItemByName(name).amount > 0 then
                xPlayer.Functions.RemoveItem(name, 1)
                local price = (Config.uberItems[item]['price'] * Config.uberPriceMultiplier)
                if type == 1 then
                    price = price + math.random(Config.uberTipMin, Config.uberTipMax)
                    xPlayer.Functions.AddMoney('cash', price)
                elseif type == 2 then
                    xPlayer.Functions.AddMoney('cash', price)
                end
            end
        end
    end
end)

RegisterServerCallback('qs-smartphone:server:ScanPlate', function(source, cb, plate)
    if Config.Framework == 'esx' then
        local src = source
        local vehicleData = {}
        if plate ~= nil then
            local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE plate = ?', { plate })
            if result[1] ~= nil then
                local player = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = ?', { result[1].owner })
                local charinfo = json.decode(player[1].charinfo)
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = charinfo.firstname .. ' ' .. charinfo.lastname,
                    citizenid = result[1].owner
                }
            elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
                vehicleData = GeneratedPlates[plate]
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[plate] = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid
                }
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid
                }
            end
            cb(vehicleData)
        else
            cb(nil)
        end
    elseif Config.Framework == 'qb' then
        local src = source
        local vehicleData = {}
        if plate ~= nil then
            local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
            if result[1] ~= nil then
                local player = MySQL.Sync.fetchAll('SELECT * FROM ' .. userColumns .. ' WHERE citizenid = ?', { result[1].citizenid })
                local charinfo = json.decode(player[1].charinfo)
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = charinfo.firstname .. ' ' .. charinfo.lastname,
                    citizenid = result[1].citizenid
                }
            elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
                vehicleData = GeneratedPlates[plate]
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[plate] = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid
                }
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid
                }
            end
            cb(vehicleData)
        else
            cb(nil)
        end
    end
end)

function GenerateOwnerName()
    local names = {
        [1] = { name = 'Bailey Sykes', citizenid = 'DSH091G93' },
        [2] = { name = 'Aroush Goodwin', citizenid = 'AVH09M193' },
        [3] = { name = 'Tom Warren', citizenid = 'DVH091T93' },
        [4] = { name = 'Abdallah Friedman', citizenid = 'GZP091G93' },
        [5] = { name = 'Lavinia Powell', citizenid = 'DRH09Z193' },
        [6] = { name = 'Andrew Delarosa', citizenid = 'KGV091J93' },
        [7] = { name = 'Skye Cardenas', citizenid = 'ODF09S193' },
        [8] = { name = 'Amelia-Mae Walter', citizenid = 'KSD0919H3' },
        [9] = { name = 'Elisha Cote', citizenid = 'NDX091D93' },
        [10] = { name = 'Janice Rhodes', citizenid = 'ZAL0919X3' },
        [11] = { name = 'Justin Harris', citizenid = 'ZAK09D193' },
        [12] = { name = 'Montel Graves', citizenid = 'POL09F193' },
        [13] = { name = 'Benjamin Zavala', citizenid = 'TEW0J9193' },
        [14] = { name = 'Mia Willis', citizenid = 'YOO09H193' },
        [15] = { name = 'Jacques Schmitt', citizenid = 'QBC091H93' },
        [16] = { name = 'Mert Simmonds', citizenid = 'YDN091H93' },
        [17] = { name = 'Rickie Browne', citizenid = 'PJD09D193' },
        [18] = { name = 'Deacon Stanley', citizenid = 'RND091D93' },
        [19] = { name = 'Daisy Fraser', citizenid = 'QWE091A93' },
        [20] = { name = 'Kitty Walters', citizenid = 'KJH0919M3' },
        [21] = { name = 'Jareth Fernandez', citizenid = 'ZXC09D193' },
        [22] = { name = 'Meredith Calhoun', citizenid = 'XYZ0919C3' },
        [23] = { name = 'Teagan Mckay', citizenid = 'ZYX0919F3' },
        [24] = { name = 'Kurt Bain', citizenid = 'IOP091O93' },
        [25] = { name = 'Burt Kain', citizenid = 'PIO091R93' },
        [26] = { name = 'Joanna Huff', citizenid = 'LEK091X93' },
        [27] = { name = 'Carrie-Ann Pineda', citizenid = 'ALG091Y93' },
        [28] = { name = 'Gracie-Mai Mcghee', citizenid = 'YUR09E193' },
        [29] = { name = 'Robyn Boone', citizenid = 'SOM091W93' },
        [30] = { name = 'Aliya William', citizenid = 'KAS009193' },
        [31] = { name = 'Rohit West', citizenid = 'SOK091093' },
        [32] = { name = 'Skylar Archer', citizenid = 'LOK091093' },
        [33] = { name = 'Jake Kumar', citizenid = 'AKA420609' },
    }
    return names[math.random(1, #names)]
end

-- Delete and reset cache apps.
RegisterCommand('deleteallapps', function(source, args)
    if source == 0 then
        if Config.Framework == 'esx' then
            MySQL.Sync.execute('UPDATE ' .. userColumns .. ' SET apps = @apps, widget = @widget', {})
        elseif Config.Framework == 'qb' then
            MySQL.Sync.execute('UPDATE ' .. userColumns .. ' SET apps = @apps, widget = @widget', {})
        end
        print('^4[QS Smartphone] ^3[Debug]^0: Data of column apps and widget deleted from all users!')
    else
        TriggerClientEvent('qs-smartphone:sendMessage', source, 'Command only allowed to be executed from console!', 'error')
    end
end, true)

-- Delete and reset cache apps.
RegisterCommand('deleteuserapps', function(source, args)
    if args and args[1] then
        local idtarget = args[1]
        local target = GetPlayerFromIdFramework(tonumber(idtarget))
        if target then
            if Config.Framework == 'esx' then
                MySQL.Sync.execute('UPDATE ' .. userColumns .. ' SET apps = @apps, widget = @widget WHERE identifier = @identifier', {
                    ['@apps'] = nil,
                    ['@widget'] = nil,
                    ['@identifier'] = target.identifier
                })
            elseif Config.Framework == 'qb' then
                MySQL.Sync.execute('UPDATE ' .. userColumns .. ' SET apps = @apps, widget = @widget WHERE citizenid = @citizenid', {
                    ['@apps'] = nil,
                    ['@widget'] = nil,
                    ['@citizenid'] = target.identifier
                })
            end
            print('^4[QS Smartphone] ^3[Debug]^0: Data of column apps and widget deleted from user ID: ' .. idtarget .. '...')
        end
    end
end, true)

-- Test dispatch.
--RegisterCommand('fakedispatch', function()
--    local alertData = {
--        title = "10-33 | Shop Robbery",
--        coords = {x = 30, y = 20, z = 40},
--        description = "A robbery started at the store"
--    }
--    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
--end)

-- Check player phone.
RegisterCommand('GetPlayerPhone', function(source, args)
    local phone = exports['qs-base']:GetPlayerPhone(source)
    print(phone)
end)

-- OkokChat, you need enable Config.CustomCodeTwitter in config_client.lua.
RegisterServerEvent('qs-smartphone:server:twitterChat')
AddEventHandler('qs-smartphone:server:twitterChat', function(playerName, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = message
    local time = os.date(os.date('%H:%M'))
    playerName = playerName

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message twitter"><i class="fab fa-twitter"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
        args = { playerName, message, time }
    })
end)
