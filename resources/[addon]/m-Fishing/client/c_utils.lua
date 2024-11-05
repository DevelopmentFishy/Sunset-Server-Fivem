local QBCore = exports[Config.Core]:GetCoreObject()

function OpenMenuUpgrades()
    if Config.Menu == "qb" then
        exports['qb-menu']:openMenu({
            {
                header = "Upgrades Menu",
                icon = 'fa-solid fa-circle-up',
                isMenuHeader = true, 
            },
            {
                header = "Upgrade Fishingrod",
                txt = "Here is where you can upgrade your fishingrod",
                icon = 'fa-solid fa-play',
                params = {
                    isAction = true,
                    event = OpenFishingrodUpgrade,
                },
            },
            {
                header = "Upgrade Fishingnet",
                txt = "Here is where you can upgrade your fishingnet",
                icon = 'fa-solid fa-play',
                params = {
                    isAction = true,
                    event = OpenFishingnetUpgrade,
                },
            },
        })
    elseif Config.Menu == "ox" then
        lib.registerContext({
            id = 'upgradesMenu',
            title = 'Upgrades Menu',
            icon = 'fa-solid fa-circle-up',
            options = {
                { title = 'Upgrade Fishingrod',   description = "Here is where you can upgrade your fishingrod", onSelect = function() OpenFishingrodUpgrade() end },
                { title = 'Upgrade Fishingnet',   description = "Here is where you can upgrade your fishingnet", onSelect = function() OpenFishingnetUpgrade() end  },
            }
        })
        lib.showContext('upgradesMenu')
    end
end

-- Function sell fishing
function OpenSellFishing()
    if Config.Menu == "qb" then
        local menuOptions = {
            {
                header = "Sell Fish",
                icon = 'fas fa-fish',
                isMenuHeader = true,
            },
        }

        for _, fishInfo in ipairs(Config.SettingsSell) do
            local itemName = fishInfo.item
            local priceMin = fishInfo.priceMin
            local priceMax = fishInfo.priceMax

            local option = {
                header = "<img src=nui://"..Config.InventoryLink..QBCore.Shared.Items[itemName].image.." width=35px style='margin-right: 10px'> " .. QBCore.Shared.Items[itemName].label,
                txt = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "fas fa-dollar-sign",
                disabled = false,
                params = {
                    isServer = true,
                    event = 'm-Fishing:Server:SellLegalFish',
                    args = {
                        item = itemName,
                        priceMin = priceMin,
                        priceMax = priceMax,
                    }
                }
            }
            table.insert(menuOptions, option)
        end

        exports['qb-menu']:openMenu(menuOptions)
    elseif Config.Menu == "ox" then
        local SellFishing = {
            id = 'SellFishing',
            title = "Sell Fish",
            options = {}
        }
    
        for _, fishInfo in ipairs(Config.SettingsSell) do
            local itemName = fishInfo.item
            local priceMin = fishInfo.priceMin
            local priceMax = fishInfo.priceMax
            SellFishing.options[#SellFishing.options + 1] = {
                title = fishInfo.labelName,
                description = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "nui://" .. Config.InventoryLink .. itemName..".png",
                serverEvent = 'm-Fishing:Server:SellLegalFish',
                args = {
                    item = itemName,
                    priceMin = priceMin,
                    priceMax = priceMax,
                },
            }
        end
    
        lib.registerContext(SellFishing)
        lib.showContext('SellFishing')
    end
end

-- Function sell illegal fishing
function OpenSellIllegalFishing()
    if Config.Menu == "qb" then
        local menuOptions = {
            {
                header = "Sell Illegal Fish",
                icon = 'fas fa-fish',
                isMenuHeader = true,
            },
        }

        for _, fishInfo in ipairs(Config.IllegalSettingsSell) do
            local itemName = fishInfo.item
            local priceMin = fishInfo.priceMin
            local priceMax = fishInfo.priceMax

            local option = {
                header = "<img src=nui://"..Config.InventoryLink..QBCore.Shared.Items[itemName].image.." width=35px style='margin-right: 10px'> " .. QBCore.Shared.Items[itemName].label,
                txt = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "fas fa-dollar-sign",
                disabled = false,
                params = {
                    isServer = true,
                    event = 'm-Fishing:Server:SellIllegalFish',
                    args = {
                        item = itemName,
                        priceMin = priceMin,
                        priceMax = priceMax,
                    }
                }
            }
            table.insert(menuOptions, option)
        end

        exports['qb-menu']:openMenu(menuOptions)
    elseif Config.Menu == "ox" then
        local SellIllegalFishing = {
            id = 'SellIllegalFishing',
            title = "Sell IllegalFish",
            options = {}
        }
    
        for _, fishInfo in ipairs(Config.IllegalSettingsSell) do
            local itemName = fishInfo.item
            local priceMin = fishInfo.priceMin
            local priceMax = fishInfo.priceMax
            SellIllegalFishing.options[#SellIllegalFishing.options + 1] = {
                title = fishInfo.labelName,
                description = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "nui://" .. Config.InventoryLink .. itemName..".png",
                serverEvent = 'm-Fishing:Server:SellIllegalFish',
                args = {
                    item = itemName,
                    priceMin = priceMin,
                    priceMax = priceMax,
                },
            }
        end
    
        lib.registerContext(SellIllegalFishing)
        lib.showContext('SellIllegalFishing')
    end
end


