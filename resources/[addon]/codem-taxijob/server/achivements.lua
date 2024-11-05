
function achivementsCallback()

    if Config.Framework == 'esx' then
        frameworkObject.RegisterServerCallback('codem-taxi:server:AchivementsCheck', function(source, cb, val)
            local src = source
            local identifier = GetIdentifier(src)
            local result = ExecuteSql("SELECT `achivements` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
            local result2 = json.decode(result[1].achivements)

            if val == 'mission1' then 
                -- ilk defa bir görev yapıp yapmadığını kontrol ediyor 
                local firstjob = ExecuteSql("SELECT `history` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if firstjob[1].history ~= "" then 
                    local firstjob2 = json.decode(firstjob[1].history)
                    if #firstjob2 >= 1 then
                        for k,v in pairs(result2) do
                            if val == v.missionname  and not v.missionComplete then
                                v.missionComplete = true
                                ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                                achivementsReward(v.missionname,src)
                                return TriggerClientEvent('codem-taxi:client:refresh',src)
                            end
                        end
                    end
                end
            end
            if val == 'mission2' then
                --taşıma görevi 50 oyuncuya ulaşırsa görev başarılı 
                local passenger = ExecuteSql("SELECT `passenger` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
               
                if passenger[1].passenger >= 50 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
    
                end
            end
            if val == 'mission3' then 
                local firstjob = ExecuteSql("SELECT `history` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if firstjob[1].history ~= "" then 
                    local firstjob2 = json.decode(firstjob[1].history)
                        local found = false
                        for j,w in pairs(firstjob2) do 
                    
                            if w.way == 'SANDY SHORES' then 
                                found = true
                            end

                        end
                        if found then 
                         for k,v in pairs(result2) do
                             if val == v.missionname  and not v.missionComplete then
                                 v.missionComplete = true
                                 ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                                 achivementsReward(v.missionname,src)
                                 return TriggerClientEvent('codem-taxi:client:refresh',src)
                             end
                         end
                        end
                 
                end

            end

     
            if val == 'mission4' then 
                local mile = ExecuteSql("SELECT `totalmile` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
        
                if mile[1].totalmile >= 40000 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
                end
            end

            if val == 'mission5' then 
                local taximoney = ExecuteSql("SELECT `taximoney` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if taximoney[1].taximoney >= 50000 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
                end

            end

            if val == 'mission6' then
                -- eğer level 50 ve üstü olursa bu görev başarılı 
                local level = ExecuteSql("SELECT `level` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
             
                if tonumber(level[1].level) >= tonumber(50) then 
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end

                end
            end


       
            for k,v in pairs(result2) do
                if val == v.missionname then
                    if v.missionComplete == true then
                        cb({missionComplete = v.missionComplete})
                    else
                        cb({missionAccept = v.missionAccept})
                    end
                end
            end
        end)

        frameworkObject.RegisterServerCallback('codem-taxi:server:getAchivements', function(source,cb)
            local src = source
            local identifier = GetIdentifier(src)
            local result = ExecuteSql("SELECT `achivements` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
            cb(json.decode(result[1].achivements))
        end)
    else

        ----for qb-----------------------

        frameworkObject.Functions.CreateCallback('codem-taxi:server:AchivementsCheck', function(source, cb, val)
            local src = source
            local identifier = GetIdentifier(src)
            local result = ExecuteSql("SELECT `achivements` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
            local result2 = json.decode(result[1].achivements)

            if val == 'mission1' then 
                -- ilk defa bir görev yapıp yapmadığını kontrol ediyor 
                local firstjob = ExecuteSql("SELECT `history` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if firstjob[1].history ~= "" then 
                    local firstjob2 = json.decode(firstjob[1].history)
                    if #firstjob2 >= 1 then
                        for k,v in pairs(result2) do
                            if val == v.missionname  and not v.missionComplete then
                                v.missionComplete = true
                                ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                                achivementsReward(v.missionname,src)
                                return TriggerClientEvent('codem-taxi:client:refresh',src)
                            end
                        end
                    end
                end
            end
            if val == 'mission2' then
                --taşıma görevi 50 oyuncuya ulaşırsa görev başarılı 
                local passenger = ExecuteSql("SELECT `passenger` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
               
                if passenger[1].passenger >= 50 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
    
                end
            end
            if val == 'mission3' then 
                local firstjob = ExecuteSql("SELECT `history` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if firstjob[1].history ~= "" then 
                    local firstjob2 = json.decode(firstjob[1].history)
                        local found = false
                        for j,w in pairs(firstjob2) do 
                           
                            if w.way == 'SANDY SHORES' then 
                                found = true
                            end

                        end
                        if found then 
                         for k,v in pairs(result2) do
                             if val == v.missionname  and not v.missionComplete then
                                 v.missionComplete = true
                                 ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                                 achivementsReward(v.missionname,src)
                                 return TriggerClientEvent('codem-taxi:client:refresh',src)
                             end
                         end
                        end
                end

            end

            if val == 'mission4' then 
               
                local mile = ExecuteSql("SELECT `totalmile` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
            
                if mile[1].totalmile >= 40000 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
    
                end

            end

            if val == 'mission5' then 
                local taximoney = ExecuteSql("SELECT `taximoney` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
                if taximoney[1].taximoney >= 50000 then
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end
                end

            end

            if val == 'mission6' then
                -- eğer level 50 ve üstü olursa bu görev başarılı 
                local level = ExecuteSql("SELECT `level` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
          
                if tonumber(level[1].level) >= tonumber(50) then 
                    for k,v in pairs(result2) do
                        if val == v.missionname  and not v.missionComplete then
                            v.missionComplete = true
                            ExecuteSql("UPDATE `codem_taxijob` SET `achivements` = '"..json.encode(result2).."' WHERE `identifier` = '"..identifier.."'")
                            achivementsReward(v.missionname,src)
                            return TriggerClientEvent('codem-taxi:client:refresh',src)
                        end
                    end

                end
            end


       
            for k,v in pairs(result2) do
                if val == v.missionname then
                    if v.missionComplete == true then
                        cb({missionComplete = v.missionComplete})
                    else
                        cb({missionAccept = v.missionAccept})
                    end
                end
            end
        end)

        frameworkObject.Functions.CreateCallback('codem-taxi:server:getAchivements', function(source,cb)
            local src = source
            local identifier = GetIdentifier(src)
            local result = ExecuteSql("SELECT `achivements` FROM `codem_taxijob` WHERE `identifier` = '"..identifier.."'")
            cb(json.decode(result[1].achivements))
        end)

    end


end

function achivementsReward(val,src)
    for k,v in pairs(Config.Achievements) do 
         if v.mission == val then 
            if Config.Framework == 'esx' then 
                  local xPlayer = frameworkObject.GetPlayerFromId(src)
                  xPlayer.addMoney(v.price)
            else
                local xPlayer = frameworkObject.Functions.GetPlayer(src)
                xPlayer.Functions.AddMoney('cash',tonumber(v.price))
            end
        end
    end
end

RegisterServerEvent('codem-taxi:getTaximeterItem')
AddEventHandler('codem-taxi:getTaximeterItem', function()
   local src = source
    if Config.Framework == 'esx' then
      local xPlayer = frameworkObject.GetPlayerFromId(src)
      xPlayer.addInventoryItem(Config.TaxiMeterItem,1)
    else
      local xPlayer = frameworkObject.Functions.GetPlayer(src)
      xPlayer.Functions.AddItem(Config.TaxiMeterItem,1)
    end
end)