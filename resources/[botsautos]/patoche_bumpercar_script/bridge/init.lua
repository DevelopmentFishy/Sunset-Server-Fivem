Framework = nil

if GetResourceState('es_extended'):find('start') then
    Framework = 'ESX'
elseif GetResourceState('qb-core'):find('start') then
    Framework = 'QBCore'
else
    Framework = 'standalone'
end