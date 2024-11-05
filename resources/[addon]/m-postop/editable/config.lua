HSN = {}
HSN.Config = {
    Framework = "new-qb", -- old-qb / esx / new-qb
    Database = "oxmysql", --// mysql-async - oxmysql - ghmattimysql
    Vehiclekey = true,
    VehicleSystem = "qb-vehiclekeys", -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
    VehicleRemovekey = true,
    VehicleRemoveKeySystem = "qb-vehiclekeys", -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
    EnableFuel = false,
    FuelSystem = 'LegacyFuel', -- LegacyFuel / ox-fuel / nd-fuel / frfuel / cdn-fuel / hyon_gas_station
    UserImageType = "steam", -- or steam // determines from which app the player image in the top navigation will be retrieved // do not forget set steam web api key to server.cfg for steam profile photo -- https://prnt.sc/QydYu7GoxR1X
    GameBuildNumber = GetGameBuildNumber(), -- do not touch
    MoneyType = "bank", -- bank // money type for check and set
    Inventory = "qb-inventory", --// ox_inventory //esx_default // custom // qb-inventory
    VehicleItem = "transportitem",
    UseJob = true, -- if you want to use job system set true
    JobName = "postop", -- job name for access postop
    DiscordBotToken = "", -- discord bot token for user image
    FinishJobCommand = {enable = true, command = "FinishJob", DeleteVehicleAfterUsage = true},
    OXInventoryCashItem = "money",
    BadgePrice = 0,
    PostOpCam = {
        x = 1178.36, 
        y = -3244.73, 
        z = 5.97,
        heading = 197.25
    },
    Job = {
        ["start"] = {
            coord = vector4(1197.21, -3255.11, 7.1, 86.62),
            show = {
                openKey = 38, -- E 
                ped = {enable = true, hash = GetHashKey('s_m_m_ups_02')},
                marker = {enable = false, type = 2, r = 200, g = 0, b = 0, rotX = 0.0, rotY = 0.0, rotZ = 0.0},
                text = {enable = true, message = "E - PostOP", zoffset = 0.35},
                blip = {enable = true, id = 267, color = 17, scale = 0.65, label = "POST OP"},
                target = true,
                InteractionHandler = "qb-target"
            }
        },
        ["gardrop"] = {
            coord = vector4(1183.96, -3303.95, 7.1, 87.46),
            show = {
                openKey = 38, -- E 
                ped = {enable = true, hash = GetHashKey('s_m_m_ups_02')},
                marker = {enable = false, type = 2, r = 200, g = 0, b = 0, rotX = 0.0, rotY = 0.0, rotZ = 0.0},
                text = {enable = true, message = "E - Gardrop", zoffset = 0.35},
                blip = {enable = true, id = 73, color = 17, scale = 0.55, label = "POST OP Wardrobe"},
                target = true,
                InteractionHandler = "qb-target"
                
            }
        },
    },
    DeliveryBlip = {id = 1, color = 2, scale = 0.55, label = "Delivery Point"},
    DeliverAmount = {
        min = 1, 
        max = 5, 
        price = {
            kind = "perofdeliver", -- or endofdeliver,
        }
    },
    Deliver = {
        marker = {enable = true, type = 2, r = 200, g = 0, b = 0, rotX = 0.0, rotY = 0.0, rotZ = 0.0},
        text = {enable = true, message = "E - Afleveren", zoffset = 0.35},
    },
    DeleteTruck = {
        coord = vector4(1180.16, -3292.17, 5.1, 357.37),
        marker = {markerType = 6, r = 0 ,g = 150, b= 150},
        text = {enable = true, message = "E - Parkeer je postbus"}
    },
    XPAmountForPerPackage = 10,
    VehicleCapacityFill = {coord = vector4(1176.22, -3314.2, 5, 352.14), markerType =6, r = 0 ,g = 150, b= 150},
    JobVehSpawnCoord = vector4(1186.1, -3242.87, 6.03, 85.63),
    VehicleCam = {
        VehicleSpawnCoordinates = vector4(1177.8, -3266.68, 5.77, 19.9), -- local vehicle
        Cam = vector4(1170.77, -3261.22, 7.36, 231.83)
    },
    DailyMissions = {
        ["firstcargo"] = {
            xp = 200,
        },
        ["deliver"] = {
            xp = 300
        },
        ["endofwork"] = {
            xp = 200
        }
    },
    RequiredXP = { -- do not touch
        [1] = 1000,
        [2] = 1500,
        [3] = 2000,
        [4] = 2500,
        [5] = 3000,
        [6] = 3500,
        [7] = 4000,
        [8] = 4500,
        [9] = 5000,
        [10] = 5500,
        [11] = 6000,
        [12] = 6500,
        [13] = 7000,
        [14] = 7500,
        [15] = 8000,
        [16] = 8500,
        [17] = 9000,
        [18] = 9500,
        [19] = 10000,
        [20] = 10500,
        [21] = 11000,
        [22] = 11500,
        [23] = 12000,
        [24] = 12500,
        [25] = 13000,
        [26] = 13500,
        [27] = 14000,
        [28] = 14500,
        [29] = 15000,
        [30] = 15500,
        [31] = 16000,
        [32] = 16500,
        [33] = 17000,
        [34] = 17500,
        [35] = 18000,
        [36] = 18500,
        [37] = 19000,
        [38] = 19500,
        [39] = 20000,
        [40] = 20500,
        [41] = 21000,
        [42] = 21500,
        [43] = 22000,
        [44] = 22500,
        [45] = 23000,
        [46] = 23500,
        [47] = 24000,
        [48] = 24500,
        [49] = 25000,
        [50] = 60000,
    }
}


