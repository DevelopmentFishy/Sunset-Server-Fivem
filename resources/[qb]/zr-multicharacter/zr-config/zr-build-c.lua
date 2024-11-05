function zr_multichar_show_public()
	-- Trigger Custom Functions/Events when display menu.
	DisplayRadar(false)
end

function zr_multichar_hide_public()
	-- Trigger Custom Functions/Events when hide menu.
	DisplayRadar(true)
end

function zr_setup_skin(zr_data)
    DeleteEntity(zr_current_char)
    if (zr_config.framework=='QB') then -- QBcore
        if zr_data ~= nil then
            QBcore.Functions.TriggerCallback('zr-multicharacter:getSkinData', function(zr_model, zr_skin)
				if (zr_config.clothing=='qb-clothing') then
					zr_model = zr_model ~= nil and tonumber(zr_model) or false
				end
				if zr_model ~= nil then
					CreateThread(function()
						zr_skin = json.decode(zr_skin)
						zr_multichar_loadModel(zr_model)
						zr_current_char = CreatePed(2, zr_model, zr_config.StartCoords.x, zr_config.StartCoords.y, zr_config.StartCoords.z, zr_config.StartCoords.w, false, true)
						if (zr_config.clothing=='qb-clothing') then
							TriggerEvent('qb-clothing:client:loadPlayerClothing', zr_skin, zr_current_char)
						elseif (zr_config.clothing=='illenium-appearance') then
							exports['illenium-appearance']:setPedAppearance(zr_current_char, zr_skin)
						end
						zr_animate_character(zr_current_char)
					end)
				else
					CreateThread(function()				
						zr_model = GetHashKey(zr_config.DefaultModels[math.random(1, #zr_config.DefaultModels)])
						zr_multichar_loadModel(zr_model)
						zr_current_char = CreatePed(2, zr_model, zr_config.StartCoords.x, zr_config.StartCoords.y, zr_config.StartCoords.z, zr_config.StartCoords.w, false, true)	
						zr_animate_character(zr_current_char)
					end)
				end
			end, zr_data.citizenid)
        else
            CreateThread(function()
                local zr_model = GetHashKey(zr_config.DefaultModels[1])
                zr_multichar_loadModel(zr_model)
                zr_current_char = CreatePed(2, zr_model, zr_config.StartCoords.x, zr_config.StartCoords.y, zr_config.StartCoords.z, zr_config.StartCoords.w, false, true)	
				zr_animate_character(zr_current_char)
            end)
        end
    else -- ESX
		if zr_data ~= nil then
			local zr_pedtype = "mp_f_freemode_01"
			local zr_skin = zr_config.DefaultSkins["f"]
			zr_skin.sex = 1
			if zr_data.sex == nil then 
				zr_pedtype = "mp_m_freemode_01"
				if zr_pedtype == "mp_m_freemode_01" then 
					zr_skin = zr_config.DefaultSkins["m"]
					zr_skin.sex = 0
				end
			else
				if zr_data.sex == "m" then 
					zr_pedtype = "mp_m_freemode_01"
					zr_skin = zr_config.DefaultSkins["m"]
					zr_skin.sex = 0
				end  
			end
			zr_model = GetHashKey(zr_pedtype)
			if zr_model ~= nil then
				CreateThread(function()
					exports.spawnmanager:spawnPlayer({x = zr_config.StartCoords.x,y = zr_config.StartCoords.y,z = zr_config.StartCoords.z,heading = zr_config.StartCoords.w,model = ped,skipFade = true
					}, function()
						if zr_data.skin then 
							zr_multichar_loadModel(zr_model)
							SetPlayerModel(PlayerId(), zr_model)
							SetModelAsNoLongerNeeded(zr_model)
							TriggerEvent('skinchanger:loadSkin', zr_data.skin)
						else
							TriggerEvent('skinchanger:loadSkin', zr_skin)
						end
					end)
					Wait(500)
					zr_animate_character(PlayerPedId())
				end)
			end
		end         
    end
end

if (zr_config.framework=='ESX') then
    RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(zr_playerdata, zr_isnew, zr_skin)
		local zr_spawn = zr_playerdata.coords or zr_config.DefaultSpawn
		if zr_isnew or not zr_skin or #zr_skin == 1 then
			local done = false
			local zr_gender = zr_playerdata.sex -- local zr_gender = 'm' (https://github.com/zaphosting/esx_12)
			zr_skin = zr_config.DefaultSkins[zr_gender]
			zr_skin.sex = zr_gender == "m" and 0 or 1 
			if zr_skin.sex == 0 then zr_model = zr_config.DefaultModels[1] else zr_model = zr_config.DefaultModels[2] end
			zr_multichar_loadModel(zr_model)
			SetPlayerModel(PlayerId(), zr_model)
			SetModelAsNoLongerNeeded(zr_model)
			zr_multichar_esx_loops()
			TriggerEvent('skinchanger:loadSkin', zr_skin, function()
                TriggerEvent('esx_skin:openSaveableMenu', function()
                    done = true end, function() done = true
                end)
			end)
			repeat Wait(200) until done
		end
		DoScreenFadeOut(100)
		SetEntityCoordsNoOffset(PlayerPedId(), zr_spawn.x, zr_spawn.y, zr_spawn.z, false, false, false, true)
		SetEntityHeading(PlayerPedId(), zr_spawn.heading)
		if not zr_isnew then TriggerEvent('skinchanger:loadSkin', zr_skin) end
		Wait(400)
		DoScreenFadeIn(400)
		repeat Wait(200) until not IsScreenFadedOut()
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned')
		TriggerEvent('esx:restoreLoadout')
		ClearPedTasksImmediately(PlayerPedId())
		zr_player_spawned = true
		FreezeEntityPosition(PlayerPedId(), false)
		zr_multichar_esx_hideplayers = false
		zr_multichar_esx_loops_stop()
	end)

	RegisterNetEvent('esx:onPlayerLogout')
	AddEventHandler('esx:onPlayerLogout', function()
		DoScreenFadeOut(0)
		TriggerEvent('esx_skin:resetFirstSpawn')
	end)
end


function zr_identity_notify(zr_msg)
    if (zr_config.zr_notify) then
        exports['zr-notify']:zr_notify('info', zr_msg, 5000, 'info', 'right')
    else
        if (zr_config.framework=='QB') then
            QBcore.Functions.Notify(zr_msg, "primary")
		else
			ESX.ShowNotification(zr_msg, "info", 3000)
        end
    end
end