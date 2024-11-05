local QBCore = exports['qb-core']:GetCoreObject()

-- Variables

local Player, PlayerData, Objects, Spikes,AllObjects, Bombs = {}, {}, {}, {}, {}, {}
local objectId, speedzones, currentbomb, ghostobj, ghostrot, pedcoords, placelaser, inveh = nil
local inarminganim = false
local curbucket = 0
local loaded = false -- do not touch, is triggered ONCE when the person logs in
local notlevel, ghostsubents = false, {}
local placedist = nil
local objectview = false


local tires = { -- this table contains all the tire id's known, DO NOT TOUCH IF YOU DO NOT KNOW WHAT YOU ARE DOING
    {bone = "wheel_lf", index = 0},
    {bone = "wheel_rf", index = 1},
    {bone = "wheel_lm", index = 2},
    {bone = "wheel_rm", index = 3},
    {bone = "wheel_lm1", index = 2},
    {bone = "wheel_rm1", index = 3},
    {bone = "wheel_lm2", index = 99},
    {bone = "wheel_rm2", index = 101},
    {bone = "wheel_lr", index = 4},
    {bone = "wheel_rr", index = 5},
}

----------------- qb events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('r14-obj:server:loadobjects')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('r14-obj:client:SetBucket', function(plybucket)
    curbucket = plybucket
end)

--------------- start up and base level events ---------------

RegisterNetEvent('r14-obj:client:setloaded', function() -- this function
    TriggerServerEvent('r14-obj:server:loadobjects')
end)

RegisterNetEvent('r14-obj:client:bulkcreate', function(data)
    for k, v in pairs(data) do
        TriggerEvent('r14-obj:client:createobject', v)
    end

    loaded = true
end)

RegisterNetEvent('r14-obj:server:UpdateObjectConfig', function(name, objdata)
    if not Config.Objects[name] then
        Config.Objects[name] = objdata
    end
end)

RegisterNetEvent('r14-obj:client:setdebug', function(data)
    Config.Debug[data.var].enabled = data.bool

    if data.var == 'Spikes' then
        destroyingzones = true
        for k, v in pairs(Spikes) do
            if AllObjects[k].entity then
                Spikes[k].zone:destroy()
                Spikes[k].spikezone:destroy()
                Spikes[k].spikezone2:destroy()     

                local offsetspike = GetOffsetFromEntityInWorldCoords(Spikes[k].entity, 0.0, 1.75 * (Config.Objects['spikestrip'].spikelength - 1), 0.0)

                Spikes[k].spikezone = BoxZone:Create(offsetspike, 3.7 * Config.Objects['spikestrip'].spikelength, 0.6, {
                    name=tostring(k)..'spike',
                    debugPoly= data.bool,
                    minZ= Spikes[k].groundz - 0.5,
                    maxZ= Spikes[k].groundz + 0.5,
                    heading = Spikes[k].heading,
                })
                Spikes[k].spikezone2 = BoxZone:Create(offsetspike, 4.2 * Config.Objects['spikestrip'].spikelength, 1.2, {
                    name=tostring(k)..'spike2',
                    debugPoly= data.bool,
                    minZ= Spikes[k].groundz - 0.5,
                    maxZ= Spikes[k].groundz + 0.5,
                    heading = Spikes[k].heading,
                })
                Spikes[k].zone = BoxZone:Create(offsetspike, 20.0 * (Config.Objects['spikestrip'].spikelength * 0.5), 20.0, {
                    name = tostring(k)..'area',
                    debugPoly = data.bool,
                    minZ= Spikes[k].groundz - 10,
                    maxZ= Spikes[k].groundz + 10,
                    heading = Spikes[k].heading,
                })
            end
        end
        destroyingzones = false
    end

end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local vehiclePool = GetGamePool('CVehicle')
        local platePool = {}

        for k, v in pairs(vehiclePool) do           
            platePool[QBCore.Functions.GetPlate(v)] = {entity = v, coords = GetEntityCoords(v)}
        end

        for k, v in pairs(AllObjects) do
            exports['qb-target']:RemoveZone(tostring(k))

            if v.entity then 
                DeleteEntity(v.entity)
            end

            if v.subentities then
                for k, v in pairs(v.subentities) do
                    if v.entity then
                        DeleteEntity(v.entity)
                    end
                end
            end

            if v.vehicles and next(v.vehicles) then
                for k, v in pairs(v.vehicles) do
                    if platePool[k] then 
                        local veh = platePool[k].entity

                        NetworkRequestControlOfEntity(veh)
	                    SetEntityAsMissionEntity(veh, true, true)
	                    DeleteVehicle(veh)
                        Wait(300)
	                    SetEntityAsMissionEntity(veh, true, true)
                        DeleteEntity(veh)
                    end
                end
            end
        end
    end
end)

------ draw text functions ---------

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function LoadAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do 
        Wait(0)
        RequestAnimDict(animdict)
    end
    return(animdict)
end

local function LoadModel(mod)
    RequestModel(mod)

    while not HasModelLoaded(mod) do
        Wait(10)
        RequestModel(mod)
    end
end

function GetMainObjectEntityHandle(objectId)
    if AllObjects[objectId] and AllObjects[objectId].entity then 
        return AllObjects[objectId].entity
    else
        return false
    end   
end

function GetInventory(objtype)
    if Config.Objects[objtype].inventory then
        return {Config.Objects[objtype].inventory.maxweight, Config.Objects[objtype].inventory.slots}
    end

    if Config.Objects[objtype].subentities then
        for k, v in pairs(Config.Objects[objtype].subentities) do
            if v.inventory then return {v.inventory.maxweight, v.inventory.slots} end
        end
    end

    return false, 'Object does not have inventory.'
end

local function FacePed(point)
    local playerObjectOffset = GetOffsetFromEntityGivenWorldCoords(ped, point.x, point.y, point.z)
    local playerObjectAngle = math.abs(math.deg(math.atan2(playerObjectOffset.x, playerObjectOffset.y)))

    if playerObjectAngle > 10 then 
        wait = 1000
    elseif playerObjectAngle > 90 then
        wait = 2000
    elseif playerObjectAngle > 120 then
        wait = 3000
    end
    
    TaskTurnPedToFaceCoord(ped, point.x, point.y, point.z, wait)
    Wait(wait)
end

local function HasKey(objectId)
    local PlayerData = QBCore.Functions.GetPlayerData()

    for k, v in pairs(PlayerData.items) do
        if v.name == 'containerkey' and v.info.objectId == objectId then
            return true
        end
    end

    return false
end

local function DoorOpen(objectId)
    if objectId and AllObjects[objectId] and AllObjects[objectId].subentities then
        for k, v in pairs(AllObjects[objectId].subentities) do
            if v.opened then
                return true
            end
        end
    end

    return false
end

local function ContainerLocked(objectId)
    local isLocked = false
    local callbackrunning = true

    QBCore.Functions.TriggerCallback('r14-obj:GetLockedStatus', function(locked) 
        isLocked = locked
        callbackrunning = false
    end, objectId)

    while callbackrunning do Wait(50) end 

    return isLocked
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function TriggerCustomObjectEvent(data, stage)
    local customdata = {entity = data.entity, objectId = data.objectId}

    if Config.Objects[data.type].subentities then
        customdata.subentities = {}

        for k, v in pairs(Config.Objects[data.type].subentities) do
            customdata.subentities[k] = {entity = v.entity}
        end
    end

    if Config.Objects[data.type][stage] then
        if Config.Objects[data.type][stage].type and Config.Objects[data.type][stage].type == 'server' then
            TriggerServerEvent(Config.Objects[data.type][stage].event, customdata)
        elseif Config.Objects[data.type][stage].type and Config.Objects[data.type][stage].type == 'action' then
            Config.Objects[data.type][stage].event(customdata)
        else
            TriggerEvent(Config.Objects[data.type][stage].event, customdata)
        end
    end
end

local function EnableObjectView()
    objectview = not objectview 
    TriggerEvent('r14-obj:client:adminmenu')

    CreateThread(function() 
        while objectview do
            for k, v in pairs(AllObjects) do
                if #(GetEntityCoords(ped) - v.coords) < 30 then
                    if v.entity and not IsEntityAPed(v.entity) then
                        local coords = GetEntityCoords(v.entity)

                        SetEntityDrawOutline(v.entity, true)
                        SetEntityDrawOutlineColor(230, 230, 250)   

                        if v.subentities then
                            for a, b in pairs(v.subentities) do 
                                SetEntityDrawOutline(b.entity, true)
                                SetEntityDrawOutlineColor(230, 230, 250)
                            end
                        end

                        DrawText3D(coords.x, coords.y, coords.z, ('Object ID: %s, Routing Bucket: %s<br>Type: %s Placed By: %s'):format(k, v.bucket, Config.Objects[v.type].label, v.cid))
                    else
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z, ('Object ID: %s, Routing Bucket: %s<br>Type: %s Placed By: %s'):format(k, v.bucket, Config.Objects[v.type].label, v.cid))
                    end
                else
                    if v.entity and not IsEntityAPed(v.entity) then
                        SetEntityDrawOutline(v.entity, false)
                    end
                end
            end
            Wait(0)
        end
        for k, v in pairs(AllObjects) do
            if #(GetEntityCoords(ped) - v.coords) < 30 then
                if v.entity and not IsEntityAPed(v.entity) then
                    SetEntityDrawOutline(v.entity, false)
                    if v.subentities then
                        for a, b in pairs(v.subentities) do 
                            SetEntityDrawOutline(b.entity, false)
                        end
                    end
                end
            end
        end
    end)
end

local function CustomObject(data)
    if data then model, freeze, persist = data.model, data.freeze, data.persist end

    local input = exports["qb-input"]:ShowInput({
        header = "Select Object Model",
        submitText = "Submit",
        inputs = {
            {
                text = "Model Name (String)",
                name = "model",
                type = "text",
                isRequired = true,
                default = model,
            },
            {
                text = "Freeze Object", -- text you want to be displayed as a input header
                name = "freeze", -- name of the input should be unique otherwise it might override
                type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
                    {value = "true", text = "True" }, -- Options MUST include a value and a text option
                    {value = "false", text = "False" }, -- Options MUST include a value and a text option
                },
                default = freeze or "true", -- Default radio option, must match a value from above, this is optional
                isRequired = true
            },
            {
                text = "Persist (Days)",
                name = "persist",
                type = "number",
                default = persist,
                isRequired = false
            },
        }
    })
    if input and input.model and IsModelValid(joaat(input.model)) then
        local freeze = false if input.freeze == 'true' then freeze = true end
        local persist = false if input.persist then persist = tonumber(input.persist) end
        TriggerServerEvent('r14-obj:server:spawncustomobject', {type = 'adminobject', model = input.model, freeze = freeze, persist = persist, command = true})
    else
        if input and input.model and not IsModelValid(joaat(input.model)) then Config.Functions.Notify("Model does not exist in game! Try again!", "error") CustomObject(input) return end
    end                
end

----------- place cast functions -----------------


function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function PlaceCast()
    local distance = 100.0
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}

	local a, hit, hitcoords, _, entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, ped, 0))
	return hit , hitcoords, entity
end

