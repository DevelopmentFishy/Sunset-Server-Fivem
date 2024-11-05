
Config = {}
Framework = "QBCore" -- (ESX) or (QBCore)
if Framework == "QBCore" then
    Config.CoreName = "qb-core" -- your core name
    FWork = exports[Config.CoreName]:GetCoreObject()
elseif Framework == "ESX" then
    Config.CoreName = "es_extended" -- your core name
    FWork = exports[Config.CoreName]:getSharedObject()
end
Config.Debug = false -- enables debug poly for zones and prints
Config.Target = "qb-target" -- (ox_target) (qb-target) or if you are using qb-target and have chanded the resource name you can put that here and it will work as well
----------
Config.ItemsInsteadOfMopney = false -- Make this true if you want Config.ItemToGive to be what the player gets instead of money
Config.AddItemAmountInsteadOfLableAMount = true -- This will never be called unless Config.ItemsInsteadOfMopney is set to true. Make this true if you want to receive the amount of Config.ItemToGive items instead of changing the markedbills lable to the cash value.
Config.ItemToGive = "markedbills" -- This is the item they will get instead of money if Config.ItemsInsteadOfMopney is set to true
----------
Config.ChanceSell = 50 -- Chance to sell drug (in %)
Config.CallChance = 80 -- Chance the cops get called
Config.ChanceSteels = 25 -- Chance the local steels the drugs
Config.CopCount = 0 -- Minimum police count to sell drugs
----------
Config.KeyCommand = "H" -- Key bind to start selling drugs to a local
----------
Config.BagsCanSellMin = 1 -- Minimum bags players can sell at once
Config.BagsCanSellMax = 25 -- Maximum bags players can sell at once
----------
Config.WaitTimeToSellToSamePed = 30000 -- This is the time in seconds for players to have to wait to sell to the same ped again. (this was requested added by a customer. if you never want players to sell to the same ped again make this nil or false instead of a number)
----------
----------
Config.DrugsToSell = {
    [1] = {
        item = 'cokebaggy', 
        priceMin = 45,
        priceMax = 67,
    },
    [2] = {
        item = 'meth', 
        priceMin = 45,
        priceMax = 67,
    },  
    [3] = {
        item = 'weed_skunk', 
        priceMin = 45,
        priceMax = 67,
    },
    [4] = {
        item = 'weed_ak47', 
        priceMin = 45,
        priceMax = 67,
    },
}
----------
----------
Config.FrameworkFunctions = {
    -- Client-side trigger callback
    TriggerCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.TriggerCallback(...)
        else
            FWork.TriggerServerCallback(...)
        end
    end,

    -- Server-side register callback
    CreateCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.CreateCallback(...)
        else
            FWork.RegisterServerCallback(...)
        end
    end,

    GetItemByName = function(source, item, amount) 
        if Framework == 'QBCore' then 
            local player = FWork.Functions.GetPlayer(source)
            return player.Functions.GetItemByName(item, amount)
        else
            local player = FWork.GetPlayerFromId(source)
            return player.getInventoryItem(item)
        end
    end,

    -- Server-side get player data
    GetPlayer = function(source)
        if Framework == 'QBCore' then
            local self = {}
            local player = nil
            player = FWork.Functions.GetPlayer(source)

            if(player ~= nil) then
                self.source = source
                self.PlayerData = { money = player.PlayerData.money }
                self.AddMoney = function(currency, amount) 
                    player.Functions.AddMoney(currency, amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.Functions.RemoveMoney(currency, amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.Functions.RemoveItem(item, amount, false)
                end

                self.AddItem = function(item, amount, bool, info) 
                    player.Functions.AddItem(item, amount, false, info)
                end


                return self
            end
        else
            local self = {}
            local player = nil
            player = FWork.GetPlayerFromId(source)

            if (player ~= nil) then
                self.source = source
                self.PlayerData = { money = {cash = player.getAccount('money').money, bank = player.getAccount('bank').money}}
                self.AddMoney = function(currency, amount) 
                    player.addMoney(amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.removeMoney(amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.removeInventoryItem(item, amount)
                end

                self.AddItem = function(item, amount, bool, info) 
                    player.addInventoryItem(item, amount, false, info)
                end

                return self
            end
        end

        return nil
    end,
}