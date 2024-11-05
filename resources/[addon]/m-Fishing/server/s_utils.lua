local QBCore = exports[Config.Core]:GetCoreObject()

WebhookURL = ""
SellingWebhook = ""

function GiveExperience(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenID = Player.PlayerData.citizenid

    local experience

    if type == "legal" then
        experience = math.random(Config.ExperienceSettings.Legal_Fishing.min, Config.ExperienceSettings.Legal_Fishing.max)
    elseif type == "illegal" then
        experience = math.random(Config.ExperienceSettings.Illegal_Fishing.min, Config.ExperienceSettings.Illegal_Fishing.max)
    elseif type == "fishingnet" then
        experience = math.random(Config.ExperienceSettings.Fishingnet.min, Config.ExperienceSettings.Fishingnet.max)
    else
        print("Invalid experience type specified")
        return
    end

    MySQL.Async.fetchScalar("SELECT citizenid FROM m_fishing WHERE citizenid = @citizenid", {["@citizenid"] = citizenID}, function(existingCitizenID)
        if existingCitizenID then
            local updateQuery = "UPDATE m_fishing SET experience = experience + @experience WHERE citizenid = @citizenid"
            local updateParams = {["@citizenid"] = citizenID, ["@experience"] = experience}
            MySQL.Async.execute(updateQuery, updateParams, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('m-Fishing:Client:Notify', src, 'You earn +'..experience..' experience points!', 'success', 5000)
                else
                    print("Error updating experience for CitizenID: " .. citizenID)
                end
            end)
        else
            local insertQuery = "INSERT INTO m_fishing (citizenid, experience) VALUES (@citizenid, @experience)"
            local insertParams = {["@citizenid"] = citizenID, ["@experience"] = experience}
            MySQL.Async.execute(insertQuery, insertParams, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('m-Fishing:Client:Notify', src, 'You earn +'..experience..' experience points!', 'success', 5000)
                else
                    print("Error inserting experience for CitizenID: " .. citizenID)
                end
            end)
        end
    end)
end


