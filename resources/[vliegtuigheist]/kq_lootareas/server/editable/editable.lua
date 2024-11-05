
-- Triggered when a player triggers the pickup event when not even near to the prop
function FarPickupDetected(player, distance, areaKey)
    print('^1Player ' .. player .. ' attempted to pickup an item from ' .. distance .. ' meters away! [Area key: ' .. areaKey .. ']. This could be caused by lua injection.')
end
