local QBCore = exports['qb-core']:GetCoreObject()
local xSound = exports.xsound

local Objects, OvernightObjects = {}, {}
local Spikes, Bombs, MusicPlayers = {}, {}, {}
local objectlist, overnightlist = 1, 2
local PendingUpdate = false
local OvernightRemove = {}
local loaded = false -- used to check if LoadDB() has completed
local ActivePlayers, ActiveAdmins = {}, {}
local RecentlySpawned = {}

------------------------------------------------------------------------------------------------------------
--------------------------------------------    VERSION CHECK   --------------------------------------------
------------------------------------------------------------------------------------------------------------

PerformHttpRequest('https://raw.githubusercontent.com/regalonefour/r14-versions/main/r14-objects.txt', function(err, version, headers)
    local curVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

    if not version then print('Could not complete version request.') return end

    if version ~= curVersion then
        print(('^3Current Version: %s, Latest Version: %s'):format(curVersion, version))
        print('Please download the latest version of r14-objects from your keymaster!^0')
    end
end)

----------- on start/stop -----------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k, v in pairs(MusicPlayers) do
            xSound:Destroy(-1, k)
        end
        UpdateDB()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local tableFound = nil
        local result = MySQL.single.await("SHOW TABLES LIKE ?", {Config.DB.Table})

        if result and next(result) then
            for k, v in pairs(result) do
                if v == Config.DB.Table then tableFound = true end
            end
        end

        if not tableFound then
            print('^1#####################################################################################################################') 
            print(("No table named '%s' exists in database, go run the included SQL before you open a ticket asking me what's wrong"):format(Config.DB.Table)) 
            print('#####################################################################################################################^0')             
        end

        LoadDB()
    end
end)

RegisterNetEvent('r14-obj:server:setdebug', function(data)
    Config.Debug[data.var].enabled = not Config.Debug[data.var].enabled

    TriggerClientEvent('r14-obj:client:setdebug', -1, {var = data.var, bool = Config.Debug[data.var].enabled})
end)

----- functions ------------------

local function CreateObjectId()
    local objectId = tostring(math.random(100000, 999999)) 
    while (Objects[objectId]) or (Spikes[objectId]) do
        objectId = tostring(math.random(100000, 999999))
        Wait(0)
    end
    return objectId
end

local function VendorSearch(search, registered, unitId)
    if search.type == 'name' then
        a, b = string.find(string.lower(('%s %s'):format(registered.first, registered.last)), string.lower(search.text))
        if a and b then 
            return true
        end
    elseif search.type == 'cid' then
        if string.lower(registered.cid) == string.lower(search.text) then
            return true
        end
    elseif search.type == 'unitId' then
        if tostring(unitId) == tostring(search.text) then
            return true
        end
    end

    return false
end

local function GetStashItems(stashId)
	local items = {}
	local result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if not result then return items end

	local stashItems = json.decode(result)
	if not stashItems then return items end

	for _, item in pairs(stashItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				slot = item.slot,
			}
		end
	end

	return items
end

local function SetStash(stashId, oldId, items)
	for _, item in pairs(items) do
		item.description = nil
	end

	MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
		['stash'] = stashId,
		['items'] = json.encode(items)
	})

    MySQL.update('UPDATE stashitems SET items = ? WHERE stash = ?', {'[]', oldId})
end

function UpdateDB(skipovernight)
    CreateThread(function()
        if not PendingUpdate then
            local dbpackage = {}
            PendingUpdate = 5000

            while PendingUpdate > 0 do               
                PendingUpdate = PendingUpdate - 1000 
                Wait(1000)
            end

            for k, v in pairs(Objects) do
                if not v.ignore then
                    dbpackage[k] = v
                end
            end

            MySQL.update('UPDATE ' .. Config.DB.Table .. ' SET ' .. Config.DB.Column .. ' = ? WHERE id = ?', {json.encode(dbpackage), objectlist})

            if Config.Debug.Database.enabled then print(('Object database entry updated with: %s'):format(json.encode(dbpackage))) end

            if not skipovernight then
                dbpackage = {}

                for k, v in pairs(OvernightObjects) do
                    dbpackage[k] = v
                end

                MySQL.update('UPDATE ' .. Config.DB.Table .. ' SET ' .. Config.DB.Column .. ' = ? WHERE id = ?', {json.encode(dbpackage), overnightlist})

                if Config.Debug.Database.enabled then print(('Overnight Object database entry updated with: %s'):format(json.encode(dbpackage))) end
            end
    
            PendingUpdate = nil 
        else
            PendingUpdate = 5000 
        end    
    end)
end

function HasSubInventory(objtype)
    for k, v in pairs(Config.Objects[objtype].subentities) do
        if v.inventory then return true end
    end

    return false
end

