local QBCore = exports['qb-core']:GetCoreObject()

local jobData = {}
local coolDown = false

function CoolDown()
    coolDown = true
	CreateThread(function ()
		Wait(Config.CoolDown * 60000)
		coolDown = false
	end)
end

function CheckJobs(source, Player)
    for key, jobName in pairs(Config.PoliceJobs) do
        if Player.PlayerData.job.name == jobName and Player.PlayerData.job.onduty then
            return true
        end
    end
end

function GenerateCode(length)
    local charset = {}
    for i = 48, 57 do table.insert(charset, string.char(i)) end -- 0-9
    for i = 65, 90 do table.insert(charset, string.char(i)) end -- A-Z
    for i = 97, 122 do table.insert(charset, string.char(i)) end -- a-z

    if length < 1 then return nil end
    local password = ''
    for i = 1, length do
        local rand = math.random(1, #charset)
        password = password .. charset[rand]
    end
    return password
end

function TruckLockDown(PlayerId, data)
    CreateThread(function ()
        Wait(data.timer.cleanup * 60000)
        jobData[PlayerId] = {}
        TriggerClientEvent('QBCore:Notify', PlayerId, 'Truck security measures activated.', 'error', 6000)
        TriggerClientEvent('kevin-banktrucks:clearconvoy', PlayerId)
    end)
end

--- Phone Mail ---
RegisterNetEvent('script:server:lbphone', function(data)
    local PlayerId = source
    local subject = data.subject
    local message = data.message
    local number = exports['lb-phone']:GetEquippedPhoneNumber(PlayerId)
    local email = exports['lb-phone']:GetEmailAddress(number)
    exports['lb-phone']:SendMail({
        to = email,
        subject = subject,
        message = message,
    })
end)

------------------

lib.callback.register('kevin-banktrucks:checkpolice', function(source, cb)
    local PlayerId = source
    local copsOnDuty = 0
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if CheckJobs(PlayerId, Player) then
                copsOnDuty = copsOnDuty + 1
            end
        end
        return copsOnDuty
    end
end)

lib.callback.register('kevin-banktrucks:checkcanloot', function(source, cb)
    local PlayerId = source
    return jobData[PlayerId].grabbedbills
end)

lib.callback.register('kevin-banktrucks:checkcanopensafe', function(source, cb)
    local PlayerId = source
    return jobData[PlayerId].safeOpened
end)

lib.callback.register('kevin-banktrucks:checkjob', function(source)
    local PlayerId = source

    if not jobData[PlayerId] then jobData[PlayerId] = {} end
    if jobData[PlayerId].hasJob then
        return true
    else
        return false
    end
end)

RegisterNetEvent('kevin-banktrucks:takejob', function (data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not coolDown then
        if not jobData[PlayerId].hasJob then
            if Config.CoolDown > 0 then
                CoolDown()
            end

            if data.job == 'Truck Convoy' then
                local safeCode = GenerateCode(data.data.safe.codelength)
                jobData[PlayerId].safeCode = safeCode
                jobData[PlayerId].grabbedbills = false
                jobData[PlayerId].safeOpened = false
                jobData[PlayerId].timerStarted = false
            end
            jobData[PlayerId].hasJob = true
            jobData[PlayerId].job = data.job
    
            local event = data.data.event
            TriggerClientEvent(event, PlayerId, data)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, 'Computer on cooldown..', 'error', 6000)
    end
end)

RegisterNetEvent('kevin-banktrucks:givegpsdevice', function (id, data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not id and data and PlayerId then return end
    local item = data.guarditem
    if Player.Functions.AddItem(item, 1) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add')
    end
end)

RegisterNetEvent('kevin-banktrucks:removelaptop', function ()
    local PlayerID = source
    local Player = QBCore.Functions.GetPlayer(PlayerID)
    local item = Config.HackingItem
    if Player.Functions.RemoveItem(item, 1) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerID, QBCore.Shared.Items[item], 'remove')
    end
end)

RegisterNetEvent('kevin-banktrucks:removethermite', function (item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem(item, 1) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove')
    end
end)

if Config.Inventory == 'ox' then
    exports.ox_inventory:registerHook('createItem', function(payload)
        local metadata = payload.metadata
        return metadata
    end, {
        itemFilter = {
            markedbills = true,
        }
    })
end

RegisterNetEvent('kevin-banktrucks:giveloot', function (bool, data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not jobData[PlayerId].hasJob and bool then return end
    if not jobData[PlayerId].grabbedbills then
        local rewardData = data.reward.pool[math.random(#data.reward.pool)]
        local item = rewardData.item
        local itemWorth = math.random(rewardData.worth.min, rewardData.worth.max)
        local itemAmount = rewardData.amount

        local metadata = {
            worth = itemWorth
        }

        if Config.Inventory == 'ox' then
            if exports.ox_inventory:AddItem(source, item, 1, metadata) then
                TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
                '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
                '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
                '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
                '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
                '**'..'Item Recieved : '..'**'..item..'\n'..
                '**'..'Item Worth : '..'**'..itemWorth..'\n'..
                '**'..'Item Amount : '..'**'..itemAmount..'\n')
            end
        else
            if Player.Functions.AddItem(item, itemAmount, false, metadata) then
                TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', itemAmount)
            
                TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
                '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
                '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
                '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
                '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
                '**'..'Item Recieved : '..'**'..item..'\n'..
                '**'..'Item Worth : '..'**'..itemWorth..'\n'..
                '**'..'Item Amount : '..'**'..itemAmount..'\n')
            end
        end

        local chance = math.random(1, 100)
        local rareChance = data.rare.chance
        if chance <= rareChance then
            local rareData = data.rare.pool[math.random(1, #data.rare.pool)]
            local rareItem = rareData.item
            local rareAmount = rareData.amount
            Player.Functions.AddItem(rareItem, rareAmount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[rareItem], 'add', rareAmount)

            TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
            '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
            '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
            '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
            '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
            '**'..'Rare Item Recieved : '..'**'..rareItem..'\n'..
            '**'..'Item Amount : '..'**'..rareAmount..'\n')
        end

        jobData[PlayerId].grabbedbills = true
        if not jobData[PlayerId].timerStarted then
            jobData[PlayerId].timerStarted = true
            TruckLockDown(PlayerId, data)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, 'Already Looted', 'error', 6000)
    end
end)

RegisterNetEvent('kevin-banktrucks:givesafecash', function (bool, data, inputCode)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not jobData[PlayerId].hasJob and not bool and not data then return end

    if not jobData[PlayerId].safeOpened then
        local cashValue = math.random(data.safe.cash.min, data.safe.cash.max)
        if Player.Functions.AddMoney('cash', cashValue, 'Fleeca Safe') then
            jobData[PlayerId].safeOpened = true
            TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
            '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
            '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
            '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
            '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
            '**'..'Safe Combination : '..'**'..jobData[PlayerId].safeCode..'\n'..
            '**'..'Combination Used : '..'**'..inputCode..'\n'..
            '**'..'Cash Recieved : '..'**'..cashValue..'\n')

            if not jobData[PlayerId].timerStarted then
                jobData[PlayerId].timerStarted = true
                TruckLockDown(PlayerId, data)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, 'Safe already opended', 'error', 6000)
    end
end)

QBCore.Functions.CreateUseableItem(Config.Jobs['Truck Convoy'].guarditem, function(source, item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    TriggerClientEvent('kevin-banktrucks:getconvoytruck', PlayerId, jobData[PlayerId].hasJob, jobData[PlayerId].job, jobData[PlayerId].safeCode, item.name)
end)

RegisterNetEvent('kevin-banktrucks:removegps', function (item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local item = item
    Player.Functions.RemoveItem(item, 1)
    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove', 1)
end)

------------
------------
------------
------------
------------
------------

lib.callback.register('kevin-banktrucks:checkpolice', function(source, cb)
    local PlayerId = source
    local copsOnDuty = 0
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if CheckJobs(PlayerId, Player) then
                copsOnDuty = copsOnDuty + 1
            end
        end
        return copsOnDuty
    end
end)

RegisterNetEvent('kevin-banktrucks:policegps', function (coords)
    local PlayerId = source
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if CheckJobs(PlayerId, Player) then
            TriggerClientEvent('kevin-banktrucks:policegps', Player.PlayerData.source, coords)
        end
    end
end)

RegisterNetEvent('kevin-banktrucks:givedeliveryreward', function (data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not jobData[PlayerId].hasJob and jobData[PlayerId].job == nil and not data then return end

    local cashValue = math.random(data.cashreward.min, data.cashreward.max)
    if Player.Functions.AddMoney('cash', cashValue, 'Fleeca Truck Delivery') then
        TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
        '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
        '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
        '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
        '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
        '**'..'Cash Recieved : '..'**'..cashValue..'\n')

        local chance = math.random(1, 100)
        local rareChance = data.rare.chance
        if chance <= rareChance then
            local rareData = data.rare.pool[math.random(1, #data.rare.pool)]
            local rareItem = rareData.item
            local rareAmount = rareData.amount
            Player.Functions.AddItem(rareItem, rareAmount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[rareItem], 'add', rareAmount)

            TriggerEvent('qb-log:server:CreateLog', 'banktrucks', 'Fleeca Bank Truck', 'green',
            '**'..'Player: '..'**'..GetPlayerName(Player.PlayerData.source)..'\n'..
            '**'..'Citizen Id: '..'**'..Player.PlayerData.citizenid..'\n'..
            '**'..'Player Id: '..'**'..Player.PlayerData.source..'\n'..
            '**'..'Player Job: '..'**'..jobData[PlayerId].job..'\n'..
            '**'..'Rare Item Recieved : '..'**'..rareItem..'\n'..
            '**'..'Item Amount : '..'**'..rareAmount..'\n')
        end
        
        jobData[PlayerId] = {}
    end
end)

RegisterNetEvent('kevin-banktrucks:canceljob', function ()
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if jobData[PlayerId] then
        if jobData[PlayerId].job == 'Truck Convoy' then
            TriggerClientEvent('kevin-banktrucks:cancelconvoy', PlayerId)
        elseif jobData[PlayerId].job == 'Truck Delivery' then
            TriggerClientEvent('kevin-banktrucks:canceldelivery', PlayerId)
        end
        jobData[PlayerId] = {}
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, 'No job to cancel..', 'error', 6000)
    end
end)