-- Function sell seashell
function OpenSeashellsSells()
    if Config.Menu == "qb" then
        local menuOptions = {
            {
                header = "Sell Seashell",
                icon = 'fas fa-fish',
                isMenuHeader = true,
            },
        }

        for _, seashellInfo in ipairs(Config.SeashellsSell) do
            local itemName = seashellInfo.item
            local priceMin = seashellInfo.priceMin
            local priceMax = seashellInfo.priceMax

            local option = {
                header = "<img src=nui://"..Config.InventoryLink..QBCore.Shared.Items[itemName].image.." width=35px style='margin-right: 10px'> " .. QBCore.Shared.Items[itemName].label,
                txt = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "fas fa-dollar-sign",
                disabled = false,
                params = {
                    isServer = true,
                    event = 'm-Fishing:Server:SellSeashell',
                    args = {
                        item = itemName,
                        priceMin = priceMin,
                        priceMax = priceMax,
                    }
                }
            }
            table.insert(menuOptions, option)
        end

        exports['qb-menu']:openMenu(menuOptions)
    elseif Config.Menu == "ox" then
        local SellSeashell = {
            id = 'SellSeashell',
            title = "Sell Seashell",
            options = {}
        }
    
        for _, seashellInfo in ipairs(Config.SeashellsSell) do
            local itemName = seashellInfo.item
            local priceMin = seashellInfo.priceMin
            local priceMax = seashellInfo.priceMax
            SellSeashell.options[#SellSeashell.options + 1] = {
                title = seashellInfo.labelName,
                description = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "nui://" .. Config.InventoryLink .. itemName..".png",
                serverEvent = 'm-Fishing:Server:SellSeashell',
                args = {
                    item = itemName,
                    priceMin = priceMin,
                    priceMax = priceMax,
                },
            }
        end
    
        lib.registerContext(SellSeashell)
        lib.showContext('SellSeashell')
    end
end

-- Open Sell Corals
function OpenSellCorals()
    if Config.Menu == "qb" then
        local menuOptions = {
            {
                header = "Sell Corals",
                icon = 'fas fa-fish',
                isMenuHeader = true,
            },
        }

        for _, coralInfo in ipairs(Config.SellCoralsSetgins) do
            local itemName = coralInfo.item
            local priceMin = coralInfo.priceMin
            local priceMax = coralInfo.priceMax

            local option = {
                header = "<img src=nui://"..Config.InventoryLink..QBCore.Shared.Items[itemName].image.." width=35px style='margin-right: 10px'> " .. QBCore.Shared.Items[itemName].label,
                txt = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "fas fa-dollar-sign",
                disabled = false,
                params = {
                    isServer = true,
                    event = 'm-Fishing:Server:SellCorals',
                    args = {
                        item = itemName,
                        priceMin = priceMin,
                        priceMax = priceMax,
                    }
                }
            }
            table.insert(menuOptions, option)
        end

        exports['qb-menu']:openMenu(menuOptions)
    elseif Config.Menu == "ox" then
        local SellCorals = {
            id = 'SellCorals',
            title = "Sell Fish",
            options = {}
        }
    
        for _, coralInfo in ipairs(Config.SellCoralsSetgins) do
            local itemName = coralInfo.item
            local priceMin = coralInfo.priceMin
            local priceMax = coralInfo.priceMax
            SellCorals.options[#SellCorals.options + 1] = {
                title = itemName,
                description = "Sell Price Range: $" .. priceMin .. " - $" .. priceMax,
                icon = "nui://" .. Config.InventoryLink .. itemName..".png",
                serverEvent = 'm-Fishing:Server:SellCorals',
                args = {
                    item = itemName,
                    priceMin = priceMin,
                    priceMax = priceMax,
                },
            }
        end
    
        lib.registerContext(SellCorals)
        lib.showContext('SellCorals')
    end
    if Config.Cops.enable then
        CallCops()
    end
end

-- Tournaments
local pedOptions = {} 

for _, pedModel in ipairs(Config.PedsTournament) do
    table.insert(pedOptions, { value = pedModel, text = pedModel })
end

RegisterNetEvent('m-Fishing:Client:OpenTournamentMenu')
AddEventHandler("m-Fishing:Client:OpenTournamentMenu", function()
    local dialog = exports["qb-input"]:ShowInput({
        header = "Create Tournament",
        submitText = "Create",
        inputs = {
            { text = "Name of Tournament",  name = "nameevent",     type = "text",      isRequired = true },
            { text = "Ped",                 name = "pedtype",       type = "select",    options = pedOptions },
            { text = "Radius (20)",         name = "radius",        type = "text",      isRequired = true },
            { text = "Price",               name = "price",         type = "number",    isRequired = true },
            { text = "Time ( Minutes )",    name = "time",          type = "number",    isRequired = true },
            { text = "Participants",        name = "participants",  type = "number",    isRequired = true },
        },
    })
    if dialog ~= nil then
        if tonumber(dialog.time) <= Config.MaxWaitingTime then
            if tonumber(dialog.participants) <= Config.MaxParticipants then
                TriggerServerEvent("m-Fishing:Server:CreateServerSideTournament", dialog.nameevent, dialog.pedtype, dialog.radius, dialog.price, dialog.time, dialog.participants )
            else
                Notify("The number of participants is greater than permitted. Maximum participants: "..Config.MaxParticipants, "error", 5000)
            end
        else
            Notify("The waiting time is longer than allowed. Maximum waiting time: "..Config.MaxWaitingTime, "error", 5000)
        end
    end
end)