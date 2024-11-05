lib.locale()

local ver = '1.1.0'

CreateThread(function()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
        print('DRC_DRUGS STARTED ON VERSION: ' .. ver)
    end
end)


local RegisterUsable = nil

if Config.Framework == "ESX" then
    if Config.NewESX then
        ESX = exports["es_extended"]:getSharedObject()
        RegisterUsable = ESX.RegisterUsableItem
    else
        ESX = nil
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        RegisterUsable = ESX.RegisterUsableItem
    end
elseif Config.Framework == "qbcore" then
    QBCore = nil
    QBCore = exports['qb-core']:GetCoreObject()
    RegisterUsable = QBCore.Functions.CreateUseableItem
elseif Config.Framework == "standalone" then
    -- ADD YOU FRAMEWORK
end

function BanPlayer(source, message)
    if Config.AnticheatBan then
        --Example of usage for SQZ ANTICHEAT (Higly recommended Anticheat!)
        exports['sqz_anticheat']:BanPlayer(source, message)
    end
end

local webhook = "YOUR_WEBHOOK"
function Logs(source, message)
    if message ~= nil then
        if Config.Logs.enabled then
            local license = nil
            for k, v in pairs(GetPlayerIdentifiers(source)) do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
                end
            end
            if Config.Logs.type == "ox_lib" then
                lib.logger(source, "Drugs", message)
            elseif Config.Logs.type == "webhook" then
                local embed = {
                    {
                        ["color"] = 2600155,
                        ["title"] = "Player: **" .. GetPlayerName(source) .. " | License: " .. license .. " **",
                        ["description"] = message,
                        ["footer"] = {
                            ["text"] = "Logs by DRC SCRIPTS for DRC DRUGS!",
                        },
                    }
                }
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
                    json.encode({ username = "DRC DRUGS", embeds = embed, avatar_url = "https://i.imgur.com/RclET8O.png" })
                    , { ['Content-Type'] = 'application/json' })
            end
        end
    end
end

