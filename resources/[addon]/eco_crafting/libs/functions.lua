function createBlip(coords, sprite, color, scale, name)

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)

    return blip
end

function deleteBlip(blipType, id)

    if type(ECO[blipType]) ~= 'table' or next(ECO[blipType]) == nil or id == nil then

        return
    end

    if id == 'all' then

        for _, v in pairs(ECO[blipType]) do

            RemoveBlip(v)
        end

        ECO[blipType] = {}
    else

        id = tonumber(id)
        RemoveBlip(ECO[blipType][id])

        ECO[blipType][id] = nil
    end
end

function inTable(needs, t)

    if t and type(t) == 'table' and next(t) ~= nil then

        for _, v in pairs(t) do

            if v == needs then
                return true
            end
        end
    end

    return false
end

function trim(value)
    if not value then
        return nil
    end
    if type(value) ~= 'string' then
        return value
    end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function numberFormat(number)

    if not tonumber(number) then
        return number
    end

    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1 ")

    return minus .. int:reverse():gsub("^ ", "") .. fraction
end

function moneyFormat(amount)

    local out

    if Config.currency.suffix then

        out = ('%s%s'):format(numberFormat(amount), Config.currency.symbol)
    else

        out = ('%s%s'):format(Config.currency.symbol, numberFormat(amount))
    end

    return out
end

function modelLoader(model)

    if not HasModelLoaded(model) then

        RequestModel(model)
        Wait(100)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

function fxLoader(dict)

    if not HasNamedPtfxAssetLoaded(dict) then

        RequestNamedPtfxAsset(dict)
        Wait(100)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(10)
        end
    end
end

function getPlayer(player)

    if type(player) == 'table' then
        return player
    end
    return tonumber(player) and QBCore.Functions.GetPlayer(tonumber(player)) or false
end

function maxProduct(recipeData, inventory)

    local ingredients = recipeData.ingredients;

    if not ingredients or not next(ingredients) then

        return 0
    end

    local max = 1000;
    local pAmount;
    local playerItems = getInventory(inventory)
    local absAmount = 0

    for ingredient, amount in pairs(ingredients) do

        absAmount = math.abs(amount)
        pAmount = playerItems[ingredient];

        if (pAmount and pAmount >= absAmount) then

            if amount > 0 then

                local result = math.floor(pAmount / absAmount);
                max = (result > max) and max or result
            end
        else

            max = 0;
            break
        end
    end

    return max
end

function countFreeSlots(inventory)

    local free = 0
    local maxSlots = QBCore.Config.Player.MaxInvSlots or Config.maxInventorySlots

    for i = 1, maxSlots do

        if (not inventory[i]) then

            free = free + 1
        end
    end

    return free
end

function getInventoryWeight(inventory)

    local weight = 0

    if not inventory or type(inventory) ~= 'table' or not next(inventory) then
        return 0
    end

    for _, item in pairs(inventory) do

        weight = weight + item.weight * item.amount
    end

    return weight
end

function getRecipeByName(product)

    for profession, recipes in pairs(Config.craftData) do

        for name, recipe in pairs(recipes) do

            if (name == product) then

                return profession, recipe
            end
        end
    end

    return false, false
end

function getIngredientsWeight(recipe)

    local ingredients = recipe.ingredients
    local ingredientsWeight = 0

    if not ingredients or type(ingredients) ~= 'table' or not next(ingredients) then
        return 0
    end

    for item, amount in pairs(ingredients) do

        if amount > 0 then

            ingredientsWeight = ingredientsWeight + (QBCore.Shared.Items[item:lower()].weight * amount or 0)
        end
    end

    return tonumber(ingredientsWeight)
end

function getProductData(inventory, product, recipe)

    local item = QBCore.Shared.Items[product:lower()]
    local amount = tonumber(item.weight * recipe.amount)
    local requiredSlot

    if item.unique then

        requiredSlot = recipe.amount
    else

        requiredSlot = getFirstSlotByItem(inventory, product) and 0 or 1
    end

    return amount, requiredSlot
end

function getFirstSlotByItem(items, itemName)

    if not items then
        return nil
    end

    for slot, item in pairs(items) do

        if item.name:lower() == itemName:lower() then

            return tonumber(slot)
        end
    end

    return nil
end

function getInventory(inventory)

    local playerItems = {}

    if not inventory or type(inventory) ~= 'table' or not next(inventory) then

        return playerItems
    end

    for _, item in pairs(inventory) do

        if not playerItems[item.name] then
            playerItems[item.name] = 0
        end

        playerItems[item.name] = (playerItems[item.name] + item.amount)
    end

    return playerItems
