local QBCore = exports[Config.Core]:GetCoreObject()

function Notify(msg)
    QBCore.Functions.Notify(msg)
end

function GiveKeys(plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
    -- exports['qs-vehiclekeys']:GiveKeysAuto(plate)
end

function CallCops(carModel)
    if Config.Dispatch == 'cd_dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-10 - Car Thief',
            message = 'A '..data.sex..' possibly committing a crime '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 156,
                scale = 1.2,
                colour = 1,
                flashes = false,
                text = '911 - Illegal Fishing',
                time = (5*60*1000),
                sound = 1,
            }
        })
    elseif Config.Dispatch == 'ps-dispatch' then
        local pCoords = GetEntityCoords(PlayerPedId())
        exports["ps-dispatch"]:CustomAlert({
            coords = pCoords,
            message = "Mogelijk een auto dief",
            dispatchCode = "10-10 AutoDiefstal",
            description = "Auto betrokken bij een overval ofzo?",
            gender = true,
            radius = 0,
            sprite = 156,
            color = 1,
            scale = 1.2,
            length = 3,
        })
    elseif Config.Dispatch == 'qs-dispatch' then
        local pCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('qs-dispatch:server:CreateDiapatchCall', {
             job = 'police',
             callLocation = pCoords,
             callCode = {code = '911 - Car Thief', snippet = '10-10 Car Thief'},
             message = 'possibly committing a crime',
             flashes = 'Boolean',
             image = 'URL.png',
             blip = {
                sprite = 110,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = '10-10 Car Thief',
                time = (6*60*1000),-- 6 minutes
            }
        })
    end
end

function Email()
    if Config.Phone == 'qb-phone' then
        TriggerServerEvent("qb-phone:server:sendNewMail", {
            sender = Language["Email"].Sender,
            subject = Language["Email"].Title,
            message = Language["Email"].Message,
        })
    elseif Config.Phone == 'gksphone' then
        TriggerServerEvent("gksphone:NewMail", {
            sender = Language["Email"].Sender,
            image = '/html/static/img/icons/mail.png',
            subject = Language["Email"].Title,
            message = Language["Email"].Message,
        })
    elseif Config.Phone == 'qs-smartphone' then
        TriggerServerEvent("qs-smartphone:server:sendNewMail", {
            sender = Language["Email"].Sender,
            subject = Language["Email"].Title,
            message = Language["Email"].Message,
        })
    elseif Config.Phone == 'notify' then
        exports['okokNotify']:Alert("Get this car", "I have pinged your gps with the car that u need to get for me", 5000, 'type')
    elseif Config.Phone == 'lb-phone' then
        local sender = exports["lb-phone"]:GetEquippedPhoneNumber(source)
        local emailAddress = exports['lb-phone']:GetEmailAddress(sender)

        local success, id = exports["lb-phone"]:SendMail({
            to = emailAddress,
            subject = Language["Email"].Title,
            message = Language["Email"].Message,
            attachments = {
               "https://cdn.discordapp.com/attachments/1035667053115363349/1042500877426110474/upload.png", --- Change that image
            },

        })
    elseif Config.Phone == "jpr-phone" then
        TriggerServerEvent("jpr-newphone:server:sendNewMailFix", { sender = Language["Email"].Title, subject = Language["Email"].Message, message = Language["Email"].Message})
    end
end