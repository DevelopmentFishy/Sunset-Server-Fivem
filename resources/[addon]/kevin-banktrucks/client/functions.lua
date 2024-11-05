local QBCore = exports['qb-core']:GetCoreObject()

function MiniGameSettings()
    if Config.LesterMinigame.game == 'path' then
        return Config.LesterMinigame.minigame['path']
    elseif Config.LesterMinigame.game == 'spot' then
        return Config.LesterMinigame.minigame['spot']
    elseif Config.LesterMinigame.game == 'math' then
        return Config.LesterMinigame.minigame['math']
    end
end

function HasPhoneItem()
    for key, phoneName in pairs(Config.Phone.items) do
        local hasItem = QBCore.Functions.HasItem(phoneName)
        if hasItem then
            return true
        end
    end
end

function GetRandomData(data)
    if data then
        return data[math.random(#data)]
    else
        return nil
    end
end

function CheckCanPlantThermite(entity, entity2, vehicle)
    if IsEntityDead(entity) and IsEntityDead(entity2) then
        if IsVehicleStopped(vehicle) then
            if not IsEntityInWater(vehicle) then
                return true
            end
        end
    end
    return false
end

function ParticleEffect()
	if not HasNamedPtfxAssetLoaded('scr_jewelheist') then
		RequestNamedPtfxAsset('scr_jewelheist')
    end
    while not HasNamedPtfxAssetLoaded('scr_jewelheist') do
		Wait(0)
    end
    SetPtfxAssetNextCall('scr_jewelheist')
end

function Notification(message, duration, type)
    if Config.Notifications == 'ox' then
        lib.notify({
            title = 'Bank Trucks',
            description = message,
            duration = duration,
            type = type,
        })
    elseif Config.Notifications == 'qb' then
        QBCore.Functions.Notify(message, type, duration)
    end
end

function PhoneNotification(title, message)
    if Config.Phone.resource == 'qb' then
        TriggerEvent('qb-phone:client:CustomNotification', title, message, 'fas fa-location-arrow', '#00ffd5', 6000)
    elseif Config.Phone.resource == 'gks' then
        TriggerEvent('gksphone:notifi', {title = title, message = message, img= '/html/static/img/icons/messages.png'})
    elseif Config.Phone.resource == 'qs' then
        TriggerEvent('qs-smartphone:client:notify', {title = title, text = message, icon = './img/apps/whatsapp.png', timeout = 6000})
    elseif Config.Phone.resource == 'lb' then
        exports['lb-phone']:SendNotification({
            title = title,
            content = message,
        })
    end
end

function SendMail(title, subject, message)
    CreateThread(function ()
        if Config.Phone.resource == 'qb' then
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = title,
                subject = subject,
                message = message,
                button = {}
            })
        elseif Config.Phone.resource == 'gks' then
            TriggerServerEvent('gksphone:NewMail', {
                sender = title,
                image = '/html/static/img/icons/mail.png',
                subject = subject,
                message = message,
                button = {}
            })
        elseif Config.Phone.resource == 'qs' then
            TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                sender = title,
                subject = subject,
                message = message,
                button = {}
            })
        elseif Config.Phone.resource == 'lb' then
            TriggerServerEvent('script:server:lbphone', {
                subject = subject,
                message = message,
            })
        end
    end)
end

function TriggerAlert()
    if Config.Dispatch == 'ps' then
        exports['ps-dispatch']:BankTrucks()
    elseif Config.Dispatch == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-90 - Fleeca Truck Robbery',
            message = 'A '..data.sex..' robbing a bank truck at '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 67,
                scale = 1.5,
                colour = 2,
                flashes = false,
                text = '911 - Fleeca Truck Robbery',
                time = (5*60*1000),
                sound = 1,
            }
        })
    end
end