end

function removeItems(itemList, xPlayer)

    if not xPlayer then
        return false
    end

    if not itemList or type(itemList) ~= 'table' then
        return false
    end

    local count, removed
    local items = xPlayer.PlayerData.items
    local ingredientsInfo = {}

    if next(items) == nil then
        return false
    end



    -- check all item exists:
    for itemToRemove, amountToRemove in pairs(itemList) do

        count = 0

        if amountToRemove > 0 then

            for _, item in pairs(items) do

                if item.name:lower() == itemToRemove:lower() then
                    count = count + item.amount
                end
            end

            if count < amountToRemove then
                return false
            end
        end
    end



    -- item remove
    for itemToRemove, amountToRemove in pairs(itemList) do

        if amountToRemove > 0 then

            for _, item in pairs(items) do

                if item.name:lower() == itemToRemove:lower() then

                    -- GET ITEM INFO
                    ingredientsInfo = infoMerge(item.info, ingredientsInfo)

                    if item.amount >= amountToRemove then

                        item.amount = item.amount - amountToRemove
                        amountToRemove = 0

                    elseif item.amount < amountToRemove then

                        amountToRemove = amountToRemove - item.amount

                        item.amount = 0
                    end

                    if amountToRemove == 0 then
                        break
                    end
                end
            end
        end
    end


    -- save inventory
    local temp = {}

    for slot, item in pairs(items) do

        if item.amount > 0 then

            temp[slot] = item
        end
    end

    xPlayer.Functions.SetInventory(temp, true)
    return true, ingredientsInfo
end

function increaseLabor(metaData, amount)

    if not Config.systemMode.labor then
        return false
    end

    metaData.crafting.labor.point = metaData.crafting.labor.point + tonumber(amount)
    metaData.crafting.labor.timestamp = os.time()

    if metaData.crafting.labor.point > Config.laborCap then

        metaData.crafting.labor.point = Config.laborCap
    end
end

function addLabor(player, amount)

    if not Config.systemMode.labor then
        return false
    end

    amount = tonumber(amount)
    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer or not amount then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)

    local basePoint = metaData.crafting.labor.point

    if basePoint >= Config.laborCap then
        return false
    end

    increaseLabor(metaData, amount)

    xPlayer.Functions.SetMetaData('crafting', metaData.crafting)

    if amount > Config.laborIncrease then

        local log = createLog(Config.discordWebhook.labor)

        if log then

            log.putEmbed()
            log.color('yellow')
            log.description(('%s %s **+%s**'):format(Lang:t('increase_labor'),
                    basePoint,
                    amount))
            log.title(('[%s] %s %s (%s) %s'):format(xPlayer.PlayerData.source,
                    xPlayer.PlayerData.charinfo.firstname,
                    xPlayer.PlayerData.charinfo.lastname,
                    xPlayer.PlayerData.name,
                    xPlayer.PlayerData.citizenid))
            log.footer(('/tp %s %s %s'):format(round(xPlayer.PlayerData.position.x, 2),
                    round(xPlayer.PlayerData.position.y, 2),
                    round(xPlayer.PlayerData.position.z, 2)))
            log.send()
        end
    end

    return true
end

function decreaseLabor(metaData, amount)

    if not Config.systemMode.labor then
        return false
    end

    metaData.crafting.labor.point = metaData.crafting.labor.point - amount
    metaData.crafting.labor.timestamp = os.time()

    if metaData.crafting.labor.point < 0 then

        metaData.crafting.labor.point = 0
    end
end

function removeLabor(player, amount)

    amount = tonumber(amount)
    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer or not amount then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)
    decreaseLabor(metaData, amount)

    xPlayer.Functions.SetMetaData('crafting', metaData.crafting)

    return true
end

function getLabor(player)

    if not Config.systemMode.labor then
        return 0
    end

    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)

    return metaData.crafting.labor.point
end

function increaseProficiency(metaData, profession, amount)

    if not Config.systemMode.profession or not metaData.crafting.proficiency[profession] then
        return false
    end

    metaData.crafting.proficiency[profession] = metaData.crafting.proficiency[profession] + amount

    if metaData.crafting.proficiency[profession] > Config.proficiencyCap then

        metaData.crafting.proficiency[profession] = Config.proficiencyCap
    end

    return true
end