function LoadDB()
    local result = MySQL.single.await('SELECT ' .. Config.DB.Column .. ' FROM ' .. Config.DB.Table .. ' WHERE id = ?', {objectlist})
           
    Wait(1000)

    if result then
        objtable = json.decode(result.list)
        
        if Config.Debug.Database.enabled then print(('Objects called from database: %s'):format(json.encode(objtable))) end

        if objtable and next(objtable) then
            for k, v in pairs(objtable) do
                if v.time and v.time - os.time() > 0 and not v.ignore then
                    local data = v
                    data.coords = vector3(data.coords.x, data.coords.y, data.coords.z)
                    data.rotation = vector3(data.rotation.x, data.rotation.y, data.rotation.z)

                    if Config.Containers.CloseOnReset or Config.Containers.LockOnReset then data.subentities = nil end
                    if Config.Containers.LockOnReset then data.locked = true end

                    local emailcheck = false

                    if v.vendor then emailcheck = Config.Containers.Vendors[v.vendor].emailRenewalStart or Config.Containers.VendorDefaults.emailRenewalStart end

                    if emailcheck and v.time - os.time() < (60 * 60 * 24 * emailcheck) then
                        Config.Containers.SendEmail({
                            cid = v.cid,
                            sender = Config.Containers.Vendors[v.vendor].label,
                            subject = "Renew Your Contract!",
                            message = (Config.Containers.Vendors[v.vendor].emailRenew or Config.Containers.VendorDefaults.emailRenew):format(k, os.date('%m/%d', v.time), Config.Containers.Vendors[v.vendor].label),                          
                        })
                    end

                    if not Config.Objects[v.type] and v.thirdParty and v.customConfig then -- will load custom config from item info if third party object
                        TriggerEvent('r14-obj:server:CreateCustomObject', v.type, v.customConfig)
                    end

                    TriggerEvent('r14-obj:server:SyncObjects', data, true)
                else
                    if v.vendor then
                        local maildata = {cid = v.cid, sender = Config.Containers.Vendors[v.vendor].label}

                        if next(GetStashItems(v.type..v.objectId)) then
                            maildata.subject = "Contract Expired"
                            maildata.message = (Config.Containers.Vendors[v.vendor].emailExpiredUnclaimedItems or Config.Containers.VendorDefaults.emailExpiredUnclaimedItems):format(k, os.date('%m/%d', v.time), maildata.sender)
                        else
                            maildata.subject = "Contract Expired"
                            maildata.message = (Config.Containers.Vendors[v.vendor].emailExpired or Config.Containers.VendorDefaults.emailExpired):format(k, os.date('%m/%d', v.time), maildata.sender)
                        end
                        Config.Containers.SendEmail(maildata)
                    end
                end
            end
        end
    else
        print(("Row 1 missing in table '%s' for column '%s', creating row for you because you did not run the SQL."):format(Config.DB.Table, Config.DB.Column))

        MySQL.insert(('INSERT INTO %s (%s, id) VALUES (? , ?)'):format(Config.DB.Table, Config.DB.Column), {'[]', 1})
    end 

    result, objtable = nil, nil

    local result = MySQL.single.await('SELECT ' .. Config.DB.Column .. ' FROM ' .. Config.DB.Table .. ' WHERE id = ?', {overnightlist})
           
    Wait(1000)

    if result and result ~= 'ignore' then
        objtable = json.decode(result.list)
        
        if Config.Debug.Database.enabled then print(('Overnight Objects called from database: %s'):format(json.encode(objtable))) end

        if objtable and next(objtable) then
            for k, v in pairs(objtable) do
                local data = v
                data.coords = vector3(data.coords.x, data.coords.y, data.coords.z)
                data.rotation = vector3(data.rotation.x, data.rotation.y, data.rotation.z)

                if Config.Containers.CloseOnReset then data.subentities = nil end
                if Config.Containers.LockOnReset then data.locked = true end

                if v.oldId and (Config.Objects[v.originalType].inventory or HasSubInventory(v.originalType)) then
                    local stashId = v.type..v.objectId
                    local oldStashId = v.originalType..v.oldId

                    GetStashItems(stashId)

                    SetStash(stashId, oldStashId, GetStashItems(oldStashId))
                end

                if not Config.Objects[v.type] and v.thirdParty and v.customConfig then -- will load custom config from item info if third party object
                    TriggerEvent('r14-obj:server:CreateCustomObject', v.type, v.customConfig)
                end

                TriggerEvent('r14-obj:server:SyncObjects', data, true)
            end
        end

        MySQL.update('UPDATE ' .. Config.DB.Table .. ' SET ' .. Config.DB.Column .. ' = ? WHERE id = ?', {'ignore', overnightlist})

        UpdateDB(true)
    else
        print(("Row 2 missing in table '%s' for column '%s', creating row for you because you did not run the SQL."):format(Config.DB.Table, Config.DB.Column))

        MySQL.insert(('INSERT INTO %s (%s, id) VALUES (? , ?)'):format(Config.DB.Table, Config.DB.Column), {'[]', 2})
    end     

    loaded = true
    TriggerClientEvent('r14-obj:client:setloaded', -1)
end

local function CreateUseableObjectItem(src, item)
    local data = {}
    data.objectId = CreateObjectId()
    data.type = item.name
    data.command = false
    data.slot = item.slot

    if item.name == 'spikestrip' then Spikes[data.objectId] = {ignore = true, pending = true} else Objects[data.objectId] = {ignore = true, pending = true} end

    TriggerClientEvent('r14-obj:client:castobject', src, data)
end

local function GenerateSafeCode()
    local code = {math.random(1, 60), math.random(1, 60), math.random(1, 60), math.random(1, 60)}

    return code
end

------------ dev event handlers ------------------------

AddEventHandler('r14-obj:server:CreateCustomObject', function(name, objdata) -- this event allows you to create custom objects
    if not Config.Objects[name] then
        Config.Objects[name] = objdata
        Config.Objects[name].thirdParty = true
        
        TriggerClientEvent('r14-obj:server:UpdateObjectConfig', -1, name, objdata)
        if not objdata.noitem then
            QBCore.Functions.CreateUseableItem(name, function(source, item)
                local src = source
                CreateUseableObjectItem(src, item)
            end)
        end

    else
        print('Attempt to add custom object to r14-objects failed. Object name already exists in config.')
    end
end)

------------ object creation functions ---------------------


RegisterNetEvent('r14-obj:server:spawncustomobject', function(data) -- this event allows the admin menu to spawn custom objects
    src = source

    if ActiveAdmins[src] then
        data.objectId = CreateObjectId()
        data.type = 'adminobject'
        data.command = true

        Objects[data.objectId] = {ignore = true, pending = true}

        TriggerClientEvent('r14-obj:client:castobject', src, data)
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted an exploit. Attempted to create admin object.'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Item Exploit (r14-objects)', 'red', ('%s potentially attempted an exploit. Attempted to admin object without server authorization'):format(src), false) 
        return
    end
end)


