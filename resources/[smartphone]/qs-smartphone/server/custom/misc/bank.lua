local BankWebhook = Config.BankWebhook

function LogTransferToDiscord(src, target, amount)
    local embed = {
        {
            ["color"] = 65280, -- Color en hexadecimal (verde)
            ["title"] = "SMARTPHONE Bank",
            ["description"] = 'Log of bank app',
            ["footer"] = {
                ["text"] = "Player: " .. src .. " Send to " ..target.. " $ " ..amount
            }
        }
    }
    PerformHttpRequest(BankWebhook, function(err, text, headers) end, 'POST', json.encode({ username = "FiveM", embeds = embed }), { ['Content-Type'] = 'application/json' })
end

if Config.Framework == 'esx' then 
    RegisterServerEvent('qs-smartphone:server:TransferMoney')
    AddEventHandler('qs-smartphone:server:TransferMoney', function(Iban, amount)
        local src = source
        local sender = ESX.GetPlayerFromId(src)
        if not sender then return end
        if sender.getAccount('bank').money <= amount then 
            TriggerClientEvent("qs-smartphone:client:notify", src, {
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_DONT_ENOUGH"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            return
        end 
        if Config.BankSystem == 'id' then
            local iban = tonumber(Iban)
            local target = ESX.GetPlayerFromId(iban)
            if not target then                 
                TriggerClientEvent("qs-smartphone:client:notify", src, {
                    title = Lang("BANK_TITLE"),
                    text = Lang("IBAN_DONT_EXISTS"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end
            target.addAccountMoney('bank', amount)
            sender.removeAccountMoney('bank', amount)

            if not GetExistPhone(target) then
                TriggerClientEvent("qs-smartphone:client:notify", src, { 
                    title = Lang("BANK_TITLE"),
                    text = Lang("BANK_NOT_PHONE"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end
            TriggerClientEvent("qs-smartphone:client:notify", iban, {
                title = Lang("BANK_TITLE"),
                text = string.format(Lang("BANK_TRANSFER"), amount),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent("qs-smartphone:client:notify", src, { 
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_TRANSFER_SUCCESS"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent('qs-smartphone:client:TransferMoney', iban, amount, target.getAccount('bank').money)
            LogTransferToDiscord(src, iban, amount)
        elseif Config.BankSystem == 'iban' then
            local iban = tostring(Iban)
            local query = '%' .. iban .. '%'
            local result = MySQL.query.await('SELECT * FROM users WHERE charinfo LIKE ?', {query})
            if result[1] == nil then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end
            local target = ESX.GetPlayerFromIdentifier(result[1].identifier)
            if not target then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end

            if not GetExistPhone(target) then
                TriggerClientEvent("qs-smartphone:client:notify", src, { 
                    title = Lang("BANK_TITLE"),
                    text = Lang("BANK_NOT_PHONE"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end

            target.addAccountMoney('bank', amount)
            sender.removeAccountMoney('bank', amount)
            TriggerClientEvent("qs-smartphone:client:notify", target.source, {
                title = Lang("BANK_TITLE"),
                text = string.format(Lang("BANK_TRANSFER"), amount),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent("qs-smartphone:client:notify", src, { 
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_TRANSFER_SUCCESS"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent('qs-smartphone:client:TransferMoney', target.source, amount, target.getAccount('bank').money)
            LogTransferToDiscord(src, target.source, amount)
        elseif Config.BankSystem == 'okokBanking' then
            local iban = tostring(Iban)
            local query = '%' .. iban .. '%'
            local result = MySQL.query.await('SELECT * FROM users WHERE iban LIKE ?', {query})
            if result[1] == nil then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end
            local target = ESX.GetPlayerFromIdentifier(result[1].identifier)
            if not target then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end

            if not GetExistPhone(target) then
                TriggerClientEvent("qs-smartphone:client:notify", src, { 
                    title = Lang("BANK_TITLE"),
                    text = Lang("BANK_NOT_PHONE"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end
    
            target.addAccountMoney('bank', amount)
            sender.removeAccountMoney('bank', amount)
            TriggerClientEvent("qs-smartphone:client:notify", target.source, {
                title = Lang("BANK_TITLE"),
                text = string.format(Lang("BANK_TRANSFER"), amount),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent("qs-smartphone:client:notify", src, { 
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_TRANSFER_SUCCESS"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent('qs-smartphone:client:TransferMoney', target.source, amount, target.getAccount('bank').money)
            LogTransferToDiscord(src, target.source, amount)
        end
    end)
elseif Config.Framework == 'qb' then
    RegisterServerEvent('qs-smartphone:server:TransferMoney')
    AddEventHandler('qs-smartphone:server:TransferMoney', function(Iban, amount)
        local src = source
        local sender = GetPlayerFromIdFramework(src)
        if not sender then return end
        if sender.PlayerData.money['bank'] <= amount then 
            TriggerClientEvent("qs-smartphone:client:notify", src, {
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_DONT_ENOUGH"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            return
        end 
        if Config.BankSystem == 'id' then
            local iban = tonumber(Iban)
            local target = GetPlayerFromIdFramework(iban)
            if not target then                 
                TriggerClientEvent("qs-smartphone:client:notify", src, {
                    title = Lang("BANK_TITLE"),
                    text = Lang("IBAN_DONT_EXISTS"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end

            if not GetExistPhone(target) then
                TriggerClientEvent("qs-smartphone:client:notify", src, { 
                    title = Lang("BANK_TITLE"),
                    text = Lang("BANK_NOT_PHONE"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end

            target.Functions.AddMoney('bank', amount)
            sender.Functions.RemoveMoney('bank', amount)
            TriggerClientEvent("qs-smartphone:client:notify", iban, {
                title = Lang("BANK_TITLE"),
                text = string.format(Lang("BANK_TRANSFER"), amount),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent("qs-smartphone:client:notify", src, { 
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_TRANSFER_SUCCESS"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent('qs-smartphone:client:TransferMoney', iban, amount, sender.PlayerData.money['bank'])
            LogTransferToDiscord(src, iban, amount)
        elseif Config.BankSystem == 'iban' or Config.BankSystem == 'okokBanking' then
            local iban = tostring(Iban)
            local query = '%' .. iban .. '%'
            local result = MySQL.query.await('SELECT * FROM players WHERE charinfo LIKE ?', {query})
            if result[1] == nil then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end
            local target = QBCore.Functions.GetPlayerByCitizenId(result[1].citizenid)
            if not target then 
                TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("IBAN_DONT_EXISTS"), 'error')
                return
            end

            if not GetExistPhone(target) then
                TriggerClientEvent("qs-smartphone:client:notify", src, { 
                    title = Lang("BANK_TITLE"),
                    text = Lang("BANK_NOT_PHONE"),
                    icon = "./img/apps/bank.png",
                    timeout = 5000
                })
                return
            end

            target.Functions.AddMoney('bank', amount)
            sender.Functions.RemoveMoney('bank', amount)
            TriggerClientEvent("qs-smartphone:client:notify", target.PlayerData.source, {
                title = Lang("BANK_TITLE"),
                text = string.format(Lang("BANK_TRANSFER"), amount),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent("qs-smartphone:client:notify", src, { 
                title = Lang("BANK_TITLE"),
                text = Lang("BANK_TRANSFER_SUCCESS"),
                icon = "./img/apps/bank.png",
                timeout = 5000
            })
            TriggerClientEvent('qs-smartphone:client:TransferMoney', target.PlayerData.source, amount, target.PlayerData.money.bank)
            LogTransferToDiscord(src, target.PlayerData.source, amount)
        end
    end)
end

RegisterServerCallback('qs-smartphone:server:GetBankData', function(source, cb)
    local src = source
    local data = {}
    if Config.Framework == 'esx' then 
        local xPlayer = GetPlayerFromId(src)
        local qPlayer = GetPlayerFromIdFramework(src)
        local bankMoney = xPlayer.getAccount('bank').money
        local ibanNanme = qPlayer.PlayerData.charinfo.account
        local name = qPlayer.PlayerData.charinfo.firstname .. " " ..qPlayer.PlayerData.charinfo.lastname 

        if Config.BankSystem == 'id' then
            data = {
                bank = bankMoney, 
                iban = src, 
                username = name
            }
        elseif Config.BankSystem == 'iban' then
            data = {
                bank = bankMoney, 
                iban = ibanNanme, 
                username = name
            }
        elseif Config.BankSystem == 'okokBanking' then
            MySQL.Async.fetchAll('SELECT iban FROM users WHERE identifier = @identifier', { ['@identifier'] = xPlayer.identifier }, function(result)
                if result and result[1] and result[1].iban then
                    data = {
                        bank = bankMoney, 
                        iban = result[1].iban, 
                        username = name
                    }
                else
                    data = {
                        bank = bankMoney, 
                        iban = Lang("BANK_MISSING_IBAN"),
                        username = name
                    }
                end
                cb(data)
            end)
            return
        else
            data = {
                bank = bankMoney, 
                iban = 'Missing',
                username = name
            }
            print('Bad config of iban, please only select one') 
        end
        cb(data)
    elseif Config.Framework == 'qb' then 
        local xPlayer = GetPlayerFromIdFramework(src)
        local bankMoney = xPlayer.PlayerData.money['bank']
        local ibanQB = xPlayer.PlayerData.charinfo.account
        local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
        if Config.BankSystem == 'id' then
            data = {
                bank = bankMoney, 
                iban = src, 
                username = name
            }
        elseif Config.BankSystem == 'iban' then
            data = {
                bank = bankMoney, 
                iban = ibanQB,
                username = name
            }
        elseif Config.BankSystem == 'okokBanking' then
            data = {
                bank = bankMoney, 
                iban = ibanQB,
                username = name
            }
        else
            data = {
                bank = bankMoney, 
                iban = 'Missing',
                username = name
            }
            print('Bad config of iban, please only select one') 
        end
        cb(data)
    end
end)