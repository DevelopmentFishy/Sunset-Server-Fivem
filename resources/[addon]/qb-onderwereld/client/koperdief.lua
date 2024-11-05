-- local QBCore = exports['qb-core']:GetCoreObject()

-- local paalk = "paltje"
-- local snelte = "smeltje"
-- local kopenem = "kopers"
-- local spawnedzone = false

-- local function koperstelen()
-- if CurrentCops >= Config.MinimumkoperPolice then
--     for k, v in pairs(Config.paaltjes) do
-- 		local ped = GetPlayerPed(-1)
--         local coords = GetEntityCoords(ped)
--         local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.coords, false)
--         if dist < 1.7 then
-- 		    SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"), true)
-- 			TriggerServerEvent("qb-onderwereld:server:koperdief:zetstatus", "isbezet", true, k)			
-- 		    QBCore.Functions.Progressbar("start_bomb", 'koperknippen..', 10000, false, true, {
--                 disablemovement = true,
--                 disablecarmovement = true,
--                 disablemouse = false,
--                 disablecombat = true,
--             }, { animdict = "amb@prop_human_bbq@male@base", anim = "base", }, {model = "prop_tool_pliers", bone = 28422, coords = { x = 0.0, y = 0.0, z = 0.0 }, rotation = { x = 60.0, y = -80.0, z = 0.20 },
-- 	        }, {}, function() -- done
--                 ClearAllPedProps(ped)
-- 		        ClearPedTasks(ped)
--             end)
-- 			Wait(10000)
-- 			local succeschance = math.random(1, 10)
-- 			if succeschance <= 7 then
-- 			    ShootSingleBulletBetweenCoords(v.coords, coords, 30, 0, GetHashKey('weapon_stungun'), GetPlayerServerId(player), false, false, 100)
-- 				exports['ps-dispatch']:koperdiefstal()
-- 			end
-- 			TriggerServerEvent("qb-onderwereld:server:koperloot")
-- 			TriggerServerEvent("qb-onderwereld:server:koperdief:zetstatus", "defect", true, k)
-- 	        TriggerServerEvent("qb-onderwereld:server:koperdief:zetdefecttijd")
			
			
--         end
        
--     end    
-- else
--     QBCore.Functions.Notify("minimaal "..Config.MinimumkoperPolice.."politie nodig")
-- end
-- end 


-- CreateThread(function () 
-- 	for k, v in pairs(Config.paaltjes) do 
--         exports["qb-target"]:AddCircleZone(paalk..tostring(k), v.coords, 1.0,{
--         name = paalk..tostring(k),
--         debugpoly = true,
--         usez = true,
--         }, { 
--         options = {
-- 			{
--                 action = function()
--                     koperstelen()
--                 end,
--                 type = "client",
--                 icon = 'fa-solid fa-bomb',
-- 				label = "koper stelen",
--                 caninteract = function ()
--                 local plydata = QBCore.Functions.GetPlayerData()
-- 				local hasitem = false 
-- 				for k, v in pairs(plydata.items) do
--                     if v.name == 'kniptang' then hasitem = true end
--                 end
-- 				if v["defect"] or v["isbezet"] then
--                     return false
--                 end
--                 if hasitem then
-- 				    return true
-- 				end	
--                 end,

--             },			
-- 		},
--             distance = 0.8
--         })
-- 	end		
-- end)

