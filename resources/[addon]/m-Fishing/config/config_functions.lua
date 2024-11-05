local QBCore = exports[Config.Core]:GetCoreObject()

function Notify(msg, type, time)
    if Config.Notify == "qb" then
        QBCore.Functions.Notify(msg, type, time)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert('Fishing', msg, time, type, true)
    elseif Config.Notify == "ox" then
        lib.notify({ title = 'Fishing', description = msg, type = type })
    end
end

function GiveKeys(veh)
    local plate = GetVehicleNumberPlateText(veh)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    if Config.VehicleKeys == "qb" then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    elseif Config.VehicleKeys == "qs" then
        exports['qs-vehiclekeys']:GiveKeys(plate, model)
    elseif Config.VehicleKeys == "renewed" then
        exports['Renewed-Vehiclekeys']:addKey(plate)
    end
end

function SetFuel(veh)
    if Config.Fuel == "LegacyFuel" then
        exports["LegacyFuel"]:SetFuel(veh, 100.0)
    elseif Config.Fuel == "okokFuel" then
        exports['okokGasStation']:SetFuel(veh, 100.0)
    elseif Config.Fuel == "ox_fuel" then
        SetVehicleFuelLevel(veh, 100.0)
    elseif Config.Fuel == "ti_fuel" then
        exports["ti_fuel"]:setFuel(veh, 100.0, "RON91")
    elseif Config.Fuel == "qs-fuel" then
        exports['qs-fuelstations']:SetFuel(veh, 100.0)
    end
end

function SendHelpText(msg, position)
    if Config.HelpText == "qb" then
        exports['qb-core']:DrawText(msg, position)
    elseif Config.HelpText == "ox" then
        lib.showTextUI(msg)
    end
end

function RemoveHelpText()
    if Config.HelpText == "qb" then
        exports['qb-core']:HideText()
    elseif Config.HelpText == "ox" then
        lib.hideTextUI()
    end
end

function OpenFishingShop()
    if Config.Inventory == "qb" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", Config.Language.fishingShop, {
            label = Config.Language.fishingShop,
            items = Config.FishingShopItems,
            slots = #Config.FishingShopItems,
        })
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:openInventory('shop', { type = Config.Language.fishingShop, id = 1 })
    elseif Config.Inventory == "qs" then
        local shop = Config.Language.fishingShop
        local Items = {
            label = Config.Language.fishingShop,
            items = Config.FishingShopItems
        }
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_" .. shop, Items)
    end
end

function StartMinigame(callback)
    if Config.MinigameType == "ps-ui" then
        exports['ps-ui']:Circle(function(success)
            callback(success)
        end, 2, 20)
    elseif Config.MinigameType == "bl_ui" then
        local success = exports.bl_ui:CircleProgress(1, 20)
        callback(success)
    elseif Config.MinigameType == "ox_lib" then
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 50, speedMultiplier = 1}, 'easy'}, {'e', 'e', 'e', 'e'})
        callback(success)
    end
end

function StartAnimation(animation)
    if Config.EmoteMenu == "dp" then
        TriggerEvent('animations:client:EmoteCommandStart', {animation})
    elseif Config.EmoteMenu == "rp" then
        exports["rpemotes"]:EmoteCommandStart(animation)
    elseif Config.EmoteMenu == "scully" then
        exports["scully_emotemenu"]:playEmoteByCommand(animation)
    end
end

function CallCops()
    if Config.Dispatch == 'cd_dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-10 - Sellling Corals',
            message = 'A '..data.sex..' possibly committing a crime '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 156,
                scale = 1.2,
                colour = 1,
                flashes = false,
                text = '911 - Sellling Corals',
                time = (5*60*1000),
                sound = 1,
            }
        })
    elseif Config.Dispatch == 'ps-dispatch' then
        local pCoords = GetEntityCoords(PlayerPedId())
        exports["ps-dispatch"]:CustomAlert({
            coords = pCoords,
            message = "911 - Sellling Corals",
            dispatchCode = "10-10 Sellling Corals",
            description = "possibly committing a crime",
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
             callCode = {code = '911 - Sellling Corals', snippet = '10-10 Sellling Corals'},
             message = 'possibly committing a crime',
             flashes = 'Boolean',
             image = 'URL.png',
             blip = {
                sprite = 110,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = '10-10 Sellling Corals',
                time = (6*60*1000),-- 6 minutes
            }
        })
    end
end