HSN.Vehicles = {
    ["boxville"] = {
        hash = GetHashKey("boxville"),
        capacity = 100,
        label = "BOXVILLE",
        requiredIndex = 1,
    },
    ["mule"] = {
        hash = GetHashKey("mule"),
        capacity = 200,
        label = "MULE",
        requiredIndex = 2,
    },
    ["benson"] = {
        hash = GetHashKey("benson"),
        capacity = 300,
        label = "BENSON",
        requiredIndex = 3,
    },
    ["yourtruck"] = {
        capacity = 400,
        requiredIndex = 4,
        label = "YOUR TRUCK"
    },
}


HSN.Class = { -- do not touch
    ["beginner"] = {
        label = "Post-OP Beginner",
        index = 1,
        minlevel = 0,
        maxlevel = 19,
    },
    ["skilled"] = {
        label = "Post-OP Skilled",
        index = 2,
        minlevel = 20,
        maxlevel = 29,
    },
    ["proffesional"] = {
        label = "Post-OP Proffesional",
        index = 3,
        minlevel = 30,
        maxlevel = 49,
    },
    ["postopguru"] = {
        label = "Post-OP Guru",
        index = 4,
        minlevel = 50,
        maxlevel = 50,
    }
}



HSN.CheckDailyMissions = function(time, identifier)
    time = tonumber(time)
    local difftime = os.difftime(os.time(), time)
    hours = string.format("%0.f", math.floor(difftime/3600));
    mins = string.format("%0.f", math.floor(difftime/60 - (hours*60)));
    if tonumber(hours) >= 24 then
        HSN.ResetDailyMissions(identifier)
    end
    if tonumber(hours) == 0 then
        return mins..'M'
    else
        return hours..'H '..mins..'M'
    end
end

HSN.GetClassFromLevel = function(level)
    level = tonumber(level)
    for k,v in pairs(HSN.Class) do
        if level >= v.minlevel and level <= v.maxlevel then
            return HSN.Class[k]
        end
    end
end

HSN.GetLevelFromXP = function(xp)
    xp = tonumber(xp)
    local level = nil
    local templevel = nil
    for k, v in ipairs(HSN.Config.RequiredXP) do
        if (xp <= v) then
            level = k
            return level
        end
        templevel = k
    end
    if level == nil then return templevel end
end