function addProficiency(player, profession, amount)

    if not Config.systemMode.profession then
        return false
    end

    amount = tonumber(amount);
    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer or not profession or not amount then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)
    increaseProficiency(metaData, profession, amount)

    xPlayer.Functions.SetMetaData('crafting', metaData.crafting)

    return true
end

function decreaseProficiency(metaData, profession, amount)

    if not Config.systemMode.profession or not metaData.crafting.proficiency[profession] then
        return false
    end

    metaData.crafting.proficiency[profession] = metaData.crafting.proficiency[profession] - amount

    if metaData.crafting.proficiency[profession] < 0 then

        metaData.crafting.proficiency[profession] = 0
    end

    return true
end

function removeProficiency(player, profession, amount)

    amount = tonumber(amount)
    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer or not profession or not amount then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)
    decreaseProficiency(metaData, profession, amount)

    xPlayer.Functions.SetMetaData('crafting', metaData.crafting)

    return true
end

function getProficiency(player)

    if not Config.systemMode.profession then
        return {}
    end

    local xPlayer = getPlayer(player) -- serverId or xPlayer

    if not xPlayer then
        return false
    end

    local metaData = xPlayer.PlayerData.metadata

    initCraftingMeta(metaData)

    return metaData.crafting.proficiency
end

function calcOfflineLabor(metaData)

    if not Config.systemMode.labor then
        return 0
    end

    if type(Config.laborIncreaseOffline) ~= 'number' or Config.laborIncreaseOffline < 1 then
        return 0
    end

    local increaseTime = Config.laborIncreaseTime * 60
    local elapsedTime = os.time() - metaData.crafting.labor.timestamp

    if elapsedTime < increaseTime then
        return 0
    end

    local multiplier = math.floor(elapsedTime / increaseTime)

    return Config.laborIncreaseOffline * multiplier
end

function accessManagement(data, playerData, playerAcePermissions)

    return {

        accessToUse = accessToUse(data, playerData, playerAcePermissions),
        accessToRemove = accessToRemove(data, playerData),
    }
end

function accessToRemove(data, playerData)

    if not data.workstation then
        -- if recipe data then return
        return false
    end

    if type(data.owner) ~= 'table' then
        -- if not portable then return
        return false
    end

    if Config.canRemove.everybody then

        return true
    end

    if playerData.citizenid == data.owner.citizenid then

        return true
    end

    if Config.canRemove.ownerJob and
            playerData.job.name ~= 'unemployed' and
            playerData.job.name == data.owner.jobName then

        return true
    end

    if Config.canRemove.ownerGang and
            playerData.gang.name ~= 'none' and
            playerData.gang.name == data.owner.gangName then

        return true
    end

    if type(Config.canRemove.supervisoryJobs) == 'table' and next(Config.canRemove.supervisoryJobs) ~= nil then

        if inTable(playerData.job.name, Config.canRemove.supervisoryJobs) then

            return true
        end
    end

    return false
end

function accessToUsePortable(data, playerData)

    if playerData.citizenid == data.owner.citizenid then

        return true
    end

    if Config.canUse.everybody then

        return true
    end

    if Config.canUse.ownerJob and
            data.owner.jobName ~= 'unemployed' and
            playerData.job.name == data.owner.jobName then

        return true
    end

    if Config.canUse.ownerGang and
            data.owner.gangName ~= 'none' and
            playerData.gang.name == data.owner.gangName then

        return true
    end

    return false
end

function accessToUse(data, playerData, playerAcePermissions)

    if data.requiredAcePermission then

        if type(playerAcePermissions) ~= 'table' then

            playerAcePermissions = {}
        end

        if not playerAcePermissions[data.requiredAcePermission] then

            return false
        end
    end

    if data.workstation and type(data.owner) == 'table' then

        if not accessToUsePortable(data, playerData) then

            return false
        end
    end

    if not data.exclusive and not data.excluding then

        return true
    end

    local authorized = false

    if data.exclusive then

        authorized = inTable(playerData.job.name, data.exclusive) or inTable(playerData.gang.name, data.exclusive)

        if not authorized then

            local level = data.exclusive[playerData.job.name]

            if level then

                authorized = (type(level) == 'table' and next(level) ~= nil) and inTable(playerData.job.grade.level, level) or true
            end
        end

        if not authorized then

            local level = data.exclusive[playerData.gang.name]

            if level then

                authorized = (type(level) == 'table' and next(level) ~= nil) and inTable(playerData.gang.grade.level, level) or true
            end
        end

    elseif data.excluding then

        authorized = not (inTable(playerData.job.name, data.excluding) or inTable(playerData.gang.name, data.excluding))
    end

    return authorized