-- local bezet = false
-- local function smeltmenu()
--     for k, v in pairs(Config.smeltbad) do
-- 	    local ped = getplayerped(-1)
--         local coords = getentitycoords(ped)
--         local dist = getdistancebetweencoords(coords.x, coords.y, coords.z, v.coords, false)
--             if dist < 1.7  then
-- 	            local dialog = exports['qb-input']:showinput({
--                 header = "hoeveel koper wil u smelten?",
--                 submittext = "smelt koper",
--                 inputs = {
--                     {
--                         text = "aantal", -- text you want to be displayed as a place holder
--                         name = "koperdraad", -- name of the input should be unique otherwise it might override
--                         type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
--                         isrequired = true, -- optional [accepted values: true | false] but will submit the form if no value is inputted
--                         default = 1, -- default number option, this is optional
--                     },

--                 },
--             })

    
-- 	        if dialog ~= nil then
--                 if not dialog.koperdraad then
--                     return
--                 end
--                 local amount = tonumber(dialog.koperdraad)
-- 		        qbcore.functions.triggercallback("qb-onderwereld:checkitem", function(output)
--                     if output then 
--                         bezet = true				
-- 			            TriggerServerEvent("qb-onderwereld:smeltkoper", amount)
-- 				        QBCore.Functions.Notify("u begint met smelten van "..amount.." x koperdraad")
-- 		            else
--                         QBCore.Functions.Notify("u heeft geen "..amount.." x koperdraad")
-- 			        end	
--                 end, 'koperdraad', amount)		
--             end
-- 		end	   	
--     end
-- end


-- CreateThread(function () 
-- 	for k, v in pairs(Config.smeltbad) do 
--         exports["qb-target"]:AddCircleZone(snelte..tostring(k), v.coords, 1.0,{
--         name = snelte..tostring(k),
--         debugpoly = false,
--         usez = true,
--         }, { 
--         options = {
-- 			{
--                 action = function()
--                     smeltmenu()
--                 end,
--                 type = "client",
--                 icon = 'fa-solid fa-bomb',
-- 				label = "koper smelten",
--                 caninteract = function ()
--                 local plydata = qbcore.functions.getplayerdata()
-- 				local hasitem = false
-- 				for k, v in pairs(plydata.items) do
--                     if v.name == 'koperdraad' then hasitem = true end
--                 end
--                 if bezet then
-- 				    return false
					
--                 end
--                 if hasitem then
-- 				    print(bezet)
-- 					return true
-- 				end	
--                 end,

--             },			
-- 		},
--             distance = 0.9
--         })
-- 	end		
-- end)


-- RegisterNetEvent("qb-onderwereld:client:startsmelt", function(amount)
-- 	for k, v in pairs(Config.smeltbad) do
-- 		local ped = getplayerped(-1)
--         local coords = getentitycoords(ped)
--         local dist = getdistancebetweencoords(coords.x, coords.y, coords.z, v.coords, false)
--         if dist < 1.7 then
-- 			local tijd = Config.smelttijd * amount
-- 			local sec = tijd
--             while sec > 0 do
--                 wait(1000)
--                 sec = sec - 1
--                 exports['qb-core']:drawtext('tijd  '..sec.. '  seconden','left')

--             end
-- 			exports['qb-core']:hidetext()
			
-- 			local function neemkoper()
-- 			    bezet = false
-- 				local xkoper = Config.aantalkoper * amount
-- 			    TriggerServerEvent("qb-onderwereld:server:gesmoltenkoper",xkoper)
-- 				TriggerServerEvent("qb-onderwereld:server:verwijderzone",kopenem)
-- 				exports['qb-target']:removezone(kopenem)
-- 	            spawnedzone = false
-- 			end	
			
-- 			if not spawnedzone then
-- 				spawnedzone = true
-- 			    exports['qb-target']:addcirclezone(kopenem, v.smelted, 1.0,{
-- 	                name = kopenem,
--                     debugpoly = false,
--                     usez = true,
--                     }, { 
-- 				    options = {
--                     {
                       
-- 					    action = function()
--                         neemkoper(k)
--                         end,
-- 					    type = "client",
--                         label = "neem koper",

-- 						}	
--                     },

--                     distance = 1.8
--                 })

--             end
        
		
-- 		end
-- 	end 
-- end)

-- RegisterNetEvent("qb-onderwereld:koperdief:krijgstatus", function(fase, staat, k)
--     Config.paaltjes[k][fase] = staat
-- end)

