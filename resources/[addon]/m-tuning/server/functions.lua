
Core = nil
CreateThread(function()
    Core, Config.Framework = GetCore()
end)

function ExecuteSQL(query, params)
    local IsBusy = true
    local result = nil
    
    if Config.Database == "oxmysql" then
        exports.oxmysql:execute(query, params, function(data)
            result = data
            IsBusy = false
        end)
    
    elseif Config.Database == "ghmattimysql" then
        exports.ghmattimysql:execute(query, params, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.Database == "mysql-async" then
        exports['mysql-async']:mysql_fetch_all(query, params, function(data)
            result = data
            IsBusy = false
        end)
    end
    
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

Citizen.CreateThread(function ()
    while not Core do
        Citizen.Wait(0)
    end
    if Config.Framework == "ESX" then
        Core.RegisterUsableItem(Config.TabletItemName, function(source)
            TriggerClientEvent("m-tuning:tabletCheck", source, true)
        end)
        Core.RegisterUsableItem(Config.CheckerItemName, function(source)
            TriggerClientEvent("m-tuning:tunerCheckerCheck", source, true)
        end)
    else 
        Core.Functions.CreateUseableItem(Config.TabletItemName, function(source)
            TriggerClientEvent("m-tuning:tabletCheck", source, true)
        end)
        Core.Functions.CreateUseableItem(Config.CheckerItemName, function(source)
            TriggerClientEvent("m-tuning:tunerCheckerCheck", source, true)
        end)
    end
end)

Citizen.CreateThread(function ()
    while not Core do
        Citizen.Wait(0)
    end
    if Config.AdvancedAuthorize then
        RegisterServerEvent('m-tuning:CheckPermission')
        AddEventHandler('m-tuning:CheckPermission', function()
            local src = source
            local authorizedGroups = Config.AdvancedAuthorizedGroup
                
            local permissions = {} 
            
            for _, group in pairs(authorizedGroups) do
                local hasPerm = false
                
                if Config.Framework == "ESX" then 
                    local xPlayer = Core.GetPlayerFromId(src)
                    local playerGroup = xPlayer.getGroup()
                    hasPerm = (playerGroup == group)
                else
                    hasPerm = Core.Functions.HasPermission(src, group)
                end
                
                permissions[group] = hasPerm 
            end
        
            TriggerClientEvent("m-tuning:SendPermission", src, permissions)
        end)
    end
end)
