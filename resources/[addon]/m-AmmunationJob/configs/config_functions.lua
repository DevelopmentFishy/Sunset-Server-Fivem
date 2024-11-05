local QBCore = exports[Config.Settings.Core]:GetCoreObject()


-- ███████╗██╗░░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
-- ██╔════╝██║░░░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
-- █████╗░░██║░░░██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
-- ██╔══╝░░██║░░░██║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
-- ██║░░░░░╚██████╔╝╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░░░░░░╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

-- Function to check job on event's
function ValidJob()
    local job = QBCore.Functions.GetPlayerData().job.name 
    if job ~= Config.Settings.Job then 
        return Notify(Config.Text[Config.Language]["NoJob"]) 
    else
        return true
    end
end

-- Function to check job on event's
function Duty()
    TriggerServerEvent("QBCore:ToggleDuty")
end

-- Function to give weapons on testing
function GiveWeapon(option)
    local wait = Config.TestingTime * 1000
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    if option == "weapon_heavypistol" then
        GiveWeaponToPed(src, GetHashKey("weapon_heavypistol"), 1, true, true)
        Wait(1000)
        SetPedAmmo(src, "weapon_heavypistol", 50)
        Wait(wait)
        RemoveWeaponFromPed(src, GetHashKey("weapon_heavypistol"), 1, true, true)
    elseif option == "weapon_snspistol" then
        GiveWeaponToPed(src, GetHashKey("weapon_snspistol"), 1, true, true)
        Wait(1000)
        SetPedAmmo(src, "weapon_snspistol", 50)
        Wait(wait)
        RemoveWeaponFromPed(src, GetHashKey("weapon_snspistol"), 1, true, true)
    elseif option == "weapon_combatpistol" then
        GiveWeaponToPed(src, GetHashKey("weapon_combatpistol"), 1, true, true)
        Wait(1000)
        SetPedAmmo(src, "weapon_combatpistol", 50)
        Wait(wait)
        RemoveWeaponFromPed(src, GetHashKey("weapon_combatpistol"), 1, true, true)
    elseif option == "weapon_pistol50" then
        GiveWeaponToPed(src, GetHashKey("weapon_pistol50"), 1, true, true)
        Wait(1000)
        SetPedAmmo(src, "weapon_pistol50", 50)
        Wait(wait)
        RemoveWeaponFromPed(src, GetHashKey("weapon_pistol50"), 1, true, true)
    elseif option == "weapon_machinepistol" then
    GiveWeaponToPed(src, GetHashKey("weapon_machinepistol"), 1, true, true)
    Wait(1000)
    SetPedAmmo(src, "weapon_machinepistol", 50)
    Wait(wait)
    RemoveWeaponFromPed(src, GetHashKey("weapon_machinepistol"), 1, true, true)
    elseif option == "weapon_compactrifle" then
    GiveWeaponToPed(src, GetHashKey("weapon_compactrifle"), 1, true, true)
    Wait(1000)
    SetPedAmmo(src, "weapon_compactrifle", 50)
    Wait(wait)
    RemoveWeaponFromPed(src, GetHashKey("weapon_compactrifle"), 1, true, true)
end
end

-- Function to open the stash
function OpenStash()
    if Config.Job then if not ValidJob() then return false end end
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Ammunation") 
    TriggerEvent("inventory:client:SetCurrentStash", "Ammunation") 
end

-- Function to open the shop
function OpenShop()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Ammunation_Shop", {
        label = "Ammunation_Shop",
        items = Config.Shop,
        slots = #Config.Shop,
    })
end

-- Function to open a the shop of clips and suppressors
function OpenShops(type)
    if Config.Job then if not ValidJob() then return false end end
    local option = type.type
    if option == "ammo" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "DefaultClips_Ammunation", {
            label = "DefaultClips_Ammunation",
            items = Config.DefaultClips,
            slots = #Config.DefaultClips,
        })
    elseif option == "extendedclips" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "ExtendedClips_Ammunation", {
            label = "ExtendedClips_Ammunation",
            items = Config.ExtendedClips,
            slots = #Config.ExtendedClips,
        })
    elseif option == "suppressors" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Suppressors_Ammunation", {
            label = "Suppressors_Ammunation",
            items = Config.Suppressors,
            slots = #Config.Suppressors,
        })
    end
end

-- Function to open qb-menu with list of shops available
function ChooseChop()
    if Config.Job then if not ValidJob() then return false end end
    TriggerEvent('qb-menu:client:openMenu', {
        { id = 0, header = "Shops Options", isMenuHeader = true },
        { id = 1, header = "[🔹] Ammo",     txt = "❓ Here you will find all standard magazines for various weapons.", params = {event = "m-Ammunation:Client:OpenShop", args = { type = "ammo" }}},
        { id = 2, header = "[🔹] Extended Clips",    txt = "❓ Here you will find all extended magazines for various weapons.", params = {event = "m-Ammunation:Client:OpenShop", args = { type = "extendedclips" }}},
        { id = 3, header = "[🔹] Suppressors",       txt = "❓ Here you will find all silencers for various weapons.", params = {event = "m-Ammunation:Client:OpenShop", args = { type = "suppressors" }}},
        { id = 4, header = "[❌] Close",             txt = '', params = {event = 'qb-menu:closeMenu'}}
    })
end