function GhostObject(type, coords, entity, model) 
    if not ghostobj then
        placedist = Config.Objects[type].maxPlaceDist or Config.MaxPlaceDist
        pedcoords = GetEntityCoords(ped)
        ghostrot = vector3(0.0, 0.0, GetGameplayCamRot())
        ghostoff = 0.0
        ghostsubents = {}
        if not Config.Objects[type].subentities then ghostsubents = nil end

        if Config.Objects[type].rotation then
            ghostrot = vector3(Config.Objects[type].rotation.x, Config.Objects[type].rotation.y, ghostrot.z)
        end

        if Config.Objects[type].ghostoff then
            ghostoff = Config.Objects[type].ghostoff
        end       

        LoadModel(model)

        ghostobj = CreateObject(model, 0.0, 0.0, 0.0, false, true, false)
        SetEntityRotation(ghostobj, ghostrot, 1, true)

        SetEntityAlpha(ghostobj, 100, true)
        FreezeEntityPosition(ghostobj, true)
        SetEntityCollision(ghostobj, false, false)

        if ghostsubents then
            for k, v in pairs(Config.Objects[type].subentities) do
                local subcoords = vector3(0.0, 0.0, 0.0)
                local subrot = ghostrot

                if v.rotation then subrot = subrot + v.rotation end
                if v.offset then subcoords = GetOffsetFromEntityInWorldCoords(ghostobj, v.offset.x, v.offset.y, v.offset.z) end

                LoadModel(v.model)

                local subent = CreateObject(v.model, subcoords, 0, 0, 0)
                SetEntityRotation(subent, subrot)

                SetEntityAlpha(subent, 100, true)
                FreezeEntityPosition(subent, true)
                SetEntityCollision(subent, false, false)

                ghostsubents[k] = {entity = subent, offset = v.offset, rotation = v.rotation, ghostoff = v.ghostoff or 0}
            end
        end
    else
        SetEntityCoords(ghostobj, coords.x, coords.y, coords.z + ghostoff, false, false, false, false)        

        StopEntityFire(ghostobj)

        if IsDisabledControlPressed(0, 16, true) or IsDisabledControlPressed(1, 16, true) or IsDisabledControlPressed(2, 16, true) then
            ghostrot = vector3(ghostrot.x, ghostrot.y, ghostrot.z + 2.5)
        end

        if IsDisabledControlPressed(0, 17, true) or IsDisabledControlPressed(1, 17, true) or IsDisabledControlPressed(2, 17, true) then
            ghostrot = vector3(ghostrot.x, ghostrot.y, ghostrot.z - 2.5)
        end

        SetEntityRotation(ghostobj, ghostrot, 1, true)

        if ghostsubents then
            for k, v in pairs(ghostsubents) do
                local ghostcoords = GetOffsetFromEntityInWorldCoords(ghostobj, v.offset.x, v.offset.y, v.offset.z + v.ghostoff)
                SetEntityCoords(v.entity, ghostcoords.x, ghostcoords.y, ghostcoords.z, false, false, false, false)                        
                local subrot = ghostrot
                if v.rotation then subrot = subrot + v.rotation end
                SetEntityRotation(v.entity, subrot, 1, true)
            end
        end

        if (IsEntityAVehicle(entity) or IsEntityAPed(entity)) or #(coords - pedcoords) > placedist then
            SetEntityDrawOutline(ghostobj, true)
            SetEntityDrawOutlineColor(255, 0, 0, 200)
            cannotplace = true
        else
            SetEntityDrawOutline(ghostobj, false)
            cannotplace = false
        end
    end
end


-------- bomb related functions -----------

local function OnHackDone(success)
    if success then
        TriggerEvent('mhacking:hide')
        TriggerServerEvent('r14-obj:server:diffuseBomb', currentbomb)
    else
		TriggerEvent('mhacking:hide')
        TriggerServerEvent('r14-obj:server:modifyTimer', currentbomb, Config.Bomb.HackFailed)
        Config.Functions.Notify(Config.Messages.HackFail, 'error')
	end
end

local function IsBombArmed(objectId)
    if Bombs[objectId] and Bombs[objectId].status == 'armed' then
        return true
    else
        return false
    end
end

local function IsBombDiffusable(objectId)
    if Bombs[objectId] and Bombs[objectId].status == 'diffusable' then
        return true
    else
        return false
    end
end

local function IsBombDiffused(objectId)
    if Bombs[objectId] and Bombs[objectId].status == 'diffused' then
        return true
    else
        return false
    end
end

local function IsWireIntact(objectId, color)
    if Bombs[objectId] and Bombs[objectId].intact[color] ~= false then
        return true
    else
        return false
    end
end

local function checkAnim()
    CreateThread(function()
        while inarminganim do
            Wait(100)
            if not IsNuiFocused() then
                Wait(500)
                if not IsNuiFocused() then
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    inarminganim = false
                end
            end
        end       
    end)
end

---------- spike strip functions -----------------

local function PlaySpikeThrow()
    CreateThread(function()        
        local ped = PlayerPedId()
        local scene = NetworkCreateSynchronisedScene(GetEntityCoords(ped), GetEntityRotation(ped, 2), 2, false, false, 1065353216, 0, 1.0)
        LoadAnimDict("amb@medic@standing@kneel@enter")
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "amb@medic@standing@kneel@enter", "enter", 8.0, -8.0, 3341, 16, 1148846080, 0)

        NetworkStartSynchronisedScene(scene)

        while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
            Wait(0)
        end

        SetSynchronizedSceneRate(NetworkConvertSynchronisedSceneToSynchronizedScene(scene), 3.0)

        while GetSynchronizedScenePhase(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) < 0.14 do
            Wait(0)
        end

        NetworkStopSynchronisedScene(scene)                     
    end)
end

