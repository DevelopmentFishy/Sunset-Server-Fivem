RegisterServerEvent('codem-blackhud-v2:server:EjectPlayer')
AddEventHandler('codem-blackhud-v2:server:EjectPlayer', function(table, velocity)
   for i=1, #table do
        if table[i] then
            if tonumber(table[i]) ~= 0 then
                TriggerClientEvent("codem-blackhud-v2:client:EjectPlayer", table[i], velocity)
            end
        end
    end
end)


RegisterServerEvent('seatbelt:server:PlaySound')
AddEventHandler('seatbelt:server:PlaySound', function(action, table)
      for i=1, #table do
        if table[i] then
            if tonumber(table[i]) ~= 0 then
                TriggerClientEvent('seatbelt:client:PlaySound', table[i], action, 0.15)
            end
        end
    end 
end)
