-- RegisterServerEvent('vangelico:server:policeAlert')
-- AddEventHandler('vangelico:server:policeAlert', function(coords)
--     if Config['VangelicoHeist']['framework']['name'] == 'ESX' then
--         local players = ESX.GetPlayers()
--         for i = 1, #players do
--             local player = ESX.GetPlayerFromId(players[i])
--             if player['job']['name'] == Config['VangelicoHeist']['setjobForPolice'] then
--                 TriggerClientEvent('vangelico:client:policeAlert', players[i], coords)
--             end
--         end
--     elseif Config['VangelicoHeist']['framework']['name'] == 'QB' then
--         local players = QBCore.Functions.GetPlayers()
--         for i = 1, #players do
--             local player = QBCore.Functions.GetPlayer(players[i])
--             if player.PlayerData.job.name == Config['VangelicoHeist']['setjobForPolice'] then
--                 TriggerClientEvent('vangelico:client:policeAlert', players[i], coords)
--             end
--         end
--     end
-- end)

RegisterServerEvent('vangelico:server:policeAlert')
AddEventHandler('vangelico:server:policeAlert', function(coords)
    local src = source
    TriggerClientEvent('vangelico:client:policeAlert', src)
end)


discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/879717545597337610/fN1sTgBA8FRHu4JdEjZ6wIHdYRkqkOWgbPgw3LmvsMBgt1TZOoxo1ixBeuA0y9YMIqEX',
    ['name'] = 'rm_vangelicofinal',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dff6a13a5361bc520ef126991405caae.png?size=1024'
}

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end