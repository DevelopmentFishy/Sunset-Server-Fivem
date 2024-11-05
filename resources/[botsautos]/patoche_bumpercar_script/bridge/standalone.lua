if Framework ~= 'standalone' then return end
print('No framework detected, using standalone')

function haveItem(quantity)
    debugPrint("Use standalone then have quantity = true")
    return true
end

function addItem(quantity)
    return true
end

function removeItem(quantity)
    return true
end