local function PlaySpikeAnim(obj, next)
    if next then
        CreateThread(function()
            local minY, maxY, playZ = -0.3, 3.4, -0.10
            local start, stop = GetOffsetFromEntityInWorldCoords(obj, 0.0, minY, playZ), GetOffsetFromEntityInWorldCoords(obj, 0.0, maxY, playZ)
            local currentY = minY

            local transobj = CreateObject(`P_ld_stinger_s`, start, false, false, false)
            SetEntityRotation(transobj, GetEntityRotation(obj), 1, true)

            PlayEntityAnim(transobj, "P_Stinger_S_Deploy", LoadAnimDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.0, 0)
            SetEntityAnimSpeed(transobj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 0)
            SetEntityAnimCurrentTime(transobj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 0.01)

            while currentY < maxY do
                SetEntityAnimCurrentTime(transobj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 0.01)
                currentY = currentY + 0.085
                SetEntityCoords(transobj, GetOffsetFromEntityInWorldCoords(obj, 0.0, currentY, playZ))
                if currentY >= maxY then 
                    local waiting = true
                    SetTimeout(275, function() waiting = false end)

                    while waiting do
                        SetEntityAnimCurrentTime(transobj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 0.01)
                        Wait(0)
                    end
                    DeleteEntity(transobj) 
                end
                Wait(1)
            end                 
        end)
    end    

    PlayEntityAnim(obj, "P_Stinger_S_Deploy", LoadAnimDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.0, 0)
    while not IsEntityPlayingAnim(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) do
        Wait(0)
    end
    SetEntityVisible(obj, true)
    while IsEntityPlayingAnim(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) and GetEntityAnimCurrentTime(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy") <= 0.99 do
        Wait(0)
    end
    PlayEntityAnim(obj, "p_stinger_s_idle_deployed", LoadAnimDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.99, 0)
end

----------- command events --------------

RegisterNetEvent('r14-obj:client:adminmenu', function()
    local viewheader = 'DISABLED'

    if objectview then viewheader = 'ENABLED' end

    exports['qb-menu']:openMenu({
        {
            header = "r14-objects Admin Menu",
            isMenuHeader = true
        },
        {
            header = 'Access Vendor',
            params = {
                isAction = true,
                event = function()
                    local qbMenu = {
                        {
                            header = 'Open Vendor',
                            isMenuHeader = true,
                        }
                    }

                    for k, v in pairs(Config.Containers.Vendors) do
                        qbMenu[#qbMenu+1] = {
                            header = ('Open %s'):format(v.label),
                            params = {
                                event = "r14-obj:client:vendormenu",
                                args = {
                                    vendor = k,
                                }
                            }
                        }
                    end

                    qbMenu[#qbMenu+1] = {
                        header = "Close (ESC)",
                        params = {
                            event = "qb-menu:client:closeMenu"
                        }

                    }
                    exports['qb-menu']:openMenu(qbMenu)
                end,
                args = {
                    admin = true,
                }
            }
        },
        {
            header = ('Spawn Custom Object'):format(viewheader),
            params = {
                isAction = true,
                event = CustomObject,
                args = {
                    admin = true,
                }
            }
        },
        {
            header = ('Toggle Object View (%s)'):format(viewheader),
            params = {
                isAction = true,
                event = EnableObjectView,
                args = {
                    admin = true,
                }
            }
        },
        {
            header = 'Set Debug Variables',
            params = {
                isAction = true,
                event = function()
                    local qbMenu = {
                        {
                            header = 'Set Debug Variables',
                            isMenuHeader = true,
                        }
                    }

                    for k, v in pairs(Config.Debug) do
                        local status = 'DISABLED'

                        if v.enabled then status = 'ENABLED' end

                        if not v.exclude then
                            qbMenu[#qbMenu+1] = {
                                header = ('%s'):format(v.label),
                                text = ('<strong>%s</strong>'):format(status),
                                params = {
                                    isServer = true,
                                    event = "r14-obj:server:setdebug",
                                    args = {
                                        var = k,
                                    }
                                }
                            }
                        end
                    end

                    qbMenu[#qbMenu+1] = {
                        header = "Close (ESC)",
                        params = {
                            event = "qb-menu:client:closeMenu"
                        }

                    }
                    exports['qb-menu']:openMenu(qbMenu)
                end,
                args = {
                    admin = true,
                }
            }
        },
        {
            header = 'View User Placed Objects',
            params = {
                event = 'r14-obj:client:clearcommand',
                args = {
                    admin = true,
                }
            }
        },
        {
            header = 'View User Placed Spikes',
            params = {
                event = 'r14-obj:client:clearcommand',
                args = {
                    spike = true,
                    admin = true,
                }
            }
        },
        {
            header = 'Clear All Objects [CAUTION]',
            params = {
                event = 'r14-obj:client:adminconfirm',
                args = {
                    choice = 'objects',
                }
            }
        },
        {
            header = 'Clear All Spikes [CAUTION]',
            params = {
                event = 'r14-obj:client:adminconfirm',
                args = {
                    choice = 'spike strips',
                }
            }
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    })
end)

RegisterNetEvent('r14-obj:client:adminconfirm', function(data)
    exports['qb-menu']:openMenu({
        {
            header = ("Please confirm you wish to clear all %s on map."):format(data.choice),
            isMenuHeader = true
        },
        {
            header = ('Clear all %s on the map.'):format(data.choice),
            params = {
                isServer = true,
                event = 'r14-obj:server:adminclear',
                args = {
                    choice = data.choice,
                }
            }
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    })
end)

RegisterNetEvent('r14-obj:client:clearcommand', function(data)
    local menuhead = "Spawned Objects"
    local PlayerData = QBCore.Functions.GetPlayerData()
    local ComObjList = {}
    local nextevent = 'r14-obj:client:commandremove'
    if data.admin then nextevent = 'r14-obj:client:manageobject' end

    if data.spike then menuhead = "Spawned Spikes" end

    local objectMenu = {
        {
            header = menuhead,
            isMenuHeader = true,
        }
    }

    if data.spike then
        for k, v in pairs(Spikes) do
            if v.cid == PlayerData.citizenid or data.admin then
               local dist = #(GetEntityCoords(ped) - v.coords)
               ComObjList[#ComObjList+1] = {
                   dist = dist,
                   objectId = k,
               }
            end
        end

        if ComObjList and next(ComObjList) then
            table.sort(ComObjList, function(a, b)
                return a.dist < b.dist
            end)

            for k, v in ipairs(ComObjList) do
                objectMenu[#objectMenu+1] = {
                    header = ('Spike Strip (%s meters away)'):format(string.format("%.2f", tostring(v.dist))),
                    text = ('Placed By: %s'):format(AllObjects[v.objectId].cid),
                    params = {
                        event = nextevent,
                        args = {
                            objectId = v.objectId,
                            admin = data.admin,
                            spike = true,
                        }
                    }
                }
            end
        else
            objectMenu[#objectMenu+1] = {
                header = "No spawned spikes.",
                disabled = true,
            }
        end
    else
        for k, v in pairs(Objects) do
            if v.cid == PlayerData.citizenid or data.admin then
                local dist = #(GetEntityCoords(ped) - v.coords)
                ComObjList[#ComObjList+1] = {
                    dist = dist,
                    label = Config.Objects[v.type].label,
                    objectId = k,
                }
            end
        end
        
        if ComObjList and next(ComObjList) then
            table.sort(ComObjList, function(a, b)
                return a.dist < b.dist
            end)

            for k, v in ipairs(ComObjList) do
                objectMenu[#objectMenu+1] = {
                    header = ('%s (%s meters away)'):format(v.label, string.format("%.2f", tostring(v.dist))),
                    text = ('Placed By: %s'):format(AllObjects[v.objectId].cid),
                    params = {
                        event = nextevent,
                        args = {
                            objectId = v.objectId,
                            admin = data.admin,
                        }
                    }
                }
            end
        else
            objectMenu[#objectMenu+1] = {
                header = "No spawned spikes.",
                disabled = true,
            }    
        end
    end

    objectMenu[#objectMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(objectMenu)
end)

RegisterNetEvent('r14-obj:client:manageobject', function(data)
    local selobj = AllObjects[data.objectId]
    local PlayerData = QBCore.Functions.GetPlayerData()
    local menuhead = ("Manage %s %s"):format(Config.Objects[selobj.type].label, data.objectId)
    local maxweight, slots = nil, nil
    local objinv, invtext = GetInventory(selobj.type)
    local spike = false

    if selobj.type == 'spikestrip' then spike = true end 

    if objinv then maxweight, slots = objinv.maxweight, objinv.slots end

    local objectMenu = {
        {
            header = menuhead,
            isMenuHeader = true,
        }
    }
    objectMenu[#objectMenu+1] = {
        header = ('Placed By: %s'):format(selobj.cid),
        disabled = true
    }
    objectMenu[#objectMenu+1] = {
        header = ('Distance: %s'):format(selobj.cid),
        disabled = true
    }
    objectMenu[#objectMenu+1] = {
        header = 'Open Object Inventory',
        text = invtext,
        disabled = not objinv, 
        params = {
            event = 'r14-obj:client:openinventory',
            args = {
                objectId = data.objectId,
                object = selobj.type,                
                maxweight = maxweight, 
                slots = slots,
            }
        }
    }
    objectMenu[#objectMenu+1] = {
        header = 'Teleport To Object',
        text = ('Coords (x = %s, y = %s, z = %s)'):format(string.format("%.2f", tostring(selobj.coords.x)), string.format("%.2f", tostring(selobj.coords.y)), string.format("%.2f", tostring(selobj.coords.z))),
        params = {
            isAction = true,
            event = function(args) TriggerEvent('QBCore:Command:TeleportToCoords', args.coords.x, args.coords.y, args.coords.z) end,
            args = {
                coords = selobj.coords,
            }
        }
    }
    objectMenu[#objectMenu+1] = {
        header = 'Delete Object',
        params = {
            event = 'r14-obj:client:commandremove',
            args = {
                objectId = data.objectId,
                spike = spike,
                admin = data.admin,
            }
        }
    }
    objectMenu[#objectMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(objectMenu)
end)

RegisterNetEvent('r14-obj:client:commandremove', function(data)
    if not data.spike then
        TriggerServerEvent('r14-obj:server:deleteObject', data.objectId, true)
        Wait(200)
        TriggerEvent('r14-obj:client:clearcommand', data)
    else
        TriggerServerEvent('r14-obj:server:deleteSpike', data.objectId, true)
        Wait(200)
        TriggerEvent('r14-obj:client:clearcommand', data)
    end

    if not data.admin then TriggerServerEvent('r14-obj:server:logRemoval', data.objectId) end
end)


---- door locks

RegisterNetEvent('r14-obj:client:cutdoorlock', function(data)
    local pos, entpos, dest = GetEntityCoords(ped), GetEntityCoords(AllObjects[data.objectId].entity), GetOffsetFromEntityInWorldCoords(AllObjects[data.objectId].entity, 0.0, 3.5, 0.0)
    local lockOffset, standOffset = nil, nil
    local dict, anim = 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle'  

    if data.cutlock then 
        lockOffset, standOffset = Config.Objects[data.object].cutlock[data.cutlock].lock, Config.Objects[data.object].cutlock[data.cutlock].stand
    else

        local closest = nil
        local dist = nil

        for k, v in pairs(Config.Objects[data.object].cutlock) do
            local checkdist = #(pos - GetOffsetFromEntityInWorldCoords(AllObjects[data.objectId].entity, v.stand.x, v.stand.y, v.stand.z))
            if closest then 
                if checkdist < dist then checkdist = dist closest = k end
            else
                closest = k
                dist = checkdist
            end
        end

        lockOffset, standOffset = Config.Objects[data.object].cutlock[closest].lock, Config.Objects[data.object].cutlock[closest].stand
    end  

    local cutPosition = GetOffsetFromEntityInWorldCoords(AllObjects[data.objectId].entity, standOffset.x, standOffset.y, 1.0)
    local combinedOffset = lockOffset - standOffset
    local cutAngle = math.abs(math.deg(math.atan2(combinedOffset.x, combinedOffset.y)))
    cutAngle = math.abs(GetEntityHeading(AllObjects[data.objectId].entity) - cutAngle)

    TaskGoStraightToCoord(ped, cutPosition.x, cutPosition.y, cutPosition.z, 0.2, 4000, cutAngle, 0.5)

    local turningToContainer = true 

    while turningToContainer do
        if #(GetEntityCoords(ped) - cutPosition) < 0.3 and (math.abs(GetEntityHeading(ped)) - math.abs(cutAngle) < 3 and math.abs(GetEntityHeading(ped)) - math.abs(cutAngle) > -3) then
            turningToContainer = false
        end

        Wait(100)
    end

    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end

    local grinder = CreateObject(`tr_prop_tr_grinder_01a`, pos.x, pos.y, pos.z - 2.0, true, false, false)
    TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle', 2.0, 2.0, -1, 1, 0, false, false, false)
    AttachEntityToEntity(grinder, ped, GetPedBoneIndex(ped, 57005), 0.22, -0.02, -0.04, 77.5, 90.5, -153.5, true, true, false, true, 1, true)

    Wait(500)

    local inProgress = true

    CreateThread(function() 
        while inProgress do
            TriggerServerEvent('r14-obj:server:syncsparks', NetworkGetNetworkIdFromEntity(grinder), pos)

            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "anglegrinder", 0.5)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20, "anglegrinder", 0.3)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30, "anglegrinder", 0.1)

            Wait(5000)       
        end   
    end)

    QBCore.Functions.Progressbar("cutlock", "Cutting lock...", 34000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animdict,
        anim = anim,
        flags = flags,
    }, {}, {}, function() -- Done
        StopParticleFxLooped(sparks, 1)
        ClearPedTasks(ped)
        Wait(300)
        DeleteEntity(grinder)
        inProgress = false

        TriggerServerEvent('r14-obj:server:cutdoorlock', data)
    end, function() -- Cancel
        inProgress = false
        ClearPedTasks(ped)
        Wait(300)
        DeleteEntity(grinder)
    end)
end)

RegisterNetEvent('r14-obj:client:playsparks', function(netid, pos)
    if #(GetEntityCoords(ped) - pos) < 50 and DoesEntityExist(NetworkGetEntityFromNetworkId(netid)) then
        RequestNamedPtfxAsset('scr_tn_tr')
        UseParticleFxAsset('scr_tn_tr')
        sparks = StartParticleFxLoopedOnEntity("scr_tn_tr_angle_grinder_sparks", NetworkGetEntityFromNetworkId(netid), -0.1, 0.3, -0.15, 0.0, 0.0, 180.0, 1.0, true, true, true)
        Wait(4000)
        StopParticleFxLooped(sparks, 1)
    end
end)

local function EnterNumber(hdr, submit, text)
    local retval
    local entry = exports["qb-input"]:ShowInput({
        header = hdr,
        submitText = submit,
        inputs = {
            {
                text = text,
                name = "num",
                type = "number",
                isRequired = true
            },
        }
    })
   
    if entry and entry.num then retval = tonumber(entry.num) end

    return retval
end

RegisterNetEvent('r14-obj:server:opensafe', function(data)
    local code = {}

    for i = 1, 4, 1 do
        local hdr = ('Code [%s-%s-%s-%s]'):format(code[1] or '**', code[2] or '**', code[3] or '**', code[4] or '**')
        local submit = i > 3 and 'Submit' or 'Next'
        local entry = nil

        while entry == nil or entry < 1 or entry > 60 do
            entry = EnterNumber(hdr, submit, "Enter Number (1-60)")
        end

        code[i] = entry
    end

    QBCore.Functions.TriggerCallback('r14-obj:CheckSafeCode', function() end, {objectId = data.objectId, code = code, subent = data.subent})
end)

local function CashMenu(onHand, objectId)
    exports['qb-menu']:openMenu({
        {
            header = "Manage Funds",
            isMenuHeader = true
        },
        {
            header = ("Current Balance: %s"):format(onHand),
            disabled = true
        },
        {
            header = 'Safe Actions',
            isMenuHeader = true
        },
        {
            header = "Deposit Cash",
            params = {
                isAction = true,
                event = function(args)                   
                    local entry = EnterNumber('Withdraw Cash', 'Deposit', "Enter Amount")

                    while (entry and entry < 1) or (entry and entry > QBCore.Functions.GetPlayerData().money.cash) do
                        if entry and entry > QBCore.Functions.GetPlayerData().money.cash then Config.Functions.Notify("Ay breh, you ain't got that much!", "error") end
                        entry = EnterNumber('Deposit Cash', 'Deposit', "Enter Amount")
                    end        
                    
                    TriggerServerEvent('r14-obj:server:transactsafefunds', {objectId = objectId, deposit = true, amount = entry})
                end,
            },
        },
        {
            header = "Withdraw Cash",
            disabled = onHand == 0 and true,
            --hidden = onHand == 0 and true,
            params = {

                isAction = true,
                event = function(args)
                    local entry = EnterNumber('Withdraw Cash', 'Withdraw', "Enter Amount")

                    while entry and entry < 1 do
                        entry = EnterNumber('Withdraw Cash', 'Withdraw', "Enter Amount")
                    end                    

                    TriggerServerEvent('r14-obj:server:transactsafefunds', {objectId = objectId, amount = entry})
                end,
            },
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            },
        },
    })
end

RegisterNetEvent('r14-obj:client:managecash', function(data)
    QBCore.Functions.TriggerCallback('r14-obj:GetSafeFunds', function(onHand) 
        CashMenu(onHand, data.objectId)   
    end, data.objectId)
end)

RegisterNetEvent('r14-obj:client:policeopensafe', function(data) -- this is a placeholder event allowing basic police access to safes
    local animDict = "missheistfbi3b_ig7"
    local anim = "lift_fibagent_loop"
    local flags = 1

    QBCore.Functions.Progressbar("policeentersafe", "Cracking safe...", 180000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animDict,
        anim = anim,
        flags = flags,
    }, {}, {}, function() -- Done
        TriggerServerEvent('r14-obj:server:policeopensafe', data)
    end, function() -- Cancel

    end)
end)

-- garage container events

RegisterNetEvent('r14-obj:client:updatevehicles', function(data, remove)
    local veh = NetToVeh(data.netid)
    local plate = veh and QBCore.Functions.GetPlate(veh) or data.plate

    if remove then
        if AllObjects[data.objectId].vehicles then
            AllObjects[data.objectId].vehicles[plate] = nil
        end        
    else
        if AllObjects[data.objectId] and AllObjects[data.objectId].type == 'garage_container' then


            if AllObjects[data.objectId].vehicles then
                AllObjects[data.objectId].vehicles[plate] = {
                        model = data.model,
                        coords = data.coords,
                        rotation = data.rotation,
                        props = data.props
                } 
            else
                AllObjects[data.objectId].vehicles = {
                    [plate] = {
                        model = data.model,
                        coords = data.coords,
                        rotation = data.rotation,
                        props = data.props
                    }
                }
            end
        else
            print('Something has gone wrong when updating vehicles, please open the log and send the error message to your staff team!', remove and 'Removing' or 'Adding', json.encode(data))
        end
    end
end)

