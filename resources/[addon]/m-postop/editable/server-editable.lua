Citizen.CreateThread(function()
    while frameworkObject == nil do Citizen.Wait(100) end 
    if HSN.Config.Framework == "new-qb" or HSN.Config.Framework == "old-qb" then
        frameworkObject.Functions.CreateUseableItem(HSN.Config.VehicleItem,function(source)
            TriggerClientEvent("m-postop-client:SetVehicleItem", source)      
        end)
    else
        frameworkObject.RegisterUsableItem(HSN.Config.VehicleItem,function()
            TriggerClientEvent("m-postop-client:SetVehicleItem", source)      
        end)
    end
    if HSN.Config.FinishJobCommand.enable then
        RegisterCommand(HSN.Config.FinishJobCommand.command, function(source)
            if not source then return end
            local Player = HSN.GetPlayer(source)
            if HSN.Config.Framework == "new-qb" or HSN.Config.Framework == "old-qb" then
                if HSN.Config.FinishJobCommand.DeleteVehicleAfterUsage then
                    TriggerClientEvent("m-postop-client:DeleteJobVehicle", source)
                end
                Citizen.Wait(100)
                HSN.FinishJobWithCommand(Player.PlayerData.citizenid, source)
            else
                if HSN.Config.FinishJobCommand.DeleteVehicleAfterUsage then
                    TriggerClientEvent("m-postop-client:DeleteJobVehicle", source)
                end
                Citizen.Wait(100)
                HSN.FinishJobWithCommand(Player.identifier, source)
            end
        end)
    end
end)


HSN.Inventory = {}


HSN.Inventory.AddMoney = function(source, money)
    if not source then return print("unknown source") end
    money = tonumber(money)
    local Player = HSN.GetPlayer(source)
    if (HSN.Config.Inventory == "qb-inventory") then
        if (HSN.Config.Framework == "qb" or HSN.Config.Framework == "new-qb") then
            Player.Functions.AddMoney(HSN.Config.MoneyType, money, 'postop')
            -- notification
        else
            -- your qb to esx converted qb-inventory codes
        end
    elseif (HSN.Config.Inventory == "ox_inventory") then
        if HSN.Config.MoneyType == "cash" then
            exports.ox_inventory:AddItem(source, HSN.Config.OXInventoryCashItem, money)
        else
            if HSN.Config.Framework == "qb" or HSN.Config.Framework == "new-qb" then
                Player.Functions.AddMoney("bank", money, 'postop')
            else
                Player.addAccountMoney('bank', money)
            end
        end
    elseif (HSN.Config.Inventory == "esx_default") then
        if HSN.Config.MoneyType == "cash" then
            Player.addMoney(money)
        else
            Player.addAccountMoney('bank', money)
        end
    elseif HSN.Config.Inventory == "custom" then
        -- return  //your custom inv codes
    end 
    HSN.SetEarnedMoney(source, money)
    HSN.SendMessage(HSN.Messages["server"]["earnmoney"].." "..money.."$", false, "server", source)
end


HSN.Inventory.GetMoney = function(source)
    if not source then return print("unknown source") end
    local Player = HSN.GetPlayer(source)
    if (HSN.Config.Inventory == "qb-inventory") then
        if (HSN.Config.Framework == "qb" or HSN.Config.Framework == "new-qb") then
            return Player.Functions.GetMoney(HSN.Config.MoneyType)
        else
            -- your qb to esx converted qb-inventory codes
        end
    elseif HSN.Config.Inventory == "ox_inventory" then
        if HSN.Config.MoneyType == "cash" then
            local inventory = exports.ox_inventory:GetInventory(source)
            local cash = 0
            for itemkey, item in pairs(inventory.items) do
                if item.name == HSN.Config.OXInventoryCashItem then
                    cash = cash + item.count
                end
            end
            return cash
        else
            if HSN.Config.Framework == "qb" or HSN.Config.Framework == "qb-old" then
                return Player.Functions.GetMoney(HSN.Config.MoneyType)
            else
                return Player.getAccount('bank').money
            end
        end
    elseif HSN.Config.Inventory == "esx_default" then
        if HSN.Config.Framework == "esx" or HSN.Config.Framework == "new-esx" then
            if HSN.Config.MoneyType == "bank" then
                return Player.getAccount('bank').money
            elseif HSN.Config.MoneyType == "cash" then
                return Player.getMoney()
            end
        end
    elseif HSN.Config.Inventory == "custom" then
        -- your custom inv codes
    end
end


HSN.Inventory.RemoveMoney = function(source, money)
    if not source then return print("unknown source") end
    money = tonumber(money)
    local Player = HSN.GetPlayer(source)
    if (HSN.Config.Inventory == "qb-inventory") then
        if (HSN.Config.Framework == "qb" or HSN.Config.Framework == "new-qb") then
            if Player.Functions.RemoveMoney(HSN.Config.MoneyType, money, 'postop-remove') then
                return true
            else
                return false
            end
        else
            -- your qb to esx converted qb-inventory codes
        end
    elseif (HSN.Config.Inventory == "ox_inventory") then
        local PlayerMoney = HSN.Inventory.GetMoney(source)
        if HSN.Config.MoneyType == "cash" then
            if PlayerMoney >= money then
                exports.ox_inventory:RemoveItem(source, HSN.Config.OXInventoryCashItem, money)
                return true
            else
                return false
            end
        else
            if HSN.Config.Framework == "qb" or HSN.Config.Framework == "new-qb" then
                if HSN.Inventory.GetMoney(source) >= money then
                    Player.Functions.RemoveMoney(HSN.Config.MoneyType, money)
                    return true
                else
                    return false
                end
            else
                if HSN.Inventory.GetMoney(source) >= money then 
                    Player.removeAccountMoney('bank', money)
                    return true
                else
                    return false
                end
            end
        end
    elseif (HSN.Config.Inventory == "esx_default") then
        if HSN.Config.MoneyType == "cash" then
            if HSN.Inventory.GetMoney(source) >= money then
                Player.removeMoney(money)
                return true
            else
                return false
            end
        else
            if Player.getAccount('bank').money >= money then
                Player.removeAccountMoney('bank', money)
                return true
            else
                return false
            end
        end
    elseif (HSN.Config.Inventory == "custom") then
        --return // your custom inv codes
    end
end


HSN.GetPlayer = function(source)
    if not source then return print("error while finding player") end
    if HSN.Config.Framework == "new-qb" or HSN.Config.Framework == "old-qb" then
        return frameworkObject.Functions.GetPlayer(source)
    else
        return frameworkObject.GetPlayerFromId(source)
    end
end

HSN.GetPlayerCharacterNameESX = function(source)
    local Player = HSN.GetPlayer(source)
    identifier = Player.identifier
    local result = HSN.ExecuteSql("SELECT * FROM users WHERE identifier = '"..identifier.."'")
    if result[1] then 
        return result[1].firstname..' '..result[1].lastname 
    end;
end

HSN.GetPlayerJob = function(source)
    if not source then return print("error while finding player") end
    local Player = HSN.GetPlayer(source)
    if HSN.Config.Framework == "new-qb" or HSN.Config.Framework == "old-qb" then
        return Player.PlayerData.job.name
    else
        return Player.job.name
    end
end