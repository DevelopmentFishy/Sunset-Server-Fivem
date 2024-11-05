hasTracker = false

if not Config.TrackerItems.enabled then
    hasTracker = true
end

function RemoveTrackerItem(turnedOff)
    if blipsRunning then
        if Config.TrackerItems.enabled then hasTracker = false end
        
        if Config.TrackerItems.enabled then
            if turnedOff then
                ShowNotification(Locales["tracker_turned_off"], "error")
            else
                ShowNotification(Locales["tracker_removed"], "error")
                if Config.NotifyAllOtherMembers then
                    TriggerServerEvent("snipe-blips:server:trackerRemoved", fetchGroup, GetEntityCoords(PlayerPedId()))
                end
            end
        end
        lib.callback.await("snipe-blips:server:playerUnloaded", false)
        StopBlipThread()
    end
end

exports("RemoveTrackerItem", RemoveTrackerItem)

RegisterNetEvent("snipe-blips:client:RemoveTrackerItem", function()
    RemoveTrackerItem()
end)

local function UseTrackerItem()
    if blipsRunning and variable ~= PlayerJob.name then
        ShowNotification(Locales["already_have_a_different_tracker"], "error")
        return
    end
    if not hasTracker then
        local isValid = IsValidJob(PlayerJob.name)
        local isOnDuty = CheckOnDuty()
        if isValid  then
            if isOnDuty then
                hasTracker = true
                local groupName = GetGroupName(PlayerJob.name)

                lib.callback.await("snipe-blips:server:jobUpdated", false, groupName, isValid, PlayerJob.name, true, CheckOnDuty())
                ShowNotification(Locales["tracker_turned_on"], "success")
                UpdateBlips(isValid)
                
            else
                ShowNotification(Locales["not_on_duty_notify"], "error")
            end
        else
            ShowNotification(Locales["unrestricted_job_notify"], "error")
        end
    else
        RemoveTrackerItem(true)
    end
end

local function UseTrackerItemGang()
    if blipsRunning and variable ~= PlayerGang.name then
        ShowNotification(Locales["already_have_a_different_tracker"], "error")
        return
    end
    if not hasTracker then
        local isValidGang = IsValidGang(PlayerGang.name)
        if isValidGang  then
            hasTracker = true
            lib.callback.await("snipe-blips:server:gangUpdated", false, PlayerGang.name, isValidGang, true)
            ShowNotification(Locales["tracker_turned_on"], "success")
            UpdateBlips(isValidGang, true)
        else
            ShowNotification(Locales["not_valid_gang_notify"], "error")
        end
    else
        RemoveTrackerItem(true)
    end
end

lib.callback.register("snipe-blips:client:UseTrackerItem", function()
    UseTrackerItem()
    return true
end)

lib.callback.register("snipe-blips:client:UseTrackerItemGang", function()
    UseTrackerItemGang()
    return true
end)


RegisterNetEvent("esx:removeInventoryItem")
AddEventHandler("esx:removeInventoryItem", function(item)
    if item == Config.TrackerItems.jobItemName or item == Config.TrackerItems.gangItemName then
        RemoveTrackerItem()
    end
end)

RegisterNetEvent("inventory:client:ItemBox")
AddEventHandler("inventory:client:ItemBox", function(item, type)
    if item == Config.TrackerItems.jobItemName or item == Config.TrackerItems.gangItemName then
        RemoveTrackerItem()
    end
end)

-- Notifying all other job/gang members

local function DrawBlipOnMap(coords, name)
    CreateThread(function()
        -- draw a blip on the map for 5 seconds (change anything you want here)
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 161)
        SetBlipColour(blip, 1)
        SetBlipScale(blip, 1.0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        -- AddTextComponentString(name..": Last Location")
        EndTextCommandSetBlipName(blip)
        Wait(10000) -- change the time if you want, its 5 seconds now
        RemoveBlip(blip)
    end)
end

RegisterNetEvent("snipe-blips:client:trackerRemoved", function(group, isJob, coords, myId, name)
    if myId == GetPlayerServerId(PlayerId()) then return end  -- this line prevents the notification from showing up for the player whose tracker was removed (comment it to test if you are single player on the server)
    if isJob and next(PlayerJob) and PlayerJob.name == group and blipsRunning then
        ShowNotification(string.format(Locales["member_tracker_removed"], name), "error")
        DrawBlipOnMap(coords, name)
    end
end)