RegisterNetEvent('r14-obj:client:spawnveh', function(data)
    if AllObjects[data.objectId] and AllObjects[data.objectId].type == 'garage_container' then
        if AllObjects[data.objectId].vehicles and AllObjects[data.objectId].vehicles[data.plate] then    
            local coords = AllObjects[data.objectId].vehicles[data.plate].coords
            local coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords
            local rotation = AllObjects[data.objectId].vehicles[data.plate].rotation
            local rotation = type(coords) == 'table' and vector3(rotation.x, rotation.y, rotation.z) or rotation
            local tempcoords = vector3(coords.x, coords.y, coords.z - 10)
            
            if not IsModelInCdimage(data.model) then return end

            while not HasModelLoaded(data.model) do RequestModel(data.model) Wait(10) end

            local veh = CreateVehicle(data.model, tempcoords.x, tempcoords.y, tempcoords.z, tempcoords.w, true, false)
            local netid = NetworkGetNetworkIdFromEntity(veh)

            QBCore.Functions.SetVehicleProperties(veh, data.props)

            FreezeEntityPosition(veh, true)
            SetEntityCollision(veh, false)
            SetEntityCollision(AllObjects[data.objectId].entity, false)

            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetNetworkIdCanMigrate(netid, true)
            SetVehicleNeedsToBeHotwired(veh, false)
            SetVehRadioStation(veh, 'OFF')
            SetModelAsNoLongerNeeded(data.model)
            SetVehicleNumberPlateText(veh, data.plate)
            
            SetEntityRotation(veh, rotation.x, rotation.y, rotation.z)
            SetEntityCoords(veh, coords)
            SetEntityCollision(veh, true)
            SetEntityCollision(AllObjects[data.objectId].entity, true)
            FreezeEntityPosition(veh, false)
            ActivatePhysics(veh, true)
            ApplyForceToEntityCenterOfMass(veh, 1, 1.0, 1.0, 10.0, 0, false, false, false) -- lol, you have to 'kick the tires' to get the car to not clip the container           

            exports['LegacyFuel']:SetFuel(veh, data.props.fuelLevel)

            SetVehicleModKit(veh, 0)       
        else
            print('Tried to spawn vehicle from a container that doesn\'t exist on this client, please open the log and send the error message to your staff team!', json.encode(data))
        end
    else
        print('Something has gone wrong while spawning a vehicle, please open the log and send the error message to your staff team!', json.encode(data))
    end
end)

--------------- remove test command ------------------

RegisterCommand('testemote', function(source, args)
    local dict = tostring(args[1])
    local anim = tostring(args[2])
    local prop1 = joaat(args[3])
    local bone = tonumber(args[4])
    local emotemoving = args[5]
    local emoteloop = args[6]
    local MovementType = 0
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local off1, off2, off3, rot1, rot2, rot3 = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end

    TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, 1, 0, false, false, false)

    RequestModel(prop1)

    prop = CreateObject(prop1, coords.x, coords.y, coords.z+0.2,  true,  true, true)

    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
 
    CreateThread(function()
        testing = true
        rotmod = false

        while testing do
            Wait(0)
        
            DisableAllControlActions()
            EnableControlAction(1, 1, true)
            EnableControlAction(1, 2, true)
            DisableControlAction(0, 200, true)
            DisableControlAction(1, 200, true)
            DisableControlAction(2, 200, true)

            if IsDisabledControlPressed(0, 44, true) or IsDisabledControlPressed(1, 44, true) or IsDisabledControlPressed(2, 44, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off1 = off1 + 0.02
                else
                    rot1 = rot1 + 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)              
            end

            if IsDisabledControlPressed(0, 34, true) or IsDisabledControlPressed(1, 34, true) or IsDisabledControlPressed(2, 34, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off1 = off1 - 0.02
                else
                    rot1 = rot1 - 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
            end

            if IsDisabledControlPressed(0, 32, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off2 = off2 + 0.02
                else
                    rot2 = rot2 + 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)              
            end

            if IsDisabledControlPressed(0, 33, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off2 = off2 - 0.02
                else
                    rot2 = rot2 - 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
            end

            if IsDisabledControlPressed(0, 38, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off3 = off3 + 0.02
                else
                    rot3 = rot3 + 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)              
            end

            if IsDisabledControlPressed(0, 35, true) then
                if IsDisabledControlPressed(0, 48, true) then
                    off3 = off3 - 0.02
                else
                    rot3 = rot3 - 0.5
                end
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
            end

            if IsDisabledControlJustReleased(0, 24) then 
                testing = false
                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                DeleteEntity(prop)
                ClearPedTasks(ped)
                testing = false
            end
        end
    end)
end, 'admin')

RegisterCommand("testanim", function(source, args)
    dict = tostring(args[1])
    anim = tostring(args[2])

    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 49, .1, 0, 0, 0)
    RemoveAnimDict(anim)
end, 'admin')

RegisterCommand('checkvehexists', function(source, args) 
    QBCore.Functions.TriggerCallback('r14-obj:CheckVehExists', function(exists) 
        if exists then
            print('yeah!')
        else
            print('no!')
        end
    end, QBCore.Shared.Trim(args[1]))
end, 'admin')

----------------- primary object spawning events ----------------------

RegisterNetEvent('r14-obj:client:castobject', function(data) --type, command, item, objectId)
    if placelaser then Config.Functions.Notify("You are already doing that!", "error") return end
    if GetEntitySpeed(ped) > 2.0 then Config.Functions.Notify(Config.Messages.TooFastToPlace, "error") return end
    if IsPedInAnyVehicle(ped) then Config.Functions.Notify("Can't do that while in a vehicle!'", "error") return end
    if IsPedSwimming(ped) then Config.Functions.Notify("Can't do that while swimming!", "error") return end

    local player = PlayerId()
    local model = Config.Objects[data.type].model
    placelaser = true

    if data.model and Config.Objects[data.type].admin then
        model = data.model
    end

    if data.type == "spikestrip" then
        local checkcoords1 = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 0.0)
        local checkcoords2 = GetOffsetFromEntityInWorldCoords(ped, 0.0, (2.0 * Config.Objects['spikestrip'].spikelength), 0.0)


        _, gz1 = GetGroundZFor_3dCoord(checkcoords1.x, checkcoords1.y, checkcoords1.z, true)
        _, gz2 = GetGroundZFor_3dCoord(checkcoords2.x, checkcoords2.y, checkcoords2.z, true)

        local check = gz1 - gz2 
        
        if check > 0.3 or check < -0.3 then notlevel = true Config.Functions.Notify("Spikes should be deployed on level ground perpendicular to the roadway!", "error") placelaser = false return end

        TriggerEvent('r14-obj:client:placeobject', data)
        placelaser = false
        return
    end

    SetPlayerControl(player, true, true)

    CreateThread(function()
        while placelaser do
            Wait(0)

            DisableAllControlActions()
            EnableControlAction(1, 1, true)
            EnableControlAction(1, 2, true)
            DisableControlAction(0, 200, true)
            DisableControlAction(1, 200, true)
            DisableControlAction(2, 200, true)

            local hit, coords, entity = PlaceCast()

            GhostObject(data.type, coords, entity, model)

            DrawText2D(0.83, 1.44, 1.0, 1.0, 0.6, "~r~LEFT CLICK~w~ TO PLACE, ~r~SCROLL~w~ TO ROTATE, ~r~RIGHT CLICK~w~ TO CANCEL", 255, 255, 255, 255)

            if IsDisabledControlJustReleased(0, 200) or IsDisabledControlJustReleased(1, 25) or PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] then 
                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                DeleteEntity(ghostobj)

                if ghostsubents then
                    for k, v in pairs(ghostsubents) do
                        DeleteEntity(v.entity)
                    end
                end

                ghostobj = nil
                ghostrot = nil 
                placelaser = false
                notlevel = nil
                ghostsubents = nil

                return             
            end

            if IsDisabledControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 24) then
                if Config.Objects[data.type].checklevel then
                    local minDimension, maxDimension = GetModelDimensions(model) -- this native calculates the dimensions of the vehicle so we can find the bottom of the tires
                    
                    _, gz1 = GetGroundZFor_3dCoord(coords.x + minDimension.x, coords.y + minDimension.y, coords.z + 0.5, true)
                    _, gz2 = GetGroundZFor_3dCoord(coords.x - minDimension.x, coords.y - minDimension.y, coords.z + 0.5, true)
                    _, gz3 = GetGroundZFor_3dCoord(coords.x + maxDimension.x, coords.y + maxDimension.y, coords.z + 0.5, true)
                    _, gz4 = GetGroundZFor_3dCoord(coords.x - maxDimension.x, coords.y - maxDimension.y, coords.z + 0.5, true)

                    local levcheck = {
                        [1] = gz1,
                        [2] = gz2,
                        [3] = gz3,
                        [4] = gz4,
                    }

                    for k, v in pairs(levcheck) do
                        local check = coords.z - v
                        if check > 0.3 or check < -0.3 then notlevel = true cannotplace = true end
                    end
                end

                if hit and not cannotplace then
                    local norm = (norm(coords - pedcoords) / 2) + pedcoords
                    placelaser = false
                    DeleteEntity(ghostobj)

                    if ghostsubents then
                        for k, v in pairs(ghostsubents) do
                            DeleteEntity(v.entity)
                        end
                    end

                    TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 1000) 
                    Wait(700)

                    data.coords = coords
                    data.rotation = ghostrot

                    TriggerEvent('r14-obj:client:placeobject', data)

                    ghostobj = nil
                    ghostrot = nil
                    notlevel = nil
                    ghostsubents = nil
                elseif notlevel and cannotplace then
                    Config.Functions.Notify("Ground is not level here!", "error")
                elseif cannotplace then
                    Config.Functions.Notify("Cannot place object here.", "error")
                else
                    Config.Functions.Notify("Unable to place object, no coords found.", "error")
                end
            end
        end
    end)
end)

