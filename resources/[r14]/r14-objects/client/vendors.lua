local QBCore = exports['qb-core']:GetCoreObject()

local SpawnedVendors = {}
local loaded = false

-------------- functions ----------------

local function SpawnVendors()
    local vendors, count = {}, 0
    for k, v in pairs(Config.Containers.Vendors) do
        vendors[count + 1] = {
            spawnNow = true,
            model = v.ped, -- This is the ped model that is going to be spawning at the given coords
            coords = v.coords, -- This is the coords that the ped is going to spawn at, always has to be a vector4 and the w value is the heading
            minusOne = v.minusOne, -- Set this to true if your ped is hovering above the ground but you want it on the ground (OPTIONAL)
            freeze = true, -- Set this to true if you want the ped to be frozen at the given coords (OPTIONAL)
            invincible = true, -- Set this to true if you want the ped to not take any damage from any source (OPTIONAL)
            blockevents = true, -- Set this to true if you don't want the ped to react the to the environment (OPTIONAL)
            animDict = v.dict, -- This is the animation dictionairy to load the animation to play from (OPTIONAL)
            anim = v.anim, -- This is the animation that will play chosen from the animDict, this will loop the whole time the ped is spawned (OPTIONAL)
            flag = v.flag, -- This is the flag of the animation to play, for all the flags, check the TaskPlayAnim native here https://docs.fivem.net/natives/?_0x5AB552C6 (OPTIONAL)
            scenario = v.scenario, -- This is the scenario that will play the whole time the ped is spawned, this cannot pair with anim and animDict (OPTIONAL)
            target = { -- This is the target options table, here you can specify all the options to display when targeting the ped (OPTIONAL)
            options = { -- This is your options table, in this table all the options will be specified for the target to accept
                { 
                    num = 1,
                    type = "client", 
                    event = "r14-obj:client:viewinventory", 
                    icon = 'fas fa-basket-shopping', 
                    label = ('Shop %s'):format(v.label),
                    vendor = k,
                },
                { 
                    num = 2,
                    type = "client", 
                    event = 'r14-obj:client:checkID', 
                    icon = 'fas fa-list-check', 
                    label = 'Manage Rented Units',
                    vendor = k,
                    next = "r14-obj:client:viewunits",
                    canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                        if not Config.Containers.Vendors[k].norecords then return true end
                    end,
                },
                { 
                    num = 3,
                    type = "client", 
                    event = "r14-obj:client:vendorwarrant", 
                    icon = 'fas fa-file', 
                    label = '[LEO Only] Request Business Records', 
                    canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                        if Config.Containers.Vendors[k].norecords then return false end
                        if Config.AuthorizedJobs.LEO.Check() then return true end
                    end,
                    vendor = k,
                },
            },
            distance = v.dist or Config.MaxDist, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
            },
        action = function(data) SpawnedVendors[data.currentpednumber] = true end
        }
        count = count + 1
    end

    exports['qb-target']:SpawnPed(vendors)
end

local function DeleteVendors()
    if (GetCurrentResourceName() == resourceName) then
        local DeleteList = {}

        CurrentPeds = exports['qb-target']:GetPeds()

        for k, v in pairs(CurrentPeds) do
            if SpawnedVendors[v.currentpednumber] then
                DeleteList[k] = v.currentpednumber
            end
        end

        exports['qb-target']:RemoveSpawnedPed(DeleteList)
    end
end

------------ base events ----------------

AddEventHandler('onResourceStart', function(resourceName) -- spawns ped so if restarted in runtime they spawn
    if (GetCurrentResourceName() == resourceName) then
        if LocalPlayer.state.isLoggedIn then SpawnVendors() end
    end
end)

AddEventHandler('onResourceStop', function(resourceName) -- deletes peds so they can be respawned
    if (GetCurrentResourceName() == resourceName) then
        local DeleteList = {}

        CurrentPeds = exports['qb-target']:GetPeds()

        for k, v in pairs(CurrentPeds) do
            if SpawnedVendors[v.currentpednumber] then
                DeleteList[k] = v.currentpednumber
            end
        end

        exports['qb-target']:RemoveSpawnedPed(DeleteList)
    end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()

    if not loaded and Config.Containers then
        SpawnVendors()
    end

    loaded = true
end)

