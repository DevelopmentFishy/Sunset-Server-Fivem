lib.locale()

if Config.Framework == "ESX" then
    if Config.NewESX then
        ESX = exports["es_extended"]:getSharedObject()
    else
        ESX = nil
        CreateThread(function()
            while ESX == nil do
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
                Wait(100)
            end
        end)
    end
elseif Config.Framework == "qbcore" then
    QBCore = nil
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "standalone" then
    -- ADD YOU FRAMEWORK
end

-- Your notification type settings
-- •» You can edit a type of notifications, with chaning type or triggering your own.
Notify = function(type, title, text)
    if Config.NotificationType == "ESX" then
        ESX.ShowNotification(text)
    elseif Config.NotificationType == "ox_lib" then
        if type == "info" then
            lib.notify({
                title = title,
                description = text,
                type = "inform"
            })
        elseif type == "error" then
            lib.notify({
                title = title,
                description = text,
                type = "error"
            })
        elseif type == "success" then
            lib.notify({
                title = title,
                description = text,
                type = "success"
            })
        end
    elseif Config.NotificationType == "qbcore" then
        if type == "success" then
            QBCore.Functions.Notify(text, "success")
        elseif type == "info" then
            QBCore.Functions.Notify(text, "primary")
        elseif type == "error" then
            QBCore.Functions.Notify(text, "error")
        end
    elseif Config.NotificationType == "custom" then
        print("add your notification system! in cl_Utils.lua")
        -- ADD YOUR NOTIFICATION | TYPES ARE info, error, success
    end
end

local active = false

ProgressBar = function(duration, label)
    if Config.Progress == "ox_lib" then
        lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    elseif Config.Progress == "qbcore" then
        active = true
        QBCore.Functions.Progressbar(label, label, duration, false, true, {
        }, {}, {}, {}, function()
        end)
        Wait(duration)
        active = false
    elseif Config.Progress == "progressBars" then
        exports['progressBars']:startUI(duration, label)
        Wait(duration)
    end
end

IsProgressBarActive = function()
    if Config.Progress == "ox_lib" then
        return lib.progressActive()
    elseif Config.Progress == "qbcore" then
        return active
    elseif Config.Progress == "progressBars" then
        return false
    end
end

TextUIShow = function(text)
    if Config.TextUI == "ox_lib" then
        lib.showTextUI(text)
    elseif Config.TextUI == "esx" then
        exports["esx_textui"]:TextUI(text)
    elseif Config.TextUI == "luke" then
        TriggerEvent('luke_textui:ShowUI', text)
    elseif Config.TextUI == "custom" then
        print("add your textui system! in cl_Utils.lua")
        -- ADD YOUR TEXTUI | TO SHOW
    end
end

IsTextUIShowed = function()
    if Config.TextUI == "ox_lib" then
        return lib.isTextUIOpen()
    elseif Config.TextUI == "esx" then
        --exports["esx_textui"]:TextUI(text)
    elseif Config.TextUI == "luke" then
        --TriggerEvent('luke_textui:ShowUI', text)
    elseif Config.TextUI == "custom" then
        print("add your textui system! in cl_Utils.lua")
        -- ADD YOUR TEXTUI | TO SHOW
    end
end

TextUIHide = function()
    if Config.TextUI == "ox_lib" then
        lib.hideTextUI()
    elseif Config.TextUI == "esx" then
        exports["esx_textui"]:HideUI()
    elseif Config.TextUI == "luke" then
        TriggerEvent('luke_textui:HideUI')
    elseif Config.TextUI == "custom" then
        print("add your textui system! in cl_Utils.lua")
        -- ADD YOUR TEXTUI | TO HIDE
    end
end

Draw3DText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    
    if onScreen then
        SetTextFont(Config.FontId)
        SetTextScale(0.33, 0.30)
        SetTextDropshadow(10, 100, 100, 100, 255)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 350
        DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 10)
    end
end

Target = function()
    if Config.Target == "qtarget" then
        return exports['qtarget']
    end
    if Config.Target == "qb-target" then
        return exports['qb-target']
    end
    if Config.Target == "ox_target" then
        return exports['qtarget']
    end
end

