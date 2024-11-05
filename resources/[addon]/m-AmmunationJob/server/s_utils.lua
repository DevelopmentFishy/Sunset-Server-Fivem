local QBCore = exports[Config.Settings.Core]:GetCoreObject()

RegisterServerEvent(Config.Prefix..":Server:Billing")
AddEventHandler(Config.Prefix..":Server:Billing", function(playerId, amount)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    if biller.PlayerData.job.name == Config.Settings.Job then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    MySQL.Async.execute('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (@citizenid, @amount, @society, @sender)', {
                        ['@citizenid'] = billed.PlayerData.citizenid,
                        ['@amount'] = amount,
                        ['@society'] = biller.PlayerData.job.name,
                        ['@sender'] = biller.PlayerData.charinfo.firstname
                    })
                    TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                    TriggerClientEvent(Config.Prefix..':Client:Notify', source, "Invoice sent successfully.", 'success', 5000)
                    TriggerClientEvent(Config.Prefix..':Client:Notify', billed.PlayerData.source, "New invoice received.", "primary", 5000)
                else
                    TriggerClientEvent(Config.Prefix..':Client:Notify', source, "Must be a valid value above 0.", 'error', 5000)
                end
            else
                TriggerClientEvent(Config.Prefix..':Client:Notify', source, "You can't bill yourself.", 'error', 5000)
            end
        else
            TriggerClientEvent(Config.Prefix..':Client:Notify', source, "Player unavailable.", 'error', 5000)
        end
    else
        TriggerClientEvent(Config.Prefix..':Client:Notify', source, "You don't have permissions.", 'error', 5000)
    end
end)



