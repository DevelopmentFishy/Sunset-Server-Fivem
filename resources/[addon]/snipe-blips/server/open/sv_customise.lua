QBCore = nil
ESX = nil

if Config.Core == "QBCore" then
    TriggerEvent(Config.Core..':GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.CoreFolderName]:GetCoreObject()
    end
elseif Config.Core == "ESX" then
    local status, errorMsg = pcall(function() ESX = exports[Config.CoreFolderName]:getSharedObject() end)
    if ESX == nil then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
    end
end

function GetFrameworkName(src)
    if Config.Core == "QBCore" then
        local player = QBCore.Functions.GetPlayer(src)
        if player ~= nil then
            return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
        end
    elseif Config.Core == "ESX" then
        local player = ESX.GetPlayerFromId(src)
        if player ~= nil then
            return player.getName()
        end
    end
end

function GetPlayerCallSign(source)
	if Config.Core == "QBCore" then
		local Player = QBCore.Functions.GetPlayer(source)
		return Player.PlayerData.metadata["callsign"] or "NO Callsign"
	elseif Config.Core == "ESX" then
		return "000"
	end
end

function GetRadioChannel(src)
    -- if the radio channel is 100 or above, it wont show on the blip. If you use any other voice system other than pma-voice, you need to edit the code to return the right radio channel.
    return Player(src).state.radioChannel or 0
end

function GetSendName(id, name, callsign, job, isGang)
    if not name then
        playerNames[id] = GetFrameworkName(id) 
        name = playerNames[id]
    end

    if isGang then
        return name
    end
    if Config.ShowCallSign and job then
        if not callsign then
            playerCallsigns[id] = GetPlayerCallSign(id)
            callsign = playerCallsigns[id]
        end
        return callsign .. " | " .. name
    else
        
        return name
    end
end


-- RegisterCommand("debugblips", function()
--     print(json.encode(group))
-- end)
