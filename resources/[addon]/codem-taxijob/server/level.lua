
RegisterServerEvent('codem_taxijob:AddXP')
AddEventHandler('codem_taxijob:AddXP', function (xp)
   local src = source
   AddXPTaxi(src, xp)
end)

function AddXPTaxi(source, xp)

   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if taxiData[identifier] then
         local level = taxiData[identifier].level
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) + tonumber(xp)
         if taxiData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end

      local identifier = GetIdentifier(source)
      if taxiData[identifier] then
         local level = taxiData[identifier].level
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) + tonumber(xp)
         if taxiData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   end
end

function TaxiRemoveXP(source, xp)
   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if taxiData[identifier] then
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) - xp
         if taxiData[identifier].xp <= 0 then
            RemoveLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end

      local identifier = GetIdentifier(source)
      if taxiData[identifier] then
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) - xp
         if taxiData[identifier].xp <= 0 then
            RemoveLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end

   end
end

function SetXP(source, xp)
   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if taxiData[identifier] then
         local level = taxiData[identifier].level
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) + xp
         if taxiData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end
      local identifier = GetIdentifier(source)

      if taxiData[identifier] then
         local level = taxiData[identifier].level
         taxiData[identifier].xp = tonumber(taxiData[identifier].xp) + xp
         if taxiData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   end
end

function AddLevel(source)
   if Config.Framework == 'esx' then
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier

      if taxiData[identifier] then
         taxiData[identifier].level = taxiData[identifier].level + 1
         if not Config.RequiredXP[taxiData[identifier].level]  then
            taxiData[identifier].level = #Config.RequiredXP
            taxiData[identifier].xp = Config.RequiredXP[taxiData[identifier].level]
         else
            taxiData[identifier].xp = 0
         end
     
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return taxiData[identifier].level
      end
   else
      local identifier = GetIdentifier(source)
      if taxiData[identifier] then
         taxiData[identifier].level = taxiData[identifier].level + 1
         if not Config.RequiredXP[taxiData[identifier].level]  then
            taxiData[identifier].level = #Config.RequiredXP
            taxiData[identifier].xp = Config.RequiredXP[taxiData[identifier].level]
         else
            taxiData[identifier].xp = 0
         end
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return taxiData[identifier].level
      end

   end
end

function RemoveLevel(source)
   if Config.Framework == 'esx' then
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if taxiData[identifier] then
         taxiData[identifier].level = taxiData[identifier].level - 1
         if taxiData[identifier].level <= 0 then
            taxiData[identifier].level = 1
         end
         taxiData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return taxiData[identifier].level
      end
   else
      local identifier = GetIdentifier(source)
      if taxiData[identifier] then
         taxiData[identifier].level = taxiData[identifier].level - 1
         if taxiData[identifier].level <= 0 then
            taxiData[identifier].level = 1
         end
         taxiData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return taxiData[identifier].level
      end

   end
end

function SetTaxiLevel(source, level)
   if Config.Framework == 'esx' then
      if not level and level <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if taxiData[identifier] and tonumber(taxiData[identifier].level) ~= tonumber(level) then
         taxiData[identifier].level = level
         
         if taxiData[identifier].level <= 0 then
            taxiData[identifier].level = 1
         end
         taxiData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))
         return taxiData[identifier].level
      end
   else
      if not level and level <= 0 then
         return
      end
      local identifier = GetIdentifier(source)
      if taxiData[identifier] and tonumber(taxiData[identifier].level) ~= tonumber(level) then
         taxiData[identifier].level = level
         if taxiData[identifier].level <= 0 then
            taxiData[identifier].level = 1
         end
         taxiData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `codem_taxijob` SET `xp` = '" .. taxiData[identifier].xp .. "', `level` = '"..taxiData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return taxiData[identifier].level
      end

   end
end