HSN.RemoveVehicleKeys = function (vehicle,plate)
    if HSN.Config.VehicleRemovekey then
        if HSN.Config.VehicleRemoveKeySystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif HSN.Config.VehicleRemoveKeySystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:RemoveKeysAuto()
        elseif HSN.Config.VehicleRemoveKeySystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif HSN.Config.VehicleRemoveKeySystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end

HSN.Routes = { 
    ["cargo"] = {
        ["airport"] = {
            totalDelivery = 200,
            revenue = {min = 2000, max = 7500},
            requiredIndex = 2,
            label = "AIRPORT",
            locations = {
                vector4(-1267.37, -2683.48, 19.63, 338.4),
                vector4(-1243.97, -2679.79, 15.19, 327.04),
                vector4(-1172.4, -2681.93, 19.95, 241.03),
                vector4(-1138.68, -2632.19, 15.1, 235.86),
                vector4(-1122.24, -2531.66, 14.07, 336.25),
                vector4(-1174.84, -2474.18, 15.46, 59.0),
                vector4(-1189.18, -2425.83, 20.26, 150.97),
                vector4(-1295.11, -2376.54, 14.1, 326.12),  
                vector4(-1302.5, -2340.97, 14.09, 329.5),
                vector4(-1035.31, -2383.26, 14.09, 61.88),
                vector4(-1089.23, -2493.8, 15.47, 61.15),
                vector4(-1176.44, -2681.83, 14.24, 146.21),
                vector4(-1215.43, -2685.48, 14.29, 148.02),
                vector4(-1237.11, -2667.21, 15.18, 153.1),
                vector4(-1270.77, -2654.34, 14.07, 97.46)

            }
        },
        ["downtown"] = {
            totalDelivery = 100,
            revenue = {min = 1000, max = 5000},
            requiredIndex = 1,
            label = "DOWNTOWN",
            locations = {
                vector4(196.17, -406.39, 45.32, 246.82),
                vector4(66.53, -255.81, 52.35, 256.6),
                vector4(8.73, -243.21, 47.66, 335.79),
                vector4(-17.91, -296.5, 45.75, 107.43),
                vector4(-50.92, -398.22, 38.13, 336.77),
                vector4(118.94, -204.74, 54.64, 161.49),
                vector4(90.44, -222.8, 54.64, 161.52),
                vector4(18.24, -122.11, 56.1, 336.73),
                vector4(-87.96, -83.12, 57.81, 25.13),
                vector4(-70.67, 141.61, 81.86, 231.61),
                vector4(-155.05, 214.54, 94.81, 103.6),
                vector4(-92.83, 233.12, 100.58, 266.01),
                vector4(36.74, 224.03, 109.38, 247.9),
                vector4(81.54, 275.03, 110.21, 339.04),
                vector4(-122.42, -888.0, 29.66, 22.81),
                vector4(83.85, -854.95, 30.77, 244.82),
                vector4(57.11, -1004.93, 29.36, 160.91),
                vector4(243.45, -1074.22, 29.29, 177.66),
            }
        },
        ["sandy"] = {
            totalDelivery = 300,
            revenue = {min = 3000, max = 10000},
            requiredIndex = 3,
            label = "SANDY",
            locations = {
                vector4(2160.18, 4789.63, 41.96, 269.06),
                vector4(1958.79, 4627.88, 41.07, 215.63),
                vector4(1790.39, 4602.71, 37.68, 182.11),
                vector4(1740.41, 4648.57, 43.86, 119.06),
                vector4(1682.87, 4689.65, 43.07, 88.16),
                vector4(1673.63, 4658.23, 43.41, 85.77),
                vector4(1719.04, 4677.39, 43.66, 264.71),
                vector4(1725.41, 4642.51, 43.88, 297.05),
                vector4(1663.95, 4739.69, 42.01, 104.56),
                vector4(1662.12, 4776.16, 42.04, 99.26),
                vector4(1657.55, 4838.96, 42.02, 101.1),
                vector4(1654.9, 4862.13, 41.99, 92.46),
                vector4(1676.75, 4870.51, 42.04, 276.09),
                vector4(1683.11, 4855.16, 42.06, 277.88),
                vector4(1707.84, 4791.83, 41.98, 265.13),

            
            }
        },
        ["paleto"] = {
            totalDelivery = 400,
            revenue = {min = 6000, max = 15000},
            requiredIndex = 4,
            label = "PALETO BAY",
            locations = {
                vector4(-238.34, 6423.65, 31.46, 43.57),
                vector4(-229.61, 6445.49, 31.2, 318.07),
                vector4(-111.68, 6468.83, 31.63, 309.1),
                vector4(-149.86, 6429.45, 31.92, 222.26),
                vector4(-87.82, 6494.51, 32.1, 46.0),
                vector4(-44.33, 6582.1, 32.18, 219.44),
                vector4(-26.39, 6597.32, 31.86, 220.74),
                vector4(-41.77, 6637.29, 31.09, 54.87),
                vector4(-9.59, 6654.23, 31.71, 25.59),
                vector4(35.25, 6663.18, 32.19, 325.59),
                vector4(56.64, 6646.43, 32.28, 296.83),
                vector4(119.27, 6626.69, 31.96, 48.3),
                vector4(151.01, 6647.82, 31.6, 315.17),
                vector4(58.6, 6333.03, 31.38, 123.8),
                vector4(-136.4, 6198.48, 32.39, 226.58)
            }
        },
    },
    ["transport"] = {
        ["airport"] = {
            totalDelivery = 100,
            label = "LSIA HANGARS",
            revenue = {price = 3000}, 
            location = {
                vector4(-1267.37, -2683.48, 19.63, 338.4),
                vector4(-1243.97, -2679.79, 15.19, 327.04),
                vector4(-1172.4, -2681.93, 19.95, 241.03),
                vector4(-1138.68, -2632.19, 15.1, 235.86),
                vector4(-1122.24, -2531.66, 14.07, 336.25),
                vector4(-1174.84, -2474.18, 15.46, 59.0),
                vector4(-1189.18, -2425.83, 20.26, 150.97),
                vector4(-1295.11, -2376.54, 14.1, 326.12),  
                vector4(-1302.5, -2340.97, 14.09, 329.5),
                vector4(-1035.31, -2383.26, 14.09, 61.88),
                vector4(-1089.23, -2493.8, 15.47, 61.15),
                vector4(-1176.44, -2681.83, 14.24, 146.21),
                vector4(-1215.43, -2685.48, 14.29, 148.02),
                vector4(-1237.11, -2667.21, 15.18, 153.1),
                vector4(-1270.77, -2654.34, 14.07, 97.46)
            }
        },
        ["downtown"] = {
            totalDelivery = 150,
            label = "DOWNTOWN",
            revenue = {price = 4500}, 
            location = {
                vector4(196.17, -406.39, 45.32, 246.82),
                vector4(66.53, -255.81, 52.35, 256.6),
                vector4(8.73, -243.21, 47.66, 335.79),
                vector4(-17.91, -296.5, 45.75, 107.43),
                vector4(-50.92, -398.22, 38.13, 336.77),
                vector4(118.94, -204.74, 54.64, 161.49),
                vector4(90.44, -222.8, 54.64, 161.52),
                vector4(18.24, -122.11, 56.1, 336.73),
                vector4(-87.96, -83.12, 57.81, 25.13),
                vector4(-70.67, 141.61, 81.86, 231.61),
                vector4(-155.05, 214.54, 94.81, 103.6),
                vector4(-92.83, 233.12, 100.58, 266.01),
                vector4(36.74, 224.03, 109.38, 247.9),
                vector4(81.54, 275.03, 110.21, 339.04),
                vector4(-122.42, -888.0, 29.66, 22.81),
                vector4(83.85, -854.95, 30.77, 244.82),
                vector4(57.11, -1004.93, 29.36, 160.91),
                vector4(243.45, -1074.22, 29.29, 177.66),
            }
        },
        ["sandy"] = {
            totalDelivery = 300,
            label = "SANDY SHORES",
            revenue = {price = 7500},
            location = {
                vector4(2160.18, 4789.63, 41.96, 269.06),
                vector4(1958.79, 4627.88, 41.07, 215.63),
                vector4(1790.39, 4602.71, 37.68, 182.11),
                vector4(1740.41, 4648.57, 43.86, 119.06),
                vector4(1682.87, 4689.65, 43.07, 88.16),
                vector4(1673.63, 4658.23, 43.41, 85.77),
                vector4(1719.04, 4677.39, 43.66, 264.71),
                vector4(1725.41, 4642.51, 43.88, 297.05),
                vector4(1663.95, 4739.69, 42.01, 104.56),
                vector4(1662.12, 4776.16, 42.04, 99.26),
                vector4(1657.55, 4838.96, 42.02, 101.1),
                vector4(1654.9, 4862.13, 41.99, 92.46),
                vector4(1676.75, 4870.51, 42.04, 276.09),
                vector4(1683.11, 4855.16, 42.06, 277.88),
                vector4(1707.84, 4791.83, 41.98, 265.13),
            }
        },
        ["paleto"] = {
            totalDelivery = 400,
            label = "PALETO BAY",
            revenue = {price = 12500}, 
            location = {
                vector4(-238.34, 6423.65, 31.46, 43.57),
                vector4(-229.61, 6445.49, 31.2, 318.07),
                vector4(-111.68, 6468.83, 31.63, 309.1),
                vector4(-149.86, 6429.45, 31.92, 222.26),
                vector4(-87.82, 6494.51, 32.1, 46.0),
                vector4(-44.33, 6582.1, 32.18, 219.44),
                vector4(-26.39, 6597.32, 31.86, 220.74),
                vector4(-41.77, 6637.29, 31.09, 54.87),
                vector4(-9.59, 6654.23, 31.71, 25.59),
                vector4(35.25, 6663.18, 32.19, 325.59),
                vector4(56.64, 6646.43, 32.28, 296.83),
                vector4(119.27, 6626.69, 31.96, 48.3),
                vector4(151.01, 6647.82, 31.6, 315.17),
                vector4(58.6, 6333.03, 31.38, 123.8),
                vector4(-136.4, 6198.48, 32.39, 226.58)
            }
        },
    }
}

