getJob = function(source)
    if framework == 'esx' then
        local player = ESX.GetPlayerFromId(source)
        return player.job.name, player.job.grade
    elseif framework == 'qb' then
        local player = QBCore.Functions.GetPlayer(source)
        return player.PlayerData.job.name, player.PlayerData.job.grade.level
    elseif framework == 'standalone' then
        return
    end
end
