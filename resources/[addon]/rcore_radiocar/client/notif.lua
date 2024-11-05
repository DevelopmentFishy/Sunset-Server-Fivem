function ShowNotification(msg, style)
    SendNUIMessage({
        type = "notif",
        msg = msg,
        style = style,
    })
end
RegisterNetEvent("rcore_radiocar:notif", ShowNotification)

RegisterNUICallback("notif", function(data, cb)
    ShowNotification(data.msg, data.style)

    if cb then
        cb('ok')
    end
end)