HSN.Target = function(v, k) 
    if v.show.InteractionHandler == 'qb-target' then
        exports['qb-target']:AddBoxZone("postop" ..k, vector3(v.coord.x, v.coord.y, v.coord.z), 1.5, 1.5, {
            name = "m-postop" .. k,
            debugPoly = false,
            heading = -20,
            minZ = v.coord.z - 2,
            maxZ = v.coord.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    event = "m-postop-client-target",
                    icon = 'fas fa-credit-card',
                    label = v.show.text.message,
                    index = k,
                    
                },
            },
            distance = 8
        })

    elseif v.show.InteractionHandler == 'ox-target' then
        exports['ox_target']:addBoxZone({
            coords = vector3(v.coord.x, v.coord.y, v.coord.z),
            minZ = v.coord.z - 2,
            maxZ = v.coord.z + 2,
            heading = -20,
            name = "postop" .. k,
            options = {
                {
                    type = "client",
                    event = "m-postop-client-target",
                    icon = 'fas fa-credit-card',
                    label = v.show.text.message,
                    index = k,
                },
            },
        })
    elseif v.show.InteractionHandler == 'bt-target"' then
        exports['bt-target']:AddBoxZone("postop"..k, v.coord, 1.25, 0.55, {
            name = "postop"..k,
            heading = 0.0,
            debugPoly = false,
            minZ = v.coord.z,
            maxZ = v.coord.z+2.0,
            }, {
                options = {
                    {
                        event = "m-postop-client-target",
                        icon = "fa-solid fa-bank",
                        label = v.show.text.message,
                        index = k,
                    },
                },
                distance = 3.0,
                job = {"all"}
        })
    else
        if v.show.marker and v.show.marker.enable then
            HSN.DrawMarker(v.coord.x, v.coord.y, v.coord.z, v.show.marker.type, v.show.marker.r, v.show.marker.g, v.show.marker.b, v.show.marker.rotX, v.show.marker.rotY, v.show.marker.rotZ)
        end
        if v.show.text and v.show.text.enable then
            HSN.DrawText(v.coord.x, v.coord.y, v.coord.z +v.show.text.zoffset, v.show.text.message)
        end
        if IsControlJustPressed(0, v.show.openKey) then
            TriggerServerEvent("m-postop-server:Job", k)
        end
    end
