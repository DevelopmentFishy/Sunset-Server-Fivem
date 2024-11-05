print'Pug Simple DrugSales 1.0'
local SoldToPeds = {}
local drugcooldown = false
local StolenDrugs = {}
local function ReloadSKin(tped)
	for k, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(PlayerPedId(), v) or IsEntityAttachedToEntity(tped, v) then
			SetEntityAsMissionEntity(v, true, true)
			DeleteObject(v)
			DeleteEntity(v)
		end
	end
	TriggerEvent("Pug:ReloadGuns:sling")
end

local function GetItemsInformation(I, bool)
	if Framework == "QBCore" then
		if FWork.Shared.Items[I].label ~= nil then
            if bool then
			    return FWork.Shared.Items[I].label
            else
                return FWork.Shared.Items[I]
            end
		else
			return I
		end
	else
		return I
	end
end

-- Change this to your notification script if needed
function DrugSaleNotify(msg, type, length)
	if Framework == "ESX" then
		FWork.ShowNotification(msg)
	elseif Framework == "QBCore" then
    	FWork.Functions.Notify(msg, type, length)
	end
end

RegisterNetEvent("Pug:client:DrugSaleNotify", function(msg, type, length)
	DrugSaleNotify(msg, type, length)
end)

-- PUT YOUR POLICE CALL IN THIS FUNCTION
local function CallPoliceForDrugs()
	local pos = GetEntityCoords(PlayerPedId())
	exports['ps-dispatch']:SuspiciousActivity(pos)
	if Config.Debug then Wait(5000) print('Police Notify Function triggered') end
end