RegisterNetEvent('r14-obj:client:placeobject', function(data)
    if Config.Debug.Print.enabled then print(("In place object: Type %s, Coords %s, Rotation %s"):format(data.type, data.coords, data.rotation)) end

    local animdict = 'anim@narcotics@trash'
    local anim = 'drop_front'
    local flags = 16
    local time = 1200

    if Config.Objects[data.type].shortProgressBar then
        animdict, anim, flags, time = nil, nil, nil, 300
    end

    if data.type == 'spikestrip' then 
        animdict, anim, flags = nil time = 300 
        PlaySpikeThrow()
    end

    QBCore.Functions.Progressbar("spawn_object", "Placing object...", time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animdict,
        anim = anim,
        flags = flags,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)

        data.cid = QBCore.Functions.GetPlayerData().citizenid

        if data.type == "spikestrip" then
            data.coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
            data.rotation = vector3(0.0, 0.0, GetEntityHeading(ped))
            _, data.groundz = GetGroundZFor_3dCoord(data.coords.x, data.coords.y, data.coords.z, true)
        end

        if Config.Objects[data.type].speedzone then
            if Config.Objects[data.type].speedlimit == 0 then
                if not Config.Objects[data.type].hidespeed then
                    Config.Functions.Notify(Config.Messages.StoppedTraffic)
                end
            end
        end

        TriggerServerEvent('r14-obj:server:CheckObjectId', data)
    end, function() -- Cancel
        if type == 'spikestrip' then
            StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@enter", "enter", 1.0)            
        else
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        end

        Config.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('r14-obj:client:createobject', function(data)
    if Config.Debug.Print.enabled then print(("In create object: %s"):format(json.encode(data))) end

    local pos = GetEntityCoords(ped or PlayerPedId())
    local obj = nil


    if #(pos - data.coords) < 200 and data.bucket == curbucket then
        LoadModel(data.model or Config.Objects[data.type].model)
    
        if data.type == 'spikestrip' then data.coords = vector3(data.coords.x, data.coords.y, data.groundz) end

        obj = CreateObject(data.model or Config.Objects[data.type].model, data.coords, false, false, false)
        if data.throw then SetEntityVisible(obj, false) end

        data.entity = obj

        SetEntityRotation(obj, data.rotation, 1, true)

        if data.type == 'spikestrip' then 
            ActivatePhysics(obj)

            CreateThread(function()
                Wait(100)
                SetEntityCollision(obj, false, false)
                FreezeEntityPosition(obj, true)
            end)

            local spikelength = 1
            local nextspike = false

            if Config.Objects["spikestrip"].spikelength or Config.Objects["spikestrip"].spikelength > 2 then spikelength = math.floor(Config.Objects["spikestrip"].spikelength) end

            if spikelength > 1 then nextspike = true end

            if data.throw then PlaySpikeAnim(obj, nextspike) end

            if spikelength > 1 then  
                spikelength = spikelength - 1

                if data.throw or not data.subentities then 
                
                    data.subentities = {} 

                    for i = 1, spikelength, 1 do
                        local offsetobj = obj 

                        if data.subentities[i-1] and data.subentities[i-1].entity then offsetobj = data.subentities[i-1].entity end

                        local subcoords = GetOffsetFromEntityInWorldCoords(offsetobj, 0.0, 3.7, 0.0)
                        local subent = CreateObject(Config.Objects[data.type].model, subcoords, false, false, false)
                        SetEntityRotation(subent, data.rotation, 1, true)
                        ActivatePhysics(subent)
                        SetEntityVisible(subent, false) 

                        CreateThread(function()
                            Wait(100)
                            SetEntityCollision(subent, false, false)
                            FreezeEntityPosition(subent, true)
                        end)

                        data.subentities[i] = {entity = subent, rotation = data.rotation, coords = subcoords}

                        local nextspike = false

                        if i < spikelength then nextspike = true end 

                        if data.throw then PlaySpikeAnim(subent, nextspike) end
                    end
                end
            else
                SetEntityVisible(obj, true)
                if data.subentities then
                    for k, v in pairs(data.subentities) do
                        SetEntityVisible(v.entity, true)
                    end
                end
            end
        end

        if Config.Objects[data.type].zoffset then
            local zoff = data.coords.z - Config.Objects[data.type].zoffset
            SetEntityCoords(obj, data.coords.x, data.coords.y, zoff, false, false, false, false)
        end

        ActivatePhysics(obj)
        FreezeEntityPosition(obj, data.freeze or Config.Objects[data.type].freeze)

        if Config.Objects[data.type].speedzone then
            data.speedzone = AddRoadNodeSpeedZone(data.coords.x, data.coords.y, data.coords.z, 20.0, Config.Objects[data.type].speedlimit, false)
        end

        if Config.Objects[data.type].subentities or data.type == 'spikestrip' then 
            if (data.type == 'spikestrip' and not data.throw) or AllObjects[data.objectId] and AllObjects[data.objectId].subentities and AllObjects[data.objectId].subentities[1].coords then
                for k, v in pairs(data.subentities) do
                    local model = nil

                    if data.type == 'spikestrip' then model = Config.Objects[data.type].model else model = Config.Objects[data.type].subentities[k].model end

                    LoadModel(model)

                    local subent = CreateObject(model, v.coords, 0, 0, 0)
                    SetEntityRotation(subent, v.rotation)

                    if data.type == 'spikestrip' or (Config.Objects[data.type].subentities and Config.Objects[data.type].subentities[k].freeze) then FreezeEntityPosition(subent, true) end
                    if data.type == 'spikestrip' then SetEntityCollision(subent, false, false) end
                    if Config.Objects[data.type].subentities and Config.Objects[data.type].subentities[k].alpha then SetEntityAlpha(subent, v.alpha, false) end
                    
                    data.subentities[k].entity = subent

                    if data.type ~= 'spikestrip' then 
                        CreateThread(function()
                            Wait(500)                       
                            TriggerEvent('r14-obj:client:createSubTargets', {objectId = data.objectId, parent = data.entity, entity = subent, type = data.type, subent = k})
                        end)
                    end
                   
                end
            elseif data.type ~= 'spikestrip' then   
                for k, v in pairs(Config.Objects[data.type].subentities) do
                    local subcoords = data.coords
                    local subrot = data.rotation
                    local tempopen, tempclose, tempopened = nil, nil, nil

                    if v.rotation then subrot = subrot + v.rotation end

                    if v.offset then subcoords = GetOffsetFromEntityInWorldCoords(obj, v.offset.x, v.offset.y, v.offset.z) end

                    LoadModel(v.model)

                    local subent = CreateObject(v.model, subcoords, 0, 0, 0)
                    SetEntityRotation(subent, subrot)

                    if v.freeze then FreezeEntityPosition(subent, true) end
                    if v.alpha then SetEntityAlpha(subent, v.alpha, false) end

                    if v.open then
                        tempopen = subrot + v.open
                        tempclose = subrot
                    end

                    if data.subentities and data.subentities[k] and data.subentities[k].opened then                        
                        subrot = tempopen
                        SetEntityRotation(subent, tempopen)
                        tempopened = data.subentities[k].opened
                    end

                    if data.subentities then
                        data.subentities[k] = {entity = subent, inherit = v.inheritTarget, coords = subcoords, rotation = subrot, close = tempclose, open = tempopen, opened = tempopened}
                    end

                    CreateThread(function()
                        Wait(500)                       
                        TriggerEvent('r14-obj:client:createSubTargets', {objectId = data.objectId, parent = data.entity, entity = subent, type = data.type, subent = k})
                    end)
                end
            end
        end

        if obj and data.type == "spikestrip" and not AllObjects[data.objectId] then
            if data.subentities then
                for k, v in pairs(data.subentities) do
                    data.subentities[k].coords = GetEntityCoords(v.entity)
                    data.subentities[k].rotation = GetEntityRotation(v.entity)                               
                end
            end
        end
    end

    TriggerEvent('r14-obj:client:createtarget', data)
end)

RegisterNetEvent('r14-obj:client:createtarget', function(data)
    Wait(500)

    if Config.Debug.Print.enabled then print(("In sync target: %s"):format(json.encode(data))) end

    if not AllObjects[data.objectId] then
        AllObjects[data.objectId] = {
            objectId = data.objectId,
            type = data.type,
            coords = data.coords, 
            rotation = data.rotation, 
            cid = data.cid, 
            groundz = data.groundz, 
            speedzone = data.speedzone,
            entity = data.entity,
            bucket = data.bucket,
            subentities = data.subentities,
            model = data.model,
        }

        if data.type == 'garage_container' then
            AllObjects[data.objectId].vehicles = data.vehicles or {} 
        end

        if Config.Objects[data.type].locks and DoesEntityExist(data.entity) then
            AllObjects[data.objectId].entityZone = EntityZone:Create(data.entity, {
                useZ = true,
                name="entity_zone",
            }) 
        end

        TriggerCustomObjectEvent(data, 'customEventObjectCreate')
    else
        if Config.Objects[data.type].locks and DoesEntityExist(data.entity) then
            AllObjects[data.objectId].entityZone = EntityZone:Create(data.entity, {
                name="entity_zone",
                useZ = true,
            }) 
        end

        AllObjects[data.objectId].entity = data.entity
        AllObjects[data.objectId].speedzone = data.speedzone
        AllObjects[data.objectId].subentities = data.subentities

        TriggerCustomObjectEvent(data, 'customEventEntityCreate')
    end

    if data.type == 'spikestrip' then
        local heading = data.rotation.z -- get heading for polyzone

        if not Spikes[data.objectId] then
            Spikes[data.objectId] = {               
                object = 'spikestrip',
                cid = data.cid,
                coords = data.coords,
                entity = data.entity,
                bucket = data.bucket,
                heading = heading,
                groundz = data.groundz,
            }
        else
            Spikes[data.objectId].entity = data.entity
            Spikes[data.objectId].speedzone = data.speedzone
        end

        if data.entity then
            local offsetspike = GetOffsetFromEntityInWorldCoords(data.entity, 0.0, 1.75 * (Config.Objects['spikestrip'].spikelength - 1), 0.0)

            Spikes[data.objectId].spikezone = BoxZone:Create(offsetspike, 3.7 * Config.Objects['spikestrip'].spikelength, 0.6, {
                name=tostring(data.objectId)..'spike',
                debugPoly= Config.Debug.Spikes.enabled,
                minZ= data.groundz - 0.5,
                maxZ= data.groundz + 0.5,
                heading = heading,
            })
            Spikes[data.objectId].spikezone2 = BoxZone:Create(offsetspike, 4.2 * Config.Objects['spikestrip'].spikelength, 1.2, {
                name=tostring(data.objectId)..'spike2',
                debugPoly= Config.Debug.Spikes.enabled,
                minZ= data.groundz - 0.5,
                maxZ= data.groundz + 0.5,
                heading = heading,
            })
            Spikes[data.objectId].zone = BoxZone:Create(offsetspike, 20.0 * (Config.Objects['spikestrip'].spikelength * 0.5), 20.0, {
                name = tostring(data.objectId)..'area',
                debugPoly = Config.Debug.Spikes.enabled,
                minZ= data.groundz - 10,
                maxZ= data.groundz + 10,
                heading = heading,
            })
        end

        if data.bucket ~= curbucket then return end

        local offsetspike = GetOffsetFromEntityInWorldCoords(data.entity, 0.0, 1.75 * (Config.Objects['spikestrip'].spikelength - 1), 0.0)

        exports['qb-target']:AddBoxZone(tostring(data.objectId), offsetspike, 3.75 * Config.Objects['spikestrip'].spikelength, 0.5, {
	        name = tostring(data.objectId),
	        heading = heading,
    	    debugPoly = Config.Debug.ObjectZones.enabled,
	        minZ = data.groundz - 0.3,
	        maxZ = data.groundz + 0.3,
        }, {
	        options = {
                {
                    type = "client",
                    event = 'r14-obj:client:deleteSpike',
                    icon = "fas fa-box-open",
                    label = "Neem spijkermat op",
                    canInteract = function(entity)
                        local auth = table.clone(Config.AuthorizedJobs)

                        if auth.LEO.Check() or auth.Mechanic.Check() then return true end

                        return false
                    end,
                    cid = data.cid,
                    speedzone = data.speedzone,
    		        entity = entity,
                    objectId = data.objectId
                },
	        },
	        distance = 2.5
        })
    else

        if not Objects[data.objectId] then
            Objects[data.objectId] = {
                objectId = data.objectId,
                type = data.type,
                cid = data.cid,
                coords = data.coords,
                speedzone = data.speedzone,
                entity = data.entity,
            }
        else
            Objects[data.objectId].entity = data.entity
        end

        if data.bucket ~= curbucket then return end

        if Config.Objects[data.type].bomb then -- check if non-spikestrip object is bomb or not
            local targetoptions = {
                {
                    type = "client",
                    event = 'r14-obj:client:armBomb',
                    icon = "fas fa-bomb",
                    label = "Arm Bomb",
                    citizenid = data.cid,
				    entity = data.entity,
                    objectId = data.objectId,
                    cid = data.cid,
			        canInteract = function()
				        if not IsBombArmed(data.objectId) and not IsBombDiffusable(data.objectId) and not IsBombDiffused(data.objectId) then
					        return true
				        end
                    end,                        
                },
                {
                    type = "client",
                    event = 'r14-obj:client:deleteObject',
                    icon = "fas fa-box-open",
                    label = "Pickup Bomb",
                    citizenid = data.cid,
                    speedzone = data.speedzone,
				    entity = data.entity,
                    objectId = data.objectId,
			        canInteract = function()
				        if not IsBombArmed(data.objectId) and not IsBombDiffusable(data.objectId) and not IsBombDiffused(data.objectId) then
					        return true
				        end
                    end,
                },
                {
                    type = "client",
                    event = 'r14-obj:client:deleteObject',
                    icon = "fas fa-box-open",
                    label = "Dispose of Bomb",
                    broken = true,
                    speedzone = data.speedzone,
				    entity = data.entity,
                    objectId = data.objectId,
			        canInteract = function()
				        if IsBombDiffused(data.objectId) then
					        return true
				        end
                    end,
                },
                {
                    type = "client",
                    event = 'r14-obj:client:diffuseBomb',
                    icon = "fas fa-mobile-screen-button",
                    label = "Run Diffusal Program",
				    entity = data.entity,
                    objectId = data.objectId,
			        canInteract = function()
				        if IsBombDiffusable(data.objectId) then
					        return true
				        end
                    end,                        
                },
                {
                    type = "client",
                    event = 'r14-obj:client:enterCode',
                    icon = "fas fa-hashtag",
                    label = "Enter Disarm Code",
				    entity = data.entity,
                    code = '',
                    objectId = data.objectId,
			        canInteract = function()
				        if IsBombArmed(data.objectId) then
					        return true
				        end
                    end,                        
                },
                {
                    type = "server",
                    event = 'r14-obj:server:CheckTimer',
                    icon = "fas fa-stopwatch",
                    label = "Check Timer",
				    entity = data.entity,
                    objectId = data.objectId,
			        canInteract = function()
				        if IsBombArmed(data.objectId) or IsBombDiffusable(data.objectId) then
					        return true
				        end
                    end,                        
                },
            }

            for k, v in pairs(Config.Objects[data.type].wires) do
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:cutWire',
                    icon = "fas fa-scissors",
                    label = ('Cut %s Wire'):format(v:gsub("^%l", string.upper)),
				    entity = data.entity,
                    objectId = data.objectId,
                    color = v,
			        canInteract = function()
				        if IsBombArmed(data.objectId) and not IsBombDiffusable(data.objectId) and IsWireIntact(data.objectId, v) then
					        return true
				        end
                    end,                        
                }
            end

            exports['qb-target']:AddBoxZone(tostring(data.objectId), data.coords, 0.5, 0.5, {
                name = tostring(data.objectId),
    	        debugPoly = Config.Debug.ObjectZones.enabled,
                minZ = data.coords.z - 0.1,
                maxZ = data.coords.z + 0.2,
                heading = data.rotation.z,
                useZ = true,
            }, {
                options = targetoptions,
                distance = 1.5
            })
        else
            local targetoptions = {}
           
            if not Config.Objects[data.type].nopickup then
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:deleteObject',
                    icon = Config.Objects[data.type].icon or "fas fa-box-open",
                    label = ('Pick Up %s'):format(Config.Objects[data.type].label),
                    cid = data.cid,
                    job = Config.Objects[data.type].jobs,
				    entity = data.entity,
                    objectId = data.objectId
                }
            else
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:deleteObject',
                    icon = Config.Objects[data.type].icon or "fas fa-box-open",
                    label = ('Mark %s For Removal'):format(Config.Objects[data.type].label),
                    cid = data.cid,
                    canInteract = function(entity)
                        local auth = table.clone(Config.AuthorizedJobs)
                        local PlyData = QBCore.Functions.GetPlayerData()

                        if not auth.LEO.Check() then return false end
                        if PlyData.metadata['inlaststand'] or PlyData.metadata['isdead'] then return false end

                        return true
                    end,
				    entity = data.entity,
                    objectId = data.objectId
                }
            end

            if Config.Objects[data.type].policecheck then
                targetoptions[#targetoptions+1] = {
                    action = function()
                        Config.Functions.Chat({
                            color = { 255, 0, 0},
                            multiline = false,
                            args = {("Vendor ID: "), data.objectId}
                        })
                    end,
                    icon = Config.Objects[data.type].icon or "fas fa-box-open",
                    label = ('Check for Vendor ID'):format(Config.Objects[data.type].label),
                    canInteract = function(entity)
                        local auth = table.clone(Config.AuthorizedJobs)
                        local PlyData = QBCore.Functions.GetPlayerData()

                        if not auth.LEO.Check() then return false end
                        if PlyData.metadata['inlaststand'] or PlyData.metadata['isdead'] then return false end

                        return true
                    end,
				    entity = data.entity,
                    objectId = data.objectId
                }
            end

            if Config.Objects[data.type].give then
                for k, v in pairs(Config.Objects[data.type].give) do
                    local label = ('Create %s'):format(v.label) -- create default craft label and icon for qb-target
                    local icon = 'fas fa-hammer'
                    if not v.req then label = ('Get %s'):format(v.label) icon = 'fas fa-plus' end -- if no req, modify to default get label and icon for qb-target

                    targetoptions[#targetoptions+1] = {
                        type = "server",
                        event = 'r14-obj:server:checkreqs',
                        icon = v.icon or icon,
                        label = v.targetlabel or label,
				        entity = data.entity,
                        objectId = data.objectId,
                        object = data.type,
                        give = k,
                    }
                end
            end

            if Config.Objects[data.type].inventory then
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:openinventory',
                    icon = Config.Objects[data.type].inventory.icon,
                    label = Config.Objects[data.type].inventory.label or ('Open %s'):format(Config.Objects[data.type].label),
                    object = data.type,
                    objectId = data.objectId,
				    entity = data.entity,
                    maxweight = Config.Objects[data.type].inventory.maxweight,
                    slots = Config.Objects[data.type].inventory.slots,
                }
            end

            if Config.Objects[data.type].safe then
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:openinventory',
                    icon = 'fas fa-vault',
                    label = 'Open kluis',
                    object = data.type,
                    objectId = data.objectId,
			        entity = data.entity,
                    maxweight = Config.Objects[data.type].safe.maxweight,
                    slots = Config.Objects[data.type].safe.slots,
			        canInteract = function(entity)
                        local DoorOpen, ContainerLocked = DoorOpen, ContainerLocked

                        if DoorOpen(data.objectId) and not ContainerLocked(data.objectId) then return true end
                        return false
		            end,
                }

                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:managecash',
                    icon = 'fas fa-vault',
                    label = 'Controleer geld',
                    object = data.type,
                    objectId = data.objectId,
			        entity = data.entity,
                    maxweight = Config.Objects[data.type].safe.maxweight,
                    slots = Config.Objects[data.type].safe.slots,
			        canInteract = function(entity)
                        local DoorOpen, ContainerLocked = DoorOpen, ContainerLocked

                        if DoorOpen(data.objectId) and not ContainerLocked(data.objectId) then return true end
                        return false
		            end,
                }
            end

            if Config.Objects[data.type].music then
                targetoptions[#targetoptions+1] = {
                    type = "client",
                    event = 'r14-obj:client:musicplayer',
                    icon = "fas fa-music",
                    label = "Use Controls",
                    object = data.type,                       
                    objectId = data.objectId,
                    coords = data.coords,
                    name = Config.Objects[data.type].label,
                }
            end

            if Config.Objects[data.type].sit then
                targetoptions[#targetoptions+1] = {
                    event = "qb-Sit:Sit",
                    icon = "fas fa-chair",
                    label = "Zit neer",
				    entity = data.entity,
                }
                
                if data.entity then TriggerEvent('qb-sit:client:updatechairs', data.entity, true) end
            end

            if Config.Objects[data.type].customTarget then
                if Config.Objects[data.type].customTarget.event then
                    targetoptions[#targetoptions+1] = {
                        type = Config.Objects[data.type].customTarget.type or 'client',
                        event = Config.Objects[data.type].customTarget.event,
                        icon = Config.Objects[data.type].customTarget.icon,
                        label = Config.Objects[data.type].customTarget.label,
                        entity = data.entity,
                        objectId = data.objectId,
                        object = data.type,
                        citizenid = Config.Objects[data.type].customTarget.citizenid and data.cid,
                    }
                else
                    for k, v in pairs(Config.Objects[data.type].customTarget) do
                    targetoptions[#targetoptions+1] = {
                        type = v.type or 'client',
                        event = v.event,
                        icon = v.icon,
                        label = v.label,
                        entity = data.entity,
                        objectId = data.objectId,
                        object = data.type,
                        citizenid = Config.Objects[data.type].customTarget.citizenid and data.cid,
                    }
                    end
                end
            end

            if Config.Objects[data.type].entityzone then
                exports['qb-target']:AddEntityZone(tostring(data.objectId), data.entity, {
                    name = tostring(data.objectId),
    	            debugPoly = Config.Debug.ObjectZones.enabled,
                    useZ = true,
                }, {
                    options = targetoptions,
                    distance = Config.Objects[data.type].targetdist or Config.TargetDist,
                })

            else
                exports['qb-target']:AddTargetEntity(data.entity, {
                    options = targetoptions,
                    distance = 3.0
                })
            end
        end
    end

    TriggerEvent('r14-obj:client:objectcreated', data) -- this event allows other scripts to link into the script and create options for target