--Blip creating
CreateThread(function()
    for _, v in pairs(Config.Blips) do
        local blip = AddBlipForCoord(v.BlipCoords)
        SetBlipSprite(blip, v.Sprite)
        SetBlipDisplay(blip, v.Display)
        SetBlipScale(blip, v.Scale)
        SetBlipColour(blip, v.Colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(v.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

--Appearance
local appearance = nil
GetSkin = function()
    if Config.Clothing == "illenium-appearance" then
        appearance = exports['illenium-appearance']:getPedAppearance(PlayerPedId())
    elseif Config.Clothing == "esx_skin" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            appearance = skin
        end)
    elseif Config.Clothing == "qb-clothing" then
        -- no need
    elseif Config.Clothing == "custom" then
        print("add your clothing system! in cl_Utils.lua")
        -- ADD YOUR CLOTHING SCRIPT
    end
end

ApplySkin = function()
    if Config.Clothing == "illenium-appearance" then
        exports['illenium-appearance']:setPedAppearance(PlayerPedId(), appearance)
    elseif Config.Clothing == "esx_skin" then
        TriggerEvent('skinchanger:loadSkin', appearance)
    elseif Config.Clothing == "qb-clothing" then
        TriggerServerEvent("drc_drugs:loadPlayerSkin")
        --TriggerServerEvent("qb-clothes:loadPlayerSkin")
    elseif Config.Clothing == "custom" then
        print("add your clothing system! in cl_Utils.lua")
        -- ADD YOUR CLOTHING SCRIPT
    end
end

RegisterNetEvent("drc_drugs:loadSkin")
AddEventHandler("drc_drugs:loadSkin", function(_, model, data)
    model = model ~= nil and tonumber(model) or false
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        --SetPlayerModel(PlayerId(), model) -- WITH THIS CUTSCENE WONT WORK
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
        data = json.decode(data)
        TriggerEvent('qb-clothing:client:loadPlayerClothing', data, PlayerPedId())
    end)
end)

--
Dispatch = function(coords, type)
    if Config.Dispatch.enabled then
        if Config.Dispatch.script == "cd_dispatch" then
            if type == "drugselling" then
                local data = exports['cd_dispatch']:GetPlayerInfo()
                TriggerServerEvent('cd_dispatch:AddNotification', {
                    job_table = Config.PoliceJobs,
                    coords = coords,
                    title = "10-66 - Suspicious person",
                    message = "Suspicious activity  was spotted by citizen",
                    flash = 0,
                    unique_id = tostring(math.random(0000000, 9999999)),
                    blip = {
                        sprite = sprite,
                        scale = 1.2,
                        colour = 3,
                        flashes = false,
                        text = text,
                        time = (5 * 60 * 1000),
                        sound = 1,
                    }
                })
            end
        elseif Config.Dispatch.script == "linden_outlawalert" then
            if type == "drugselling" then
                local data = { displayCode = "10-66", description = "Suspicious person", isImportant = 1,
                    recipientList = Config.PoliceJobs,
                    length = '10000', infoM = 'fa-info-circle', info = "Suspicious activity  was spotted by citizen" }
                local dispatchData = { dispatchData = data, caller = 'citizen', coords = coords }
                TriggerServerEvent('wf-alerts:svNotify', dispatchData)
            end
        elseif Config.Dispatch.script == "ps-disptach" then
            if type == "drugselling" then
                exports['ps-dispatch']:SuspiciousActivity()
            end
        elseif Config.Dispatch.script == "custom" then
            print("add your dispatch system! in cl_Utils.lua")
        end
    end
end

Minigame = function(type)
    if Config[type].Minigame.oxlib then
        success = lib.skillCheck({'easy'}, {'w', 'a', 's', 'd'})
    elseif Config[type].Minigame.Memorygame then
        exports["memorygame"]:thermiteminigame(6, 3, 5, 10,
        function()
            success = true
        end,
        function()
            success = false
        end)
    else
        success = true
    end
    
    repeat
        Citizen.Wait(100) -- wait for 100 milliseconds before checking again
    until success ~= nil
    
    return success
end


if Config.Bob74_ipl then
    Citizen.CreateThread(function()
        BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()

        -- Here we make two modifications
        BikerMethLab.Style.Set(BikerMethLab.Style.upgrade, false)
        BikerMethLab.Security.Set(BikerMethLab.Security.upgrade, false)

        -- But we only call the refresh at the end
        RefreshInterior(BikerMethLab.interiorId)
    end)

    Citizen.CreateThread(function()
        BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
        BikerCocaine.Ipl.Interior.Remove()
        -- Here we make two modifications
        BikerCocaine.Style.Set(BikerCocaine.Style.upgrade, false)
        BikerCocaine.Security.Set(BikerCocaine.Security.upgrade, false)
        BikerCocaine.Details.Enable({ BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2,
            BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3 }, true)

        -- But we only call the refresh at the end
        RefreshInterior(BikerCocaine.interiorId)
    end)

    Citizen.CreateThread(function()
        -- Getting the object to interact with
        BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()

        -- Setting the style
        BikerWeedFarm.Style.Set(BikerWeedFarm.Style.basic)

        -- Setting the security
        BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic)

        -- Enabling a single detail
        BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, true)

        -- Enabling multiple details at once
        BikerWeedFarm.Details.Enable({ BikerWeedFarm.Details.production, BikerWeedFarm.Details.chairs,
            BikerWeedFarm.Details.drying }, true)

        -- Setting up a plant using the 1st method (in one go)
        BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.small, BikerWeedFarm.Plant1.Light.basic)

        -- Setting up another plant using the 2nd method (settings each parameters individually)
        BikerWeedFarm.Plant2.Stage.Set(BikerWeedFarm.Plant1.Stage.full)
        BikerWeedFarm.Plant2.Light.Set(BikerWeedFarm.Plant1.Light.basic)
        BikerWeedFarm.Plant2.Hose.Enable(true)

        -- No other plants
        BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.medium, BikerWeedFarm.Plant1.Light.basic)
        BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.full, BikerWeedFarm.Plant2.Light.basic)
        BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.medium, BikerWeedFarm.Plant3.Light.basic)
        BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.full, BikerWeedFarm.Plant4.Light.basic)
        BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.medium, BikerWeedFarm.Plant5.Light.basic)
        BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.full, BikerWeedFarm.Plant6.Light.basic)
        BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.medium, BikerWeedFarm.Plant7.Light.basic)
        BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.full, BikerWeedFarm.Plant8.Light.basic)
        BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.full, BikerWeedFarm.Plant9.Light.basic)

        -- Refreshing the interior to the see the result
        RefreshInterior(BikerWeedFarm.interiorId)
    end)