end

function initCraftingMeta(metaData)

    metaData.crafting = metaData.crafting or {}
    metaData.crafting.labor = metaData.crafting.labor or {}
    metaData.crafting.proficiency = metaData.crafting.proficiency or {}

    if Config.systemMode.labor then

        metaData.crafting.labor.point = metaData.crafting.labor.point or Config.defaultLabor
        metaData.crafting.labor.timestamp = metaData.crafting.labor.timestamp or os.time()
    end

    if Config.systemMode.profession then

        for profession, _ in pairs(Config.craftData) do

            metaData.crafting.proficiency[profession] = metaData.crafting.proficiency[profession] or 0
        end

        for profession, amount in pairs(metaData.crafting.proficiency) do

            if not Config.craftData[profession] and amount == 0 then

                metaData.crafting.proficiency[profession] = nil
            end
        end
    end
end

function sessionReset()

    ECO.SESSION = {
        inProgress = false,
        productName = '',
        productLabel = '',
        recipeTime = 10,
        productRequest = 0,
        productDone = 0,
        productionTime = 5,
        profession = '',
        level = 0
    }
end

function setAction(zoneId)

    ECO.ACTION = {}

    if not Config.workstations[zoneId] then

        ECO.ACTION.error = 'not_in_the_workspace'
        return false
    end

    playerData = QBCore.Functions.GetPlayerData()

    if IsPedInAnyVehicle(_PlayerPedId, true) or
            not IsPedOnFoot(_PlayerPedId) or
            playerData.metadata['inlaststand'] or
            playerData.metadata['isdead'] then

        ECO.ACTION.error = 'cant_work'
        return false
    end

    ECO.ACTION = Config.workstations[zoneId];
    ECO.ACTION.id = zoneId

    return true
end

-- ITEM CHECK
function getItem(item, sharedItems)

    local sharedItem = sharedItems[item];

    if sharedItem then

        return {
            label = sharedItem.label,
            image = sharedItem.image
        }
    end

    return false
end

