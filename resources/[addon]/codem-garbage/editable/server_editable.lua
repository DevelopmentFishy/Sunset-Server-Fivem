bot_Token = ""
bot_logo = "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
bot_name = "Codem Store"


discord_webhook = {
    ['jobfinish'] = "",
}

local key = nil
Citizen.CreateThread(function()
    key = "CODEM" .. math.random(10000, 999999999) .. "saas" .. math.random(10000, 999999999) .. "KEY"
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while Core == nil do
        Citizen.Wait(0)
    end
    RegisterCallback('codem-garbage:getKey', function(source, cb)
        cb(key)
    end)
end)


AddEventHandler('playerDropped', function(reason)
    local src = source
    leaveLobbyorDeleteLobby(src)
end)


RegisterServerEvent('codem-garbage:resetjob', function()
    local src = source
    leaveLobbyorDeleteLobby(src)
end)


function leaveLobbyorDeleteLobby(src)
    local clientIdentifier = GetIdentifier(src)
    local data = playerJobData[clientIdentifier]
    if not data then
        return
    end
    local roomname = false
    for k, v in pairs(coopData) do
        local players = v.players
        for _, player in pairs(players) do
            if player.src == src then
                roomname = v.roomData.hostIdentifier
            end
        end
    end
    if roomname == nil then
        return
    end
    local room = coopData[roomname]
    if not room then
        return
    end
    local players = room.players
    for _, player in pairs(players) do
        if tonumber(player.src) == tonumber(src) then
            if player.host then
                for __, playerId in pairs(players) do
                    if tonumber(playerId.src) then
                        TriggerClientEvent('codem-garbage:deleteRoom', tonumber(playerId.src),
                            roomname)
                    end
                end
                coopData[roomname] = nil
                Citizen.Wait(150)
                TriggerClientEvent('codem-garbage:deleteroomeveryone', -1, roomname)
            else
                table.remove(players, _)
                coopData[roomname].players = players
                for __, playerId in pairs(players) do
                    if tonumber(playerId.src) ~= tonumber(src) then
                        TriggerClientEvent('codem-garbage:updateClientRoomPlayersData', -1, roomname,
                            coopData[roomname].players)
                    end
                end
                TriggerClientEvent('codem-garbage:deleteMyTeam', src, roomname, src)
            end
        end
    end
    savePlayerData(src)
end

RegisterServerEvent('codem-garbage:finishMultiplayerJobs', function()
    local src = source
    local identifier = GetIdentifier(src)
    local data = playerJobData[GetIdentifier(src)]
    if not data then
        return
    end
    local room = coopData[identifier]
    if not room then
        print('room not found')
        return
    end
    local players = room.players

    for _, player in pairs(players) do
        if player.src then
            TriggerClientEvent('codem-garbage:client:finishMultiplayerJob', tonumber(player.src))
        end
    end
    Citizen.Wait(2500)
    if coopData[identifier] then
        coopData[identifier] = nil
        TriggerClientEvent('codem-garbage:deleteroomeveryone', -1, identifier)
    end
end)

RegisterServerEvent('codem-garbage:deliveryVehicleForDriver', function()
    local src = source
    local data = playerJobData[GetIdentifier(src)]
    if not data then
        return
    end
    local roomname = nil
    for k, v in pairs(coopData) do
        local players = v.players
        for _, player in pairs(players) do
            if player.src == src then
                roomname = v.roomData.hostIdentifier
            end
        end
    end
    local roomData = coopData[roomname]
    if roomData then
        local players = roomData.players
        for _, player in pairs(players) do
            if player.src then
                if player.host then
                    TriggerClientEvent('codem-garbage:finishIsDriver', tonumber(player.src))
                end
            end
        end
    end
end)



RegisterServerEvent('codem-garbagejob:finishJob', function(clientkey, money, gatheredcount, stopname, multivalue)
    local src = source
    if key ~= clientkey then
        DropPlayer(src, 'Codem Garbage Event Trigger.')
        return
    end
    for k, v in pairs(Config.GarbagejobSettings['garbageRouteSettings']) do
        if v.name == stopname then
            local data = playerJobData[GetIdentifier(src)]
            if not data then
                return
            end
            local xpAwarded = v.xp
            if multivalue then
                xpAwarded = xpAwarded * 2
            end
            AddMoney(src, 'cash', tonumber(money))
            AddXPGarbabgeJob(src, tonumber(xpAwarded))
            data.profiledata.completejobs = data.profiledata.completejobs + 1
            data.profiledata.totalearnings = data.profiledata.totalearnings + tonumber(money)
            data.profiledata.gathered = data.profiledata.gathered + tonumber(gatheredcount)
            local historyData = {
                ['routename'] = v.label,
                ['gathered'] = gatheredcount,
                ['money'] = money,
                ['time'] = os.date("%m-%d-%Y %H:%M")
            }
            table.insert(data.historydata, historyData)
            local discordlog = discordloghistoryData(src, historyData)
            sendDiscordLogHistory(discordlog)
            local function updateDailyMission(missionType, increment)
                for _, missionConfig in pairs(Config.GarbagejobSettings['dailyMission']) do
                    if missionConfig.name == missionType and not data.dailymission[missionType].complete then
                        data.dailymission[missionType].count = data.dailymission[missionType].count + increment
                        if data.dailymission[missionType].count >= missionConfig.count then
                            data.dailymission[missionType].complete = true
                            AddXPGarbabgeJob(src, tonumber(missionConfig.xp))
                            Config.Notification(
                                string.format(Config.NotificationText['completedailymission'].text, missionConfig.xp),
                                Config.NotificationText['completedailymission'].type, true, src)
                        end
                    end
                end
            end

            for missionType, _ in pairs(data.dailymission) do
                if missionType == 'transportpassenger' then
                    updateDailyMission(missionType, gatheredcount)
                elseif missionType == 'completeoneroute' then
                    updateDailyMission(missionType, 1)
                elseif missionType == 'earninoneroute' then
                    updateDailyMission(missionType, money)
                end
            end

            savePlayerData(src)
        end
    end
end)

function discordloghistoryData(source, data)
    local src = source
    local identifier = GetIdentifier(src)
    local dataInfo = {
        identifier = identifier,
        avatar = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
        name = GetName(src),
        id = src,
        routename = data.routename,
        abbreviation = data.abbreviation,
        gathered = data.gathered,
        passenger = data.passenger,
        money = data.money,
    }
    return dataInfo
end

function sendDiscordLogHistory(data)
    local message = {
        username = bot_name,
        embeds = {
            {
                title = botname,
                color = 0xFFA500,
                author = {
                    name = 'Codem GARBAGE - JOB FINISH',
                },
                thumbnail = {
                    url = data.avatar
                },
                fields = {
                    { name = "Player Name", value = data.name or false, inline = true },
                    { name = "Player ID",   value = data.id or false,   inline = true },
                    {
                        name = "──────────Job Information──────────",
                        value = "",
                        inline = false
                    },
                    { name = "Route Name", value = data.routename or false,                inline = true },
                    { name = "Gathered",   value = tonumber(data.gathered) or 'undefined', inline = true },
                    { name = "Job Price",  value = tonumber(data.money) or 'undefined',    inline = true },

                },
                footer = {
                    text = "Codem Store - https://discord.gg/zj3QsUfxWs",
                    icon_url =
                    "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
                },

                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        },
        avatar_url = bot_logo
    }

    PerformHttpRequest(discord_webhook['jobfinish'], function(err, text, headers) end,
        "POST",
        json.encode(message),
        { ["Content-Type"] = "application/json" })
end
