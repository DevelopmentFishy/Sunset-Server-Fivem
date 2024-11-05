--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

ESX = exports['es_extended']:getSharedObject()

function RegisterUsableItem(name, cb)
    exports['qs-inventory']:CreateUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetIdentifier(source)
    return ESX.GetPlayerFromId(source).identifier
end

function AddItem(source, item, count, slot)
    exports['qs-inventory']:AddItem(source, item, count, slot)
end

function RemoveItem(source, item, count)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, count)
end