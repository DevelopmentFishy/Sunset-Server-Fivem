-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function Notify(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

RegisterNetEvent('kq_ped_loot:client:notify')
AddEventHandler('kq_ped_loot:client:notify', function(message)
    Notify(message)
end)


function KeybindTip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, 200)
end

--This function is responsible for drawing all the 3d texts
function Draw3DText(coords, textInput, scaleX)
    scaleX = scaleX * Config.textScale
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, coords, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(scaleX * scale, scaleX * scale)
    SetTextFont(Config.textFont or 4)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
