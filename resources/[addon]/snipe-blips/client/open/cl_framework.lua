
function IsValidJob(job)
    for k, v in pairs(Config.Blips) do
        if k == job then
            return true
        end
    end
end


function IsValidGang(gang) -- only works for qbcore
    if Config.Core == "ESX" then
        return false -- if you use ESX and have a custom gang script, you can add your exports here to check if player is in a gang
    end
    for k, v in pairs(Config.GangBlips) do
        if k == gang then
            return true
        end
    end
end


function CheckOnDuty()
    if not Config.UseFrameworkDutySystem then
        return true
    end
    if Config.Core == "QBCore" then
        return PlayerJob.onduty
    elseif Config.Core == "ESX" then
        return true -- If you use an external script for onduty system, make sure to edit it here
    else 
        return true -- If you use an external script for onduty system, make sure to edit it here
    end
end

function GetGroupName(job)
    for k, v in pairs(Config.GroupJobs) do
        for _, j in pairs(v) do
            if j == job then
                return k
            end
        end
    end
    return job
end