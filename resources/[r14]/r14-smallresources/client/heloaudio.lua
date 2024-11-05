-- local on, isHeli, isPlane = false

-- local function EnableSubmix()
--     SetAudioSubmixEffectRadioFx(0, 0)
--     SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
--     SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 1200.0)
--     SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 9000.0)
--     SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 0.5)
--     SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 20.0)
--     on = true
-- end

-- local function DisableSubmix()
--     SetAudioSubmixEffectRadioFx(0, 0)
--     SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
--     on = false 
-- end

-- DisableSubmix()

-- AddEventHandler('gameEventTriggered', function (name, args) -- checks when ped enters a helicopter
-- 	if name == 'CEventNetworkPlayerEnteredVehicle' and args[1] == player then       
--         local vehmodel = GetEntityModel(args[2])
--         isHeli = IsThisModelAHeli(vehmodel) 
--         isPlane = IsThisModelAPlane(vehmodel)

--         if isHeli or isPlane then 
--             CreateThread(function()
--                 while IsPedInAnyVehicle(ped, false) do
-- 		            if GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, false)) then
--                         if not on and (isHeli or isPlane) then
--                             EnableSubmix()
--                         end
--                     else
--                         if on then 
--                             DisableSubmix()
--                         end		
-- 		            end        
--                     Wait(500)
--                 end

--                 if on then 
--                     DisableSubmix() 
--                 end                
--             end)       
--         else
--             if on then
--                 DisableSubmix()
--             end
--         end
--     end
-- end)
