function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 50)
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0, 1)
end

RegisterNetEvent('vangelico:client:showNotification')
AddEventHandler('vangelico:client:showNotification', function(str)
    ShowNotification(str)
end)


RegisterNetEvent('vangelico:client:policeAlert')
AddEventHandler('vangelico:client:policeAlert', function(targetCoords)
    local camId = '31 | 32 | 33 | 34'
    exports['ps-dispatch']:VangelicoRobbery(camId)
end)
-- --This event send to all police players
-- RegisterNetEvent('vangelico:client:policeAlert')
-- AddEventHandler('vangelico:client:policeAlert', function(targetCoords)
--     exports['ps-dispatch']:VangelicoRobbery(camId)
--     -- ShowNotification(Strings['police_alert'])
--     local alpha = 250
--     local vangelicoBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)


--     SetBlipHighDetail(vangelicoBlip, true)
--     SetBlipColour(vangelicoBlip, 1)
--     SetBlipAlpha(vangelicoBlip, alpha)
--     SetBlipAsShortRange(vangelicoBlip, true)

--     while alpha ~= 0 do
--         Citizen.Wait(500)
--         alpha = alpha - 1
--         SetBlipAlpha(vangelicoBlip, alpha)

--         if alpha == 0 then
--             RemoveBlip(vangelicoBlip)
--             return
--         end
--     end
-- end)