end

HSN.DrawText = function(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    ClearDrawOrigin()
    --return factor / 360.0
end

HSN.DrawMarker = function(x, y, z, mType, r, g, b, rotx, roty, rotz, conf)
    if conf ~= nil then
        DrawMarker(mType, x,y,z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 5.0, 1.0, 5.0, r,g,b, 100, false, true, 2, false, false, false, false)
        return
    end
    DrawMarker(mType, x, y, z, 0.0, 0.0, 0.0, rotx,roty,rotz, 0.3, 0.2, 0.15, r, g, b, 222, false, false, false, false, false, false, false)
end




HSN.CalculateEarnMoney = function(source, route, amount ,finished, istransportjob) 
    if istransportjob then
        if amount == route.totalDelivery then
            local calculated = route.revenue.price
            HSN.Inventory.AddMoney(source, math.floor(calculated))
            return math.floor(calculated)
        else
            local calculated = route.revenue.price / route.totalDelivery
            c = calculated * amount
            HSN.Inventory.AddMoney(source, math.floor(c))
            return math.floor(c)
        end
    end
    if HSN.Config.DeliverAmount.price.kind == "perofdeliver" then
        if amount then
            random = math.random(route.revenue.min, route.revenue.max) * 0.009
            calculated = amount * random
            HSN.Inventory.AddMoney(source, math.floor(calculated))
            return math.floor(calculated)
        end
    elseif HSN.Config.DeliverAmount.price.kind == "endofdeliver" then
        if finished then
            if route.revenue then
                calculated = math.random(route.revenue.min, route.revenue.max)
                HSN.Inventory.AddMoney(source, math.floor(calculated))
                return math.floor(calculated)
            end
        end
    end  
end


HSN.Messages = {
    client = {
        ["waypointsetforgardrop"] = "Waypoint set for take Badge!!",
        ["vehicleset"] = "Set your vehicle!",
        ["vehiclenotfound"] = "We can not find your car!",
        ["finishjob"] = "You finished the job! You should to park your vehicle to Post Op. Garage. also refunded your badge price!",
        ["finishjobyourtruck"] = "You finished the job! also refunded your badge price!",
        ["returncar"] = "You need to give the car to start work",
    },
    server = {
        ["needbadge"] = "You need to Badge!",
        ["setclothes"] = "You took your Badge!",
        ["startjob"] = "Your job has been started with : ",
        ["earnmoney"] = "You earned :",
        ["enoughmoney"] = "You don't enough money for take badge!",
        ["selectjobfirst"] =  "You need to select a job first!",
        ["notjob"] = "You are not a Post Op. Worker!"
    },
    html = {
        ["welcome"] = "Welcome to Post Op. Transport",
        ["done"] = "DONE!",
        ["selectroute"] = "SELECT A ROUTE",
        ["areaselected"] = "AREA SELECTED!",
        ["selectthisarea"] = "SELECT THIS AREA!",
        ["selectwork"] = "SELECT A WORK!",
        ["selectvehicle"] = "SELECT VEHICLE!",
        ["package"] = "PACKAGE"
    },
}

HSN.SendMessage = function(message, isError, part, source)
    if part == nil then part = "client" end
    if part == "client" then
        if HSN.Config.Framework == "new-qb" or  HSN.Config.Framework == "old-qb" then
            local p = nil
            if isError then p = "error" else p = "success" end
            TriggerEvent("QBCore:Notify",message, p)
        else
            TriggerEvent("esx:showNotification", message)
        end
    elseif part == "server" then
        if HSN.Config.Framework == "new-qb" or  HSN.Config.Framework == "old-qb" then
            local p = nil
            if isError then p = "error" else p = "success" end
            TriggerClientEvent('QBCore:Notify', source, message, p)
        else
            TriggerClientEvent("esx:showNotification",source, message)
        end
    end
end