----------------- net events -------------------------

RegisterNetEvent('r14-obj:client:vendormenu', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = ('Welcome to %s'):format(Config.Containers.Vendors[data.vendor].label),
            isMenuHeader = true,
        }
    }

    if Config.Containers.Vendors[data.vendor].greeting then
        qbMenu[#qbMenu+1] = {
            header = ('<i>%s</i>'):format(Config.Containers.Vendors[data.vendor].greeting),
            disabled = true,
        }
    end

    qbMenu[#qbMenu+1] = {
        header = 'View Inventory',
        params = {
            event = 'r14-obj:client:viewinventory',
            args = {
                vendor = data.vendor,
            },
        },
    }

    if not Config.Containers.Vendors[data.vendor].norecords then
        qbMenu[#qbMenu+1] = {
            header = 'Manage Rented Units',
            params = {
                event = 'r14-obj:client:checkID',
                args = {
                    vendor = data.vendor,
                    next = "r14-obj:client:viewunits",
                },
            },
        }
    end

    if not Config.Containers.Vendors[data.vendor].norecords and Config.AuthorizedJobs.LEO.Check() then
        qbMenu[#qbMenu+1] = {
            header = '[LEO Only] Request Records',
            params = {
                event = "r14-obj:client:vendorwarrant",
                args = {
                    vendor = data.vendor,
                },
            },
        }
    end

    qbMenu[#qbMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(qbMenu)
end)

RegisterNetEvent('r14-obj:client:viewinventory', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = ('Shop %s'):format(Config.Containers.Vendors[data.vendor].label),
            isMenuHeader = true,
        }
    }

    for k, v in pairs(Config.Containers.Vendors[data.vendor].inventory) do
        qbMenu[#qbMenu+1] = {
            header = ('Purchase %s'):format(Config.Objects[k].label),
            params = {
                event = 'r14-obj:client:checkID',
                args = {
                    type = k,
                    vendor = data.vendor,
                    next = 'r14-obj:client:selecttender',
                    nextServer = false,
                    after = 'r14-obj:server:createcontract',
                    afterServer = true,
                }
            }
        }
    end

    qbMenu[#qbMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(qbMenu)
end)

RegisterNetEvent("r14-obj:client:checkID", function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = 'Present ID to Continue Purchase',
            isMenuHeader = true,
        }
    }

    for k, v in pairs(PlayerData.items) do
        if Config.Containers.ValidID[v.name] then
            local first, last, cid = v.info[Config.Containers.ValidID[v.name].firstname], v.info[Config.Containers.ValidID[v.name].lastname], v.info[Config.Containers.ValidID[v.name].cid]

            qbMenu[#qbMenu+1] = {
                header = ('Name: %s %s, Citizen ID: %s'):format(first, last, cid),
                text = ("%s"):format(v.label), 
                params = {
                    isServer = data.nextServer,
                    event = data.next,
                    args = {
                        type = data.type,
                        vendor = data.vendor,
                        first = first,
                        last = last,
                        cid = cid,
                        slot = v.slot,
                        next = data.after,
                        nextServer = data.afterServer,
                    }
                }
            }
        end
    end

    qbMenu[#qbMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(qbMenu)
end)

RegisterNetEvent("r14-obj:client:selecttender", function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = 'Select Tender to Complete Payment',
            isMenuHeader = true,
        }
    }

    local cost = data.cost

    if not cost and data.type and data.vendor then
        cost = Config.Containers.Vendors[data.vendor].inventory[data.type].price
    end

    for k, v in pairs(Config.Containers.Tender) do
        local enough = false
        if PlayerData.money[k] >= cost then
            enough = true
        end

        qbMenu[#qbMenu+1] = {
            header = ('Pay %s via %s'):format(cost, Config.Containers.Tender[k]),
            text = ('Current Balance: %s'):format(PlayerData.money[k]),
            disabled = not enough,
            params = {
                isServer = data.nextServer,
                event = data.next,
                args = {
                    objectId = data.objectId,
                    type = data.type,
                    vendor = data.vendor,
                    first = data.first,
                    last = data.last,
                    cid = data.cid,
                    slot = data.slot,
                    tender = k,
                    cost = cost,
                }
            }
        }
    end

    qbMenu[#qbMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(qbMenu)
end)

