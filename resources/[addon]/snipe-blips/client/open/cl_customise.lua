QBCore, ESX = nil, nil
PlayerJob = {}
PlayerGang = {}
gangBlipRunning = false
fetchGroup = nil

CreateThread(function()
    if Config.Core == "QBCore" then
        local status, errorMsg = pcall(function() QBCore = exports[Config.CoreFolderName]:GetCoreObject() end)
        Wait(250)
        if QBCore == nil then
            Citizen.CreateThread(function()
                while QBCore == nil do
                    TriggerEvent(Config.Core..':GetObject', function(obj) QBCore = obj end)
                    Citizen.Wait(200)
                end
            end)
        end
    elseif Config.Core == "ESX" then
        ESX = exports[Config.CoreFolderName]:getSharedObject()
        Wait(250)
        if (ESX == nil) then
            while ESX == nil do
                Wait(100)
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            end
        end
    end
end)

local function UpdatePlayerJob()
    if Config.Core == "QBCore" then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    elseif Config.Core == "ESX" then
        while ESX.GetPlayerData() == nil do
            Wait(100)
        end
        while ESX.GetPlayerData().job == nil do
            Wait(100)
        end
        PlayerJob = ESX.GetPlayerData().job
    end
end

local function UpdatePlayerGang()
    if Config.Core == "QBCore" then
        PlayerGang = QBCore.Functions.GetPlayerData().gang
    end
end

function UpdateBlips(isValid, isGang)
    if not isGang and not CheckOnDuty() then
        if blipsRunning then
            RemoveTrackerItem()
            return
        end
    end
    if isValid then
        if isGang and not blipsRunning then
            variable = PlayerGang.name
            fetchGroup = PlayerGang.name
            gangBlipRunning = true
            StartBlipThread()
            
        elseif isGang and blipsRunning then
            RemoveTrackerItem()
        elseif not isGang then
            if not blipsRunning and CheckOnDuty() then
                variable = PlayerJob.name
                fetchGroup = GetGroupName(PlayerJob.name)
                StartBlipThread()
            elseif blipsRunning and variable ~= PlayerGang.name and not CheckOnDuty() then
                RemoveTrackerItem()
            end
        end
    elseif not isValid then
        if blipsRunning and not gangBlipRunning then
            RemoveTrackerItem()
        end
    end
end

-- Do not touch if you dont know what you are doing!!
AddEventHandler('onResourceStart', function(resourceName)
    Wait(1000)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    UpdatePlayerJob()
    UpdatePlayerGang()
    local isValid = IsValidJob(PlayerJob.name)
    if not isValid then 
        local isValidGang = IsValidGang(PlayerGang.name)
        lib.callback.await("snipe-blips:server:gangUpdated", false, PlayerGang.name, isValidGang)
        UpdateBlips(isValidGang, true)
        
    else
        local groupName = GetGroupName(PlayerJob.name)
        lib.callback.await("snipe-blips:server:playerLoaded", false, groupName, isValid, PlayerJob.name, CheckOnDuty())
        UpdateBlips(isValid, false)
    end
    
end)

RegisterNetEvent(Config.PlayerLoadedEvent)
AddEventHandler(Config.PlayerLoadedEvent, function()
    UpdatePlayerJob()
    UpdatePlayerGang()
    local isValid = IsValidJob(PlayerJob.name)
    
    if not isValid then 
        local isValidGang = IsValidGang(PlayerGang.name)
        lib.callback.await("snipe-blips:server:gangUpdated", false, PlayerGang.gang, isValidGang)
        UpdateBlips(isValidGang, true)
        
    else
        local groupName = GetGroupName(PlayerJob.name)
        lib.callback.await("snipe-blips:server:playerLoaded", false, groupName, isValid, PlayerJob.name, CheckOnDuty())
        UpdateBlips(isValid, false)
    end
    
end)

RegisterNetEvent(Config.PlayerUnloadEvent)
AddEventHandler(Config.PlayerUnloadEvent, function()
    PlayerJob = {}
    PlayerGang = {}
    lib.callback.await("snipe-blips:server:playerUnloaded")
end)

RegisterNetEvent(Config.JobUpdateEvent)
AddEventHandler(Config.JobUpdateEvent, function(jobInfo)
    PlayerJob = jobInfo
    if not gangBlipRunning then 
        local isValid = IsValidJob(PlayerJob.name)
        local groupName = GetGroupName(PlayerJob.name)
        lib.callback.await("snipe-blips:server:jobUpdated", false, groupName, isValid, PlayerJob.name, false, CheckOnDuty())
        UpdateBlips(isValid, false)
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(boolean)
    PlayerJob.onduty = boolean
    if not boolean and not gangBlipRunning then
        lib.callback.await("snipe-blips:server:playerUnloaded", false)
    end
    if not gangBlipRunning then
        local isValid = IsValidJob(PlayerJob.name)
        local groupName = GetGroupName(PlayerJob.name)
        lib.callback.await("snipe-blips:server:jobUpdated", false, groupName, isValid, PlayerJob.name, false, CheckOnDuty())
        Wait(100)
        UpdateBlips(isValid, false)
    end
end)

RegisterNetEvent(Config.GangUpdateEvent)
AddEventHandler(Config.GangUpdateEvent, function(gangInfo)
    PlayerGang = gangInfo
    local isValid = IsValidJob(PlayerJob.name)
    local isValidGang = IsValidGang(PlayerGang.name)
    lib.callback.await("snipe-blips:server:gangUpdated", false, PlayerGang.name, isValidGang)
    UpdateBlips(isValidGang, true)
end)

function ShowNotification(msg, type)
    if Config.Core == "QBCore" then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Core == "ESX" then
        ESX.ShowNotification(msg)
    end
end