function configCheck()

    Config.itemList = {};
    Config.usedAcePermissions = {}

    local serverSide = IsDuplicityVersion()
    local sharedItems = QBCore.Shared.Items

    ------------------------
    -- REGISTER KEYMAPPING
    ------------------------

    if type(Config.keyBind) ~= 'table' then

        Config.keyBind = {}
    end

    ------------------------
    -- PREPARE RECIPES
    ------------------------
    local craftData, droppedRecipes, nonExistentIngredients = {}, {}, {}
    local valid = true
    local productData, ingredientData
    local defaultVars = {
        labor = { 'number', 0 },
        time = { 'number', 10 },
        price = { 'number', 0 },
        amount = { 'number', 1 },
        proficiency = { 'number', 0 },
        chance = { 'number', 100 },
        special = { 'string', nil },
        exclusive = { 'table', nil },
        excluding = { 'table', nil },
        requiredAcePermission = { 'string', nil },
    }

    for profession, recipes in pairs(Config.craftData) do

        if type(recipes) == 'table' and next(recipes) then

            for product, data in pairs(recipes) do

                valid = true
                productData = getItem(product, sharedItems)
                nonExistentIngredients = {}

                if productData and type(data.ingredients) == 'table' and next(data.ingredients) then

                    Config.itemList[product] = productData

                    for ingredient, amount in pairs(data.ingredients) do

                        ingredientData = getItem(ingredient, sharedItems)

                        if ingredientData then

                            Config.itemList[ingredient] = ingredientData
                        else

                            table.insert(nonExistentIngredients, ingredient)
                            valid = false
                        end
                    end
                else

                    valid = false
                end

                if valid then

                    -- SET DEFAULT VARS
                    data.label = productData.label

                    for k, v in pairs(defaultVars) do

                        if v[1] == 'number' then

                            data[k] = (tonumber(data[k])) and data[k] or v[2]

                        elseif v[1] == 'string' then

                            data[k] = (type(data[k]) == 'string' and #trim(data[k]) > 0) and data[k] or v[2]

                        elseif v[1] == 'table' then

                            data[k] = (type(data[k]) == 'table' and next(data[k]) ~= nil) and data[k] or v[2]
                        end
                    end

                    -- INFO
                    if type(data.info) ~= 'table' then

                        data.info = {}
                    end

                    -- IF EXCLUSIVE VALID, DESTROY EXCLUDING
                    if (data.exclusive) then
                        data.excluding = nil
                    end

                    if not craftData[profession] then
                        craftData[profession] = {}
                    end

                    craftData[profession][product] = data

                    if type(data.requiredAcePermission) == 'string' and #trim(data.requiredAcePermission) > 0 then

                        Config.usedAcePermissions[data.requiredAcePermission] = true
                    end
                else

                    if not droppedRecipes[profession] then

                        droppedRecipes[profession] = {}
                    end

                    droppedRecipes[profession][product] = nonExistentIngredients
                end
            end
        end
    end

    Config.craftData = craftData

    if Config.consoleReport and next(droppedRecipes) ~= nil and serverSide then

        print("ECO CRAFTING: DROPPED RECIPES:")
        print_r(droppedRecipes)
    end

    droppedRecipes = nil

    ------------------------
    -- PREPARE WORKSTATIONS
    ------------------------

    for k, v in pairs(Config.workstations) do

        Config.workstations[k] = workstationCheck(v, serverSide)
    end

    -----------------
    -- VERSION CHECK
    -----------------
    if Config.versionCheck == nil then

        Config.versionCheck = true
    end

    -----------------
    -- LABOR INCREASE
    -----------------
    if not tonumber(Config.laborIncreaseTime) or Config.laborIncreaseTime < 1 then

        Config.laborIncreaseTime = false
    end

    ------------------------
    -- SYSTEM MODE
    ------------------------
    if type(Config.systemMode) ~= 'table' then

        Config.systemMode = {}
    end

    if not Config.systemMode.labor then

        Config.systemMode.profession = false
    end

    ------------------------
    -- CURRENCY MODE
    ------------------------
    if type(Config.currency) ~= 'table' then

        Config.currency = {}
    end

    Config.currency.symbol = Config.currency.symbol and Config.currency.symbol or ''

    ------------------------
    -- RANKS
    ------------------------

    if type(Config.ranks) ~= 'table' then

        Config.ranks = {}
    end

    if #Config.ranks > 0 then

        local rankDefaultVars = {
            labor = { 'number', 0 },
            time = { 'number', 0 },
            price = { 'number', 0 },
            chance = { 'number', 0 },
        }

        Config.proficiencyCap = 0

        for i = 1, #Config.ranks do

            local data = Config.ranks[i]

            -- SET RANK DEFAULT VARS
            for k, v in pairs(rankDefaultVars) do

                if v[1] == 'number' then

                    data[k] = (tonumber(data[k])) and data[k] or v[2]

                elseif v[1] == 'string' then

                    data[k] = (type(data[k]) == 'string' and #trim(data[k]) > 0) and data[k] or v[2]

                elseif v[1] == 'table' then

                    data[k] = (type(data[k]) == 'table' and next(data[k]) ~= nil) and data[k] or v[2]
                end
            end

            if Config.ranks[i].limit and Config.ranks[i].limit > Config.proficiencyCap then

                Config.proficiencyCap = Config.ranks[i].limit
            end
        end

        if Config.consoleReport and Config.proficiencyCap == 0 then

            print("RANKS configure error: proficiencyCap = 0")
        end
    else
        if Config.consoleReport then

            print("No configured RANKS!")
        end
    end

    ------------------------
    -- PORTABLE WORKSTATIONS
    ------------------------


    if not tonumber(Config.workstationExpirationTime) then

        Config.workstationExpirationTime = 0
    end

    if not tonumber(Config.workstationPlacementTime) then

        Config.workstationPlacementTime = 10
    end

    if not tonumber(Config.workstationRemovalTime) then

        Config.workstationRemovalTime = 10
    end

    if not tonumber(Config.workstationPlacementLimit) then

        Config.workstationRemovalTime = 1
    end

    if not tonumber(Config.workstationPlacementLimit) then

        Config.workstationRemovalTime = 1
    end

    if type(Config.workstationRemoveCommand) ~= 'string' or #trim(Config.workstationRemoveCommand) < 1 then

        Config.workstationRemoveCommand = false
    end

    if type(Config.workstationRemoveAdminGroup) ~= 'string' or #trim(Config.workstationRemoveAdminGroup) < 1 then

        Config.workstationRemoveAdminGroup = 'god'
    end

    if type(Config.showRestrictedAreaCommand) ~= 'string' or #trim(Config.showRestrictedAreaCommand) < 1 then

        Config.showRestrictedAreaCommand = false
    end

    if type(Config.showRestrictedAreaAdminGroup) ~= 'string' or #trim(Config.showRestrictedAreaAdminGroup) < 1 then

        Config.showRestrictedAreaAdminGroup = 'god'
    end

    if type(Config.canUse) ~= 'table' then

        Config.canUse = {}
    end

    if type(Config.canRemove) ~= 'table' then

        Config.canRemove = {}
    end

    if type(Config.canRemove.supervisoryJobs) ~= 'table' then

        Config.canRemove.supervisoryJobs = {}
    end
end

function workstationCheck(v, serverSide)

    -- WORKSTATION TYPE
    if type(v.workstation) ~= 'string' or #trim(v.workstation) < 1 then

        return nil
    end

    -- POSITION
    if not v.pos or type(v.pos) ~= 'vector4' then

        return nil
    end

    -- ANIMATION
    if not v.animation or
            type(v.animation) ~= 'table' or
            type(v.animation.dict) ~= 'string' or #trim(v.animation.dict) < 1 or
            type(v.animation.anim) ~= 'string' or #trim(v.animation.anim) < 1 then

        v.animation = nil
    end

    if v.animation and not tonumber(v.animation.flag) then

        v.animation.flag = 16
    end

    -- FX MARKER
    if not v.fx or
            type(v.fx) ~= 'table' or
            type(v.fx.dict) ~= 'string' or #trim(v.fx.dict) < 1 or
            type(v.fx.name) ~= 'string' or #trim(v.fx.name) < 1 then

        v.fx = nil
    end

    if v.fx then

        if type(v.fx.offset) ~= 'vector3' then

            v.fx.offset = vector3(0, 0, 0.5)
        end

        if type(v.fx.loopedAtCoord) ~= 'table' or #v.fx.loopedAtCoord < 4 then

            v.fx.loopedAtCoord = { 0.0, 0.0, 0.0, 1.0 }
        end

        if type(v.fx.loopedColour) ~= 'table' or #v.fx.loopedColour < 3 then

            v.fx.loopedColour = { 8.0, 2.0, 2.0 }
        end
    end

    -- OBJECT
    if serverSide == false then

        if not v.object then

            v.object = {}
        else

            local tmp = {}

            if type(v.object) == 'table' then

                if type(v.object.model) == 'string' and #trim(v.object.model) > 0 then

                    if IsModelInCdimage(v.object.model) then

                        tmp.model = v.object.model
                    else
                        print('the model does not exist: ', v.object.model)
                        print('loading base model: prop_table_03b')
                        print('update GTA using the Rockstar client')

                        tmp.model = 'prop_table_03b'
                    end

                    tmp.placeOnGround = v.object.placeOnGround
                    tmp.offset = type(v.object.offset) == 'vector3' and v.object.offset or nil
                end

            elseif type(v.object) == 'string' then

                if #trim(v.object) > 0 then

                    tmp.model = IsModelInCdimage(v.object) and v.object or 'prop_table_03b'
                    tmp.placeOnGround = true
                end
            end

            v.object = tmp
        end
    end

    -- ------
    v.special = (type(v.special) == 'string' and #trim(v.special) > 0) and v.special or nil
    v.actionDistance = (type(tonumber(v.actionDistance)) == 'number') and tonumber(v.actionDistance) or 1.5

    if type(v.requiredAcePermission) == 'string' and #trim(v.requiredAcePermission) > 0 then

        Config.usedAcePermissions[v.requiredAcePermission] = true
    else

        v.requiredAcePermission = nil
    end

    return v
end

function setWorkstationAccess(playerData, playerAcePermissions)

    for _, v in pairs(Config.workstations) do

        local perm = accessManagement(v, playerData, playerAcePermissions)
        v.accessToUse = perm.accessToUse
        v.accessToRemove = perm.accessToRemove
    end
end

function inZoneId()

    if loaded then

        local coords = GetEntityCoords(PlayerPedId())

        for id, workstation in pairs(Config.workstations) do

            if #(coords - workstation.pos.xyz) < workstation.actionDistance then

                return id
            end
        end
    end

    return false
end

function draw(chance)

    chance = tonumber(chance)

    if not Config.systemMode.chance or not chance or chance > 99 then

        return true
    end

    if chance < 1 then

        chance = 1
    end

    math.randomseed(math.floor(os.clock() * math.random(1000)))
    math.random();
    math.random();
    math.random();

    local acc = {}

    for i = 1, chance do

        while (true) do

            local idx = math.random(100)

            if not acc[idx] then

                acc[idx] = true
                break
            end
        end
    end

    return acc[math.random(100)] or false
end

function getRank(proficiency)

    proficiency = tonumber(proficiency) or 0
    local numberOfRanks = #Config.ranks

    if not Config.ranks or numberOfRanks == 0 then

        return false
    end

    local rank = {}

    if proficiency < Config.ranks[1].limit then

        rank = shallowCopy(Config.ranks[1])
        rank.level = 0
        rank.progress = proficiency > 0 and math.floor(proficiency / Config.ranks[1].limit * 100) or 0

        return rank
    end

    for i = 1, numberOfRanks do

        if Config.ranks[i].limit and Config.ranks[i].limit > proficiency then

            local previous = Config.ranks[i - 1]

            local range = Config.ranks[i].limit - previous.limit
            local progress = (proficiency - previous.limit) / range
            local laborRange = Config.ranks[i].labor - previous.labor
            local timeRange = Config.ranks[i].time - previous.time
            local priceRange = Config.ranks[i].price - previous.price
            local chanceRange = Config.ranks[i].chance - previous.chance

            rank = shallowCopy(Config.ranks[i])
            rank.progress = math.floor(progress * 100)
            rank.level = i - 1
            rank.labor = math.floor(previous.labor + laborRange * progress)
            rank.time = math.floor(previous.time + timeRange * progress)
            rank.price = math.floor(previous.price + priceRange * progress)
            rank.chance = math.floor(previous.chance + chanceRange * progress)

            return rank
        end
    end

    rank = shallowCopy(Config.ranks[numberOfRanks])
    rank.level = numberOfRanks - 1
    rank.progress = 100

    return rank
end

function infoMerge(info, acc)

    if type(acc) ~= 'table' then

        acc = {}
    end

    if type(info) ~= 'table' or next(info) == nil then

        return acc
    end

    for infoKey, infoValue in pairs(info) do

        if infoKey ~= 'serie'
                and infoKey ~= 'creator'
                and infoKey ~= 'quality'
                and infoKey ~= 'created'
                and infoKey ~= 'decay'
        then

            if not acc[infoKey] then

                acc[infoKey] = infoValue

            elseif type(acc[infoKey]) == 'table' then

                table.insert(acc[infoKey], infoValue)
            else

                local value = acc[infoKey]
                acc[infoKey] = {}
                table.insert(acc[infoKey], value)
                table.insert(acc[infoKey], infoValue)
            end
        end
    end

    return acc
end

function getSerialNumber()

    return tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
end

function shallowCopy(t)

    local temp

    if type(t) == 'table' then

        temp = {}

        for k, v in pairs(t) do
            temp[k] = v
        end
    else

        temp = t
    end

    return temp
end

function allowedPlacement(src, citizenid)

    local hit = 0

    if IsPlayerAceAllowed(src, 'command') then

        return true
    end

    for _, v in pairs(ECO.portableWorkstations) do

        if (v.owner and v.owner.citizenid == citizenid) then

            hit = hit + 1
        end
    end

    if hit >= Config.workstationPlacementLimit then

        return false
    end

    return true
end

function workstationAddRequest(ownerId, usableItemName, params)

    local source = ownerId
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local citizenid = xPlayer.PlayerData.citizenid

    if not allowedPlacement(source, citizenid) then

        interface.server.notify(source, Lang:t('no_more_portable_workstation'), 'error')
        return false
    end

    if type(params.object) ~= 'table' or type(params.object.model) ~= 'string' then

        print('workstationAddRequest: missing parameter: object model')
        return false
    end

    TriggerClientEvent('eco_crafting:placePortableWorkstation', source, params, usableItemName)
end

function addPortableWorkstation(params, usableItemName, ownerId, noLimit)

    local xPlayer

    if type(params) ~= 'table' or not next(params) then

        print('addWorkstation: Missing params data')
        return false
    end

    params = workstationCheck(params, 1)

    if not params then

        print('addWorkstation: Missing "pos:vector4" or "workstation" type')
        return false
    end

    if usableItemName then

        params.usableItemName = usableItemName
    end

    if ownerId then

        xPlayer = QBCore.Functions.GetPlayer(ownerId)
    end

    if xPlayer then

        if not noLimit and not allowedPlacement(ownerId, xPlayer.PlayerData.citizenid) then

            interface.server.notify(ownerId, Lang:t('no_more_portable_workstation'), 'error')
            return false
        end

        if type(params.usableItemName) == 'string' and #trim(params.usableItemName) > 0 then

            if xPlayer.Functions.RemoveItem(params.usableItemName, 1) then

                interface.server.notify(ownerId, Lang:t('workstation_placed'), 'success')
                TriggerClientEvent('inventory:client:ItemBox', ownerId, QBCore.Shared.Items[params.usableItemName], 'remove', 1)
            else

                interface.server.notify(ownerId, Lang:t('portable_item_does_not_exist'), 'error')
                return false
            end
        end

        params.owner = {
            info = ('[%s] %s %s (%s)  %s'):format(xPlayer.PlayerData.source,
                    xPlayer.PlayerData.charinfo.firstname,
                    xPlayer.PlayerData.charinfo.lastname,
                    xPlayer.PlayerData.name,
                    xPlayer.PlayerData.citizenid),
            citizenid = xPlayer.PlayerData.citizenid,
            jobName = xPlayer.PlayerData.job.name,
            gangName = xPlayer.PlayerData.gang.name
        }
    end

    table.insert(ECO.portableIds, true)
    local id = 'portable_' .. #ECO.portableIds

    params.id = id
    params.placementTime = os.time()

    ECO.portableWorkstations[id] = params

    TriggerClientEvent('eco_crafting:addWorkstation', -1, id, params)

    return id
end

function removePortableWorkstation(workstationId, requesterId)

    local xPlayer

    local workstation = ECO.portableWorkstations[workstationId]

    if type(workstation) ~= 'table' then

        print('removeWorkstation: Missing workstation')
        return false
    end

    if requesterId then

        xPlayer = QBCore.Functions.GetPlayer(requesterId)
    end

    if xPlayer and type(workstation.usableItemName) == 'string' and #trim(workstation.usableItemName) > 0 then

        xPlayer.Functions.AddItem(workstation.usableItemName, 1)
        interface.server.notify(requesterId, Lang:t('workstation_removed'), 'success')
        TriggerClientEvent('inventory:client:ItemBox', requesterId, QBCore.Shared.Items[workstation.usableItemName], 'add', 1)
    end

    local workstationData = {

        workstation = workstation.workstation,
        owner = workstation.owner,
        special = workstation.special,
    }

    ECO.portableWorkstations[workstationId] = nil
    TriggerClientEvent('eco_crafting:removeWorkstation', -1, workstationId)

    return workstationData
end

function getPortableWorkstations()

    return ECO.portableWorkstations
end

function locationAnalysis(pos)

    local result = true
    local reason = ''

    for _, v in pairs(Config.workstations) do

        if #(pos - v.pos.xyz) < 2.5 then

            return false, 'another_workstation_is_too_close'
        end
    end

    for i = 1, #Config.restrictedArea do

        if #(Config.restrictedArea[i].center - pos) < Config.restrictedArea[i].radius then

            return false, 'in_a_restricted_area'
        end
    end

    if IsPointOnRoad(pos.x, pos.y, pos.z) then

        return false, 'in_a_restricted_area'
    end

    return result, reason
end

function copyToClipboard(model, pos, w)

    if type(pos) ~= 'vector3' then

        return false
    end

    local x = round(pos.x, 2)
    local y = round(pos.y, 2)
    local z = round(pos.z, 2)
    w = round(w, 2)

    SendNUIMessage({
        subject = 'COPY',
        string = string.format('model = "%s", vector4(%s, %s, %s, %s)', model, x, y, z, w)
    })
end

function savePortableWS()

    SaveResourceFile(GetCurrentResourceName(), "./db/portable_ws.json", json.encode({ ECO.portableWorkstations }), -1)
end

function loadPortableWS()
    -- This will run once when the script starts

    local loadResult = LoadResourceFile(GetCurrentResourceName(), "./db/portable_ws.json")
    local dbResult = json.decode(loadResult)

    return (type(dbResult) == 'table' and dbResult[1]) and dbResult[1] or {}
end

function tableToVector(coords)

    if type(coords) ~= 'table' then

        return coords
    end

    local x = tonumber(coords.x)
    local y = tonumber(coords.y)
    local z = tonumber(coords.z)
    local w = tonumber(coords.w)

    if not x or not y or not z then

        return false
    end

    return w and vector4(x, y, z, w) or vector3(x, y, z)
end

function removePrefix(str, prefix)

    return (str:sub(0, #prefix) == prefix) and str:sub(#prefix + 1) or str
end

function updatePlayerAcePermissions(src)

    local temp = {}

    for perm in pairs(Config.usedAcePermissions) do

        temp[perm] = IsPlayerAceAllowed(src, perm)
    end

    return temp
end

function print_r(data)

    print(json.encode(data, { indent = true }))
end