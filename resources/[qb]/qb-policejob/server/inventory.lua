Inventory = Inventory or {}

Inventory = {
    AddItem = function(source, item, amount, metadata, slot)
        local src = source
        if Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            if exports[Config.Inventory]:AddItem(src, item, amount, slot or false, metadata or {}) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                return true
            else return false end
        elseif Config.Inventory == 'ox_inventory' then
            if exports.ox_inventory:CanCarryItem(src, item, amount) then
                if exports.ox_inventory:AddItem(src, item, amount, metadata or {}, slot) then
                    return true
                else return false end
            else return false end
        end
    end,

    RemoveItem = function(source, item, amount, slot)
        local src = source
        if Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            if exports[Config.Inventory]:RemoveItem(src, item, amount, slot or nil) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
                return true
            else return false end
        elseif Config.Inventory == 'ox_inventory' then
            local success = exports.ox_inventory:RemoveItem(src, item, amount, nil, slot or nil)
            if success then return true else return false end
        end
    end,

    HasItem = function(source, item)
        if Config.Inventory == 'ox_inventory' then
            local amt = exports.ox_inventory:Search(source, 'count', item)
            if amt > 0 then return true else return false end
        elseif Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            return exports[Config.Inventory]:HasItem(source, item)
        end
    end,

    GetItem = function(source, item)
        if Config.Inventory == 'ox_inventory' then
            local items = exports.ox_inventory:Search(source, 'slots', item)
            return items
        elseif Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            return exports[Config.Inventory]:GetItemsByName(source, item)
        end
    end,

    OpenStash = function(source, id, name)
        if Config.Inventory == 'ox_inventory' then
            local inventory = exports.ox_inventory:GetInventory(id)
            if not inventory then
                exports.ox_inventory:RegisterStash(id, name, 30, 100000, true)
            end
            TriggerClientEvent('ox_inventory:openInventory', source, 'player', id)
        elseif Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            TriggerEvent("inventory:server:OpenInventory", "stash", id, Config.StashSettings)
            TriggerClientEvent("inventory:client:SetCurrentStash", source, id)
        end
    end,

    OpenShop = function(source, name, items, jobs)
        if Config.Inventory == 'ox_inventory' then
            local inventory = exports.ox_inventory:GetInventory(name)
            if not inventory then
                exports.ox_inventory:RegisterShop(name, {
                    name = name,
                    inventory = items,
                    groups = jobs,
                })
            end
            TriggerClientEvent('ox_inventory:openInventory', source, 'shop', {type = name})
        elseif Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            TriggerEvent("inventory:server:OpenInventory", "shop", name, items)
        end
    end,

    TrunkItems = function(source, plate, items)
        if Config.Inventory == 'ox_inventory' then
            local inventory = exports.ox_inventory:GetInventory(plate)
            if not inventory then
                for _,v in pairs(items) do
                    exports.ox_inventory:AddItem(plate, v.name, v.amount)
                end
            end
        elseif Config.Inventory == 'qs-inventory' or Config.Inventory == 'ps-inventory' then
            TriggerEvent("inventory:server:addTrunkItems", plate, items)
        end
    end,
}