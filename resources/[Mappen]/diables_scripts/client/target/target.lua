Citizen.CreateThread(function()
    if Config.Showers == true then
	-- q-target and ox-target
        if Config.Target == "q-target" or Config.Target == "ox-target" then
            for index, value in pairs(Config2.ShowersLocations) do
                exports['qtarget']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ
                }, {
                    options = {
                        {
                            event = "diables_hospital:douches",
                            icon = "fas fa-droplet",
                            label = _U('showers_use'),
                        },
                    },
                    distance = 1.5
                })
            end
            for index, value in pairs(Config2.WashHandsLocations) do
                exports['qtarget']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ
                }, {
                    options = {
                        {
                            event = "diables_hospital:washHands",
                            icon = "fas fa-droplet",
                            label = _U('hands_use'),
                        },
                    },
                    distance = 1.5
                })
            end
                exports.qtarget:AddTargetModel(`v_diables_hopital_bed01`, {
                    options = {
                        {
                            event = "diables_hospital:Bed1",
                            icon = "fas fa-spa",
                            label = _U('PushBed'),
                        },
                        {
                            action = function(entity)
                              TriggerEvent('diables_hospital:lieonbed', entity)
                            end,
                            icon = "fas fa-spa",
                            label = _U('OnLie'),
                        },
                    },
                    distance = 2
                })
                if Config.Perfusions then
                exports.qtarget:AddTargetModel(`v_diables_hopital_perf_01`, {
                	options = {
                		{
                			event = "diables_hospital:Perf1",
                			icon = "fas fa-spa",
                			label = _U('TakePerf'),
                		},
                	},
                	distance = 2
                })
                exports.qtarget:AddTargetModel(`v_diables_hopital_perf_02`, {
                	options = {
                		{
                			event = "diables_hospital:Perf2",
                			icon = "fas fa-spa",
                			label = _U('TakePerf'),
                		},
                	},
                	distance = 2
                })
                end
-- qb-target
        elseif Config.Target == "qb-target" then
            for index, value in pairs(Config2.ShowersLocations) do
                exports['qb-target']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            event = "diables_hospital:douches",
                            icon = 'fas fa-droplet',
                            label = _U('showers_use'),
                        }
                    },
                    distance = 1.5,
                })
            end
            for index, value in pairs(Config2.WashHandsLocations) do
                exports['qb-target']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            event = "diables_hospital:washHands",
                            icon = 'fas fa-droplet',
                            label = _U('hands_use'),
                        }
                    },
                    distance = 1.5,
                })
            end
                exports['qb-target']:AddTargetModel(`v_diables_hopital_bed01`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Bed1",
                            icon = "fas fa-spa",
                            label = _U('PushBed'),
                        },
                        {
                            type = "client",
                            action = function(entity)
                              TriggerEvent('diables_hospital:lieonbed', entity)
                            end,
                            icon = "fas fa-spa",
                            label = _U('OnLie'),
                        },
                    },
                    distance = 2
                })
               if Config.Perfusions then
                exports['qb-target']:AddTargetModel(`v_diables_hopital_perf_01`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Perf1",
                            icon = "fas fa-spa",
                            label = _U('TakePerf'),
                        },
                    },
                    distance = 2
                })
                exports['qb-target']:AddTargetModel(`v_diables_hopital_perf_02`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Perf2",
                            icon = "fas fa-spa",
                            label = _U('TakePerf'),
                        },
                    },
                    distance = 2
                })
			  end
-- luck-contextmenu
        elseif Config.Target == "luck-contextmenu" then
            for index, value in pairs(Config2.ShowersLocations) do
                exports['luck-contextmenu']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            event = "diables_hospital:douches",
                            icon = 'fas fa-droplet',
                            label = _U('showers_use'),
                        }
                    },
                    distance = 1.5,
                })
            end
            for index, value in pairs(Config2.WashHandsLocations) do
                exports['luck-contextmenu']:AddBoxZone(index, value.pos, value.x, value.y, {
                    name = index,
                    heading = value.heading,
                    debugPoly = Config.Debug,
                    minZ = value.minZ,
                    maxZ = value.maxZ,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            event = "diables_hospital:washHands",
                            icon = 'fas fa-droplet',
                            label = _U('hands_use'),
                        }
                    },
                    distance = 1.5,
                })
            end
                exports['luck-contextmenu']:AddTargetModel(`v_diables_hopital_bed01`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Bed1",
                            icon = "fas fa-spa",
                            label = _U('PushBed'),
                        },
                        {
                            type = "client",
                            action = function(entity)
                              TriggerEvent('diables_hospital:lieonbed', entity)
                            end,
                            icon = "fas fa-spa",
                            label = _U('OnLie'),
                        },
                    },
                    distance = 2
                })
               if Config.Perfusions then
                exports['luck-contextmenu']:AddTargetModel(`v_diables_hopital_perf_01`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Perf1",
                            icon = "fas fa-spa",
                            label = _U('TakePerf'),
                        },
                    },
                    distance = 2
                })
                exports['luck-contextmenu']:AddTargetModel(`v_diables_hopital_perf_02`, {
                    options = {
                        {
                            type = "client",
                            event = "diables_hospital:Perf2",
                            icon = "fas fa-spa",
                            label = _U('TakePerf'),
                        },
                    },
                    distance = 2
                })
			  end
        end
    end
end)