function GetMoney(count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() >= count then
            return true
        else
            return false
        end
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.GetMoney('cash') >= count then
            return true
        else
            return false
        end
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function RemoveMoney(count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeMoney(count)
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveMoney('cash', count)
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function AddMoney(count, source, type)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type then
            xPlayer.addAccountMoney(type, count)
        else
            xPlayer.addMoney(count)
        end
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if type then
            xPlayer.Functions.AddMoney(type, count)
        else
            xPlayer.Functions.AddMoney('cash', count)
        end
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function GetItem(name, count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem(name).count >= count then
            return true
        else
            return false
        end
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.GetItemByName(name) ~= nil then
            if xPlayer.Functions.GetItemByName(name).amount >= count then
                return true
            else
                return false
            end
        else
            return false
        end
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function AddItem(name, count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(name, count)
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.AddItem(name, count, nil, nil)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[name], "add", count)

    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

function RemoveItem(name, count, source)
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(name, count)
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem(name, count, nil, nil)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[name], "remove", count)
    elseif Config.Framework == "standalone" then
        -- ADD YOUR FRAMEWORK
    end
end

lib.callback.register('drc_drugs:getpolice', function(source)
    local policeCount = 0
    if Config.Framework == "ESX" then
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            for _, job in pairs(Config.PoliceJobs) do
                if xPlayer.job.name == job then
                    policeCount = policeCount + 1
                end
            end
        end
        return policeCount
    elseif Config.Framework == "qbcore" then
        local xPlayers = QBCore.Functions.GetPlayers()
        for i = 1, #xPlayers do
            local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
            for _, job in pairs(Config.PoliceJobs) do
                if xPlayer.PlayerData.job.name == job then
                    policeCount = policeCount + 1
                end
            end
        end
        return policeCount
    elseif Config.Framework == "standalone" then
        -- ADD YOU FRAMEWORK
    end
end)

if Config.Clothing == "qb-clothing" then
    RegisterServerEvent("drc_drugs:loadPlayerSkin")
    AddEventHandler('drc_drugs:loadPlayerSkin', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?',
            { Player.PlayerData.citizenid, 1 })
        if result[1] ~= nil then
            TriggerClientEvent("drc_drugs:loadSkin", src, false, result[1].model, result[1].skin)
        else
            TriggerClientEvent("drc_drugs:loadSkin", src, true)
        end
    end)
end

RegisterServerEvent("drc_drugs:deleteprop", function(ent)
    local ent = NetworkGetEntityFromNetworkId(ent)
    DeleteEntity(ent)
end)


lib.callback.register('drc_drugs:getitembyname', function(source, item)
    local src = source
    if GetItem(item, 1, src) then
        return true
    else
        return false
    end
end)

for k, v in pairs(Config.Consumables) do
    if k == "lsd" or k == "ecstasy" then
        for i = 1, 5 do
            RegisterUsable(k .. i, function(source)
                -- Logs(v.Log)
                if v.Remove then
                    if GetItem(v.RemoveItem .. i, v.RemoveItemCount, source) then
                        RemoveItem(v.RemoveItem .. i, v.RemoveItemCount, source)
                        TriggerClientEvent('drc_drugs:consumables', source, v.ProgressBar, v.animation, v.duration,
                            v.effect, v.add)
                    end
                else
                    TriggerClientEvent('drc_drugs:consumables', source, v.ProgressBar, v.animation, v.duration, v.effect, v.add)
                end
            end)
        end
    else
        RegisterUsable(k, function(source)
            Logs(v.Log)
            if v.Remove then
                if GetItem(v.RemoveItem, v.RemoveItemCount, source) then
                    RemoveItem(v.RemoveItem, v.RemoveItemCount, source)
                    TriggerClientEvent('drc_drugs:consumables', source, v.ProgressBar, v.animation, v.duration, v.effect, v.add)
                end
            else
                TriggerClientEvent('drc_drugs:consumables', source, v.ProgressBar, v.animation, v.duration, v.effect, v.add)
            end
        end)
    end
end

RegisterUsable('weed_wrap', function(source)
    TriggerClientEvent('drc_drugs:consumables:menu', source, "weed_wrap")
end)

RegisterUsable('syringe', function(source)
    TriggerClientEvent('drc_drugs:consumables:menu', source, "syringe")
end)

RegisterUsable('weed_papers', function(source)
    TriggerClientEvent('drc_drugs:consumables:menu', source, "weed_papers")
end)

RegisterUsable('xanaxpack', function(source)
    TriggerClientEvent('drc_drugs:consumables:progress', source, "xanax_pack")
end)

RegisterUsable('xanaxplate', function(source)
    TriggerClientEvent('drc_drugs:consumables:progress', source, "xanax_plate")
end)

RegisterUsable('coke_figure', function(source)
    TriggerClientEvent('drc_drugs:coke:menus', source, "FullFigure")
end)

RegisterUsable('coke_figureempty', function(source)
    TriggerClientEvent('drc_drugs:coke:menus', source, "EmptyFigure")
end)

RegisterUsable('coke_figurebroken', function(source)
    TriggerClientEvent('drc_drugs:coke:menus', source, "BrokenFigure")
end)

lib.callback.register('drc_drugs:consumables:getitem', function(source, type)
    if type == "weed_wrap" then
        if GetItem("weed_package", 1, source) and GetItem("weed_wrap", 1, source) then
            return true
        else
            return false
        end
    elseif type == "weed_papers" then
        if GetItem("weed_package", 1, source) and GetItem("weed_papers", 1, source) then
            return true
        else
            return false
        end
    elseif type == "heroin" then
        if GetItem("syringe", 1, source) and GetItem("heroin", 1, source) then
            return true
        else
            return false
        end
    elseif type == "meth" then
        if GetItem("syringe", 1, source) and GetItem("meth_bag", 1, source) then
            return true
        else
            return false
        end
    end
end)

RegisterServerEvent("drc_drugs:consumables:giveitems")
AddEventHandler("drc_drugs:consumables:giveitems", function(type)
    if type == "weed_wrap" then
        if GetItem("weed_package", 1, source) and GetItem("weed_wrap", 1, source) then
            RemoveItem("weed_package", 1, source)
            RemoveItem("weed_wrap", 1, source)
            AddItem("weed_blunt", 1, source)
        end
    elseif type == "weed_papers" then
        if GetItem("weed_package", 1, source) and GetItem("weed_papers", 1, source) then
            RemoveItem("weed_package", 1, source)
            RemoveItem("weed_papers", 1, source)
            AddItem("weed_joint", 1, source)
        end
    elseif type == "xanax_pack" then
        if GetItem("xanaxpack", 1, source) then
            RemoveItem("xanaxpack", 1, source)
            AddItem("xanaxplate", 2, source)
        end
    elseif type == "xanax_plate" then
        if GetItem("xanaxplate", 1, source) then
            RemoveItem("xanaxplate", 1, source)
            AddItem("xanaxpill", 10, source)
        end
    elseif type == "meth" then
        if GetItem("syringe", 1, source) and GetItem("meth_bag", 1, source) then
            RemoveItem("meth_bag", 1, source)
            RemoveItem("syringe", 1, source)
            AddItem("meth_syringe", 1, source)
        end
    elseif type == "heroin" then
        if GetItem("syringe", 1, source) and GetItem("heroin", 1, source) then
            RemoveItem("heroin", 1, source)
            RemoveItem("syringe", 1, source)
            AddItem("heroin_syringe", 1, source)
        end
    end
end)