local function PugGetPeds(ignoreList)
    local pedPool = GetGamePool('CPed')
    local peds = {}
    ignoreList = ignoreList or {}
    for i = 1, #pedPool, 1 do
        local found = false
        for j = 1, #ignoreList, 1 do
            if ignoreList[j] == pedPool[i] then
                found = true
            end
        end
        if not found then
            peds[#peds + 1] = pedPool[i]
        end
    end
    return peds
end

function PugGetClosestPed(coords, ignoreList)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    ignoreList = ignoreList or {}
    local peds = PugGetPeds(ignoreList)
    local closestDistance = -1
    local closestPed = -1
    for i = 1, #peds, 1 do
        local pedCoords = GetEntityCoords(peds[i])
        local distance = #(pedCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestPed = peds[i]
            closestDistance = distance
        end
    end
    return closestPed, closestDistance
end

-- Play animation for both player and ped
local function SellDrugsAnimation(tped)
	SetPedTalk(tped)
	PlayAmbientSpeech1(tped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
	obj = CreateObject(GetHashKey('prop_weed_bottle'), 0, 0, 0, true)
	AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	obj2 = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)
	AttachEntityToEntity(obj2, tped, GetPedBoneIndex(tped,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	RequestAnimDict("mp_common")
	TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 8.0, -8, -1, 0, 0, 0, 0, 0)    
	TaskPlayAnim(tped, "mp_common", "givetake2_a", 8.0, -8, -1, 0, 0, 0, 0, 0)    
	Wait(1000)
	AttachEntityToEntity(obj2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	AttachEntityToEntity(obj, tped, GetPedBoneIndex(tped,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	Wait(2300)
	DeleteEntity(obj)
	DeleteEntity(obj2)
	ReloadSKin(tped)
	PlayAmbientSpeech1(tped, 'GENERIC_THANKS', 'SPEECH_PARAMS_STANDARD')
end

-- Add Old Ped to table
local function AddSoldPed(localped)
    SoldToPeds[localped] = true
	if Config.WaitTimeToSellToSamePed then
		TriggerEvent("Pug:client:RemoveSoldToPedTimer", localped)
	end
end

RegisterNetEvent("Pug:client:RemoveSoldToPedTimer", function(localped)
	Wait(Config.WaitTimeToSellToSamePed)
	SoldToPeds[localped] = nil
end)

-- Check if ped is in table
local function HasSoldPed(localped)
    return SoldToPeds[localped] ~= nil
end

local function StartDrugSale()
	local AlreadySold = false
	for k, v in pairs(Config.DrugsToSell) do			
		Wait(500) -- CHANGE THIS IF PEOPLE SCUFF									
		if not AlreadySold then
			Config.FrameworkFunctions.TriggerCallback('Pug:Drugs:check', function(result)
				if result then		
					AlreadySold = true							
					TriggerServerEvent('Pug:Server:SellDrugs', v)														
				else
					if Config.Debug then print('You dont have ['..v.item..'] to sell') end
				end			
			end, v.item)
		end
	end
end
RegisterNetEvent("Pug:client:SetStolenItemData", function(drug, bagAmount)
	StolenDrugs = {}
	Wait(200)
	StolenDrugs = {
		item = drug,
		amount = bagAmount,
	}
end)
local robberyped = nil
local function PedRobbery(pedStole)
	TaskSmartFleePed(pedStole, PlayerPedId(),600.0, -1, true, true)
	if Config.Target == "ox_target" then
		if robberyped ~= nil then
			exports.ox_target:removeModel(robberyped, {'OxTargetModelDrugs'})
		end
		robberyped = GetEntityModel(pedStole)
		exports.ox_target:addModel(robberyped, {
			{
				name = 'OxTargetModelDrugs',
				icon = 'fa-solid fa-capsules',
				label = 'Take Back Drugs',
				event = "Pug:client:GrabDrugsFromPed",
			}
		})
	else
		exports[Config.Target]:RemoveTargetModel(robberyped, 'Take Back Drugs')
		robberyped = GetEntityModel(pedStole)
		exports[Config.Target]:AddTargetModel(robberyped, {
			options = {
				{
					icon = 'fa-solid fa-capsules',
					label = 'Neem drugs terug',
					action = function()
						local player = PlayerPedId()
						RequestAnimDict("pickup_object")
						while not HasAnimDictLoaded("pickup_object") do
							Wait(0)
						end
						TaskPlayAnim(player, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
						Wait(2000)
						ClearPedTasks(player)
						TriggerServerEvent("Pug:server:GiveDrugItem", StolenDrugs.item, StolenDrugs.amount)
						StolenDrugs = {}
						exports[Config.Target]:RemoveTargetModel(robberyped, 'Take Back Drugs')
						robberyped = nil
					end,
					canInteract = function(entity)
						if IsEntityDead(entity) then
							return true
						end
					end
				}
			},
			distance = 2.5
		})
	end
end
RegisterNetEvent("Pug:client:GrabDrugsFromPed", function()
	exports.ox_target:removeModel(robberyped, {'OxTargetModelDrugs'})
	local player = PlayerPedId()
	RequestAnimDict("pickup_object")
	while not HasAnimDictLoaded("pickup_object") do
		Wait(0)
	end
	TaskPlayAnim(player, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
	Wait(2000)
	ClearPedTasks(player)
	TriggerServerEvent("Pug:server:GiveDrugItem", StolenDrugs.item, StolenDrugs.amount)
	StolenDrugs = {}
	robberyped = nil
end)
-- Interact with the ped
local function InteractPed(ped)	
	SetEntityAsMissionEntity(ped)	
	ClearPedTasksImmediately(ped)
	Wait(400)
	local coords = GetEntityCoords(PlayerPedId())
	local coordsNPC = GetEntityCoords(ped)
	ClearPedTasksImmediately(ped)
	TaskTurnPedToFaceCoord(PlayerPedId(), coordsNPC.x, coordsNPC.y, coordsNPC.z, 2000)
	TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 2000)
	Wait(2000)	
	local percent = math.random(1, 100)
	if percent < Config.ChanceSell then
		SellDrugsAnimation(ped)
		Wait(200) -- Dont Change this
		local Steels = math.random(1, 100)
		if Steels < Config.ChanceSteels then
			local AlreadySold = false
			for k, v in pairs(Config.DrugsToSell) do			
				Wait(500) -- CHANGE THIS IF PEOPLE SCUFF									
				if not AlreadySold then
					Config.FrameworkFunctions.TriggerCallback('Pug:Drugs:check', function(result)
						if result then		
							AlreadySold = true
							TriggerServerEvent("Pug:Server:StealDrugs", v)	
							Wait(500)
							PedRobbery(ped)			
						end			
					end, v.item)
				end
			end
		else
			StartDrugSale()
		end
	else
		if Config.Debug then print('Police call') end
		local randomnotification = math.random(1,6)
		if randomnotification == 1 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Geen interesse kerel...', 'error')
			RequestAnimDict("anim@heists@ornate_bank@chat_manager") 
			TaskPlayAnim(ped, "anim@heists@ornate_bank@chat_manager", "fail", 8.0, -8, -1, 0, 0, 0, 0, 0) 
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_MED', 'SPEECH_PARAMS_STANDARD')
		elseif randomnotification == 2 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Rot op vriend...', 'error')
			RequestAnimDict("anim@mp_player_intselfiethe_bird") 
			TaskPlayAnim(ped, "anim@mp_player_intselfiethe_bird", "idle_a", 8.0, -8, -1, 0, 0, 0, 0, 0) 
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_HIGH', 'SPEECH_PARAMS_STANDARD')  
		elseif randomnotification == 3 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Neen.', 'error')
			RequestAnimDict("anim@heists@ornate_bank@chat_manager") 
			TaskPlayAnim(ped, "anim@heists@ornate_bank@chat_manager", "fail", 8.0, -8, -1, 0, 0, 0, 0, 0)  
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_MED', 'SPEECH_PARAMS_STANDARD')
		elseif randomnotification == 4 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Ga weg!', 'error')
			RequestAnimDict("gestures@f@standing@casual") 
			TaskPlayAnim(ped, "gestures@f@standing@casual", "gesture_hand_down", 8.0, -8, -1, 0, 0, 0, 0, 0)
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_HIGH', 'SPEECH_PARAMS_STANDARD')
		elseif randomnotification == 5 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Ik gebruik geen drugs, sorry..', 'error')
			RequestAnimDict("mp_cp_welcome_tutthink") 
			TaskPlayAnim(ped, "mp_cp_welcome_tutthink", "b_think", 8.0, -8, -1, 0, 0, 0, 0, 0)
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_MED', 'SPEECH_PARAMS_STANDARD')
		elseif randomnotification == 6 then
			TriggerEvent('Pug:client:DrugSaleNotify', 'Wat is er mis met jou?!', 'error')
			RequestAnimDict("anim@mp_player_intupperfinger") 
			TaskPlayAnim(ped, "anim@mp_player_intupperfinger", "idle_a_fp", 8.0, -8, -1, 0, 0, 0, 0, 0)  
			PlayAmbientSpeech1(ped, 'GENERIC_INSULT_HIGH', 'SPEECH_PARAMS_STANDARD')
		end
		local randomcall = math.random(1,100)
		if randomcall < Config.CallChance then		
			CallPoliceForDrugs()
		end
	end
	SetPedAsNoLongerNeeded(ped)
end

-- Start Drug Sale To Local Ped
local function StartSalesToPed(localped)
	local CurrentPedID = PedToNet(localped)			
	local isSoldtoPed = HasSoldPed(CurrentPedID)
	if isSoldtoPed then TriggerEvent('Pug:client:DrugSaleNotify', 'Je hebt al een deal gemaakt met deze persoon') return false end
	Config.FrameworkFunctions.TriggerCallback('PugCallBack:server:getCops', function(Count)
		if Count >= Config.CopCount then
			AddSoldPed(CurrentPedID)
			InteractPed(localped)
			if Config.Debug then print('Drug Sales Started') end
		else
			TriggerEvent('Pug:client:DrugSaleNotify', 'Er is geen politie in dienst...', "error")
		end
	end)
end

RegisterKeyMapping("selldrugs", "Sell Drugs", "keyboard", Config.KeyCommand) 

RegisterCommand('selldrugs', function()
	if not IsPedInAnyVehicle(PlayerPedId()) and not drugcooldown then
		local coords = GetEntityCoords(PlayerPedId())
		local PlayerPeds = {}
		if next(PlayerPeds) == nil then
			for _, player in ipairs(GetActivePlayers()) do
				local ped = GetPlayerPed(player)
				PlayerPeds[#PlayerPeds+1] = ped
			end
		end
		local closestPed, closestDistance = PugGetClosestPed(coords, PlayerPeds)
		if closestDistance < 2.5 then
			if not IsPedDeadOrDying(closestPed) and not IsPedInAnyVehicle(closestPed) and (GetPedType(closestPed)~=28) then
				if (GetEntityPopulationType(closestPed) ~= 7) then
					drugcooldown = true
					Config.FrameworkFunctions.TriggerCallback('Pug:serverCB:CheckIfHasDrugs', function(HasItems)
						if HasItems then
							StartSalesToPed(closestPed)
						end
					end)
					Wait(3000)
					drugcooldown = false
				else
					TriggerEvent('Pug:client:DrugSaleNotify', 'Je kan niet verkopen aan deze ped', "error")
				end
			end
		end
	end
end)