RegisterNetEvent('r14-obj:server:CheckObjectId', function(data)
    if Config.Debug.Print.enabled then print(("In check object ID: %s"):format(json.encode(data))) end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not data.command then
        Player.Functions.RemoveItem(data.type, 1, data.slot)
    end

    if not Objects[data.objectId] and not Spikes[data.objectId] then    
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted an exploit. Attempted to create %s without server authorized objectID'):format(src, data.type))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Item Exploit (r14-objects)', 'red', ('%s potentially attempted an exploit. Attempted to create %s without server authorized objectID'):format(src, data.type), false) 
        return
    end

    if (Objects[data.objectId] and not Objects[data.objectId].pending) or (Spikes[data.objectId] and not Spikes[data.objectId].pending) then    
        local prexisting = Objects[data.objectId].type
        if Spikes[data.objectId] then prexisting = 'spikestrip' end
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted an exploit. Attempted to recreate %s %s as %s'):format(src, data.objectId, text, data.type))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Item Exploit (r14-objects)', 'red', ('%s potentially attempted an exploit. Attempted to recreate %s %s as %s'):format(src, data.objectId, prexisting, data.type), false) 
        return
    end

    data.bucket = GetPlayerRoutingBucket(tostring(src))

    if Config.Objects[data.type].locks then
        Player.Functions.AddItem('containerkey', 1, data.slot, {objectId = data.objectId})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['containerkey'], "add")
        Player.Functions.RemoveItem('storagecontract', 1, data.slot, {objectId = data.objectId})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['storagecontract'], "remove")
    end

    if Config.Objects[data.type].safe then
        local code = GenerateSafeCode()
        local label = ("Safe Code: %s-%s-%s-%s"):format(code[1], code[2], code[3], code[4])

        data.code = code
        data.funds = 0

        info = {
            label = label,
        }

        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = false,
            args = {"Code Entered:", label}
        })

        Player.Functions.AddItem("stickynote", 1, false, info)

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stickynote'], "add")
        Player.Functions.RemoveItem('storagecontract', 1, data.slot, {objectId = data.objectId})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['storagecontract'], "remove")
    end

    if data.type == 'spikestrip' then
        TriggerEvent('r14-obj:server:SyncSpikes', data)
        data.throw = true
    else
        if data.overnight or Config.Objects[data.type].overnight then 
            TriggerEvent('r14-obj:server:OvernightObjects', data)
            Config.Functions.ServerNotify(src, (Config.Messages.OvernightPlacement):format(Config.Objects[data.type].label))
            return
        else
            TriggerEvent('r14-obj:server:SyncObjects', data)
        end
    end

    if Config.Objects[data.type].music then
        TriggerEvent('r14-obj:server:syncplayer', data.objectId)
    end

    TriggerClientEvent('r14-obj:client:createobject', -1, data)
end)

AddEventHandler('r14-obj:server:OvernightObjects', function(data)
    if Config.Debug.Print.enabled then print(("In overnight objects: %s"):format(json.encode(data))) end

    local time = data.persist or Config.Objects[data.type].persist or Config.DB.MinTime
    local customConfig = nil
    local subentities = {}

    if data.length then
        time = os.time() + (60 * 60 * 24 * 7 * data.length)
    else
        if data.persist or Config.Objects[data.type].persist or Config.DB.MinTime > 0 then
            time = os.time() + (time * 60 * 60 * 24)
        else
            time = nil
        end
    end
    
    if Config.Objects[data.type].thirdParty then
        customConfig = Config.Objects[data.type]
    end

    if Config.Objects[data.type].subentities then
        for k, v in pairs(Config.Objects[data.type].subentities) do
            subentities[k] = {exists = true}
        end
    end

    OvernightObjects[data.objectId] = {
        objectId = data.objectId,
        type = data.type,
        originalType = data.type,
        coords = data.coords,
        rotation = data.rotation,
        cid = data.cid,
        groundz = data.groundz,
        speedzone = data.speedzone,
        bucket = data.bucket,
        subentities = data.subentities or subentities,
        time = data.time or time,
        created = data.purchased or os.time(),
        maxtime = data.maxtime or (os.time() + (Config.DB.MaxTime * 60 * 60 * 24)),
        locked = data.locked,
        vendor = data.vendor,
        registered = data.registered,
        oldId = data.oldId,
        thirdParty = Config.Objects[data.type].thirdParty,
        customConfig = customConfig,
        model = data.model,
        freeze = data.freeze,
        vehicles = data.vehicles,
        code = data.code,
        funds = data.funds,
    }

    Objects[data.objectId] = {ignore = true}

    UpdateDB()
end)

AddEventHandler('r14-obj:server:SyncObjects', function(data, ignoresync)
    if Config.Debug.Print.enabled then print(("In server sync objects: %s"):format(json.encode(data)), 'ignore database sync', ignoresync) end

    local time = data.persist or Config.Objects[data.type].persist or Config.DB.MinTime
    local customConfig = nil
    local subentities = {}

    if not data.time then
        if data.persist or Config.Objects[data.type].persist or Config.DB.MinTime > 0 then
            time = os.time() + (time * 60 * 60 * 24)
        else
            time = nil
        end    
    else
        time = data.time
    end

    if Config.Objects[data.type].thirdParty then
        customConfig = Config.Objects[data.type]
    end

    if Config.Objects[data.type].subentities then
        for k, v in pairs(Config.Objects[data.type].subentities) do
            subentities[k] = {exists = true}
        end
    end

    Objects[data.objectId] = {
        objectId = data.objectId,
        type = data.type,
        originalType = data.type,
        coords = data.coords,
        rotation = data.rotation,
        cid = data.cid,
        groundz = data.groundz,
        speedzone = data.speedzone,
        subentities = data.subentities or subentities,
        bucket = data.bucket,
        created = data.created or os.time(),
        time = data.time or time,
        maxtime = data.maxtime or (os.time() + (Config.DB.MaxTime * 60 * 60 * 24)),
        locked = data.locked,
        vendor = data.vendor,
        registered = data.registered,
        thirdParty = Config.Objects[data.type].thirdParty,
        customConfig = customConfig,
        model = data.model,
        freeze = data.freeze,
        vehicles = data.vehicles,
        code = data.code,
        funds = data.funds,
    }
    
    if not ignoresync then UpdateDB() end
end)

AddEventHandler('r14-obj:server:SyncSpikes', function(data)
    if Config.Debug.Print.enabled then print(("In server sync spikes: %s"):format(json.encode(data))) end

    Spikes[data.objectId] = {
        objectId = data.objectId,
        type = data.type,
        coords = data.coords,
        rotation = data.rotation,
        cid = data.cid,
        groundz = data.groundz,
        speedzone = data.speedzone,
        bucket = data.bucket,
    }

    UpdateDB()
end)

