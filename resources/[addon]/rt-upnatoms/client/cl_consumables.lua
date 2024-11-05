local QBCore = exports['qb-core']:GetCoreObject()

------/ Creating Eating Emote Events
-- Eating Plated Food
RegisterNetEvent('rt-upnatoms:client:EatPlate', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("dinner")
    QBCore.Functions.Progressbar("eat_something", "Eten", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + HungerFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Eating Burgers
RegisterNetEvent('rt-upnatoms:client:EatBurger', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("eat")
    QBCore.Functions.Progressbar("eat_something", "Burger Eten", 3000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + HungerFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Eating Sandwiches
RegisterNetEvent('rt-upnatoms:client:EatSandwich', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("sandwich")
    QBCore.Functions.Progressbar("eat_something", "Sandwich Eten", 3000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + HungerFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Eating
RegisterNetEvent('rt-upnatoms:client:Eat', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("eat")
    QBCore.Functions.Progressbar("eat_something", "Eten", 3000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + HungerFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

------/ Creating Drink Emote Events
-- Drink Ecola
RegisterNetEvent('rt-upnatoms:client:DrinkEcola', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("soda")
    QBCore.Functions.Progressbar("drink_something", "Ecola Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink Sprunk
RegisterNetEvent('rt-upnatoms:client:DrinkSprunk', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("soda")
    QBCore.Functions.Progressbar("drink_something", "Sprunk Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("e")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink OrangTang
RegisterNetEvent('rt-upnatoms:client:DrinkOrangTang', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("soda9")
    QBCore.Functions.Progressbar("drink_something", "Orang Tang Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink Water
RegisterNetEvent('rt-upnatoms:client:DrinkWater', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("drink")
    QBCore.Functions.Progressbar("drink_something", "Water Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink Raine
RegisterNetEvent('rt-upnatoms:client:DrinkWater2', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("water")
    QBCore.Functions.Progressbar("drink_something", "Raine Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink Junk
RegisterNetEvent('rt-upnatoms:client:DrinkJunk', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("edrink2")
    QBCore.Functions.Progressbar("drink_something", "Junk Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

-- Drink Hercules
RegisterNetEvent('rt-upnatoms:client:DrinkHercules', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("drink")
    QBCore.Functions.Progressbar("drink_something", "Hercules Drinken", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ThirstFill[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(1, 3))
    end)
end)

------/ Creating Cook Events
-- Cooked Bacon
RegisterNetEvent('rt-upnatoms:client:makeCookedBacon', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-bacon'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "grilling", 0.2)
        QBCore.Functions.Progressbar("cooking_food", "Spek bakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeCookedBacon")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-bacon"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Cooked Beef Patty
RegisterNetEvent('rt-upnatoms:client:makeCookedBeefPatty', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-beef-patty'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "grilling", 0.2)
        QBCore.Functions.Progressbar("cooking_food", "Burger bakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableComabt = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeCookedBeefPatty")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-beef-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-beef-patty"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Cooked Chicken Patty
RegisterNetEvent('rt-upnatoms:client:makeCookedChickenPatty', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken-patty'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "grilling", 0.2)
        QBCore.Functions.Progressbar("cooking_food", "Kip Burger bakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableComabt = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeCookedChickenPatty")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-patty"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Cooked Chicken
RegisterNetEvent('rt-upnatoms:client:makeCookedChicken', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "grilling", 0.2)
        QBCore.Functions.Progressbar("cooking_food", "Kip bakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeCookedChicken")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

------/ BREAKFAST SECTION
-- Eggs Benedict
RegisterNetEvent('rt-upnatoms:client:makeEggsBenedict', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-english-muffin', 'atoms-eggs', 'atoms-ham-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Eggs Benedict maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeEggsBenedict")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-english-muffin"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ham-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs-benedict"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Hashbrowns
RegisterNetEvent('rt-upnatoms:client:makeHashbrowns', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-potatos'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Frieten bakken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeHashbrowns")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-potatos"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Sausages
RegisterNetEvent('rt-upnatoms:client:makeSausages', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-frozen-sausages'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Worsten bakken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeSausages")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-frozen-sausages"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-sausages"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Bacon Rolls
RegisterNetEvent('rt-upnatoms:client:makeBaconRolls', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-bacon', 'atoms-mozzarella-cheese-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Spekrol Frituren", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeBaconRolls")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-bacon"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-mozzarella-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon-rolls"], "add", 1)
            Texports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Bacon and Egg/Toast
RegisterNetEvent('rt-upnatoms:client:makeBaconEggsToast', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-eggs', 'atoms-bread', 'atoms-bacon'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Spek met Eieren en Toast maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeBaconEggsToast")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bread"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon-eggs"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Egg Florentine
RegisterNetEvent('rt-upnatoms:client:makeEggsFlorentine', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-eggs', 'atoms-english-muffin', 'atoms-ham-slices', 'atoms-spinach'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Eggs Florentine maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeEggsFlorentine")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-english-muffin"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ham-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-spinach"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs-florentine"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- French Toast/Bacon
RegisterNetEvent('rt-upnatoms:client:makeFrenchToastBacon', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bread', 'atoms-eggs', 'atoms-bacon'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "French Toast maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeFrenchToastBacon")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bread"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-eggs"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-french-toast-bacon"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)
------/ BURGER SECTION
-- Atoms Burger
RegisterNetEvent('rt-upnatoms:client:makeAtomsBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-beef-patty', 'atoms-lettuce', 'atoms-tomato', 'atoms-cheddar-cheese-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Atoms Burger maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-beef-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-cheddar-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- DB Atoms Burger
RegisterNetEvent('rt-upnatoms:client:makeDBAtomsBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-beef-patty', 'atoms-lettuce', 'atoms-tomato', 'atoms-cheddar-cheese-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Double Atoms Burger maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeDBAtomsBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-beef-patty"], "remove", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-cheddar-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-db-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Bacon Burger
RegisterNetEvent('rt-upnatoms:client:makeAtomsBaconBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-beef-patty', 'atoms-lettuce', 'atoms-tomato', 'atoms-cheddar-cheese-slices', 'atoms-bacon'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Making Atoms Bacon Burger", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsBaconBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-beef-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-cheddar-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Pickle Burger
RegisterNetEvent('rt-upnatoms:client:makeAtomsPickleBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-beef-patty', 'atoms-lettuce', 'atoms-tomato', 'atoms-cheddar-cheese-slices', 'atoms-pickles'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Atoms Pickle Burger maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsPickleBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-beef-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-cheddar-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-pickles"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-pickle-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Sandwich
RegisterNetEvent('rt-upnatoms:client:makeAtomsSandwich', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bread', 'atoms-lettuce', 'atoms-tomato', 'atoms-mozzarella-cheese-slices', 'atoms-ham-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Atoms Sandwich maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsSandwich")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bread"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-mozzarella-cheese-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ham-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-sandwich"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Chicken Burger
RegisterNetEvent('rt-upnatoms:client:makeAtomsChickenBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-lettuce', 'atoms-tomato', 'atoms-chicken-patty'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Atoms Chicken Burger maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsChickenBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-patty"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- DB Atoms Chicken Burger
RegisterNetEvent('rt-upnatoms:client:makeDBAtomsChickenBurger', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bun', 'atoms-lettuce', 'atoms-tomato', 'atoms-chicken-patty'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Atoms DB Chicken Burger maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeDBAtomsChickenBurger")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bun"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-patty"], "remove", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-burger"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

------/ CHICKEN SECTION
-- Chicken Fillets
RegisterNetEvent('rt-upnatoms:client:makeChickenFillets', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kipfilet bakken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeChickenFillets")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken"], "remove", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-fillets"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Chicken Stars
RegisterNetEvent('rt-upnatoms:client:makeChickenStars', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kip Stars bakken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeChickenStars")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-stars"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Chicken Sandwich
RegisterNetEvent('rt-upnatoms:client:makeChickenSandwich', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bread', 'atoms-lettuce', 'atoms-tomato', 'atoms-chicken-slices'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kip Sandwich maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeChickenSandwich")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bread"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-tomato"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-slices"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-sandwich"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Grilled Chicken
RegisterNetEvent('rt-upnatoms:client:makeGrilledChicken', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kip Grillen", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeGrilledChicken")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken"], "remove", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-grilled-chicken"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Chicken Salad
RegisterNetEvent('rt-upnatoms:client:makeChickenSalad', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-lettuce', 'atoms-spinach', 'atoms-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kip Sla maken", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeChickenSalad")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-lettuce"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-spinach"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-salad"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Hunks o Hen
RegisterNetEvent('rt-upnatoms:client:makeHunksHen', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-raw-chicken'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Kip Grillen", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeHunksHen")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raw-chicken"], "remove", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hunk-o-hen"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

------/ DRINK SECTION
-- Hercules
RegisterNetEvent('rt-upnatoms:client:makeHercules', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "Hercules maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeHercules")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hercules"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

-- Orang Tang
RegisterNetEvent('rt-upnatoms:client:makeOrangTang', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "OrangTang maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeOrangTang")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-orangtang"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

-- Sprunk
RegisterNetEvent('rt-upnatoms:client:makeSprunk', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "Sprunk maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeSprunk")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-sprunk"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

-- Ecola
RegisterNetEvent('rt-upnatoms:client:makeEcola', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "Ecola maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeEcola")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

-- Raine
RegisterNetEvent('rt-upnatoms:client:makeRaine', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "Raine maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeRaine")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-raine"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

-- Junk
RegisterNetEvent('rt-upnatoms:client:makeJunk', function(itemName)
    exports["rpemotes"]:EmoteCommandStart("mechanic")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20.0, "watermachine", 0.02)
    QBCore.Functions.Progressbar("making_drink", "Junk maken", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("rt-upnatoms:server:makeJunk")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-junk"], "add", 1)
        exports["rpemotes"]:EmoteCommandStart("c")
        TriggerEvent('rt-upnatoms:cooking')
    end, function() -- Cancel
        QBCore.Functions.Notify("Okay then", "error")
        TriggerEvent('rt-upnatoms:cooking')
    end)
end)

------/ MEAL SECTION
-- Atoms Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Packaging Food and Drink", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Bacon Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsBaconBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-bacon-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Menu verpakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsBaconBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-bacon-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Pickle Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsPickleBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-pickle-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Menu Verpakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsPickleBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-pickle-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-pickle-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Double Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsDoubleBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-db-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Menu verpakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsDoubleBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-db-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-db-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Chicken Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsChickenBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-chicken-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Menu verpakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsChickenBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-chicken-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)

-- Atoms Dobule Chicken Burger Meal
RegisterNetEvent('rt-upnatoms:client:makeAtomsDoubleChickenBurgerMeal', function(itemName)
    local ingredients = QBCore.Functions.HasItem({'atoms-db-chicken-burger', 'atoms-ecola', 'atoms-hashbrown'})
    if ingredients then
        exports["rpemotes"]:EmoteCommandStart("mechanic")
        QBCore.Functions.Progressbar("cooking_food", "Menu verpakken", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("rt-upnatoms:server:makeAtomsDoubleChickenBurgerMeal")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-db-chicken-burger"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-ecola"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-hashbrown"], "remove", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["atoms-db-chicken-burger-meal"], "add", 1)
            exports["rpemotes"]:EmoteCommandStart("c")
            TriggerEvent('rt-upnatoms:cooking')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('rt-upnatoms:cooking')
        end)
    else
        QBCore.Functions.Notify('Je mist iets', 'error')
    end
end)
------/ MENU SECTION

RegisterNetEvent('rt-upnatoms:closemenu', function()
    ClearPedTasksImmediately(PlayerPedId())
    TriggerEvent("qb-menu:closeMenu")
end)

RegisterNetEvent('rt-upnatoms:client:cookStation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Fornuis",
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Spek",
            txt = "Benodigdheden:</p>1x Rauw Spek",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeCookedBacon",
            }
        },
        {
            header = "Rundsburger",
            txt = "Benodigdheden:</p>1x Burger",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeCookedBeefPatty",
            }
        },
        {
            header = "Kipburger",
            txt = "Benodigdheden:</p>1x Rauw Kipburger",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeCookedChickenPatty",
            }
        },
        {
            header = "Gegrilde Kip",
            txt = "Benodigdheden:</p>2x Rauwe Kip",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeGrilledChicken",
            }
        },
        {
            header = "French Toast",
            txt = "Benodigdheden:</p>1x Brood | 1x Ei | 1x Spek",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeFrenchToastBacon",
            }
        },
        {
            header = "Spek met Eieren en Toast",
            txt = "Benodigdheden:</p>1x Ei | 1x Brood | 1x Spek",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeBaconEggsToast",
            }
        },
        {
            header = "Exit",
            icon = "fa-regular fa-circle-xmark fa-beat",
            params = {
                event = "rt-upnatoms:closemenu"
            }
        },
    })
end)

RegisterNetEvent('rt-upnatoms:client:deepfryStation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Friteuse",
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Frieten",
            txt = "Benodigdheden:</p>1x Aardappelen",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeHashbrowns",
            }
        },
        {
            header = "Kip Stars",
            txt = "Benodigdheden:</p>1x Rauwe Kip",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeChickenStars",
            }
        },
        {
            header = "Kip Filet",
            txt = "Benodigdheden:</p>2x Rauwe Kip",
            icon = "fa-solid fa-fire fa-beat",
            params = {
                event = "rt-upnatoms:client:makeChickenFillets",
            }
        },
        {
            header = "Terug",
            icon = "fa-regular fa-circle-xmark fa-beat",
            params = {
                event = "rt-upnatoms:closemenu"
            }
        },
    })
end)

RegisterNetEvent('rt-upnatoms:client:buildStation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Prep Station",
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Atoms Burger",
            txt = "Benodigdheden:</p>1x Bun | 1x Rundsburger | 1x Sla | 1x Tomaat | 1x Cheddar",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsBurger"
            }
        },
        {
            header = "Double Atoms Burger",
            txt = "Benodigdheden:</p>1x Bun | 2x Rundsburger | 1x Sla | 1x Tomaat | 1x Cheddar",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeDBAtomsBurger"
            }
        },
        {
            header = "Atoms Bacon Burger",
            txt = "Benodigdheden:</p>1x Bun | 1x Rundsburger | 1x Sla | 1x Tomaat | 1x Cheddar | 1x Spek",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsBaconBurger"
            }
        },
        {
            header = "Atoms Sandwich",
            txt = "Benodigdheden:</p>1x Boterham | 1x Sla | 1x Tomaat | 1x Mozzarella | 1x Gesneden Ham",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsSandwich"
            }
        },
        {
            header = "Atoms Kip Burger",
            txt = "Benodigdheden:</p>1x Bun | 1x Kipburger | 1x Sla | 1x Tomaat",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsChickenBurger"
            }
        },
        {
            header = "DB Atoms Kip Burger",
            txt = "Benodigdheden:</p>1x Bun | 2x Kipburger | 1x Sla | 1x Tomaat",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeDBAtomsChickenBurger"
            }
        },
        {
            header = "Atoms Kip Sandwich",
            txt = "Benodigdheden:</p>1x Bread | 1x Sla | 1x Tomaat | 1x Gesneden Kipfilet",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeChickenSandwich"
            }
        },
        {
            header = "Atoms Kip Sla",
            txt = "Benodigdheden:</p>1x Sla | 1x Spinazie | 1x Gebakken Kipfilet",
            icon = "fa-solid fa-hands fa-beat",
            params = {
                event = "rt-upnatoms:client:makeChickenSalad"
            }
        },
        {
            header = "Terug",
            icon = "fa-regular fa-circle-xmark fa-beat",
            params = {
                event = "rt-upnatoms:closemenu"
            }
        },
    })
end)

RegisterNetEvent('rt-upnatoms:client:drinkStation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Frisdrank Machine",
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Hercules",
            txt = "",
            icon = "fa-solid fa-faucet-drip fa-beat",
            params = {
                event = "rt-upnatoms:client:makeHercules",
            }
        },
        {
            header = "Orang Tang",
            txt = "",
            icon = "fa-solid fa-faucet-drip fa-beat",
            params = {
                event = "rt-upnatoms:client:makeOrangTang",
            }
        },
        {
            header = "Sprunk",
            txt = "",
            icon = "fa-solid fa-faucet-drip fa-beat",
            params = {
                event = "rt-upnatoms:client:makeSprunk",
            }
        },
        {
            header = "Ecola",
            txt = "",
            icon = "fa-solid fa-faucet-drip fa-beat",
            params = {
                event = "rt-upnatoms:client:makeEcola",
            }
        },
        {
            header = "Junk",
            txt = "",
            icon = "fa-solid fa-faucet-drip fa-beat",
            params = {
                event = "rt-upnatoms:client:makeJunk",
            }
        },
        {
            header = "Terug",
            icon = "fa-regular fa-circle-xmark fa-beat",
            params = {
                event = "rt-upnatoms:closemenu"
            }
        },
    })
end)

RegisterNetEvent('rt-upnatoms:client:packageStation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Verpakken",
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Classic Burger Menu",
            txt = "Benodigdheden:</p>1x Burger | 1x Frieten | 1x Ecola",
            icon = "fa-solid fa-box fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsBurgerMeal",
            }
        },
        {
            header = "Bacon Burger Menu",
            txt = "Benodigdheden:</p>1x Bacon Burger | 1x Frieten | 1x Ecola",
            icon = "fa-solid fa-box fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsBaconBurgerMeal",
            }
        },
        {
            header = "Double Burger Menu",
            txt = "Benodigdheden:</p>1x Double Burger | 1x Frieten | 1x Ecola",
            icon = "fa-solid fa-box fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsDoubleBurgerMeal",
            }
        },
        {
            header = "Chicken Burger Menu",
            txt = "Benodigdheden:</p>1x Chicken Burger | 1x Frieten | 1x Ecola",
            icon = "fa-solid fa-box fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsChickenBurgerMeal",
            }
        },
        {
            header = "Double Chicken Burger Menu",
            txt = "Benodigdheden:</p>1x Double Chicken Burger | 1x Frieten | 1x Ecola",
            icon = "fa-solid fa-box fa-beat",
            params = {
                event = "rt-upnatoms:client:makeAtomsDoubleChickenBurgerMeal",
            }
        },
        {
            header = "Terug",
            icon = "fa-regular fa-circle-xmark fa-beat",
            params = {
                event = "rt-upnatoms:closemenu"
            }
        },
    })
end)