end


local TSE = TriggerServerEvent
local using = false
local stamina = false
local speed = false
local strength = false
RegisterNetEvent('drc_drugs:consumables', function(text, animation, duration, effect, add)
    if not IsProgressBarActive() then
        if animation.emote.enabled then
            dict = animation.emote.anim.dict
            clip = animation.emote.anim.clip
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            if animation.emote.prop.model then
                local hash = animation.emote.prop.model
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Wait(100)
                    RequestModel(hash)
                end
                prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
                AttachEntityToEntity(prop, cache.ped, animation.emote.prop.bone, animation.emote.prop.pos, animation.emote.prop.rot, true, true, false, false, 1, true)
            end
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(true)
            end
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(duration, text)
            if animation.emote.prop.model then
                DetachEntity(prop, false, false)
                DeleteEntity(prop)
            end
            StopAnimTask(cache.ped, dict, clip, 1.0)
            Wait(0)
            FreezeEntityPosition(cache.ped, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(false)
            end
            Status(add)
            Drug(effect)
        elseif animation.scenario.enabled then
            TaskStartScenarioInPlace(cache.ped, animation.scenario.anim.scenario, 0, true)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(true)
            end
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(duration, text)
            ClearPedTasks(cache.ped)
            FreezeEntityPosition(cache.ped, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(false)
            end
            Status(add)
            Drug(effect)
        elseif animation.custom.enabled then
            if animation.custom.anim == "syringe" then
                if not using then
                    using = true
                    RequestAnimDict("rcmpaparazzo1ig_4")
                    while (not HasAnimDictLoaded("rcmpaparazzo1ig_4")) do Wait(0) end
                    TaskPlayAnim(cache.ped, 'rcmpaparazzo1ig_4', 'miranda_shooting_up', 8.0, -8, -1, 49, 0, 0, 0, 0)
                    local hash = GetHashKey("prop_syringe_01")
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Wait(100)
                        RequestModel(hash)
                    end
                    prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
                    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 18905), 0.12, 0.03, 0.03,
                        143.0
                        ,
                        30.0, 0.0, true, true, false, false, 1, true)
                    ProgressBar(12500, locale("PrepairingSyringe"))
                    Wait(1000)
                    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.03, -0.02,
                        1.0, 0
                        ,
                        0.0, true, true, false, false, 1, true)
                    ProgressBar(duration, text)
                    DetachEntity(prop, 0, 0)
                    DeleteEntity(prop)
                    ClearPedTasks(cache.ped)
                    using = false
                    Status(add)
                    Drug(effect)
                end
            end
        end
    end