end)

RegisterNetEvent('r14-obj:client:createSubTargets', function(data)
    local targetoptions = {}

    while not AllObjects[data.objectId] or not AllObjects[data.objectId].subentities do print('wait') Wait(100) end
           
    if Config.Objects[data.type].subentities[data.subent].give then
        for k, v in pairs(Config.Objects[data.type].subentities[data.subent].give) do
            local label = ('Create %s'):format(Config.Objects[data.type].subentities[data.subent].label) -- create default craft label and icon for qb-target
            local icon = 'fas fa-hammer'
            if not v.req then label = ('Get %s'):format(Config.Objects[data.type].subentities[data.subent].label) icon = 'fas fa-plus' end -- if no req, modify to default get label and icon for qb-target

            targetoptions[#targetoptions+1] = {
                type = "server",
                event = 'r14-obj:server:checkreqs',
                icon = v.icon or icon,
                label = v.label or label,
				entity = data.entity,
                objectId = data.objectId,
                object = data.type,
                give = k,
            } 
        end
    end 

    if Config.Objects[data.type].subentities[data.subent].open then
        if Config.Objects[data.type].locks then
            targetoptions[#targetoptions+1] = {
                type = "server",
                event = 'r14-obj:server:toggledoorlock',
                icon = 'fas fa-lock-open',
                label = 'Open Container',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,
                unlocking = true,
			    canInteract = function(entity)
                    local HasKey, DoorOpen, ContainerLocked = HasKey, DoorOpen, ContainerLocked

                    if AllObjects[data.objectId].entityZone:isPointInside(GetEntityCoords(ped)) then return false end     
                    if not HasKey(data.objectId) then return false end
                    if DoorOpen(data.objectId) then return false end
                    if ContainerLocked(data.objectId) then return true end 
                    return false
		        end,
            }
            targetoptions[#targetoptions+1] = {
                type = "client",
                event = 'r14-obj:client:cutdoorlock',
                icon = 'fas fa-scissors',
                label = 'Snij het slot kapot',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,
                item = 'anglegrinder',
                unlocking = true,
			    canInteract = function(entity)
                    local DoorOpen, ContainerLocked = DoorOpen, ContainerLocked

                    if AllObjects[data.objectId].entityZone:isPointInside(GetEntityCoords(ped)) then return false end     
                    if DoorOpen(data.objectId) then return false end
                    if ContainerLocked(data.objectId) then return true end 

                    return false
		        end,
            } 
            targetoptions[#targetoptions+1] = {
                type = "server",
                event = 'r14-obj:server:toggledoorlock',
                icon = 'fas fa-lock',
                label = 'Sluit Container',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,
                locking = true,
			    canInteract = function(entity)
                    local HasKey, DoorOpen, ContainerLocked = HasKey, DoorOpen, ContainerLocked

                    if not HasKey(data.objectId) then return false end
                    if DoorOpen(data.objectId) then return false end
                    if not ContainerLocked(data.objectId) then return true end 

                    return false
		        end,
            }
        elseif Config.Objects[data.type].safe then 
            targetoptions[#targetoptions+1] = {
                type = "client",
                event = 'r14-obj:server:opensafe',
                icon = 'fas fa-vault',
                label = 'Enter Combinatie',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,
                unlocking = true,
			    canInteract = function(entity)
                    local DoorOpen, ContainerLocked = DoorOpen, ContainerLocked

                    if DoorOpen(data.objectId) then return false end
                    if ContainerLocked(data.objectId) then return true end 
                    return false
		        end,
            }

            targetoptions[#targetoptions+1] = { -- placeholder for a better safe crack event
                type = "client",
                event = 'r14-obj:client:policeopensafe',
                icon = 'fas fa-scissors',
                label = '[Politie] Kraak kluis',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,

                unlocking = true,
			    canInteract = function(entity)
                    local DoorOpen, ContainerLocked, Auth = DoorOpen, ContainerLocked, Config.AuthorizedJobs
                    local PlayerData = QBCore.Functions.GetPlayerData()

                    if not Auth.LEO.Check() then return false end
                    if DoorOpen(data.objectId) then return false end
                    if ContainerLocked(data.objectId) then return true end 

                    return false
		        end,
            }

            targetoptions[#targetoptions+1] = {
                type = "server",
                event = 'r14-obj:server:toggledoorlock',
                icon = 'fas fa-lock',
                label = 'Sluit kluis',
                object = data.type,
                objectId = data.objectId,
			    entity = data.entity,
                subent = data.subent,
                locking = true,
			    canInteract = function(entity)
                    local DoorOpen, ContainerLocked = DoorOpen, ContainerLocked

                    if DoorOpen(data.objectId) then return false end
                    if not ContainerLocked(data.objectId) then return true end 

                    return false
		        end,
            }
        end

        targetoptions[#targetoptions+1] = {
            type = "server",
            event = 'r14-obj:server:opendoor',
            icon = 'fas fa-door-open',
            label = 'Open deur',
            object = data.type,
            objectId = data.objectId,
			entity = data.entity,
            subent = data.subent,
			canInteract = function(entity)
                local ContainerLocked = ContainerLocked
                if not AllObjects[data.objectId] or not AllObjects[data.objectId].subentities then return false end
                if AllObjects[data.objectId] and AllObjects[data.objectId].subentities and AllObjects[data.objectId].subentities[data.subent].opened then return false end

                if ContainerLocked(data.objectId) then return false end

                return true
		    end,
        }
        targetoptions[#targetoptions+1] = {
            type = "server",
            event = 'r14-obj:server:opendoor',
            icon = 'fas fa-door-open',
            label = 'Sluit deur',
            object = data.type,
            objectId = data.objectId,
			entity = data.entity,
            subent = data.subent,
			canInteract = function(entity)
                if not AllObjects[data.objectId] or not AllObjects[data.objectId].subentities then return false end
                if AllObjects[data.objectId] and AllObjects[data.objectId].subentities and AllObjects[data.objectId].subentities[data.subent].opened then return true end

                return false
		    end,
        }
    end

    if Config.Objects[data.type].subentities[data.subent].inventory then
        targetoptions[#targetoptions+1] = {
            type = "client",
            event = 'r14-obj:client:openinventory',
            icon = Config.Objects[data.type].subentities[data.subent].inventory.icon,
            label = Config.Objects[data.type].subentities[data.subent].inventory.label or ('Open %s'):format(Config.Objects[data.type].subentities[data.subent].label),
            object = data.type,
            objectId = data.objectId,
			entity = data.entity,
            maxweight = Config.Objects[data.type].subentities[data.subent].inventory.maxweight,
            slots = Config.Objects[data.type].subentities[data.subent].inventory.slots,
			canInteract = function(entity)
                local ContainerLocked = ContainerLocked

                if Config.Objects[data.type].locks then
                    if Config.Objects[data.type].container and not AllObjects[data.objectId].entityZone:isPointInside(GetEntityCoords(ped)) then return false end     
                    if ContainerLocked(data.objectId) and not HasKey(data.objectId) then return false end

                    return true
                else
                    return true
                end
		    end,
        }
    end

    if Config.Objects[data.type].subentities[data.subent].music then
        targetoptions[#targetoptions+1] = {
            type = "client",
            event = 'r14-obj:client:musicplayer',
            icon = "fas fa-music",
            label = "Use Controls",
            object = data.type,                       
            objectId = data.objectId,
            coords = data.coords,
            name = Config.Objects[data.type].subentities[data.subent].label,
        }
    end

    if Config.Objects[data.type].subentities[data.subent].sit then
        targetoptions[#targetoptions+1] = {
            event = "qb-Sit:Sit",
            icon = "fas fa-chair",
            label = "Zit neer",
			entity = data.entity,
        }
    end

    if Config.Objects[data.type].subentities[data.subent].entityzone then
        exports['qb-target']:AddEntityZone(tostring(data.objectId), data.entity, {
            name = tostring(data.objectId),
    	    debugPoly = Config.Debug.ObjectZones.enabled,
            useZ = true,
        }, {
            options = targetoptions,
            distance = Config.Objects[data.type].subentities[data.subent].targetdist or Config.TargetDist,
        })
    else
        exports['qb-target']:AddTargetEntity(data.entity, {
            options = targetoptions,
            distance = Config.Objects[data.type].subentities[data.subent].targetdist or Config.TargetDist,
        })
    end
end)