RegisterNetEvent('r14-obj:server:loadobjects', function()  
    local src = source
    local count = 0
    local objpack = {}

    while not loaded do
        Wait(1000)
    end

    count = 0

    if next(Spikes) then
        for k, v in pairs(Spikes) do
            if not v.ignore then
                objpack[k] = v
                count = count + 1

                if count >= 100 then
                    TriggerClientEvent('r14-obj:client:bulkcreate', src, objpack)
                    objpack = {}
                    count = 0
                    if true or Config.Debug.Print.enabled then print(("Loading object for %s: %s"):format(src, json.encode(data))) end
                end
            end
        end
    end
    if next(Objects) then
        for k, v in pairs(Objects) do
            if not v.ignore then
                objpack[k] = v
                count = count + 1

                if count >= 100 then
                    TriggerClientEvent('r14-obj:client:bulkcreate', src, objpack)
                    objpack = {}
                    count = 0
                    if true or Config.Debug.Print.enabled then print(("Loading spike for %s: %s"):format(src, json.encode(data))) end
                end
            end
        end
    end

    if next(objpack) then
        TriggerClientEvent('r14-obj:client:bulkcreate', src, objpack)
    end
end)

---------- object deletion events -----------------------

RegisterNetEvent('r14-obj:server:deleteObject', function(objectId, noitem, broken)
    local Player = QBCore.Functions.GetPlayer(source)
    local returnItem = nil

    if not Objects[objectId] then return end

    if broken and not noitem then returnItem = Config.Objects[Objects[objectId].type].broken else returnItem = Objects[objectId].type end
    if noitem then returnItem = nil end

    if not returnItem or (returnItem and Player.Functions.AddItem(returnItem, 1)) then
        if Config.Objects[Objects[objectId].type].inventory then 
            TriggerEvent('r14-obj:server:CreateDrop', objectId)
        end

        Objects[objectId] = nil
        if Bombs[objectId] then
            Bombs[objectId] = nil
        end
        if MusicPlayers[objectId] then
            xSound:Destroy(-1, objectId)
            MusicPlayers[objectId] = nil
        end
        UpdateDB()
        TriggerClientEvent('r14-obj:client:removeObject', -1, objectId)
    else
        Config.Functions.ServerNotify(source, Config.Messages.Overweight)
    end
end)

RegisterNetEvent('r14-obj:server:deleteSpike', function(objectId, noitem)  
    local Player = QBCore.Functions.GetPlayer(source)

    if not Spikes[objectId] then return end

    if noitem or Player.Functions.AddItem('spikestrip', 1) then
        Spikes[objectId] = {}
        Config.Functions.ServerNotify(source, Config.Messages.ResumeTraffic)
        TriggerClientEvent('r14-obj:client:removeSpike', -1, objectId)
    else
        Config.Functions.ServerNotify(source, Config.Messages.Overweight)
    end
end)

------------ item events ----------------

RegisterNetEvent('r14-obj:server:ReturnItem', function(item, amount, broken) -- this event will only return object items to players, it will not give them anything else
    local src = source

    if Config.Objects[item] then      
        local Player = QBCore.Functions.GetPlayer(src)
        local get = item
       
        if broken then get = Config.Objects[item].broken end
       
        if Player.Functions.AddItem(get, amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[get], "add")
        else
            Config.Functions.ServerNotify(src, Config.Messages.Overweight)
        end
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted item exploit. Attempted to acquire %s %s using ReturnItem event!'):format(src, amount, item))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Item Exploit (r14-objects)', 'red', ('%s potentially attempted item exploit. Attempted to acquire %s %s using ReturnItem event!'):format(src, amount, item), false)
    end
end)

RegisterNetEvent('r14-obj:server:CreateDrop', function(objectId)
    local src = source
	local items = {}
    local coords = vector3(Objects[objectId].coords.x, Objects[objectId].coords.y, Objects[objectId].coords.z + 0.5)


	local result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {Objects[objectId].type .. objectId})
	if not result then return items end

	local stashItems = json.decode(result)
	if not stashItems then return items end

	for _, item in pairs(stashItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				slot = item.slot,
			}
		end
	end

    TriggerEvent('inventory:server:CreateDrop', items,  coords, src)
end)

------------------------- bomb events -------------------------

RegisterNetEvent('r14-obj:server:armBomb', function(objectId, timer, color, code)
    local time = os.time() + timer

    Bombs[objectId] = {
        time = time,
        color = color,
        code = code,
        cut = 0,
        coords = Objects[objectId].coords,
    }

    Objects[objectId].detonated = false

    TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'arm', color, code)

end)

RegisterNetEvent('r14-obj:server:modifyTimer', function(objectId, fraction, color)
    if Bombs[objectId] then
        local timereduction = math.floor((Bombs[objectId].time - os.time()) * fraction)
        Bombs[objectId].time = Bombs[objectId].time - timereduction
        if color then
            Bombs[objectId].cut = Bombs[objectId].cut + 1
            if Bombs[objectId].cut == Config.Bomb.MaxAttempts then
                local coords = Bombs[objectId].coords
                Objects[objectId].detonated = true
                TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'detonate')
                TriggerEvent('r14-obj:server:deleteObject', objectId, true)
                TriggerEvent('r14-obj:server:secondaryexplosions', objectId, coords)
            else
                TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'cutwire', color)    
            end
        end
    end
end)

RegisterNetEvent('r14-obj:server:CheckTimer', function(data)
    local src = source
    local remaining = Bombs[data.objectId].time - os.time()
    local notifytext = ''

    if remaining > 59 then
        minutes = math.floor(remaining / 60)
        seconds = remaining % 60 
        if seconds < 10 then
            notifytext = ('%s:0%s remaining'):format(minutes, seconds)
        else
            notifytext = ('%s:%s remaining'):format(minutes, seconds)
        end
    else
       notifytext = ('%s seconds remaining'):format(remaining)
    end

    Config.Functions.ServerNotify(src, notifytext)
end)

RegisterNetEvent('r14-obj:server:disarmBomb', function(data)
    Bombs[data.objectId] = nil
    TriggerClientEvent('r14-obj:client:syncBomb', -1, data.objectId, 'disarm')
end)

RegisterNetEvent('r14-obj:server:diffuseBomb', function(objectId)
    Bombs[objectId] = nil
    TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'diffuse')
end)

RegisterNetEvent('r14-obj:server:CorrectWire', function(objectId)
    TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'diffusable')
end)

RegisterNetEvent('r14-obj:server:secondaryexplosions', function(objectId, detcoords)
    for k, v in pairs(Objects) do
        if v.type == 'bomb' and objectId ~= k and #(detcoords - v.coords) < 5 and not Objects[k].detonated then
            Objects[k].detonated = true
            local coords = Objects[k].coords
            Wait(200)
            TriggerClientEvent('r14-obj:client:syncBomb', -1, k, 'detonate')
            TriggerEvent('r14-obj:server:deleteObject', k, true)

            TriggerEvent('r14-obj:server:secondaryexplosions', k, coords)
        end
    end
end)   

