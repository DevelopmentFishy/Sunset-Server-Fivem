Utils = {}

Utils.AlertCops = function(bankType)
    TriggerServerEvent('police:server:policeAlert', 'Jailbreak Alarm') -- Standard QBCore police alert
    
    if GetResourceState('ps-dispatch') ~= 'started' then return end
    local camId = '36 | 37 | 38 | 39 | 40'
    exports['ps-dispatch']:PrisonBreak(camId) -- ps-dispatch alert
end

Utils.PlayerIsLeo = function(Job)
    -- return Job.name == 'police' and Job.onduty
    return Job.type == 'leo' and Job.onduty
end

Utils.Notify = function(message, notifType, timeOut)
    if Config.Notify == 'qb' then
        QBCore.Functions.Notify(message, notifType, timeOut)
    elseif Config.Notify == 'ox' then
        lib.notify({
            title = Locales['notify_title'],
            description = message,
            duration = timeOut,
            type = notifType,
            position = 'center-right',
        })
    end
end
