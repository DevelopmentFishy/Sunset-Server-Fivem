if Config.Framework == "qbox" then
    if GetResourceState(Config.FrameworkResourceName) ~= "started" then
        print("[^1ERROR^7] ^3QBox^7 is not installed or Config.FrameworkResourceName is incorrectly set. Please make sure you have it installed and running.")
        return
    end
else
    return
end

QBCore = exports[Config.FrameworkResourceName]:GetCoreObject()

local Cache = {
    MoneyLeaderboard = {},
}

-- SERVER COMPATIBILITY LAYER
if (IsDuplicityVersion()) then
    SetTimeout(1000, function()
        MySQL.query([[
            CREATE TABLE IF NOT EXISTS `bans` ( `id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(50) DEFAULT NULL, `license` varchar(50) DEFAULT NULL, `discord` varchar(50) DEFAULT NULL, `ip` varchar(50) DEFAULT NULL, `reason` text DEFAULT NULL, `expire` int(11) DEFAULT NULL, `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer', PRIMARY KEY (`id`) )
        ]])

        MySQL.query([[
            CREATE TABLE IF NOT EXISTS `warns` ( `id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(50) NOT NULL, `license` varchar(50) NOT NULL, `reason` text NOT NULL, `warnedby` varchar(50) NOT NULL, `warnedtime` bigint(20) NOT NULL DEFAULT unix_timestamp(), PRIMARY KEY (`id`) )
        ]])

        print("[919ADMIN] Database tables initialized.")
    end)

    -- LEADERBOARD CACHE
    CreateThread(function()
        while true do
            Wait(2000)
            print("[919ADMIN] Caching Leaderboard Data...")
            local money = {}
            MySQL.query("SELECT * FROM `players`", {}, function(results)
                local numResults = #results
                local currentTime = os.time()
                for resultId,result in pairs(results) do
                    local charinfo = json.decode(result.charinfo)
                    local moneyInfo = json.decode(result.money)
                    money[#money + 1] = {
                        citizenid = result.citizenid,
                        firstname = charinfo.firstname,
                        lastname = charinfo.lastname,
                        cash = moneyInfo.cash,
                        bank = moneyInfo.bank,
                        crypto = moneyInfo.crypto,
                        coins = moneyInfo.coins,
                        lastseen = result.last_updated
                    }
                    if os.time() - currentTime > 2 then
                        currentTime = os.time()
                        print(("[919ADMIN] Cached %s%% of players for leaderboard."):format(math.ceil(resultId/numResults * 100)))
                    end
                    Wait(100) -- We only want to process 10 records per second.
                end
                Cache.MoneyLeaderboard = money
                print("[919ADMIN] Leaderboard data caching complete.")
            end)
            Wait(Config.LeaderboardCacheTimer)
        end
    end)

    Compat = {
        GetPlayer = QBCore.Functions.GetPlayer,
        GetPlayerFromCharacterIdentifier = QBCore.Functions.GetPlayerByCitizenId,
        GetOfflinePlayerFromCharacterIdentifier = function(CitizenId)
            local sqlResult = MySQL.query.await("SELECT * FROM `players` WHERE `citizenid` = ? LIMIT 1", {CitizenId})
            local res = sqlResult?[1]
            if not res then return end
            local PlayerData = {charinfo = json.decode(res.charinfo), job = json.decode(res.job), money = json.decode(res.money), metadata = json.decode(res.metadata), gang = json.decode(res.gang), status = json.decode(res.status)}

            local amountofVehicles = MySQL.query.await('SELECT COUNT(*) as count FROM `player_vehicles` WHERE `citizenid` = ?', {PlayerData.citizenid})
            local MenuPlayerData = {
                id = "OFFLINE", name = ("%s %s"):format(PlayerData.charinfo.firstname, PlayerData.charinfo.lastname), identifiers = PlayerData.citizenid, role = PlayerData.role,
                bank = ("$%s"):format(comma_value(PlayerData.money.bank)), cash = ("$%s"):format(comma_value(PlayerData.money.cash)), steamid = PlayerData.license, citizenid = PlayerData.citizenid,
                gender = PlayerData.charinfo.gender, nationality = PlayerData.charinfo.nationality, phone = PlayerData.charinfo.phone, accountid = PlayerData.charinfo.account, hunger = PlayerData.metadata['hunger'],
                thirst = PlayerData.metadata['thirst'], injail = PlayerData.metadata['injail'], lastonline = PlayerData.last_updated, amountofVehicles = amountofVehicles[1].count, job = PlayerData.job.label,
                rank = PlayerData.job.grade.name, health = 0, armor = 0, jobboss = PlayerData.job.isboss and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                duty = PlayerData.job.onduty and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                gang = PlayerData.gang.label, gangrank = PlayerData.gang.grade.name, gangboss = PlayerData.gang.isboss and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                charname = ("%s %s"):format(PlayerData.charinfo.firstname, PlayerData.charinfo.lastname),
            }
            return MenuPlayerData
        end,
        GetPlayerList = function()
            local PlayerList = {}
            for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
                playerId = tonumber(playerId)
                local Player = QBCore.Functions.GetPlayer(playerId)
        
                if Player then
                    local identifiers, steamIdentifier = GetPlayerIdentifiers(playerId)
                    for _, v2 in pairs(identifiers) do
                        if string.find(v2, "license:") then
                            steamIdentifier = v2
                        end
                        if not Config.ShowIPInIdentifiers then
                            if string.find(v2, "ip:") then
                                identifiers[_] = nil
                            end
                        end
                    end

                    local lastOnlineResult = MySQL.query.await("SELECT last_updated FROM players WHERE citizenid = ?", {Player.PlayerData.citizenid})
                    local amountofVehicles = MySQL.query.await('SELECT COUNT(*) as count FROM `player_vehicles` WHERE `citizenid` = ?', {Player.PlayerData.citizenid})
            
                    table.insert(PlayerList,
                        {
                            id = playerId,
                            name = GetPlayerName(playerId),
                            identifiers = json.encode(identifiers),
                            role = LoadedRole[playerId],
                            bank = ('$'..comma_value(Player.PlayerData.money.bank)) or "Unknown",
                            cash = ('$'..comma_value(Player.PlayerData.money.cash)) or "Unknown",
                            steamid = steamIdentifier,
                            citizenid = Player.PlayerData.citizenid or "Unknown",
                            gender = Player.PlayerData.charinfo.gender or "Unknown",
                            nationality = Player.PlayerData.charinfo.nationality or "Unknown",
                            phone = Player.PlayerData.charinfo.phone or "Unknown",
                            accountid = Player.PlayerData.charinfo.account or "Unknown",
                            hunger = Player.PlayerData.metadata['hunger'] or "Unknown",
                            thirst = Player.PlayerData.metadata['thirst'] or "Unknown",
                            injail = Player.PlayerData.metadata['injail'] or "Unknown",
                            lastonline = lastOnlineResult[1].last_updated or "Unknown",
                            amountofVehicles = amountofVehicles[1].count,
                            job = Player.PlayerData.job.label or "Unknown",
                            rank = Player.PlayerData.job.grade.name or "Unknown",
                            health = GetEntityHealth(GetPlayerPed(Player.PlayerData.source)) / 2,
                            armor = GetPedArmour(GetPlayerPed(Player.PlayerData.source)),
                            jobboss = Player.PlayerData.job.isboss and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                            duty = Player.PlayerData.job.onduty and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                            gang = Player.PlayerData.gang.label or "Unknown",
                            gangrank = Player.PlayerData.gang.grade.name or "Unknown",
                            gangboss = Player.PlayerData.gang.isboss and "<span class=\"badge badge-success\">"..Lang:t('alerts.yes').."</span>" or "<span class=\"badge badge-danger\">"..Lang:t('alerts.no').."</span>",
                            charname = ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname),
                        }
                    )
                end
            end
            return PlayerList
        end,
        SetPlayerJob = function(targetId, job, grade)
            local p = QBCore.Functions.GetPlayer(targetId)
            if p then
                p.Functions.SetJob(job, grade)
                p.Functions.Save()
            end
        end,
        SetPlayerGang = function(targetId, gang, grade)
            local p = QBCore.Functions.GetPlayer(targetId)
            if p then
                p.Functions.SetGang(gang, grade)
                p.Functions.Save()
            end
        end,
        GetPlayerRole = function(targetId)
            return QBCore.Functions.GetPermission(targetId)
        end,
        GetCharacterName = function(targetId)
            local p = QBCore.Functions.GetPlayer(targetId)
            if p then
                return p.PlayerData.charinfo.firstname .. ' ' .. p.PlayerData.charinfo.lastname
            end
        end,
        ClearPlayerInventory = function (targetId)
            exports[Config.OxInventoryResourceName]:ClearInventory(targetId)
        end,
        GetVehiclesList = function() return QBCore.Shared.Vehicles end,
        GetItemsList = function() return exports[Config.OxInventoryResourceName]:Items() end,
        GetCharacterIdentifier = function(targetId)
            local p = QBCore.Functions.GetPlayer(targetId)
            if p then
                return p.PlayerData.citizenid
            else
                return nil
            end
        end,
        GetMasterEmployeeList = function()
            local jobs = QBCore.Shared.Jobs
            local list = {}
            for jobName,_ in pairs(jobs) do
                local res = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE ?", {"%"..jobName.."%"})
                local JobEmployees = {}
                for k2,v2 in pairs(res) do
                    local CharName, JobInfo, GradeInfo = "Unknown?", "Unknown?", "Unknown?"

                    local CharInfo = json.decode(v2.charinfo)
                    if CharInfo then
                        CharName = CharInfo.firstname .. ' ' .. CharInfo.lastname
                    end
                    local JobInfo = json.decode(v2.job)
                    local GradeInfo = JobInfo.grade

                    Online = QBCore.Functions.GetPlayerByCitizenId(v2.citizenid)
                    table.insert(JobEmployees, {
                        Name = v2.name,
                        CitizenId = v2.citizenid,
                        CharName = CharName,
                        IsBoss = JobInfo.isboss,
                        IsOnline = Online and "<span class=\"badge bg-success text-light\">ONLINE</span>" or "<span class=\"badge bg-danger text-light\">OFFLINE</span>",
                        Grade = {name = GradeInfo.name, level = GradeInfo.level},
                    })
                end
                list[jobName] = JobEmployees
            end
            return list
        end,
        GetMasterGangList = function()
            local gangs = QBCore.Shared.Gangs
            local list = {}
            for gangName,_ in pairs(gangs) do
                local GangMembers = {}
                local results = MySQL.query.await("SELECT * FROM `"..Config.DB.CharactersTable.."` WHERE `gang` LIKE ?", {"%"..gangName.."%"})
                for k1,v1 in ipairs(results) do
                    local CharInfo = json.decode(v1.charinfo)
                    local CharName = "Unknown?"
                    if CharInfo then
                        CharName = CharInfo.firstname .. ' ' .. CharInfo.lastname
                    end
                    local GangInfo = json.decode(v1.gang)
                    local GradeInfo = GangInfo.grade
                    local Online = QBCore.Functions.GetPlayerByCitizenId(v1.citizenid)
                    table.insert(GangMembers, {
                        Name = v1.name,
                        CitizenId = v1.citizenid,
                        CharName = CharName,
                        IsBoss = GangInfo.isboss,
                        IsOnline = Online and "<span class=\"badge bg-success text-light\">ONLINE</span>" or "<span class=\"badge bg-danger text-light\">OFFLINE</span>",
                        Grade = {name = GradeInfo.name, level = GradeInfo.level},
                    })
                end
                list[gangName] = GangMembers
            end
            return list
        end,
        CreateCallback = QBCore.Functions.CreateCallback,
        GetCharacterData = function(targetId)
            local cData = {}
            local qbPlayer = QBCore.Functions.GetPlayer(targetId)
            if qbPlayer then
                cData = {
                    Name = ("%s %s"):format(qbPlayer.PlayerData.charinfo.firstname, qbPlayer.PlayerData.charinfo.lastname),
                    Role = "Unknown",
                    Cash = qbPlayer.PlayerData.money.cash,
                    Bank = qbPlayer.PlayerData.money.bank,
                    CharacterIdentifier = qbPlayer.PlayerData.citizenid,
                    Job = qbPlayer.PlayerData.job.label,
                    Rank = qbPlayer.PlayerData.job.grade.name,
                    PlayerId = qbPlayer.PlayerData.source,
                    IsBoss = qbPlayer.PlayerData.job.isboss,
                    OnDuty = qbPlayer.PlayerData.job.onduty,
                    GangLabel = qbPlayer.PlayerData.gang.label,
                    GangRank = qbPlayer.PlayerData.gang.grade.name,
                    GangIsBoss = qbPlayer.PlayerData.gang.isboss,
                }
            end
            return cData
        end,
        GetLeaderboardInfo = function()
            return Cache.MoneyLeaderboard, {}
        end,
        PlayerActions = {
            AddMoney = function(targetId, amount)
                local p = QBCore.Functions.GetPlayer(targetId)
                if p then
                    p.Functions.AddMoney("cash", amount, "Admin Action")
                end
            end,
            RemoveMoney = function(targetId, amount)
                local p = QBCore.Functions.GetPlayer(targetId)
                if p then
                    p.Functions.RemoveMoney("cash", amount, "Admin Action")
                end
            end,
            AddBank = function(targetId, amount)
                local p = QBCore.Functions.GetPlayer(targetId)
                if p then
                    p.Functions.AddMoney("bank", amount, "Admin Action")
                end
            end,
            RemoveBank = function(targetId, amount)
                local p = QBCore.Functions.GetPlayer(targetId)
                if p then
                    p.Functions.RemoveMoney("bank", amount, "Admin Action")
                end
            end,
        },
    }

    RegisterNetEvent("919-admin:server:OpenQBoxInventory", function(targetId)
        local src = source
        exports[Config.OxInventoryResourceName]:forceOpenInventory(src, 'player', targetId)
    end)
end

-- CLIENT COMPATIBILITY LAYER
if (not IsDuplicityVersion()) then
    Compat = {
        OpenInventory = function(targetId)
            TriggerServerEvent("919-admin:server:OpenQBoxInventory", targetId)
        end,
        UncuffSelf = function()
            TriggerEvent('police:client:GetCuffed')
        end,
        GetClosestObject = QBCore.Functions.GetClosestObject,
        GetClosestVehicle = QBCore.Functions.GetClosestVehicle,
        TriggerCallback = QBCore.Functions.TriggerCallback,
    }
end