RegisterNetEvent("r14-obj:client:viewunits", function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = ('%s\'s Units with %s'):format(data.cid, Config.Containers.Vendors[data.vendor].label),
            isMenuHeader = true,
        }
    }

    QBCore.Functions.TriggerCallback('r14-obj:GetOwned', function(ownedList) 

        if ownedList and next(ownedList) then
            for k, v in pairs(ownedList) do
                qbMenu[#qbMenu+1] = {
                    header = ('Unit %s'):format(k),
                    text = ('Purchased: %s </n>, Expires: %s'):format(v.purchased, v.expires),
                    params = {
                        event = 'r14-obj:client:manageunits',
                        args = {
                            objectId = k,
                            vendor = data.vendor,
                        }
                    }
                }
            end
        else
            qbMenu[#qbMenu+1] = {
                header = Config.Containers.Vendors[data.vendor].noresults or "No results!",
                disabled = true, 
            }
        end

        qbMenu[#qbMenu+1] = {
            header = "Close (ESC)",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(qbMenu)
    end, data)
end)

RegisterNetEvent("r14-obj:client:manageunits", function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    local qbMenu = {
        {
            header = ('Unit %s, %s'):format(data.objectId, Config.Containers.Vendors[data.vendor].label),
            isMenuHeader = true,
        }
    }

    QBCore.Functions.TriggerCallback('r14-obj:GetUnitInfo', function(unitInfo) 
        qbMenu[#qbMenu+1] = {
            header = ('Unit Type: %s'):format(Config.Objects[unitInfo.original].label),
            disabled = true
        }

        qbMenu[#qbMenu+1] = {
            header = ('Purchased: %s, Expires: %s'):format(unitInfo.purchased, unitInfo.expires),
            disabled = true
        }

        local renewHeader, renewText = 'Renew Unit Lease', 'Unit Not Eligible for Renewal'

        if unitInfo.canRenew then renewHeader = ('Renew Unit Lease (%s weeks)'):format(unitInfo.weeks) renewText = ('Cost: %s, Extended To: %s'):format(unitInfo.cost, unitInfo.newDate) end

        qbMenu[#qbMenu+1] = {
            header = renewHeader,
            text = renewText,
            disabled = not unitInfo.canRenew,
            params = {
                event = 'r14-obj:client:selecttender',
                args = {
                    objectId = unitInfo.objectId,
                    type = unitInfo.original,
                    vendor = unitInfo.vendor,
                    next = 'r14-obj:server:vendorextendtime',
                    nextServer = true,
                }
            }
        }

        local changeLocksText = nil

        if unitInfo.locksChanging then changeLocksText = 'Unavailable, lock change service requested.' end

        qbMenu[#qbMenu+1] = {
            header = ('Change Unit Locks ($%s)'):format(Config.Containers.Vendors[unitInfo.vendor].rekey or Config.Containers.VendorDefaults.rekey),
            text = changeLocksText,
            disabled = unitInfo.locksChanging,
            params = {
                event = 'r14-obj:client:selecttender',
                args = {
                    objectId = unitInfo.objectId,
                    type = unitInfo.original,
                    vendor = unitInfo.vendor,
                    cost = Config.Containers.Vendors[unitInfo.vendor].rekey or Config.Containers.VendorDefaults.rekey,
                    next = 'r14-obj:server:vendorchangelocks',
                    nextServer = true,
                }
            }
        }

        qbMenu[#qbMenu+1] = {
            header = ('Request Duplicate Key ($%s)'):format(Config.Containers.Vendors[unitInfo.vendor].duplicateKey or Config.Containers.VendorDefaults.duplicateKey),
            text = changeLocksText,
            disabled = unitInfo.locksChanging,
            params = {
                event = 'r14-obj:client:selecttender',
                args = {
                    objectId = unitInfo.objectId,
                    type = unitInfo.original,
                    vendor = unitInfo.vendor,
                    cost = Config.Containers.Vendors[unitInfo.vendor].duplicateKey or Config.Containers.VendorDefaults.duplicateKey,
                    next = 'r14-obj:server:vendorchangelocks',
                    nextServer = true,
                }
            }
        }

        qbMenu[#qbMenu+1] = {
            header = 'Request Directions to Unit',
            params = {
                isAction = true,
                event = function(args) SetNewWaypoint(args.coords.x, args.coords.y) end,
                args = {
                    objectId = unitInfo.objectId,
                    coords = unitInfo.coords, 
                }
            }
        }

        qbMenu[#qbMenu+1] = {
            header = ('Break Unit Lease ($%s)'):format(Config.Containers.Vendors[unitInfo.vendor].breakLeaseCost or Config.Containers.VendorDefaults.breakLeaseCost),
            params = {
                event = 'r14-obj:client:selecttender',
                args = {
                    objectId = unitInfo.objectId,
                    type = unitInfo.original,
                    vendor = unitInfo.vendor,
                    cost = Config.Containers.Vendors[unitInfo.vendor].breakLeaseCost or Config.Containers.VendorDefaults.breakLeaseCost,
                    next = 'r14-obj:server:vendorbreakcontract',
                    nextServer = true,
                }
            }
        }

        qbMenu[#qbMenu+1] = {
            header = "Close (ESC)",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(qbMenu)
    end, data.objectId)
end)

RegisterNetEvent('r14-obj:client:vendorwarrant', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()

    if not Config.AuthorizedJobs.LEO.Check() then print('not a cop, stop cheating!') return end

    local qbMenu = {
        {
            header = ('Warrant Request for %s'):format(Config.Containers.Vendors[data.vendor].label),
            isMenuHeader = true,
        }
    }

    if Config.Containers.Vendors[data.vendor].policegreeting then
        qbMenu[#qbMenu+1] = {
            header = ('<i>%s</i>'):format(Config.Containers.Vendors[data.vendor].policegreeting),
            disabled = true,
        }
    end

    qbMenu[#qbMenu+1] = {
        header = 'Search by Unit Number',
        params = {
            event = 'r14-obj:client:warrantinput',
            args = {
                label = 'Unit ID',
                type = 'unitId',
                vendor = data.vendor,
            }
        }
    }

    qbMenu[#qbMenu+1] = {
        header = 'Search by Name',
        params = {
            event = 'r14-obj:client:warrantinput',
            args = {
                label = 'Owner Name',
                type = 'name',
                vendor = data.vendor,
            }
        }
    }

    qbMenu[#qbMenu+1] = {
        header = 'Search by CID',
        params = {
            event = 'r14-obj:client:warrantinput',
            args = {
                label = 'Owner CID',
                type = 'cid',
                vendor = data.vendor,
            }
        }
    }

    qbMenu[#qbMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(qbMenu)
end)

RegisterNetEvent('r14-obj:client:warrantinput', function(data)

    local warrantinput = exports['qb-input']:ShowInput({
        header = ('Search by %s'):format(data.type),
        submitText = "Submit",
        inputs = {
            {
                text = 'Text',
                name = "text", 
                type = "text",
                isRequired = true,
            },
        },
    })

    if warrantinput ~= nil then
        local qbMenu = {
            {
                header = ('Results for Search ["%s"]<br> Click to Set Waypoint'):format(warrantinput.text),
                isMenuHeader = true,
            }
        }

        QBCore.Functions.TriggerCallback('r14-obj:RecordsRequest', function(results) 

            if results and next(results) then
                for k, v in pairs(results) do
                    qbMenu[#qbMenu+1] = {
                        header = ('Type: %s</br> Contact Holder: %s'):format(Config.Objects[v.originalType].label, v.name),
                        text = ('Purchased: %s, Expires: %s'):format(v.purchased, v.expires),
                        params = {
                            isAction = true,
                            event = function() end,
                            args = {
                                objectId = v.objectId,
                                type = v.original,
                                vendor = v.vendor,
                            }
                        }
                    }
                end
            else
                qbMenu[#qbMenu+1] = {
                    header = Config.Containers.Vendors[data.vendor].noresults or "No results!",
                    disabled = true, 
                }
            end

            qbMenu[#qbMenu+1] = {
                header = "Close (ESC)",
                params = {
                    event = "qb-menu:client:closeMenu"
                }

            }
            exports['qb-menu']:openMenu(qbMenu)
        end, {vendor = data.vendor, type = data.type, text = warrantinput.text})
    end
end)