---------------------------- commands -----------------------------
-- these commands allow you to clear objects

QBCore.Commands.Add('clearspikes', '[OOC] Open menu to clear scuffed spike strips (This is logged).', {}, true, function(source, args)
    local src = source
    local data = {}
    data.spike = true

    TriggerClientEvent('r14-obj:client:clearcommand', src, data)
end)

QBCore.Commands.Add('clearobjects', '[OOC] Open menu to clear scuffed objects (This is logged).', {}, true, function(source, args)
    local src = source
    local data = {}

    TriggerClientEvent('r14-obj:client:clearcommand', src, data)
end)

QBCore.Commands.Add('r14obj', '[OOC] Manage objects from admin menu.' , {}, false, function(source, args)
    local src = source

    ActiveAdmins[src] = true

    TriggerClientEvent('r14-obj:client:adminmenu', src)
end, 'admin')

QBCore.Commands.Add('object', 'Spawn an object from config. [admin only].' , {}, false, function(source, args)
    local src = source
    local spawn = args[1]
    
    if not Config.Objects[spawn] then
        Config.Functions.ServerNotify(src, 'Object not in config!', 'error')       
        return
    end

    local data = {}
    data.objectId = CreateObjectId()
    data.type = args[1]
    data.command = true

    if spawn == 'spikestrip' then Spikes[data.objectId] = {ignore = true, pending = true} else Objects[data.objectId] = {ignore = true, pending = true} end

    TriggerClientEvent('r14-obj:client:castobject', src, data)

end, 'admin')

------------------------ command events ------------------------

RegisterNetEvent('r14-obj:server:logRemoval', function(objectId)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData

    if Config.AdminAlert then
        local Players = QBCore.Functions.GetPlayers()
        local name = PlayerData.charinfo.firstname..' '.. PlayerData.charinfo.lastname
        for k, v in pairs(Players) do
            if QBCore.Functions.HasPermission(v, 'admin') then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chat:addMessage', v, {
                        color = {255, 215, 0},
                        multiline = true,
                        args = {'Admin Log:', ('%s (%s) used /clearspikes'):format(name, src)}
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('r14-obj:server:adminclear', function(data)
    if data.choice == 'spike strips' then
        for k, v in pairs(Spikes) do
            TriggerClientEvent('r14-obj:client:removeSpike', -1, k)
            Spikes[k] = nil
        end
    else
        for k, v in pairs(Objects) do
            if Config.Objects[v.type].inventory then
                TriggerEvent('qb-log:server:CreateLog', 'lostitems', 'Items lost in object clear.', 'red', 'Items located in stash '..v.type..k, false)
            end

            TriggerClientEvent('r14-obj:client:removeObject', -1, k)

            Objects[k] = nil
        end
    end

    UpdateDB(true)
end)

-------------- create usable items --------------------------
-- this for loop goes through the Config.Objects list and creates usable items
-- unless you specify that it is not usable

for k, v in pairs(Config.Objects) do
    if not v.noitem then
        QBCore.Functions.CreateUseableItem(k, function(source, item)
            local src = source
            CreateUseableObjectItem(src, item)
        end)
    end
end

----------------- crafting events -------------------------

RegisterNetEvent('r14-obj:server:checkreqs', function(data)
    local src = source
    local caughtlacking = false
    local ply = QBCore.Functions.GetPlayer(src)

    if not Objects[data.objectId] then 
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted an exploit. Attempted to craft using %s which does not exist serverside'):format(src, data.type))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Item Exploit (r14-objects)', 'red', ('%s potentially attempted item exploit. Attempted to craft %s using %s which does not exist serverside!'):format(src, data.give, data.object), false) 
        return 
    end

    if Config.Objects[data.object].give[data.give].req then
        for k, v in pairs(Config.Objects[data.object].give[data.give].req) do
            local checkitem = ply.Functions.GetItemByName(k)
            if not checkitem or (checkitem and v > checkitem.amount) then
                caughtlacking = true 
            end
        end
    end

    if not caughtlacking then
        TriggerClientEvent('r14-obj:client:craft', src, data)
    else
        Config.Functions.ServerNotify(src, Config.Messages.NoIngredients)        
    end
end)


RegisterNetEvent('r14-obj:server:craftitem', function(data)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local caughtlacking = false

    if Config.Objects[data.object] and Config.Objects[data.object].give[data.give] then 
        if Config.Objects[data.object].give[data.give].req then                     

            for k, v in pairs(Config.Objects[data.object].give[data.give].req) do
                local checkitem = ply.Functions.GetItemByName(k)

                if not checkitem or (checkitem and v > checkitem.amount) then
                    caughtlacking = true 
                end
            end

            if not caughtlacking then
                for k, v in pairs(Config.Objects[data.object].give[data.give].req) do
                    ply.Functions.RemoveItem(k, v)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "remove")
                end

                ply.Functions.AddItem(data.give, Config.Objects[data.object].give[data.give].get)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.give], "add")
            else
                Config.Functions.ServerNotify(src, Config.Messages.NoIngredients)
            end
        else
            ply.Functions.AddItem(data.give, Config.Objects[data.object].give[data.give].get)
        end   
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted item exploit. Attempted to acquire %s using %s'):format(src, data.give, data.object))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potential Item Exploit (r14-objects)', 'red', ('%s potentially attempted item exploit. Attempted to acquire %s using %s'):format(src, data.give, data.object), false)
    end
end)

---------------- bomb thread ------------------------------
-- this thread manages active bombs, keeping track of their remainingtime, playing beeps for players
-- nearby, and detonating them when they reach the timer

CreateThread(function()
    while true do
        Wait(1000)
        if Bombs ~= {} then
            local time = os.time()

            for k, v in pairs(Bombs) do
                local remaining = v.time - time
                if remaining > 60 then
                    if remaining % 2 == 0 then                
                        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, Objects[k].coords, 20.0, 'beep', 0.2)
                    end
                else
                    TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, Objects[k].coords, 20.0, 'beep', 0.2)
                end

                if time >= v.time then
                    TriggerClientEvent('r14-obj:client:syncBomb', -1, k, 'detonate')

                    Bombs[k] = nil

                    TriggerEvent('r14-obj:server:secondaryexplosions', k, v.coords)

                    TriggerEvent('r14-obj:server:deleteObject', k, true)
                end
            end
        end
    end
