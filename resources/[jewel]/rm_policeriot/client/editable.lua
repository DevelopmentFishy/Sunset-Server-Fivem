function getAttachedPlayers()
    local p = PlayerPedId()
    local pC = GetEntityCoords(p)
    local attachedPlayers = {}

    local nearbyPlayers = getClosestPlayers(pC, 1.5)
    if #nearbyPlayers < 1 then return attachedPlayers end

    for i = 1, #nearbyPlayers do
        local ped = GetPlayerPed(nearbyPlayers[i])
        if IsEntityAttachedToEntity(ped, p) then
            DetachEntity(ped, false, false)
            attachedPlayers[#attachedPlayers + 1] = GetPlayerServerId(nearbyPlayers[i])
        end
    end

    return attachedPlayers
end
