function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end


function hackAnimation()
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(100)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, Config.Locations['info'].animHeading)

    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", Config.Locations['info'].animPos, Config.Locations['info'].animPos, 0, 2) -- Animasyon kordinatları, buradan lokasyonu değiştirin // These are fixed locations so if you want to change animation location change here
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", Config.Locations['info'].animPos, Config.Locations['info'].animPos, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", Config.Locations['info'].animPos, Config.Locations['info'].animPos, 0, 2)
    -- part1
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
    -- part2
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)
    -- part3
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(netScene)
    Wait(6000)
    NetworkStopSynchronisedScene(netScene)

    CreateThread(function()
        while true do
            if Config.Hacking then
                NetworkStartSynchronisedScene(netScene2)
            end

            if not Config.Hacking then
                if not Config.Stopped then
                    NetworkStopSynchronisedScene(netScene2)
                    NetworkStartSynchronisedScene(netScene3)
                    Wait(4500)
                    NetworkStopSynchronisedScene(netScene3)
                    DeleteObject(bag)
                    DeleteObject(laptop)
                    DeleteObject(card)
                    FreezeEntityPosition(ped, false)
                    SetPedComponentVariation(ped, 5, 0, 0, 0)
                    Config.Stopped = true
                end
            end
            Wait(5000)
        end
    end)
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function MiniGameSettings()
    if Config.Minigame.game == 'path' then
        return Config.Minigame.minigame['path']
    elseif Config.Minigame.game == 'spot' then
        return Config.Minigame.minigame['spot']
    elseif Config.Minigame.game == 'math' then
        return Config.Minigame.minigame['math']
    end
end

function MiniGameSettings2()
    if Config.Minigame2.game == 'path' then
        return Config.Minigame2.minigame['path']
    elseif Config.Minigame2.game == 'spot' then
        return Config.Minigame2.minigame['spot']
    elseif Config.Minigame2.game == 'math' then
        return Config.Minigame2.minigame['math']
    end
end