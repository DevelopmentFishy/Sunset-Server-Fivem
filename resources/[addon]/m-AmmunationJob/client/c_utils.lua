local QBCore = exports[Config.Settings.Core]:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if not PlayerData.job.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
        end
    end)
end)

RegisterNetEvent(Config.Prefix..':Client:Notify')
AddEventHandler(Config.Prefix..":Client:Notify", function(msg,type)
    Notify(msg,type)
end)

function Notify(msg, type)
    if type == "primary" then 
        QBCore.Functions.Notify(msg, "primary")
    end
    if type == "success" then
        QBCore.Functions.Notify(msg, "success")
    end
    if type == "error" then
        QBCore.Functions.Notify(msg, "error")
    end
end

CreateThread(function()
    if Config.Job then
        exports[Config.Settings.Target]:AddBoxZone("StashAmmunation", vector3(1107.04, -2325.69, 31.44), 2.1, 1, { 
            name = "StashAmmunation", 
            heading = 86, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.44, 
            maxZ = 31.64 
        }, { 
            options = { 
                {  
                    action = function() OpenStash() end,
                    icon = "fas fa-box", 
                    label = "Stash", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ShopAmmunation", vector3(1111.33, -2327.62, 31.39), 0.8, 1, { 
            name = "ShopAmmunation", 
            heading = 356, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.39, 
            maxZ = 32.19 
        }, { 
            options = { 
                {  
                    action = function() OpenShop() end,
                    icon = "fas fa-box", 
                    label = "Shop", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("CraftAmmunation", vector3(1104.69, -2327.16, 31.39), 1.0, 1, { 
            name = "CraftAmmunation", 
            heading = 355, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.99, 
            maxZ = 32.59 
        }, { 
            options = { 
                {  
                    action = function() CraftWeapons() end,
                    icon = "fa-solid fa-gun", 
                    label = "Craft Weapons", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ShopAttachments", vector3(1111.37, -2328.65, 31.39), 1, 1, { 
            name = "ShopAttachments", 
            heading = 356, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.19, 
            maxZ = 31.99 
        }, { 
            options = { 
                {  
                    action = function() ChooseChop() end,
                    icon = "fas fa-box", 
                    label = "Shop Attachments", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ObtainPieces", Config.Peds[1], 1.2, 1.0, { 
            name = "ObtainPieces", 
            heading = 33, 
            debugPoly = Config.Settings.Debug, 
            minZ = Config.Peds[1].z-1, 
            maxZ = Config.Peds[1].z+2
        }, { 
            options = { 
                {  
                    event = Config.Prefix..":Client:ObtainPieces", 
                    icon = "fas fa-box", 
                    label = "Obtain Pieces", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("BlueprintsMenu", vector3(1110.98, -2326.37, 31.39), 1.4, 1, { 
            name = "BlueprintsMenu", 
            heading = 4, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.39, 
            maxZ = 32.59
        }, { 
            options = { 
                {  
                    action = function() BlueprintShop() end,
                    icon = "fas fa-box", 
                    label = "Blueprints", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("Billing", vector3(0,0,0), 0.5, 0.5, { 
            name = "Billing", 
            heading = 0, 
            debugPoly = Config.Settings.Debug, 
            minZ = 29.62,
            maxZ = 30.02
        }, { 
            options = { 
                {  
                    action = function() Billing() end,
                    icon = "fa-solid fa-money-bill", 
                    label = "Bill Player", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

        for k,v in pairs(Config.TestWeapons) do
            exports[Config.Settings.Target]:AddCircleZone("TestWeapons"..k, v.coords, 0.8, { 
                name = "TestWeapons"..k, 
                debugPoly = Config.Settings.Debug,
                useZ = true, 
            }, { 
                options = { 
                    { 
                        event = Config.Prefix..":Client:TestWeaponsMenu", 
                        icon = "fa-solid fa-gun", 
                        label = "Test Weapons", 
                    }, 
                },
                distance = 2.5
            })
        end

        exports[Config.Settings.Target]:AddTargetModel(`prop_box_wood02a_pu`, {
            options = {
                {
                    event = Config.Prefix..":Client:GettingPieces",
                    icon = "fas fa-box",
                    label = "Get Pieces",
                    job = Config.Settings.Job,
                },
            },
            distance = 2.5,
        })

        exports[Config.Settings.Target]:AddBoxZone("Duty", vector3(1104.7, -2330.69, 31.39), 0.5, 0.5, { 
            name = "Duty", 
            heading = 350, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.19,
            maxZ = 31.79
        }, { 
            options = { 
                {  
                    action = function() Duty() end,
                    icon = "fas fa-tshirt", 
                    label = "Duty", 
                    job = Config.Settings.Job 
                }, 
            },  
            distance = 2.0 
        })

    else
        exports[Config.Settings.Target]:AddBoxZone("StashAmmunation", vector3(1107.04, -2325.69, 31.44), 2.1, 1, { 
            name = "StashAmmunation", 
            heading = 86, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.44, 
            maxZ = 31.64 
        }, { 
            options = { 
                {  
                    action = function() OpenStash() end,
                    icon = "fas fa-box", 
                    label = "Stash", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ShopAmmunation", vector3(1111.33, -2327.62, 31.39), 0.8, 1, { 
            name = "ShopAmmunation", 
            heading = 356, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.39, 
            maxZ = 32.19 
        }, { 
            options = { 
                {  
                    action = function() OpenShop() end,
                    icon = "fas fa-box", 
                    label = "Shop", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("CraftAmmunation", vector3(1104.69, -2327.16, 31.39), 1.0, 1, { 
            name = "CraftAmmunation", 
            heading = 355, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.99, 
            maxZ = 32.59 
        }, { 
            options = { 
                {  
                    action = function() CraftWeapons() end,
                    icon = "fa-solid fa-gun", 
                    label = "Craft Weapons", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ShopAttachments", vector3(1111.37, -2328.65, 31.39), 1, 1, { 
            name = "ShopAttachments", 
            heading = 356, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.19, 
            maxZ = 31.99 
        }, { 
            options = { 
                {  
                    action = function() ChooseChop() end,
                    icon = "fas fa-box", 
                    label = "Shop Attachments", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("ObtainPieces", Config.Peds[1], 1.2, 1.0, { 
            name = "ObtainPieces", 
            heading = 33, 
            debugPoly = Config.Settings.Debug, 
            minZ = Config.Peds[1].z-1, 
            maxZ = Config.Peds[1].z+2
        }, { 
            options = { 
                {  
                    event = Config.Prefix..":Client:ObtainPieces", 
                    icon = "fas fa-box", 
                    label = "Obtain Pieces", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("BlueprintsMenu", vector3(1110.98, -2326.37, 31.39), 1.4, 1, { 
            name = "BlueprintsMenu", 
            heading = 4, 
            debugPoly = Config.Settings.Debug, 
            minZ = 30.39, 
            maxZ = 32.59
        }, { 
            options = { 
                {  
                    action = function() BlueprintShop() end,
                    icon = "fas fa-box", 
                    label = "Blueprints", 
                }, 
            },  
            distance = 2.0 
        })

        exports[Config.Settings.Target]:AddBoxZone("Billing", vector3(0,0,0), 0.5, 0.5, { 
            name = "Billing", 
            heading = 0, 
            debugPoly = Config.Settings.Debug, 
            minZ = 29.62,
            maxZ = 30.02
        }, { 
            options = { 
                {  
                    action = function() Billing() end,
                    icon = "fa-solid fa-money-bill", 
                    label = "Bill Player", 
                }, 
            },  
            distance = 2.0 
        })

        for k,v in pairs(Config.TestWeapons) do
            exports[Config.Settings.Target]:AddCircleZone("TestWeapons"..k, v.coords, 0.8, { 
                name = "TestWeapons"..k, 
                debugPoly = Config.Settings.Debug,
                useZ = true, 
            }, { 
                options = { 
                    { 
                        event = Config.Prefix..":Client:TestWeaponsMenu", 
                        icon = "fa-solid fa-gun", 
                        label = "Test Weapons", 
                    }, 
                },
                distance = 2.5
            })
        end

        exports[Config.Settings.Target]:AddTargetModel(`prop_box_wood02a_pu`, {
            options = {
                {
                    event = Config.Prefix..":Client:GettingPieces",
                    icon = "fas fa-box",
                    label = "Get Pieces",
                },
            },
            distance = 2.5,
        })

       exports[Config.Settings.Target]:AddBoxZone("Duty", vector3(1104.7, -2330.69, 31.39), 0.5, 0.5, { 
            name = "Duty", 
            heading = 350, 
            debugPoly = Config.Settings.Debug, 
            minZ = 31.19,
            maxZ = 31.79
        }, { 
            options = { 
                {  
                    action = function() Duty() end,
                    icon = "fas fa-tshirt", 
                    label = "Duty", 
                }, 
            },  
            distance = 2.0 
        })
    end
end)