end)

------------- music player events -----------------

RegisterNetEvent('r14-obj:server:syncplayer', function(objectId, volume)
    local src = source
    local vol = volume or Config.Music.DefaultVolume

    MusicPlayers[objectId] = true

    TriggerClientEvent('r14-obj:client:updateplayer', -1, objectId, 'update', vol)
end)

RegisterNetEvent('r14-obj:server:playmusic', function(data)
    local src = source

    xSound:PlayUrlPos(-1, data.objectId, data.song, (data.volume / 1000) or (Config.Music.DefaultVolume / 1000), vector3(data.coords.x, data.coords.y, data.coords.z))
    xSound:Distance(-1, data.objectId, Config.Music.MusicDist)

    TriggerClientEvent('r14-obj:client:musicplayer', src, data)
end)

RegisterNetEvent('r14-obj:server:stopmusic', function(data)
    local src = source

    if data.exists then
        xSound:Destroy(-1, data.objectId)
    end
end)

RegisterNetEvent('r14-obj:server:playpause', function(data)
    local src = source
    
    if data.playing then
        xSound:Pause(-1, data.objectId)
    end

    if data.paused then
        xSound:Resume(-1, data.objectId)
    end
    
    TriggerClientEvent('r14-obj:client:musicplayer', src, data)
end)

RegisterNetEvent('r14-obj:server:changevolume', function(data)
    local src = source
    local newvolume = data.volume

    if not data.knob then 
        if data.increase then 
            newvolume = newvolume + Config.Music.VolumeStep
        else
            newvolume = newvolume - Config.Music.VolumeStep
        end
    end  

    if newvolume < 0 then newvolume = 0 end
    if newvolume > 1000 then newvolume = 1000 end

    if data.exists then
        xSound:setVolume(-1, data.objectId, newvolume / 1000)
    end

    TriggerClientEvent('r14-obj:client:updateplayer', -1, data.objectId, 'update', newvolume)
    TriggerClientEvent('r14-obj:client:musicplayer', src, data)
end)


---------------------- container events ----------------------------

RegisterNetEvent('r14-obj:server:transactsafefunds', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if #(GetEntityCoords(GetPlayerPed(tostring(src))) - Objects[data.objectId].coords) < 10 then
        if data.deposit then
            if Player.Functions.RemoveMoney('cash', data.amount) then
                Objects[data.objectId].funds = Objects[data.objectId].funds + data.amount
                Config.Functions.ServerNotify(src, (Config.Messages.Deposited):format(data.amount), 'success')                
            end
        else
            amount = data.amount

            if amount > Objects[data.objectId].funds then amount = Objects[data.objectId].funds end

            if Objects[data.objectId].funds >= amount then
                Objects[data.objectId].funds = Objects[data.objectId].funds - amount

                if Objects[data.objectId].funds < 0 then Objects[data.objectId].funds = Objects[data.objectId].funds + amount return end

                Player.Functions.AddMoney('cash', amount)
                Config.Functions.ServerNotify(src, (Config.Messages.Withdrawn):format(amount), 'success')
            end
        end
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted to access safe funds they should not have been able to see'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted to %s %s from %s\'s safe funds using an exploit.'):format(src, data.depsoit and 'deposit' or 'withdraw', data.amount, data.objectId), false)
    end
    UpdateDB(true)
end)

RegisterNetEvent('r14-obj:server:policeopensafe', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Config.AuthorizedJobs.LEO.Check(src) or #(GetEntityCoords(GetPlayerPed(tostring(src))) - Objects[data.objectId].coords) < 10 then
        Objects[data.objectId].locked = false          
        Objects[data.objectId].subentities[data.subent].opened = true 
        data.object =  Objects[data.objectId].type

        TriggerClientEvent('r14-obj:client:opendooranim', src)
        TriggerClientEvent('r14-obj:client:opendoor', -1, data)
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(tostring(src))), 5, "uncuff", 0.12)
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted to police open safe using an exploit'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted police open safe %s they should not have been able to.'):format(src, data.objectId), false)
    end

    UpdateDB(true)
end)

RegisterNetEvent('r14-obj:server:opendoor', function(data)
    if not Objects[data.objectId].locked then
        TriggerClientEvent('r14-obj:client:opendoor', -1, data)

        if Objects[data.objectId].subentities[data.subent].opened then 
            Objects[data.objectId].subentities[data.subent].opened = false 
        else
            Objects[data.objectId].subentities[data.subent].opened = true 
        end
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted to open door that they should not have been able to see'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted exploit to enter door of %s.'):format(src, data.objectId), false)
    end
    UpdateDB(true)
end)

RegisterNetEvent('r14-obj:server:toggledoorlock', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if #(GetEntityCoords(GetPlayerPed(tostring(src))) - Objects[data.objectId].coords) < 10 then
        if data.unlocking or data.locking then TriggerClientEvent('r14-obj:client:opendooranim', src) end

        if data.unlocking and Objects[data.objectId].locked then
            Objects[data.objectId].locked = false          

            TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(tostring(src))), 5, "uncuff", 0.12)
        elseif data.locking and not Objects[data.objectId].locked then
            Objects[data.objectId].locked = true
            TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(tostring(src))), 5, "uncuff", 0.12)
        end
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted to open door that they should not have been able to see'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted toggle door lock of %s using an exploit.'):format(src, data.objectId), false)
    end
    UpdateDB(true)
end)

RegisterNetEvent('r14-obj:server:cutdoorlock', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if #(GetEntityCoords(GetPlayerPed(tostring(src))) - Objects[data.objectId].coords) < 10 then
        if Objects[data.objectId].locked then
            Objects[data.objectId].locked = false
        end
    else
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        print(('%s potentially attempted to open door that they should not have been able to see'):format(src))
        TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted to cut lock of %s using an exploit.'):format(src, data.objectId), false)
    end
    UpdateDB(true)
end)

RegisterNetEvent('r14-obj:server:syncsparks', function(netid, pos)
    TriggerClientEvent('r14-obj:client:playsparks', -1, netid, pos)
end)