local function SwingDoor(entity, opening, rot, start, stop)
    CreateThread(function()
        local currentEntity = entity
        local currentRotation = start
        local endRotation = stop
        local increment = {}
        local tempIncrement = vector3(rot.x, rot.y, rot.z)

        for k, v in pairs(tempIncrement) do
            if opening then
                if v > 0 then increment[k] = 1 else increment[k] = -1 end
            else
                if v > 0 then increment[k] = -1 else increment[k] = 1 end
            end
        end
        
        while currentRotation ~= endRotation do
            local newRotation = {}

            for k, v in pairs(currentRotation) do                
                if increment[k] < 1 then
                    if currentRotation[k] + increment[k] > endRotation[k] then 
                        newRotation[k] = currentRotation[k] + increment[k]                    
                    else 
                        newRotation[k] = endRotation[k] 
                    end
                else
                    if currentRotation[k] + increment[k] < endRotation[k] then 
                        newRotation[k] = currentRotation[k] + increment[k]                    
                    else 
                        newRotation[k] = endRotation[k] 
                    end
                end
            end

            currentRotation = vector3(newRotation[1], newRotation[2], newRotation[3])

            SetEntityRotation(currentEntity, currentRotation)    
            Wait(0)
        end
    end)
end     

RegisterNetEvent('r14-obj:client:opendooranim', function()
    local doorlockAnimDict, doorlockAnimName = "anim@mp_player_intmenu@key_fob@", 'fob_click'

    loadAnimDict(doorlockAnimDict)
    TaskPlayAnim(ped, doorlockAnimDict, doorlockAnimName, 3.0, 3.0, -1, 49, 0, false, false, false)

    Wait(750)
    StopAnimTask(ped, doorlockAnimDict, doorlockAnimName, 1.0)
end)

RegisterNetEvent('r14-obj:client:opendoor', function(data)
    if AllObjects[data.objectId].subentities[data.subent].opened then
        if DoesEntityExist(AllObjects[data.objectId].subentities[data.subent].entity) then SwingDoor(AllObjects[data.objectId].subentities[data.subent].entity, false, Config.Objects[data.object].subentities[data.subent].open, AllObjects[data.objectId].subentities[data.subent].open, AllObjects[data.objectId].subentities[data.subent].close) end
        AllObjects[data.objectId].subentities[data.subent].rotation = AllObjects[data.objectId].subentities[data.subent].close
        AllObjects[data.objectId].subentities[data.subent].opened = false
    else
        if DoesEntityExist(AllObjects[data.objectId].subentities[data.subent].entity) then SwingDoor(AllObjects[data.objectId].subentities[data.subent].entity, true, Config.Objects[data.object].subentities[data.subent].open, AllObjects[data.objectId].subentities[data.subent].close, AllObjects[data.objectId].subentities[data.subent].open) end
        AllObjects[data.objectId].subentities[data.subent].rotation = AllObjects[data.objectId].subentities[data.subent].open
        AllObjects[data.objectId].subentities[data.subent].opened = true
    end
end)
----------------- primary delete object events ----------------------

RegisterNetEvent('r14-obj:client:deleteObject', function(data)
    QBCore.Functions.Progressbar("remove_object", "Picking up object..", 1500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Donec
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)

        TriggerServerEvent('r14-obj:server:deleteObject', data.objectId, Config.Objects[Objects[data.objectId].type].nopickup, data.broken) -- server sync removal
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
    end)
end)

RegisterNetEvent('r14-obj:client:removeObject', function(objectId)
    if Objects[objectId] and Objects[objectId].speedzone then RemoveRoadNodeSpeedZone(Objects[objectId].speedzone) end -- delete speedzone

    TriggerCustomObjectEvent(AllObjects[objectId], 'customEventObjectDelete')

    DeleteEntity(AllObjects[objectId].entity)

    if Config.Objects[AllObjects[objectId].type].sit then -- deletes entity from qb-sit chair list
        TriggerEvent('qb-sit:client:updatechairs', AllObjects[objectId].entity) 
    end

    if AllObjects[objectId].entityZone then AllObjects[objectId].entityZone:destroy() end

    if AllObjects[objectId].subentities then -- deletes subentities
        for k, v in pairs(AllObjects[objectId].subentities) do
            DeleteEntity(v.entity)
        end
    end

    exports['qb-target']:RemoveZone(tostring(objectId))

    TriggerEvent('r14-obj:client:objectdeleted', AllObjects[objectId]) -- this allows other scripts to realize that an object has been deleted/removed, sends object info

    Objects[objectId] = nil
    AllObjects[objectId] = nil

    if Bombs[objectId] then Bombs[objectId] = nil end -- delete object from bomb table if it is in it
end)

