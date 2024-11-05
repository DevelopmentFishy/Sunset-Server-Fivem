Citizen.CreateThread(function()
    if Config.target == 'ox-target' then
        print('ox-target')

        exports.ox_target:addBoxZone({
            coords = Config_escrow.irmmove,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    serverEvent = 'diables_irm:moveIrmUp',
                    icon = 'fa-solid fa-bed-pulse',
                    label = Config.TargetLabelStart,
                },
                {
                    name = 'box',
                    serverEvent = 'diables_irm:moveIrmDown',
                    icon = 'fa-solid fa-bed',
                    label = Config.TargetLabelStop,
                },
            }
        })
        exports.ox_target:addBoxZone({
            coords = Config_escrow.irm,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    event = 'diables_irm:startirm',
                    icon = 'fa-solid fa-bed',
                    label = Config.TargetLabelSit,
                }
            }
        })
    elseif Config.target == 'qtarget' then

      exports.qtarget:AddBoxZone("irm1", Config_escrow.irmmove, 3.05, 4.35, {
        name="irm1",
        heading=-0.0,
        debugPoly=false,
        minZ = 38.299182891846-0.9,
        maxZ = 38.299182891846+0.9,
        }, {
          options = {
            {
              name = 'box',
              event = 'diables_irm:moveIrmUp',
              icon = 'fa-solid fa-bed-pulse',
              label = Config.TargetLabelStart,
          },
          {
              name = 'box',
              event = 'diables_irm:moveIrmDown',
              icon = 'fa-solid fa-bed',
              label = Config.TargetLabelStop,
          }
      },
          distance = 1.5
      })

        exports.qtarget:AddBoxZone("irm2", Config_escrow.irm, 3.05, 4.35, {
          name="irm2",
          heading=-0.0,
          debugPoly=false,
          minZ=38.299182891846-0.9,
          maxZ=38.299182891846+0.9,
          }, {
            options = {
              {
                  name = 'box',
                  event = 'diables_irm:startirm',
                  icon = 'fa-solid fa-bed',
                  label = Config.TargetLabelSit,
              }
        },
            distance = 1.5
        })

    elseif Config.target == 'qb-target' then
   
 exports['qb-target']:AddBoxZone('irmmove', Config_escrow.irmmove, 2, 2, {
      name = 'irmmove',
      heading = Config_escrow.irmHeading,
        minZ = Config_escrow.irmMoveMinZ,
        maxZ = Config_escrow.irmMoveMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'server',
          event = 'diables_irm:moveIrmUp',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStart,
        },
        {
          type = 'server',
          event = 'diables_irm:moveIrmDown',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStop,
        },
      },
      distance = 2.5
    })
 exports['qb-target']:AddBoxZone('irm', Config_escrow.irm, 1, 4, {
      name = 'irm',
      heading = Config_escrow.irmMoveHeading,
        minZ = Config_escrow.irmMinZ,
        maxZ = Config_escrow.irmMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'client',
          event = 'diables_irm:startirm',
          icon = 'fas fa-bed',
          label = Config.TargetLabelSit,
        },
      },
      distance = 5.0
    })
		
    elseif Config.target == 'luck-contextmenu' then
	
        print('luck-contextmenu')

 exports['luck-contextmenu']:AddBoxZone('irmmove', Config_escrow.irmmove, 2, 2, {
      name = 'irmmove',
      heading = Config_escrow.irmHeading,
        minZ = Config_escrow.irmMoveMinZ,
        maxZ = Config_escrow.irmMoveMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'server',
          event = 'diables_irm:moveIrmUp',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStart,
        },
        {
          type = 'server',
          event = 'diables_irm:moveIrmDown',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStop,
        },
      },
      distance = 2.5
    })
 exports['luck-contextmenu']:AddBoxZone('irm', Config_escrow.irm, 1, 4, {
      name = 'irm',
      heading = Config_escrow.irmMoveHeading,
        minZ = Config_escrow.irmMinZ,
        maxZ = Config_escrow.irmMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'client',
          event = 'diables_irm:startirm',
          icon = 'fas fa-bed',
          label = Config.TargetLabelSit,
        },
      },
      distance = 5.0
    })
    end
end)
