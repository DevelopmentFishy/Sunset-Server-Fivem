function SetLowpassSound(name, status)
    SendNUIMessage({
        type = "lowpass",
        name = name,
        status = status,
    })
    soundInfo[name].lowpassStatus = status
end

function GetStatusLowpassSound(name)
    return soundInfo[name].lowpassStatus or false
end