RegisterNetEvent('r14-obj:client:deleteSpike', function(data)
    QBCore.Functions.Progressbar("remove_object", "Picking up spikestrip..", 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
 
        TriggerServerEvent('r14-obj:server:deleteSpike', data.objectId)
    end, function() -- Cancel
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        Config.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('r14-obj:client:removeSpike', function(objectId)
    RemoveRoadNodeSpeedZone(Spikes[objectId].speedzone)
    DeleteObject(AllObjects[objectId].entity)
    if AllObjects[objectId].subentities then -- deletes subentities
        for k, v in pairs(AllObjects[objectId].subentities) do
            DeleteEntity(v.entity)
        end
    end
    exports['qb-target']:RemoveZone(tostring(objectId))
    if Spikes[objectId].zone then
        Spikes[objectId].zone:destroy()
        Spikes[objectId].spikezone:destroy()
        Spikes[objectId].spikezone2:destroy()
    end
    Spikes[objectId] = nil
    AllObjects[objectId] = nil
end)

----------------------- item specific events -----------------------

-------------- bomb events -------------------

RegisterNetEvent('r14-obj:client:armBomb', function(data)
    
    TriggerEvent('animations:client:EmoteCommandStart', {'medic2'})

    inarminganim = true
    checkAnim()

    exports['qb-menu']:openMenu({
        {
            header = "Set Arming Wire",
            isMenuHeader = true
        },
        {
            header = "Blue Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'blue',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Red Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'red',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Green Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'green',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Yellow Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'yellow',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Purple Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'purple',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Pink Wire",
            params = {
                event = 'r14-obj:client:setCode',
                args = {
                    color = 'pink',
                    objectId = data.objectId,
                    code = '',
                }
            }
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    })
end)

RegisterNetEvent('r14-obj:client:setCode', function(data)
    local displaycode = data.code    
    local codelength = #displaycode

    if codelength < 6 then
        local missing = 6 - codelength
        for i = 1, missing do
            displaycode = displaycode..'*'
        end

        local keypadMenu = {
            {
                header = "Set Six Digit Code ["..displaycode.."]",
                isMenuHeader = true
            }
        }

        for i = 1, 9 do
            keypadMenu[#keypadMenu+1] = {
                header = i,
                params = {
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = data.color,
                        code = data.code..i,
                        objectId = data.objectId
                    }
                }
            }
        end

        keypadMenu[#keypadMenu+1] = {
            header = "Close (ESC)",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(keypadMenu)

    elseif codelength == 6 then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = false,
            args = {"Code Entered:", data.code}
        })
        TriggerEvent('r14-obj:client:setTime', data)
    end
end)

RegisterNetEvent('r14-obj:client:enterCode', function(data)
    local displaycode = data.code    
    local codelength = #displaycode

    if codelength < 6 then
        local missing = 6 - codelength
        for i = 1, missing do
            displaycode = displaycode..'*'
        end

        local keypadMenu = {
            {
                header = "Enter Six Digit Code ["..displaycode.."]",
                isMenuHeader = true
            }
        }

        for i = 1, 9 do
            keypadMenu[#keypadMenu+1] = {
                header = i,
                params = {
                    event = 'r14-obj:client:enterCode',
                    args = {
                        color = data.color,
                        code = data.code..i,
                        objectId = data.objectId,
                        
                    }
                }
            }
        end

        keypadMenu[#keypadMenu+1] = {
            header = "Close (ESC)",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(keypadMenu)

    elseif codelength == 6 then
        if data.code == Bombs[data.objectId].code then
            TriggerServerEvent('r14-obj:server:disarmBomb', data)
        else
           TriggerServerEvent('r14-obj:server:modifyTimer', data.objectId, Config.Bomb.WrongCode)
           Config.Functions.Notify(Config.Messages.WrongCode, 'error')
        end
    end
end)

RegisterNetEvent('r14-obj:client:setTime', function(data)
    local bomb = exports["qb-input"]:ShowInput({
        header = "Set Timer",
        submitText = "Arm",
        inputs = {
            {
                text = "Time (Minutes)",
                name = "time",
                type = "number",
                isRequired = true
            },
        }
    })
    if bomb then
        TriggerServerEvent('r14-obj:server:armBomb', data.objectId, (bomb.time * 60), data.color, data.code)
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        inarminganim = false
    else
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        inarminganim = false
        return
    end
end)

RegisterNetEvent('r14-obj:client:diffuseBomb', function(data)
    currentbomb = data.objectId
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", math.random(6, 7), math.random(12, 15), OnHackDone)
end)

RegisterNetEvent('r14-obj:client:cutWire', function(data)
    if Bombs[data.objectId].intact[data.color] then
        QBCore.Functions.Progressbar("remove_object", "Cutting wire...", 1500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@medic@standing@tendtodead@base",
            anim = "base",
            flags = 1,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "amb@medic@standing@tendtodead@base", "base", 1.0)
            if data.color == Bombs[data.objectId].wire then
                TriggerServerEvent('r14-obj:server:CorrectWire', data.objectId)
            else
                TriggerServerEvent('r14-obj:server:modifyTimer', data.objectId, Config.Bomb.WrongWire, data.color)
                Config.Functions.Notify(Config.Messages.WrongWire, 'error')
            end
        end, function() -- Cancel
            StopAnimTask(ped, "amb@medic@standing@tendtodead@base", "base", 1.0)
            Config.Functions.Notify("Canceled..", "error")
        end)
    else
        Config.Functions.Notify("This wire has already been cut!", "error")
    end
end)

RegisterNetEvent('r14-obj:client:syncBomb', function(objectId, event, wire, code)
    if not Objects[objectId] then return end -- prevents multiple secondary explosion commands being sent causing a nil error when it finds an empty slot in the objects table

    if event == 'arm' then
        Bombs[objectId] = {
            status = 'armed',
            wire = wire,
            code = code,
            intact = {
                ["red"] = true,
                ["blue"] = true,
                ["green"] = true,
                ["yellow"] = true,
                ["purple"] = true,
                ["pink"] = true,
            },
        }
    elseif event == 'diffusable' then
        Bombs[objectId].status = 'diffusable'
    elseif event == 'cutwire' then
        Bombs[objectId].intact[wire] = false
    elseif event == 'disarm' then
        Bombs[objectId].status = nil
    elseif event == 'diffuse' then
        Bombs[objectId].status = 'diffused'       
    elseif event == 'detonate' then
        local loud = 600
        local distant = 2000
        local superdistant = 3000
        local dist = #(Objects[objectId].coords - GetEntityCoords(ped))

        if dist < loud then 
            AddExplosion(Objects[objectId].coords.x, Objects[objectId].coords.y, Objects[objectId].coords.z, 49, 60.0, true, false, true)
        elseif dist > loud and dist < distant then
            AddExplosion(Objects[objectId].coords.x, Objects[objectId].coords.y, Objects[objectId].coords.z, 1, 60.0, true, false, true)
        elseif dist > distant and dist < superdistant then
            AddExplosion(Objects[objectId].coords.x, Objects[objectId].coords.y, Objects[objectId].coords.z, 33, 60.0, true, false, true)
        end
    end
end)

----------------- inventory items event --------------------

RegisterNetEvent('r14-obj:client:openinventory', function(data) -- event to open cooler inventory, this inventory is unique to the objectid, not the cooler itself
    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.object .. data.objectId, {
        maxweight = data.maxweight or 100000,
        slots = data.slots or 20,
    })
    TriggerEvent("inventory:client:SetCurrentStash", data.object .. data.objectId)
end)

--------------- crafting objects events --------------------

RegisterNetEvent('r14-obj:client:craft', function(data)
    if not Objects[data.objectId] then print(("This %s shouldn't exist! r14-objects may have been restarted, or someone spawned this illegally >:("):format(data.object)) return end
    
    local coords = Objects[data.objectId].coords
    local progresslabel = ('Getting %s'):format(data.give)

    if Config.Objects[data.object].give[data.give].req then progresslabel = ('Making %s'):format(data.give) end


    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
    TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 1000) 

    Wait(1000)

    TriggerEvent('animations:client:EmoteCommandStart', {Config.Objects[data.object].give[data.give].emote or 'pickup'})

    QBCore.Functions.Progressbar("pickup_sla", Config.Objects[data.object].give[data.give].prgresslabel or progresslabel, Config.Objects[data.object].give[data.give].time or 1500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done

        TriggerServerEvent('r14-obj:server:craftitem', data)

        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
    end, function()
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
    end)
end)

 
------------- Threads -------------------------------

-- this thread reduces the amount of times we fetch ped, it fetches playerpedid once per second to catch refreshed skins, etc

CreateThread(function()
	while true do
		ped = PlayerPedId()
        inveh = IsPedInAnyVehicle(ped)
        spikesdeployed = next(Spikes)
        PlayerData = QBCore.Functions.GetPlayerData()

        if Config.Debug.Bucket.enabled then print('Current routing bucket:', curbucket) end

        Wait(1000)
	end
end)

-- this thread tracks the player if they enter a spikestrips polyzone

CreateThread(function()
    local vehicle = nil
    local dz = nil

    while true do
        if spikesdeployed and LocalPlayer.state.isLoggedIn then
        
            if inveh then
                if not vehicle then
                    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local minDimension, _ = GetModelDimensions(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), true))) -- this native calculates the dimensions of the vehicle so we can find the bottom of the tires
                    dz = tonumber(minDimension.z)
                end

                pos = GetEntityCoords(vehicle)

                for k, v in pairs(Spikes) do
                    if AllObjects[k].entity and not destroyingzones and v.zone and v.zone:isPointInside(pos) then
                        for a = 1, #tires do
                            
                            if GetEntityBoneIndexByName(vehicle, tires[a].bone) ~= -1 then

                                local speed = GetEntitySpeed(vehicle) * 2.236936
                                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                                local tirePosOffset = GetOffsetFromEntityGivenWorldCoords(vehicle, tirePos.x, tirePos.y, tirePos.z)
                                local tireoff = GetOffsetFromEntityInWorldCoords(vehicle, tirePosOffset.x, tirePosOffset.y, dz + 0.2)

                                if Config.Debug.Spikes.enabled then DrawMarker(28, tireoff.x, tireoff.y, tireoff.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.30, 0.30, 0.30, 197, 197, 197, 200, false, false, 2, nil, nil, false) end
                            
                                if tirePos ~= vector3(0.00, 0.00, 0.00) then
                                
                                    if speed > 100 then
                                        if v.spikezone2:isPointInside(tireoff) then
                                            if not IsVehicleTyreBurst(vehicle, tires[a].index, true) then
                                                SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                                            end
                                        end
                                    elseif speed > 1 then
                                        if v.spikezone:isPointInside(tireoff) then
                                            if not IsVehicleTyreBurst(vehicle, tires[a].index, true) then
                                                SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else 
                vehicle = nil
            end
        end
        Wait(0)
    end
end)

CreateThread(function()
    while not loaded do 
        Wait(500)   
    end

    while true do
        local pos = GetEntityCoords(ped)
        local vehiclePool = GetGamePool('CVehicle')
        local platePool = {}

        for k, v in pairs(vehiclePool) do           
            platePool[QBCore.Functions.GetPlate(v)] = {entity = v, coords = GetEntityCoords(v)}
        end

        for k, v in pairs(AllObjects) do
            if #(pos - v.coords) < 200 and v.bucket == curbucket then
                if not v.entity then 
                    TriggerEvent("r14-obj:client:createobject", v)
                    if v.vehicles then for k, v in pairs(v.vehicles) do ApplyForceToEntityCenterOfMass(platePool[k].entity, 1, 1.0, 1.0, 10.0, 0, false, false, false) end end
                elseif v.entity then

                    if not DoesEntityExist(v.entity) or ((v.model and GetEntityModel(v.entity) ~= joaat(v.model)) or (not v.model and GetEntityModel(v.entity) ~= Config.Objects[v.type].model)) then
                        for k, v in pairs(v.subentities) do
                            if DoesEntityExist(v.entity) then DeleteEntity(v.entity) end
                        end

                        TriggerEvent("r14-obj:client:createobject", v)
                    end

                    if v.type == 'garage_container' and v.entityZone then

                        for a, b in pairs(platePool) do
                            if v.entityZone:isPointInside(b.coords) then
                                local tempCoords = v.vehicles[a] and v.vehicles[a].coords and vector3(v.vehicles[a].coords.x, v.vehicles[a].coords.y, v.vehicles[a].coords.z)

                                if not v.vehicles[a] or v.vehicles[a] and #(b.coords - tempCoords) > 0.1 then
                                    TriggerServerEvent('r14-obj:server:updatevehicles', {objectId = k, netid = VehToNet(b.entity), model = GetEntityModel(b.entity), props = QBCore.Functions.GetVehicleProperties(b.entity)})                                
                                end
                            end
                        end

                        for a, b in pairs(v.vehicles) do
                            if not platePool[a] then
                                TriggerServerEvent('r14-obj:server:requestveh', {objectId = k, plate = a})
                            else
                                if not v.entityZone:isPointInside(platePool[a].coords) then
                                    TriggerServerEvent('r14-obj:server:updatevehicles', {objectId = k, netid = VehToNet(platePool[a].entity)}, true)                                
                                end
                            end                            
                        end
                    end
                end
            else            
                if v.entity then
                    TriggerCustomObjectEvent(v, 'customEventEntityDelete')
                    TriggerEvent('r14-obj:client:deleteentity', AllObjects[k])
    
                    DeleteEntity(v.entity)

                    if v.subentities then 
                        for a, v in pairs(v.subentities) do
                            DeleteEntity(v.entity)                            
                            AllObjects[k].subentities[a].entity = nil 
                        end
                    end
                    exports['qb-target']:RemoveZone(tostring(k))
                    if v.type == 'spikestrip' then
                        Spikes[k].zone:destroy()
                        Spikes[k].spikezone:destroy()
                        Spikes[k].spikezone2:destroy()                        
                    end

                    if Config.Objects[v.type].locks and AllObjects[k] then AllObjects[k].entityZone:destroy() end
                    if Config.Objects[v.type].sit then TriggerEvent('qb-sit:client:updatechairs', v.entity) end

                    AllObjects[k].entity = nil

                    if v.speedzone then RemoveRoadNodeSpeedZone(AllObjects[k].speedzone) end
                end
            end
        end
        Wait(2000)
    end
end)
