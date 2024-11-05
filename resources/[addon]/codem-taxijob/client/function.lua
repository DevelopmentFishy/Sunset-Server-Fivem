
local frameworkObject = false

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    while not response do
        Citizen.Wait(0)
    end
end)

createNpc = nil
customerNpcBlip ,customerNpcBlipFinish =  nil, nil
createNpcCoords = nil
finishCoords = nil
npcInCar = false
deleteVehicle = false
whitelistVehicle = false
npcTime = 0
npcPrice = 0
local mile = 0
local earning = 0
itemTaximetre = false

Citizen.CreateThread(function()
    local isAlreadyOwner = false
    local lastPlate = false

    while true do
        local wait = 2000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if createNpcCoords and IsPedInAnyVehicle(playerPed,false) then
            local npc = vector3(createNpcCoords.x, createNpcCoords.y, createNpcCoords.z)
            local distance = #(playerCoords - npc)
            if distance < 10 and not npcInCar then
                local BinilenArac = GetVehiclePedIsIn(playerPed)
                wait = 0
                DrawText3D(npc.x, npc.y, npc.z + 2.0, Config.Locale['PRESSTOGETINCAR'])
                if IsControlJustPressed(0, 38) then
                    if isLocked == 2 then 
                        TriggerEvent('codem-taxi:notify', Config.Locale['LOCKVEHICLE'])
                    else
                        RemoveBlip(customerNpcBlip)
                        signalNpc()
                        Wait(1500)
                        npcInCar = true
                        customerNpcBlipFinish = AddBlipForCoord(finishCoords.x, finishCoords.y, finishCoords.z)
                        SetBlipSprite(customerNpcBlipFinish, 388)
                        SetNewWaypoint(finishCoords.x, finishCoords.y)
                        if npcTime ~= 0 then
                            TriggerServerEvent('codem-taxi:startTimer',npcTime)
                        end
                    end
                end
            end
        end
        if npcInCar then
            local finishCoordsForNpc = vector3(finishCoords.x, finishCoords.y, finishCoords.z)
            local finishDistance = #(playerCoords - finishCoordsForNpc)
            local BinilenArac = GetVehiclePedIsIn(playerPed)
            local vehSpeed = GetEntitySpeed(BinilenArac)
            mile = mile + round(vehSpeed * 0.00721371,5)
            earning = npcPrice
            if scammerPrice == 'scammer' then 
                scammer = false
                local calculate = (tonumber(earning) * 99) / 100
                price = string.format("%.0f",calculate)
           
                SendNUIMessage({
                    action = 'UPDATE_MILE',
                    mile = mile,
                    earning = calculate,
                })
                earning = price
            else

                SendNUIMessage({
                    action = 'UPDATE_MILE',
                    mile = mile,
                    earning = earning + scammerPrice,
                })

            end
            
            if finishDistance < 15 and  finishDistance > 5 then 
                wait = 5
             
                DrawMarker(2, finishCoords.x, finishCoords.y, finishCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            end

            if finishDistance < 5 and vehSpeed < 2 then
                if scammerPrice ~= "scammer" then
                    earning = earning + scammerPrice
                else
                    earning = earning
                end
                TriggerServerEvent('codem-taxi:server:finishJob', tonumber(string.format("%.1f",mile)), earning,currentJobAccount)
                NpcGoHome()
                SendNUIMessage({
                    action = 'UPDATE_MILE',
                    mile = 0,
                    earning = 0,
                    timer = 0,
                })
                mile = 0
            end
        elseif not npcCabbing and startJob then
            local BinilenArac = GetVehiclePedIsIn(playerPed)
            if BinilenArac ~= 0 then
                local plate = GetVehicleNumberPlateText(BinilenArac)
                if lastPlate ~= plate then
                    lastPlate = plate
                    local vehOwner = Callback('codem-taxi:server:getVehicleOwner', plate)
                    isAlreadyOwner = vehOwner
                    
                end
               
                if isAlreadyOwner then
                
                    local vehSpeed = GetEntitySpeed(BinilenArac)

                    local serverId = GetPlayerServerId(PlayerId())
        

                    Player(serverId).state:set( --[[keyName]] 'playerMile', --[[value]] (Player(serverId).state.playerMile or 0) + round(vehSpeed * 0.00721371,5), --[[replicate to server/client]] true)
                    Player(serverId).state:set( --[[keyName]] 'playerEarning', --[[value]] tonumber(Config.KmPrice) * (Player(serverId).state.playerMile or 0), --[[replicate to server/client]] true)
                end
            end
        end

        Citizen.Wait(wait)
    end
end)

local lastTaxiPlate = nil
local validTaxi = false
local alreadyInvehicle = false
Citizen.CreateThread(function()
    local driverId = nil
    while true do
        local time = 3000
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        if not startJob then
            
            if vehicle ~= 0 then
                if not alreadyInvehicle then
                 
                    alreadyInvehicle = true
                    time = 1500
                    local plate = GetVehicleNumberPlateText(vehicle)
                  
                    if lastTaxiPlate == nil or lastTaxiPlate ~= plate then
                
                        local model = GetEntityModel(vehicle)
                        local vehname = GetDisplayNameFromVehicleModel(model)
                        local driverPed = GetPedInVehicleSeat(vehicle, -1)
                        if driverPed then
                            local playerHandle = NetworkGetPlayerIndexFromPed(driverPed)
                            local id = GetPlayerServerId(playerHandle)
                            driverId = id
                            lastTaxiPlate = plate
                            if Config.WhitelistVehicle[vehname] or Config.WhitelistVehicle[vehname:lower()] then
                                local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                           
                                validTaxi = inWorkingTaxi
                            elseif  itemTaximetre then 
                                
                                local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                                validTaxi = inWorkingTaxi
                              
                            end
                        end
                    end
                    
                    if validTaxi then 
                        if lastTaxiPlate == plate and (driverId and Player(driverId).state and Player(driverId).state.isTaxiMeterOpen) then
                            SendNUIMessage({
                                action = 'ToggleTaxiMeterMenu',
                                value = true,
                            })
                        end
                    else
                        if lastTaxiPlate == plate and (driverId and Player(driverId).state and Player(driverId).state.isTaxiMeterOpen) then
                            SendNUIMessage({
                                action = 'ToggleTaxiMeterMenu',
                                value = true,
                            })
                        end

                    end
                
                end
            else
             
              
                if alreadyInvehicle  then
                    alreadyInvehicle = false
                    validTaxi = false
                    lastTaxiPlate = nil
                    SendNUIMessage({
                        action = 'ToggleTaxiMeterMenu',
                        value = false,
                    })
                    time = 3000
                end
            end
        end
        Citizen.Wait(time)
    end
end)

AddStateBagChangeHandler('isTaxiMeterOpen' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if bagName:find('player:') then
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            return
        end
        local id = tonumber(bagName:gsub('player:', ''), 10)
        local playerPed= PlayerPedId()
        local BinilenArac = GetVehiclePedIsIn(playerPed)
        if BinilenArac ~= 0 then
            local plate = GetVehicleNumberPlateText(BinilenArac)
            local driverPed = GetPedInVehicleSeat(BinilenArac, -1)
     
            if driverPed then
                local playerHandle = NetworkGetPlayerIndexFromPed(driverPed)
                local driverId = GetPlayerServerId(playerHandle)
                if (lastTaxiPlate == nil or lastTaxiPlate ~= plate) and tonumber(driverId) == tonumber(id) then
                    local model = GetEntityModel(BinilenArac)
                    local vehname = GetDisplayNameFromVehicleModel(model)
                    lastTaxiPlate = plate
                    if Config.WhitelistVehicle[vehname] or Config.WhitelistVehicle[vehname:lower()] then
                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                    elseif itemTaximetre then 
                 
                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                    end
                end
                if validTaxi then
                    if lastTaxiPlate == plate and tonumber(driverId) == tonumber(id) then
                        SendNUIMessage({
                            action = 'ToggleTaxiMeterMenu',
                            value = value,
                        })
                    end
                else
                    if lastTaxiPlate == plate and tonumber(driverId) == tonumber(id) then
                        SendNUIMessage({
                            action = 'ToggleTaxiMeterMenu',
                            value = value,
                        })
                    end

                end
           
            end
        end
    end
end)

AddStateBagChangeHandler('playerEarning' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if bagName:find('player:') then
        local id = tonumber(bagName:gsub('player:', ''), 10)
        local playerPed= PlayerPedId()
        local BinilenArac = GetVehiclePedIsIn(playerPed)
        if BinilenArac ~= 0 then
            local driverPed = GetPedInVehicleSeat(BinilenArac, -1)
            if driverPed then
                local playerHandle = NetworkGetPlayerIndexFromPed(driverPed)
                local driverId = GetPlayerServerId(playerHandle)
                local plate = GetVehicleNumberPlateText(BinilenArac)
               
                if (lastTaxiPlate == nil or lastTaxiPlate ~= plate) and tonumber(driverId) == tonumber(id) then
              
                    local model = GetEntityModel(BinilenArac)
                    local vehname = GetDisplayNameFromVehicleModel(model)
                    lastTaxiPlate = plate
           
                    if Config.WhitelistVehicle[vehname] or Config.WhitelistVehicle[vehname:lower()] then
                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                    elseif  itemTaximetre then 

                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                 
                    end
                end
            
                if validTaxi then 
                    if lastTaxiPlate == plate and tonumber(driverId) == tonumber(id) then
                      
                        SendNUIMessage({
                            action = 'UPDATE_MILE',
                            mile = Player(id).state.playerMile,
                            earning = value,
                        })
                    end
                else
                    if lastTaxiPlate == plate and tonumber(driverId) == tonumber(id) then
                    
                        SendNUIMessage({
                            action = 'UPDATE_MILE',
                            mile = Player(id).state.playerMile,
                            earning = value,
                        })
                    end
                end
               
            end
        end
    end
end)

AddStateBagChangeHandler('playerMile' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if bagName:find('player:') then
        local id = tonumber(bagName:gsub('player:', ''), 10)
        local playerPed= PlayerPedId()
        local BinilenArac = GetVehiclePedIsIn(playerPed)
        if BinilenArac ~= 0 then
            local plate = GetVehicleNumberPlateText(BinilenArac)
            local driverPed = GetPedInVehicleSeat(BinilenArac, -1)
      
            if driverPed then
                local playerHandle = NetworkGetPlayerIndexFromPed(driverPed)
                local driverId = GetPlayerServerId(playerHandle)
                if (lastTaxiPlate == nil or lastTaxiPlate ~= plate) and tonumber(driverId) == tonumber(id) then
                    local model = GetEntityModel(BinilenArac)
                    local vehname = GetDisplayNameFromVehicleModel(model)
                    lastTaxiPlate = plate
                    if Config.WhitelistVehicle[vehname] or Config.WhitelistVehicle[vehname:lower()] then
                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                    elseif not  itemTaximetre then 
                
                        local inWorkingTaxi = Callback('codem-taxi:server:getVehicleByPlateAndPlayerId', {plate = plate, id = id})
                        validTaxi = inWorkingTaxi
                    end
                end
                if validTaxi and lastTaxiPlate == plate and tonumber(driverId) == tonumber(id) then
               
                    SendNUIMessage({
                        action = 'UPDATE_MILE',
                        mile = value ,
                        earning = Player(id).state.playerEarning,
                    })
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        if startJob and npcCabbing then
            if npcInCar then
                SendNUIMessage({
                    action = 'taxiOn',
                    value = true
                })
            else
                SendNUIMessage({
                    action = 'taxiOn',
                    value = false
                })
            end
        end
        Citizen.Wait(wait)
    end
end)

function CreateNpc(mission)
    if Config.startPoint[mission] then
        local random = math.random(1, #Config.startPoint[mission])
        createNpcCoords = Config.startPoint[mission][random]['startCoord']
        local modelindex = math.random(1, #Config.NpcHash)
        local model = Config.NpcHash[modelindex]
        -- local finishrandom = math.random(1, #Config.finishPoint[mission])
        finishCoords = Config.startPoint[mission][random]['finishCoord']
        npcTime = Config.startPoint[mission][random]['time']
        npcPrice = Config.startPoint[mission][random]['price']
        WaitForModel(model)
        createNpc =  CreatePed("PED_TYPE_PROSTITUTE", model, createNpcCoords.x, createNpcCoords.y, createNpcCoords.z - 0.98, createNpcCoords.w, true, false)
        FreezeEntityPosition(createNpc, true)
        SetEntityInvincible(createNpc, true)
        SetBlockingOfNonTemporaryEvents(createNpc, true)
        TaskStartScenarioInPlace(createNpc, "WORLD_HUMAN_SMOKING", 0, false)
        loaddict("switch@michael@parkbench_smoke_ranger")
        customerNpcBlip = AddBlipForCoord(createNpcCoords.x, createNpcCoords.y, createNpcCoords.z)
        SetBlipSprite(customerNpcBlip, 280)
        SetNewWaypoint(createNpcCoords.x, createNpcCoords.y)
    end
end

function spawnTaxi()
    if Config.Framework == 'esx' then
        frameworkObject.Game.SpawnVehicle(GetHashKey(Config.DefaultVehicle), {
            x = Config.SpawnTaxiCoords['spawn']['x'],
            y = Config.SpawnTaxiCoords['spawn']['y'],
            z = Config.SpawnTaxiCoords['spawn']['z'] + 1
        }, Config.SpawnTaxiCoords['spawn']['h'], function(callback_vehicle)
            Config.SetVehicleFuel(callback_vehicle,100)
            if Config.Vehiclekey then
                Config.GiveVehicleKey(GetVehicleNumberPlateText(callback_vehicle), GetHashKey(Config.DefaultVehicle))
            end
            TriggerServerEvent('codem-taxi:savePlate', GetVehicleNumberPlateText(callback_vehicle))
        end)
    else
        frameworkObject.Functions.SpawnVehicle(GetHashKey(Config.DefaultVehicle), function(callback_vehicle)
            Config.SetVehicleFuel(callback_vehicle,100)
            if Config.Vehiclekey then
                Config.GiveVehicleKey(GetVehicleNumberPlateText(callback_vehicle), GetHashKey(Config.DefaultVehicle))
            end
            TriggerServerEvent('codem-taxi:savePlate', GetVehicleNumberPlateText(callback_vehicle))
        end, vector4(Config.SpawnTaxiCoords['spawn']['x'],Config.SpawnTaxiCoords['spawn']['y'],Config.SpawnTaxiCoords['spawn']['z'],Config.SpawnTaxiCoords['spawn']['h']), true)

    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        if startJob then
            local ped = PlayerPedId()
            local BinilenArac = GetVehiclePedIsIn(ped)
            local model = GetEntityModel(BinilenArac)
            local vehname = GetDisplayNameFromVehicleModel(model)
            if IsPedInAnyVehicle(PlayerPedId(),false) then
                if  Config.WhitelistVehicle[vehname] or Config.WhitelistVehicle[vehname:lower()] then
                    local plate = GetVehicleNumberPlateText(BinilenArac)
                    local vehOwner = Callback('codem-taxi:server:getVehicleOwner',plate)
                    if vehOwner then
                        whitelistVehicle = true
                        getOpenNpcTaxiCabmenu(true)
                        deleteVehicle = true
                    else
                        whitelistVehicle = false
                        getOpenNpcTaxiCabmenu(false)
                    end
                elseif itemTaximetre then 
                    local plate = GetVehicleNumberPlateText(BinilenArac)
                    local vehOwner = Callback('codem-taxi:server:getVehicleOwner',plate)
                    if vehOwner then
                        whitelistVehicle = true
                        getOpenNpcTaxiCabmenu(true)
                        deleteVehicle = true
                    else
                        whitelistVehicle = false
                        getOpenNpcTaxiCabmenu(false)
                    end
                end
            else
                whitelistVehicle = false
                getOpenNpcTaxiCabmenu(false)
            end
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 2000
        if deleteVehicle and IsPedInAnyVehicle(PlayerPedId(),false) then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = #(coords - vector3(Config.SpawnTaxiCoords['delete']['x'],Config.SpawnTaxiCoords['delete']['y'],Config.SpawnTaxiCoords['delete']['z']))
            local BinilenArac = GetVehiclePedIsIn(ped)
            local model = GetEntityModel(BinilenArac)
    
            if dist < 10 and not itemTaximetre then
                wait = 0
                DrawMarker(2, Config.SpawnTaxiCoords['delete']['x'],Config.SpawnTaxiCoords['delete']['y'],Config.SpawnTaxiCoords['delete']['z'] + 0.55, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 0, 0, 100, 0, 0, 0, 0)
                if dist < 5 then
                    DrawText3D(Config.SpawnTaxiCoords['delete']['x'],Config.SpawnTaxiCoords['delete']['y'],Config.SpawnTaxiCoords['delete']['z'] + 1.0, Config.Locale['DELETEVEHICLE'])
                    if IsControlJustPressed(0, 38) then
                        local plate = GetVehicleNumberPlateText(BinilenArac)
                        local vehOwner = Callback('codem-taxi:server:getVehicleOwner',plate)
                        if vehOwner then
                            if Config.Removekeys then
                                Config.RemoveVehiclekey(GetVehicleNumberPlateText(BinilenArac), model)
                            end
                            Wait(100)
                            DeleteVehicle(BinilenArac)
                            DeleteWaypoint()
                            RemoveBlip (customerNpcBlip)
                            deleteVehicle = false
                            startJob = false
                            createNpcCoords = nil
                            npcInCar = false
                            getOpenNpcTaxiCabmenu(false)
                            if Config.DepositeVehicle['deposite'] then 
                                TriggerEvent('codem-taxi:notify', '$'..Config.DepositeVehicle['depositePrice']..' '..Config.Locale['DEPOSITREFUNDED'])
                                TriggerServerEvent('codem-taxi:server:addDeposite',plate)   
                            end
                            TriggerServerEvent('codem-taxi:server:deleteVehicle',plate)
                        else
                            TriggerEvent('codem-taxi:notify', Config.Locale['PLATEDOESNT'])
                        end
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

RegisterNetEvent('codem-taxi:useItem')
AddEventHandler('codem-taxi:useItem', function()
    if startJob and not startJobWithTaxiMeter then return end
    local ped = PlayerPedId()
    local BinilenArac = GetVehiclePedIsIn(ped)
    local model = GetEntityModel(BinilenArac)
    local vehname = GetDisplayNameFromVehicleModel(model)
    if IsPedInAnyVehicle(PlayerPedId(),false) then
        local plate = GetVehicleNumberPlateText(BinilenArac)
        itemTaximetre = true
        TriggerServerEvent('codem-taxi:savePlate', plate)
        local playerTaxiData = Callback('codem-taxi:server:getTaxiData')
        SendNUIMessage({
            action = 'GETDATA',
            playerTaxiData = playerTaxiData,
        })
    end
end)

function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end

    while not HasModelLoaded(model) do
        Citizen.Wait(0)

    end
end

function signalNpc()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    FreezeEntityPosition(createNpc, false)
    SetEntityAsMissionEntity(createNpc)
    SetBlockingOfNonTemporaryEvents(createNpc, true)
    local entered = TaskEnterVehicle(createNpc, vehicle, -1, 0, 1.0, 1, 0)
    if not entered then 
        TaskWarpPedIntoVehicle(createNpc, vehicle, -1)
    end
end

function NpcGoHome()
    TaskLeaveVehicle(createNpc, vehicle, 0)
    SetPedAsNoLongerNeeded(createNpc)
    started = false
    npcInCar = false
    RemoveBlip(customerNpcBlipFinish)
    RemoveBlip(customerNpcBlip)
    createNpcCoords = nil
    npcTime = 0
    SendNUIMessage({
        action = 'TIMER_START',
        value = 0,
    })

    SendNUIMessage({
        action = 'SCAMMER_POINT',
        value = 0,
    })
    DeleteWaypoint()

end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
            TriggerServerEvent('codem-taxi:server:deleteVehicle2')
        end
    end
end)

RegisterCommand('vehiclename', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local model = GetEntityModel(vehicle)
    local vehname = GetDisplayNameFromVehicleModel(model)
    print(vehname)
end)

RegisterCommand(Config.FinishCommand, function()
    if startJob or startJobWithTaxiMeter then
        startJob = false
        startJobWithTaxiMeter = false
        createNpcCoords = nil
        npcInCar = false
        getOpenNpcTaxiCabmenu(false)
        NpcGoHome()
    end
end)