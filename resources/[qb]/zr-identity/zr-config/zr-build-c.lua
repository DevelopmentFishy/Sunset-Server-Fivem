function zr_identity_show_public()
	-- Trigger Custom Functions/Events when display menu.
	DisplayRadar(false)
end

function zr_identity_hide_public()
	-- Trigger Custom Functions/Events when hide menu.
    DisplayRadar(true)
end


RegisterNetEvent('zr-identity:hide', function()
    zr_identity_hide()
    if (zr_config.framework=='QB') then
        DoScreenFadeOut(500)
        Wait(2000)
        SetEntityCoords(PlayerPedId(), zr_config.DefaultSpawn.x, zr_config.DefaultSpawn.y, zr_config.DefaultSpawn.z)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        Wait(500)
        SetEntityVisible(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(250)
        TriggerEvent('qb-weathersync:client:EnableSync')
        if not zr_config.StartingAppartment then
            TriggerEvent('qb-clothes:client:CreateFirstCharacter')
        end
    end
end)

function zr_player_created()
    -- If you want to trigger a custom event or funtion after the character is created
end

function zr_identity_notify(zr_msg)
    if (zr_config.zr_notify) then
        exports['zr-notify']:zr_notify('info', zr_msg, 5000, 'info', 'left')
    else
        if (zr_config.framework=='QB') then
            QBcore.Functions.Notify(zr_msg, "primary")
        else
            ESX.ShowNotification(zr_msg, "info", 3000)
        end
    end
end