RegisterNetEvent('r14-obj:server:updatevehicles',function(data, remove)   
    local veh = NetworkGetEntityFromNetworkId(data.netid)
    local plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(veh))

    if remove then

        if Objects[data.objectId] and Objects[data.objectId].type == 'garage_container' then
            if Objects[data.objectId].vehicles then
                Objects[data.objectId].vehicles[plate] = nil
            end

            MySQL.update('UPDATE player_vehicles SET state = ?, garage = ? WHERE plate = ?', {0, 'NULL', plate})

            UpdateDB()

            TriggerClientEvent('r14-obj:client:updatevehicles', -1, data, remove)
        end
    else
        if Objects[data.objectId] and Objects[data.objectId].type == 'garage_container' then
            data.coords = GetEntityCoords(veh)
            data.rotation = GetEntityRotation(veh)
            data.plate = plate

            if Objects[data.objectId].vehicles then
                Objects[data.objectId].vehicles[plate] = {
                    model = data.model,
                    coords = data.coords,
                    rotation = data.rotation,
                    props = data.props,
                }
            else
                Objects[data.objectId].vehicles = {
                    [plate] = {
                        model = data.model,
                        coords = data.coords,
                        rotation = data.rotation,
                        props = data.props,
                    }
                }
            end

            MySQL.update('UPDATE player_vehicles SET state = ?, garage = ? WHERE plate = ?', {1, 'NULL', plate})

            UpdateDB()

            TriggerClientEvent('r14-obj:client:updatevehicles', -1, data)
        end

    end
end)

RegisterNetEvent('r14-obj:server:requestveh', function(data)   
    if RecentlySpawned[data.plate] then
        if RecentlySpawned[data.plate] - os.time() > 0 then
            return
        else
            RecentlySpawned[data.plate] = nil
        end
    end

    local allVehs = GetAllVehicles()
    local found = false
    
    for k, v in pairs(allVehs) do
        local checkPlate = QBCore.Shared.Trim(GetVehicleNumberPlateText(v))

        if data.plate == checkPlate then found = true end
    end

    if not found and Objects[data.objectId] and Objects[data.objectId].type == 'garage_container' and Objects[data.objectId].vehicles and Objects[data.objectId].vehicles[data.plate] then       
        local spawndata = {
            objectId = data.objectId,
            plate = data.plate,
            model = Objects[data.objectId].vehicles[data.plate].model,
            coords = Objects[data.objectId].vehicles[data.plate].coords,
            props = Objects[data.objectId].vehicles[data.plate].props,
            rotation = Objects[data.objectId].vehicles[data.plate].rotation,
        }

        TriggerClientEvent('r14-obj:client:spawnveh', source, spawndata)

        RecentlySpawned[data.plate] = os.time() + 5
    end
end)

------------------- vendor events -------------------------

RegisterNetEvent('r14-obj:server:createcontract', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.items[data.slot].info[Config.Containers.ValidID[Player.PlayerData.items[data.slot].name].cid] ~= data.cid then
        print(('Player %s may have attempted exploit, CID sent to server event does not match ID in inventory. Canceling vendor transaction.'):format(src))
        Config.Functions.ServerNotify(src, Config.Messages.Report)
        return
    end

    local cost = Config.Containers.Vendors[data.vendor].inventory[data.type].price

    if Player.Functions.RemoveMoney(data.tender, cost) then
        local info = {
            vendor = data.vendor,
            type = data.type,
            owner = Player.PlayerData.citizenid,
            registered = {first = data.first, last = data.last, cid = data.cid},
            length = Config.Containers.Vendors[data.vendor].inventory[data.type].length,
            purchased = os.time(),
        }

        if Player.Functions.AddItem('storagecontract', 1, false, info) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['storagecontract'], "add")
        else
            Player.Functions.AddMoney(data.tender, cost)
            Config.Functions.ServerNotify(src, Config.Messages.Overweight)
            Config.Functions.ServerNotify(src, Config.Messages.Refund)
        end
    end
end)

RegisterNetEvent('r14-obj:server:vendorextendtime', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cost = Config.Containers.Vendors[data.vendor].inventory[data.type].price

    if Player.Functions.RemoveMoney(data.tender, cost) then
        local newTime = Objects[data.objectId].time + (Config.Containers.Vendors[Objects[data.objectId].vendor].inventory[Objects[data.objectId].originalType].length * 60 * 60 * 24 * 7)
        Objects[data.objectId].time = newTime
        if Objects[data.objectId].pendingId then OvernightObjects[data.objectId].time = newTime end
        Config.Functions.ServerNotify(src, (Config.Messages.VendorExtend):format(os.date("%x", Objects[data.objectId].time)))
    end

    UpdateDB()
end)

RegisterNetEvent('r14-obj:server:vendorchangelocks', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    cost = Config.Containers.Vendors[data.vendor].rekey or Config.Containers.VendorDefaults.rekey

    if Player.Functions.RemoveMoney(data.tender, cost) then
        local newObjectId = CreateObjectId()
        local newObject = Objects[data.objectId] or OvernightObjects[data.objectId]

        newObject.objectId = newObjectId
        newObject.oldId = data.objectId

        Objects[data.objectId].pendingId = newObjectId

        Player.Functions.AddItem('containerkey', 1, false, {objectId = newObjectId})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['containerkey'], "add")
        TriggerEvent('r14-obj:server:OvernightObjects', newObject)
        Config.Functions.ServerNotify(src, Config.Messages.VendorRekey)
    end
end)

RegisterNetEvent('r14-obj:server:vendorduplicatekey', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    cost = Config.Containers.Vendors[data.vendor].duplicateKey or Config.Containers.data.duplicateKey

    if Player.Functions.RemoveMoney(data.tender, cost) then
        Player.Functions.AddItem('containerkey', 1, false, {objectId = data.objectId})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['containerkey'], "add")
    end

    UpdateDB()
end)



RegisterNetEvent('r14-obj:server:vendorbreakcontract', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
    cost = Config.Containers.Vendors[data.vendor].breakLeaseCost or Config.Containers.VendorDefaults.breakLeaseCost
   
    if Player.Functions.RemoveMoney(data.tender, cost) then
        if Objects[data.objectId] then
            Objects[data.objectId].time = os.time()

            UpdateDB()
        else
            OvernightObjects[data.objectId].ignore = true
            
         end
    end
end)