end)

function Status(add)
    if add.enabled then
        if add.health.enabled then
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + add.health.add)
        end
        if add.armor.enabled then
            AddArmourToPed(PlayerPedId(), add.armor.add)
        end
        if add.strength.enabled then
            if not strength then
                strength = true
                SetTimeout(add.strength.time * 1000, function()
                    strength = false
                end)
            end
        end
        if add.speed.enabled then
            speed(add.speed.time)
        end
        if add.stamina.enabled then
            if not stamina then
                stamina = true
                SetTimeout(add.stamina.time * 1000, function()
                    stamina = false
                end)
            end
        end
    end
end

CreateThread(function()
    while true do
        local sleep = 2500
        if stamina then
            local player = PlayerId()
            sleep = 0
            RestorePlayerStamina(player, 1.0)
        end
        Wait(sleep)
    end
end)

function speed(time)
    local player = PlayerId()
    if not speed then
        speed = true
        SetRunSprintMultiplierForPlayer(player, 1.60)
        SetPedMoveRateOverride(player, 10.0)
        SetTimeout(time * 1000, function()
            SetRunSprintMultiplierForPlayer(player, 1.0)
            SetPedMoveRateOverride(player, 0.0)
            speed = false
        end)
    end
end

CreateThread(function()
    while true do
        local sleep = 2500
        if strength then
            local ped = PlayerPedId()
            local player = PlayerId()
            if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
                SetPlayerMeleeWeaponDamageModifier(player, 2.0)
            end
            sleep = 0
        else
            Wait(1000)
        end
        Wait(sleep)
    end
end)

