--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'esx' then
	return
end

local version = GetResourceMetadata('es_extended', 'version', 0)

if version == '1.1.0' or version == '1.2.0' or version == 'legacy' then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
	ESX = exports['es_extended']:getSharedObject()
end

TriggerEvent('qs-base:getSharedObject', function(ASD) QS = ASD end)

isQSCore = false
CreateThread(function()
	if GetResourceState('qs-core') == 'started' then
		isQSCore = true
		TriggerEvent('qs-core:getSharedObject', function(library) QSCore = library end)
	end
end)

identifierTypes = 'identifier'
userColumns = 'users'
accountsType = 'accounts'
skinTable = 'users'
playerloaded_trigger = 'esx:playerLoaded'

vehiclesOwner = 'owner'
plateTable = 'plate'
vehiclesTable = 'owned_vehicles'

function RegisterServerCallback(name, cb)
	ESX.RegisterServerCallback(name, cb)
end

function GetPlayerFromIdFramework(player)
	local Player = QS.GetPlayerFromId(player)
	if Player then
		Player.identifier = Player.PlayerData.identifier
		Player.source = Player.PlayerData.source
	end
	return Player
end

function GetPlayerFromId(source)
	return ESX.GetPlayerFromId(source)
end

function GetJob(player)
	if player == nil then return 'unemployed' end
	if ESX.GetPlayerFromId(player) == nil then
		return 'unemployed'
	else
		local tempJob = ESX.GetPlayerFromId(player).job
		tempJob.onduty = true
		return tempJob
	end
end

function GetPlayerIdentifier()
	return ESX.GetPlayerFromIdentifier()
end

function math.round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function GetPlayers()
	return ESX.GetPlayers()
end

function GetPlayerName(src)
	local xPlayer = ESX.GetPlayerFromId(src)
	local firstName = xPlayer.get('firstName') or 'Anon'
	local lastName = xPlayer.get('lastName') or '.'
	return firstName, lastName
end

function GetNumber(src)
	local xPlayer = ESX.GetPlayerFromId(src)
	local number = exports['qs-base']:GetPlayerPhone(src)
	return number
end

function GetItem(player, item)
	return player.getInventoryItem(item)
end

function GetItemAmount(item)
	return item.count
end

function AddItem(player, item, count)
	player.addInventoryItem(item, count)
end

function addWeapon(player, item, count)
	player.addWeapon(item, count)
end

function removeMoney(player, account, count)
	player.removeAccountMoney(account, count)
end

function getAccount(player, account)
	return player.getAccount(account).money
end
