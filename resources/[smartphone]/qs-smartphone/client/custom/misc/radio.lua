Config.Access = { -- Configure your private Radio App frequencies here.
    {
        frequenz = 1,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 1,
        job = "ambulance",
        joblabel = "Ambulance"
    },

    {
        frequenz = 2,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 3,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 4,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 422,
        job = "ambulance",
        joblabel = "Ambulance"
    },
}

function getPrivateRadio(freq)
    local finded = true
    freq = tonumber(freq)
    for k,v in pairs(Config.Access) do
        if v.frequenz == freq then
            finded = false
            if Config.Framework == 'esx' then
                if PlayerData.job.name == v.job then return true end
            elseif Config.Framework == 'qb' then
                if QBCore.Functions.GetPlayerData().job.name == v.job then return true end
            end
        end
    end
    return finded
end

local TokoVoipID = nil
RegisterNUICallback('setRadio', function(data)
    if not getPrivateRadio(data.freq) then return SendNUIMessage({
        action = "Notification",
        PhoneNotify = {
            title = 'Radio',
            text =  Lang("RADIO_JOB"),
            icon = "./img/apps/radio.png",
            timeout = 2500,
        },
    })  end
    SendNUIMessage({
        action = "Notification",
        PhoneNotify = {
            title = 'Radio',
            text =  Lang("RADIO_CONNECTED"),
            icon = "./img/apps/radio.png",
            timeout = 2500,
        },
    })
    if Config.Voice == 'mumble' then 
        exports[Config.VoiceScriptName]:SetRadioChannel(data.freq)
        exports[Config.VoiceScriptName]:SetMumbleProperty("radioEnabled", true)
        exports["rp-radio"]:SetRadio(true)
    elseif Config.Voice == 'toko' then
        exports.tokovoip_script:addPlayerToRadio(data.freq + 120)
        TokoVoipID = data.freq + 120
    elseif Config.Voice == 'pma' then
        exports[Config.VoiceScriptName]:setVoiceProperty("radioEnabled", true)
        exports[Config.VoiceScriptName]:setRadioChannel(tonumber(data.freq))
        exports["rp-radio"]:SetRadioEnabled(true)
        exports["rp-radio"]:SetAllowRadioWhenClosed(true)

    elseif Config.Voice == 'salty' then
        exports.saltychat:SetRadioChannel(data.freq, true)
    end
end)

RegisterNUICallback('leaveRadio', function(data)
    if Config.Voice == 'mumble' then 
        exports[Config.VoiceScriptName]:SetRadioChannel(0)
    elseif Config.Voice == 'toko' then
        exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
        TokoVoipID = nil
    elseif Config.Voice == 'pma' then
        exports[Config.VoiceScriptName]:removePlayerFromRadio()
    elseif Config.Voice == 'salty' then
        exports.saltychat:SetRadioChannel('', true)
    end
end)