function Drug(effect)
    if effect == "weed" then
        RequestAnimSet("move_m@drunk@verydrunk")
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Wait(0)
        end
        SetPedMotionBlur(cache.ped, true)
        SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@VERYDRUNK", 1000)
        StartScreenEffect("CamPushInFranklin", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("CamPushInFranklin")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(cache.ped, false)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "xanax" then
        RequestAnimSet("move_m@drunk@verydrunk")
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Wait(0)
        end
        SetPedMotionBlur(cache.ped, true)
        SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@VERYDRUNK", 1000)
        StartScreenEffect("DeadlineNeon", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("DeadlineNeon")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(cache.ped, false)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "ecstasy" then
        RequestAnimSet("move_m@drunk@verydrunk")
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Wait(0)
        end
        SetPedMotionBlur(cache.ped, true)
        SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@VERYDRUNK", 1000)
        StartScreenEffect("DeathFailMichaelIn", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("DeathFailMichaelIn")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(cache.ped, false)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "coke" then
        RequestAnimSet("move_m@alien")
        while not HasAnimSetLoaded("move_m@alien") do
            Wait(0)
        end
        SetPedMovementClipset(cache.ped, "move_m@alien", 1000)
        StartScreenEffect("BeastLaunch", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("BeastLaunch")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "Poison" then
        RequestAnimSet("move_m@drunk@verydrunk")
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Wait(0)
        end
        SetPedMotionBlur(cache.ped, true)
        SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@VERYDRUNK", 1000)
        StartScreenEffect("DeathFailMPIn", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 1.0)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("DeathFailMPIn")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(cache.ped, false)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "trip" then
        RequestAnimSet("move_m@drunk@verydrunk")
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Wait(0)
        end
        SetPedMotionBlur(cache.ped, true)
        SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@VERYDRUNK", 1000)
        StartScreenEffect("DMT_flight", 10000, true)
        ShakeGameplayCam("DRUNK_SHAKE", 2.0)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsDrivingOut", 3000, true)
        StopScreenEffect("DMT_flight")
        Wait(3000)
        StopScreenEffect("DrugsDrivingOut")
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(cache.ped, false)
        ResetPedMovementClipset(cache.ped, 2000)
    elseif effect == "alien" then
        ShakeGameplayCam("DRUNK_SHAKE", 3.0)
        RequestAnimSet("move_m@alien")
        while not HasAnimSetLoaded("move_m@alien") do
            Wait(0)
        end
        SetPedMovementClipset(cache.ped, "move_m@alien", 1000)
        StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
        Wait(math.random(25000, 38000))
        StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
        ResetPedMovementClipset(cache.ped, 2000)
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        StopScreenEffect("DrugsMichaelAliensFightIn")
        StopScreenEffect("DrugsMichaelAliensFight")
        StopScreenEffect("DrugsMichaelAliensFightOut")
    end
end

RegisterNetEvent("drc_drugs:consumables:menu")
AddEventHandler("drc_drugs:consumables:menu", function(data)
    if data == "weed_wrap" then
        lib.registerContext({
            id = 'WeedWrap',
            title = locale("BluntWraps"),
            options = {
                [locale("BluntRoll")] = {
                    arrow = false,
                    description = locale("BluntDesc"),
                    event = 'drc_drugs:consumables:progress',
                    args = { type = data }
                }
            }
        })
        lib.showContext('WeedWrap')
    elseif data == "syringe" then
        lib.registerContext({
            id = 'syringe',
            title = locale("Syringe"),
            options = {
                [locale("InsertHeroin")] = {
                    arrow = false,
                    description = locale("InsertHeroinDesc"),
                    event = 'drc_drugs:consumables:progress',
                    args = { type = data, drug = "heroin" }
                },
                [locale("InsertMeth")] = {
                    arrow = false,
                    description = locale("InsertMethDesc"),
                    event = 'drc_drugs:consumables:progress',
                    args = { type = data, drug = "meth" }
                }
            }
        })
        lib.showContext('syringe')
    elseif data == "weed_papers" then
        lib.registerContext({
            id = 'WeedPapers',
            title = locale("JointPapers"),
            options = {
                [locale("JointRoll")] = {
                    arrow = false,
                    description = locale("JointDesc"),
                    event = 'drc_drugs:consumables:progress',
                    args = { type = data }
                }
            }
        })
        lib.showContext('WeedPapers')
    end
end)

RegisterNetEvent("drc_drugs:consumables:progress")
AddEventHandler("drc_drugs:consumables:progress", function(data)
    if data == "xanax_pack" then
        if not IsProgressBarActive() then

            dict = "mp_arresting"
            clip = "a_uncuff"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(true)
            end
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(5000, locale("UnpackingXanax"))
            StopAnimTask(cache.ped, dict, clip, 1.0)
            Wait(0)
            FreezeEntityPosition(cache.ped, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(false)
            end
            TSE("drc_drugs:consumables:giveitems", data)
        end
    elseif data == "xanax_plate" then
        if not IsProgressBarActive() then
            dict = "mp_arresting"
            clip = "a_uncuff"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(true)
            end
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(5000, locale("UnpackingXanax"))
            StopAnimTask(cache.ped, dict, clip, 1.0)
            Wait(0)
            FreezeEntityPosition(cache.ped, false)
            if Config.Target == 'ox_target' then
                exports.ox_target:disableTargeting(false)
            end
            TSE("drc_drugs:consumables:giveitems", data)
        end
    end
    if data.type == "weed_wrap" then
        lib.callback('drc_drugs:consumables:getitem', false, function(value)
            if value then
                if not IsProgressBarActive() then

                    dict = "mp_arresting"
                    clip = "a_uncuff"
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Wait(0) end
                    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
                    local hash = `prop_cigar_02`
                    local hash2 = `bkr_prop_weed_bag_01a`
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Wait(100)
                        RequestModel(hash)
                    end
                    RequestModel(hash2)
                    while not HasModelLoaded(hash2) do
                        Wait(100)
                        RequestModel(hash2)
                    end
                    local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
                    local prop2 = CreateObject(hash2, GetEntityCoords(cache.ped), true, true, true)
                    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1, 0.03, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    AttachEntityToEntity(prop2, cache.ped, GetPedBoneIndex(cache.ped, 18905), 0.05, 0.01, 0.02, 0.0, 0.0, 20.0, true, true, false, false, 1, true)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(true)
                    end
                    FreezeEntityPosition(cache.ped, true)
                    ProgressBar(5000, locale("BluntRolling"))
                    DetachEntity(prop, false, false)
                    DeleteEntity(prop)
                    DetachEntity(prop2, false, false)
                    DeleteEntity(prop2)
                    StopAnimTask(cache.ped, dict, clip, 1.0)
                    Wait(0)
                    FreezeEntityPosition(cache.ped, false)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(false)
                    end
                    TSE("drc_drugs:consumables:giveitems", data.type)
                end
            else
                Notify("error", locale("error"), locale("RequiredItems"))
            end
        end, data.type)
    elseif data.type == "syringe" then
        lib.callback('drc_drugs:consumables:getitem', false, function(value)
            if value then
                if not IsProgressBarActive() then
                    dict = "mp_arresting"
                    clip = "a_uncuff"
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Wait(0) end
                    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
                    local hash = `prop_cigar_02`
                    local hash2 = `bkr_prop_weed_bag_01a`
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Wait(100)
                        RequestModel(hash)
                    end
                    RequestModel(hash2)
                    while not HasModelLoaded(hash2) do
                        Wait(100)
                        RequestModel(hash2)
                    end
                    local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
                    local prop2 = CreateObject(hash2, GetEntityCoords(cache.ped), true, true, true)
                    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1, 0.03, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    AttachEntityToEntity(prop2, cache.ped, GetPedBoneIndex(cache.ped, 18905), 0.05, 0.01, 0.02, 0.0, 0.0, 20.0, true, true, false, false, 1, true)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(true)
                    end
                    FreezeEntityPosition(cache.ped, true)
                    ProgressBar(5000, locale("Inserting"))
                    DetachEntity(prop, false, false)
                    DeleteEntity(prop)
                    DetachEntity(prop2, false, false)
                    DeleteEntity(prop2)
                    StopAnimTask(cache.ped, dict, clip, 1.0)
                    Wait(0)
                    FreezeEntityPosition(cache.ped, false)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(false)
                    end
                    TSE("drc_drugs:consumables:giveitems", data.drug)
                end
            else
                Notify("error", locale("error"), locale("RequiredItems"))
            end
        end, data.drug)
    elseif data.type == "weed_papers" then
        lib.callback('drc_drugs:consumables:getitem', false, function(value)
            if value then
                if not IsProgressBarActive() then
                    dict = "mp_arresting"
                    clip = "a_uncuff"
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Wait(0) end
                    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
                    local hash = `prop_cigar_02`
                    local hash2 = `bkr_prop_weed_bag_01a`
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Wait(100)
                        RequestModel(hash)
                    end
                    RequestModel(hash2)
                    while not HasModelLoaded(hash2) do
                        Wait(100)
                        RequestModel(hash2)
                    end
                    local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
                    local prop2 = CreateObject(hash2, GetEntityCoords(cache.ped), true, true, true)
                    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1, 0.03, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    AttachEntityToEntity(prop2, cache.ped, GetPedBoneIndex(cache.ped, 18905), 0.05, 0.01, 0.02, 0.0, 0.0, 20.0, true, true, false, false, 1, true)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(true)
                    end
                    FreezeEntityPosition(cache.ped, true)
                    ProgressBar(5000, locale("JointRolling"))
                    DetachEntity(prop, false, false)
                    DeleteEntity(prop)
                    DetachEntity(prop2, false, false)
                    DeleteEntity(prop2)
                    StopAnimTask(cache.ped, dict, clip, 1.0)
                    Wait(0)
                    FreezeEntityPosition(cache.ped, false)
                    if Config.Target == 'ox_target' then
                        exports.ox_target:disableTargeting(false)
                    end
                    TSE("drc_drugs:consumables:giveitems", data.type)
                end
            else
                Notify("error", locale("error"), locale("RequiredItems"))
            end
        end, data.type)
    end
end)
