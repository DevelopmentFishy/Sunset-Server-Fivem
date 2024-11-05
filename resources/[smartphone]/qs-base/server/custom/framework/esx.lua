--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

local legacyEsx = pcall(function()
    ESX = exports['es_extended']:getSharedObject()
end)
if not legacyEsx then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

identifierTypes = 'identifier'
userColumns = 'users'

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(id, xPlayer)
    TriggerEvent('qs-base:PlayerLoaded', id)
end)
