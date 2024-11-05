function generateLicensePlate()
    local sectionLength = 4
    local availableCharacters, availableNumbers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', '0123456789'

    local randomPlate = ''

    for _ = 1, sectionLength do
        local rand = math.random(#availableNumbers)
        randomPlate = randomPlate .. string.sub(availableNumbers, rand, rand)
    end

    for _ = 1, sectionLength do
        local rand = math.random(#availableCharacters)
        randomPlate = randomPlate .. string.sub(availableCharacters, rand, rand)
    end

    return randomPlate
end

function isPictureUrlValid(url)
    if url:len() > 100 or url:find("[&<>\"]") then
        return false
    end

    local host = url:match("^%a+://([^/]+)")
    if host == svConfig.recommendedUploadWebsite then
        return true
    end

    for _, allowedHost in ipairs(svConfig.allowedImageHosts) do
        if host == allowedHost then
            return true
        end
    end

    return false
end

function deleteDropOffVehicle(vehicle)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
end