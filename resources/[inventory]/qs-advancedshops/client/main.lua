Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if CheckPlayerJobName() ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Shops) do
                for z, t in pairs(v.Shop.job) do
                    for a, b in pairs(v.Shop.grade) do
                        if t == 'all' or ((CheckPlayerJobName().name == t and b == 'all') or (CheckPlayerJobName().name == t and tostring(b) == tostring(CheckPlayerJobGrade()))) then
                            for val, coords in pairs(v.coords) do
                                local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                                if distance < (v.Shop.distanceMarker or 15) then
                                    sleep = 2
                                    DrawMarker(v.Shop.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Shop.markerSize.x or 0.2, v.Shop.markerSize.y or 0.2, v.Shop.markerSize.z or 0.2, v.Shop.markerColour.r or 55, v.Shop.markerColour.g or 255, v.Shop.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                                    if distance < (v.Shop.distanceText or 2) then
                                        if v.Shop.use3dtext then
                                            DrawText3D(coords.x, coords.y, coords.z + 0.2, v.Shop.msg or '[E]')
                                        else
                                            ShowHelpNotification(v.Shop.msg or '~INPUT_CONTEXT~')
                                        end
                                        if IsControlJustPressed(0, 38) then
                                            ItemsInfo(v.Shop.items)
                                            OpenMarket(v)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end) 

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if CheckPlayerJobName() ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Stashs) do
                for a, b in pairs(v.Stash.grade) do
                    if v.Stash.job == 'all' or (CheckPlayerJobName().name == v.Stash.job and b == 'all') or (CheckPlayerJobName().name == v.Stash.job and tostring(b) == tostring(CheckPlayerJobGrade())) and v.Stash.useMarker then
                        for val, coords in pairs(v.coords) do
                            local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                            if distance < 15 then
                                sleep = 2
                                DrawMarker(v.Stash.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Stash.markerSize.x or 0.2, v.Stash.markerSize.y or 0.2, v.Stash.markerSize.z or 0.2, v.Stash.markerColour.r or 55, v.Stash.markerColour.g or 255, v.Stash.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                                if distance < 2 then
                                    if v.Stash.use3dtext then
                                        DrawText3D(coords.x, coords.y, coords.z + 0.2, v.Stash.msg or '[E]')
                                    else
                                        ShowHelpNotification(v.Stash.msg or '~INPUT_CONTEXT~')
                                    end
                                    if IsControlJustPressed(0, 38) then
                                        OpenStash(v)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function OpenStash(v)
    if v.personal then v.label = PlayerIdForStash(id) end
    local other = {}
    other.maxweight = v.Stash.maxweight
    other.slots = v.Stash.slots
    TriggerServerEvent("inventory:server:OpenInventory", "stash", v.label, other)
    TriggerEvent("inventory:client:SetCurrentStash", v.label)
end

function OpenMarket(v)
    local ShopItems = {}
    ShopItems.label = v.label
    ShopItems.items = v.Shop.items
    ShopItems.slots = #v.Shop.items
    ShopItems.type = v.Shop.type
    if (v.Shop.license ~= nil and v.Shop.license ~= false) then -- Require license
        if Config.WeaponLicense == 'item' then
            local HasItem = exports['qs-inventory']:HasItem(v.Shop.license, 1)
            if HasItem then 
                TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..math.random(11111,99999), ShopItems)
            else
                SendTextMessage(v.Shop.licenseError, 'error')
            end
        elseif Config.WeaponLicense == 'license' then
            if Config.Framework == 'esx' then
                TriggerServerCallback(Config.esx_licensecheckLicense, function(hasWeaponLicense)
                    print(json.encode(hasWeaponLicense))
                    if hasWeaponLicense then
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..math.random(11111,99999), ShopItems)
                    else
                        SendTextMessage(v.Shop.licenseError, 'error')
                    end
                end, GetPlayerServerId(PlayerId()), v.Shop.license)	
            elseif Config.Framework == 'qb' then
                DebugPrint('Config.esx_licensecheckLicense is only for ESX...')
            end
        else 
            DebugPrint('Check Config.WeaponLicense, this should be item or license.')
        end
    else 
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..math.random(11111,99999), ShopItems)
    end
end

Citizen.CreateThread( function()
    Citizen.Wait(1000)
    while CheckPlayerJobName() == nil do 
        Citizen.Wait(10)
    end

    for k, v in pairs(Config.Shops) do
        if v.Shop.blip then
            for z, t in pairs(v.Shop.job) do
                if t == 'all' or CheckPlayerJobName().name == t then
                    for val, coords in pairs(v.coords) do
                        local _blip = AddBlipForCoord(coords.x, coords.y, coords.z)

                        SetBlipSprite(_blip, v.Shop.blip.id or 1)
                        SetBlipDisplay(_blip, 4)
                        SetBlipScale(_blip, v.Shop.blip.scale or 0.5)
                        SetBlipColour(_blip, v.Shop.blip.color or 1)
                        SetBlipAsShortRange(_blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.Shop.blip.title or 'nil')
                        EndTextCommandSetBlipName(_blip)
                    end
                end
            end
        end
    end
end)