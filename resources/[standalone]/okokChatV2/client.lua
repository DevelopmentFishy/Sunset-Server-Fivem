local players = {}
local defaultScale = 0.7 -- Text scale
local displayTime = 3500 -- Duration to display the text (in ms)
local distToDraw = 250 -- Min. distance to draw 

local pedDisplaying = {}

local function DrawText3D(coords, text, color)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    local scale = 200 / (GetGameplayCamFov() * dist)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextScale(0.0, defaultScale * scale)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextFont(6)
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function Display(ped, text, color)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)
    if dist <= distToDraw then
        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1
        local display = true
        Citizen.CreateThread(function()
            Wait(displayTime)
            display = false
        end)
        local offset = 0.7 + pedDisplaying[ped] * 0.15
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text, color)
            end
            Wait(0)
        end
        pedDisplaying[ped] = pedDisplaying[ped] - 1
    end
end

-- For 3dme:
RegisterNetEvent('okokChat:3dme')
AddEventHandler('okokChat:3dme', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
		local color = { r = 255, g = 255, b = 255, a = 255 } -- blue color
        Display(ped, text, color)
    end
end)

-- For 3ddo:
RegisterNetEvent('okokChat:3ddo')
AddEventHandler('okokChat:3ddo', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        local color = { r = 222, g = 255, b = 0, a = 255 } -- yellow color
        Display(ped, text, color)
    end
end)

exports('Message', function(background, color, icon, title, playername, message, target, image)
	TriggerServerEvent('okokChat:ServerMessage', background, color, icon, title, playername, message, target, image)
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('okokChat:onPlayerSpawn')
end)

RegisterNetEvent("okokChat:getAllPlayers")
AddEventHandler("okokChat:getAllPlayers", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closePlayers = {}
	local allPlayers = GetActivePlayers()
	local playerCount = 1
	local pedID = PlayerPedId()

	for i = 1, #allPlayers do
		local playerId = allPlayers[i]
		local playerPed = GetPlayerPed(playerId)
		local playerCoords = GetEntityCoords(playerPed)

		table.insert(closePlayers, GetPlayerServerId(playerId))
		playerCount += 1
	end

	TriggerServerEvent("okokChat:SetClosePlayers", closePlayers)
end)

RegisterNetEvent("okokChat:checkDeathStatus")
AddEventHandler("okokChat:checkDeathStatus", function()
	local ped = GetPlayerPed(-1)
	TriggerServerEvent('okokChat:deathStatus', IsEntityDead(ped))
end)

RegisterNetEvent("okokChat:Notification")
AddEventHandler("okokChat:Notification", function(info, text)
	exports['okokNotify']:Alert(info.title, text, info.time, info.type)
end)

Citizen.CreateThread(function()

	if Config.JobChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.JobCommand, 'JOB message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableOOC then
		TriggerEvent('chat:addSuggestion', '/'..Config.OOCCommand, 'OOC message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowPlayersToClearTheirChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearChatCommand, 'Clear chat', {})
	end

	if Config.EnableHideChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.HideChatCommand, 'Hide chat', {})
	end

	if Config.EnableStaffCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffCommand, 'Send a message as staff', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowStaffsToClearEveryonesChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearEveryonesChatCommand, "Clear everyone's chat", {})
	end

	if Config.EnableStaffOnlyCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffOnlyCommand, 'Staff only chat', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAdvertisementCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AdvertisementCommand, 'Make an advertisement', {
			{ name="ad", help="advertisement message" },
		})
	end

	if Config.EnableAnonymousCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AnonymousCommand, 'Send an anonymous message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitchCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitchCommand, 'Twitch message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableYoutubeCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.YoutubeCommand, 'YouTube message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitterCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitterCommand, 'Twitter message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnablePoliceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.PoliceCommand, 'Police message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAmbulanceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AmbulanceCommand, 'Ambulance message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.TimeOutPlayers then
		TriggerEvent('chat:addSuggestion', '/'..Config.TimeOutCommand, 'Mute player', {
			{ name="id", help="id of the player to mute" },
			{ name="time", help="time in minutes" }
		})

		TriggerEvent('chat:addSuggestion', '/'..Config.RemoveTimeOutCommand, 'Unmute player', {
			{ name="id", help="id of the player to unmute" }
		})
	end

	if Config.EnableMe then
		TriggerEvent('chat:addSuggestion', '/'..Config.MeCommand, 'Send a me message', {
			{ name="action", help="me action" }
		})
	end

	if Config.EnableTry then
		TriggerEvent('chat:addSuggestion', '/'..Config.TryCommand, 'Send a try message', {
			{ name="action", help="try action" }
		})
	end

	if Config.EnableDo then
		TriggerEvent('chat:addSuggestion', '/'..Config.DoCommand, 'Send a do message', {
			{ name="action", help="do action" }
		})
	end
end)