QBCore.Functions.CreateUseableItem('storagecontract', function(source, item) -- container contract item, allows you to place it 
    local src = source
    local data = {}
   
    data.objectId = CreateObjectId() -- allows storage contracts to be used to reposition an object
    data.type, data.slot, data.owner = item.info.type, item.slot, item.info.owner
    data.vendor, data.registered, data.purchased = item.info.vendor, item.info.registered, item.info.purchased
    data.length, data.time, data.noKey = item.info.length, item.info.time, item.info.noKey
    data.overnight = false

    Objects[data.objectId] = {ignore = true, pending = true}
    TriggerClientEvent('r14-obj:client:castobject', src, data)
end)

----------------------- callbacks -------------------------------

QBCore.Functions.CreateCallback('r14-obj:GetLockedStatus', function(source, cb, objectId)
    cb(Objects[objectId].locked)
end)

QBCore.Functions.CreateCallback('r14-obj:GetSafeFunds', function(source, cb, objectId)
    cb(Objects[objectId].funds or 0)
end)

QBCore.Functions.CreateCallback('r14-obj:CheckSafeCode', function(source, cb, data)
    local retval = false
    local mismatch = false

    for k, v in pairs(Objects[data.objectId].code) do
        if v ~= data.code[k] then mismatch = true end
    end

    if not mismatch then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        if #(GetEntityCoords(GetPlayerPed(tostring(src))) - Objects[data.objectId].coords) < 10 then
            Objects[data.objectId].locked = false          
            Objects[data.objectId].subentities[data.subent].opened = true 
            data.object =  Objects[data.objectId].type

            TriggerClientEvent('r14-obj:client:opendooranim', src)
            TriggerClientEvent('r14-obj:client:opendoor', -1, data)
            TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(tostring(src))), 5, "uncuff", 0.12)
        else
            Config.Functions.ServerNotify(src, Config.Messages.Report)
            print(('%s potentially attempted to open safe that they should not have been able to see'):format(src))
            TriggerEvent('qb-log:server:CreateLog', 'anticheat', 'Potenial Exploit (r14-objects)', 'red', ('%s potentially attempted exploit to open safe of %s.'):format(src, data.objectId), false)
        end

        UpdateDB(true)
    else
        Config.Functions.ServerNotify(source, Config.Messages.IncorrectCombo, 'error')
    end

    cb(retval)
end)

QBCore.Functions.CreateCallback('r14-obj:CheckVehExists', function(source, cb, plate)
    local allVehs = GetAllVehicles()
    local found = false
    
    for k, v in pairs(allVehs) do
        local checkPlate = QBCore.Shared.Trim(GetVehicleNumberPlateText(v))

        if plate == checkPlate then found = true end
    end

    cb(found)
end)

QBCore.Functions.CreateCallback('r14-obj:GetOwned', function(source, cb, query)
    local ownedlist = {}

    for k, v in pairs(Objects) do
        if v.registered and v.registered.cid == query.cid and v.vendor == query.vendor then
           ownedlist[k] = {purchased = os.date("%x", v.created), expires = os.date("%x", v.time)}
        end
    end

    for k, v in pairs(OvernightObjects) do
        if not v.oldId and v.registered and v.registered.cid == query.cid and v.vendor == query.vendor  then
           ownedlist[k] = {purchased = os.date("%x", v.created), expires = os.date("%x", v.time)}
        end
    end

    cb(ownedlist)
end)

QBCore.Functions.CreateCallback('r14-obj:GetUnitInfo', function(source, cb, unitnumber)
    local unit = Objects[unitnumber] or OvernightObjects[unitnumber]
    local canRenew, weeks, newDate, discontinued, cost, locksChanging = false, nil, nil, nil, nil, nil

    if unit.time - os.time() < (60 * 60 * 24 * 7 * Config.Containers.Vendors[unit.vendor].minRenewal) then
        if Config.Containers.Vendors[unit.vendor].inventory[unit.originalType] then
            canRenew = true
            weeks = Config.Containers.Vendors[unit.vendor].inventory[unit.originalType].length
            newDate = unit.time + (Config.Containers.Vendors[unit.vendor].inventory[unit.originalType].length * 60 * 60 * 24 * 7)
            cost = Config.Containers.Vendors[unit.vendor].inventory[unit.originalType].price
        else
            discontinued = true
        end
    end

    if Objects[unitnumber].pendingId then
        locksChanging = true
    end

    local unitInfo = {
        objectId = unitnumber,
        vendor = unit.vendor,
        coords = unit.coords,
        original = unit.originalType,
        purchased = os.date("%x", unit.created), 
        expires = os.date("%x", unit.time), 
        canRenew = canRenew, 
        locksChanging = locksChanging,
        weeks = weeks, 
        newDate = os.date("%x", newDate), 
        discontinued = discontinued, 
        cost = cost,
        breakLease = Config.Containers.Vendors[unit.vendor].breakLeaseCost,
    }

    cb(unitInfo)
end)

QBCore.Functions.CreateCallback('r14-obj:RecordsRequest', function(source, cb, search)
    local searchlist = {}

    for k, v in pairs(Objects) do
        if v.vendor == search.vendor and v.registered and VendorSearch(search, v.registered, k) then
            searchlist[k] = {cid = v.registered.cid, name = ('%s %s'):format(v.registered.first, v.registered.last), originalType = v.originalType, purchased = os.date("%x", v.created), expires = os.date("%x", v.time)}
        end
    end

    for k, v in pairs(OvernightObjects) do
        if not v.oldId and v.vendor == search.vendor and v.registered and VendorSearch(search, v.registered, k) then
           searchlist[k] = {cid = v.registered.cid, name = ('%s %s'):format(v.registered.first, v.registered.last), originalType = v.originalType, purchased = os.date("%x", v.created), expires = os.date("%x", v.time)}
        end
    end

    cb(searchlist)
end)

------------- bucket fetch thread -------------------

CreateThread(function()
    while true do
        local serverplayers = GetPlayers()
        local srclist = {}

        for k, v in pairs(serverplayers) do
            srclist[v] = true   
        end

        for k, v in pairs(srclist) do
            local src = k
            local bucket = GetPlayerRoutingBucket(tostring(src))

            if ActivePlayers[src] and bucket ~= ActivePlayers[src] then
                TriggerClientEvent('r14-obj:client:SetBucket', src, bucket)
            end

            ActivePlayers[src] = bucket
        end 

        for k, v in pairs(ActivePlayers) do
            if not srclist[k] then
                ActivePlayers[k] = nil
            end
        end

        Wait(1000)
    end
end)