-- Function of qb-menu for crafting weapons
function CraftWeapons()
    if Config.Job then if not ValidJob() then return false end end
    local columns = {
        {
            header = "Craft Weapons",
            isMenuHeader = true,
        },
    }
    for k, v in pairs(Config.CraftWeapons) do
    local item = {}
        if Config.LevelSystem.Enable then 
            exports["mz-skills"]:CheckSkill(Config.LevelSystem.XP_Name, v.level, function(hasskill)
                if hasskill then
                    item.header = "<img src=nui://"..Config.Settings.Inventory..QBCore.Shared.Items[v.hash].image.." width=35px style='margin-right: 10px'> " .. v.label
                    local text = "Required: <br>"
                    for k, v in pairs(v.materials) do
                        text = text .. "- " .. QBCore.Shared.Items[v.item].label .. ": " .. v.amount .. "<br>"
                    end
                    item.text = text
                    item.params = {
                        event = Config.Prefix..':Client:CraftingWeapon',
                        args = {
                            type = k
                        }
                    }
                    table.insert(columns, item)
                end
            end)
        else
            item.header = "<img src=nui://"..Config.Settings.Inventory..QBCore.Shared.Items[v.hash].image.." width=35px style='margin-right: 10px'> " .. v.label
            local text = "Required: <br>"
            for k, v in pairs(v.materials) do
                text = text .. "- " .. QBCore.Shared.Items[v.item].label .. ": " .. v.amount .. "<br>"
            end
            item.text = text
            item.params = {
                event = Config.Prefix..':Client:CraftingWeapon',
                args = {
                    type = k
                }
            }
            table.insert(columns, item)
        end
    end
    exports[Config.Settings.Menu]:openMenu(columns)
end

-- Function go give XP when crafting weapons
function GiveXP()
    local Amount = math.random(Config.LevelSystem.CraftWeapons.min,Config.LevelSystem.CraftWeapons.max)
    if Config.Settings.Debug then print("Skill: "..Config.LevelSystem.XP_Name) print("Amount: "..Amount) end
    exports["mz-skills"]:UpdateSkill(Config.LevelSystem.XP_Name, Amount)
end

-- Function to bill players
function Billing()
    if Config.Job then if not ValidJob() then return false end end
    if Config.Settings.JimPayments then
        TriggerEvent("jim-payments:client:Charge", Config.Settings.Job)
    else
        local dialog = exports["qb-input"]:ShowInput({
            header = "Ammunation Billing",
            submitText = "Submit",
            inputs = { 
                { type = 'number', isRequired = true, name = 'id', text = "Citizen ID (#)" },
                { type = 'number', isRequired = true, name = 'amount', text = "Bill Price ($)" }
            }
        })
        if dialog then
            if not dialog.id or not dialog.amount then return end
            TriggerServerEvent("m-Ammunation:Server:Billing", dialog.id, dialog.amount)
        end
    end
end

-- Function to spawn a box on location to getting pieces
function CreateAmmuProp()
    prop = true
    local modelHash = Config.Pieces.Prop -- You can change it https://gtahash.ru/

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end

    local obj = CreateObject(modelHash, Config.Pieces.PropLocation, true)
    SetEntityHeading(obj, 92.40) -- Heading of the object
end

-- Function to open a shop with blueprints
function BlueprintShop()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Blueprints_Shop", {
        label = "Blueprints_Shop",
        items = Config.Blueprints,
        slots = #Config.Blueprints,
    })
end

-- Function of email to collecting pieces
function Email()
    if Config.Settings.Phone == "qb-phone" then
        TriggerServerEvent("qb-phone:server:sendNewMail", {
            sender = "Ammunation Guy",
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
        })
    elseif Config.Settings.Phone == "qs-smartphone" then
        TriggerServerEvent("qs-smartphone:server:sendNewMail", {
            sender = "Ammunation Guy",
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
        })
    elseif Config.Settings.Phone == "gksphone" then
        TriggerServerEvent("gksphone:NewMail", {
            sender = "Ammunation Guy",
            image = '/html/static/img/icons/mail.png',
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
        })
    elseif Config.Settings.Phone == "roadphone" then
        TriggerServerEvent("roadphone:receiveMail", {
            sender = "Ammunation Guy",
            image = '/public/html/static/img/icons/app/mail.png',
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
        })
    elseif Config.Settings.Phone == "d-phone" then
        TriggerServerEvent("mail:functions:sendmail:tosource", 1, "Ammunation Guy", "Ammunation Guy", "Collecting Pieces", Config.Text[Config.Language]["Waypoint"], nil)
    elseif Config.Settings.Phone == "renewed-phone" then
        TriggerServerEvent("qb-phone:server:sendNewMail", {
            sender = "Ammunation Guy",
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
            button = {
                buttonEvent = "Renewed-Debt:server:AcceptShit",
                buttonData = 10,
                isServer = false
            }
        })        
    elseif Config.Settings.Phone == "jpr-phone" then
        TriggerServerEvent("jpr-newphone:server:sendNewMailFix", {
            sender = "Ammunation Guy",
            image = '/public/html/static/img/icons/app/mail.png',
            subject = "Collecting Pieces",
            message = Config.Text[Config.Language]["Waypoint"],
        })
    elseif Config.Settings.Phone == "notify" then
        Notify(Config.Text[Config.Language]["Waypoint"], "primary", 5000) 
    end
end
