Citizen.CreateThread(function()
    if Config.target == 'ox-target' then
        print('ox-target')

        exports.ox_target:addBoxZone({
            coords = Config_escrow.radiomove,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    serverEvent = 'diables_radio:moveRadioUp',
                    icon = 'fa-solid fa-bed-pulse',
                    label = Config.TargetLabelStart,
                },
                {
                    name = 'box',
                    serverEvent = 'diables_radio:moveRadioDown',
                    icon = 'fa-solid fa-bed',
                    label = Config.TargetLabelStop,
                },
            }
        })
        exports.ox_target:addBoxZone({
            coords = Config_escrow.radio,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    event = 'diables_radio:startradio',
                    icon = 'fa-solid fa-bed',
                    label = Config.TargetLabelSit,
                }
            }
        })
    elseif Config.target == 'qtarget' then
      
      exports.qtarget:AddBoxZone("radiomove", Config_escrow.radiomove, 2.0, 2.0, {
        name="radiomove",
        heading = 308.0,
        debugPoly=true,
        minZ = 37.462280273438,
        maxZ = 39.462280273438,
        }, {
          options = {
            {
              name = 'box',
              event = 'diables_radio:moveRadioUp',
              icon = 'fas fa-procedures',
              label = Config.TargetLabelStart,
            },
            {
              name = 'box',
              event = 'diables_radio:moveRadioDown',
              icon = 'fas fa-procedures',
              label = Config.TargetLabelStop,
            },
      },
          distance = 1.5
      })

        exports.qtarget:AddBoxZone("radiomove2", Config_escrow.radio, 2.0, 2.0, {
          name = "radiomove2",
          heading = 308.0,
          debugPoly = true,
          minZ = 37.370536804199,
          maxZ = 39.370536804199,
          }, {
            options = {
              {
                  name = 'box',
                  event = 'diables_radio:startradio',
                  icon = 'fa-solid fa-bed',
                  label = Config.TargetLabelSit,
              }
        },
            distance = 2.5
        })

    elseif Config.target == 'qb-target' then
        print('qb-target')
   
 exports['qb-target']:AddBoxZone('radiomove', Config_escrow.radiomove, 2, 2, {
      name = 'radiomove',
      heading = Config_escrow.radioMoveHeading,
        minZ = Config_escrow.radioMoveMinZ,
        maxZ = Config_escrow.radioMoveMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'server',
          event = 'diables_radio:moveRadioUp',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStart,
        },
        {
          type = 'server',
          event = 'diables_radio:moveRadioDown',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStop,
        },
      },
      distance = 2.5
    })
 exports['qb-target']:AddBoxZone('radiomove2', Config_escrow.radio, 1, 4, {
      name = 'radiomove2',
      heading = Config_escrow.radioHeading,
        minZ = Config_escrow.radioMinZ,
        maxZ = Config_escrow.radioMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'client',
          event = 'diables_radio:startradio',
          icon = 'fas fa-bed',
          label = Config.TargetLabelSit,
        },
      },
      distance = 5.0
    })
		
    elseif Config.target == 'luck-contextmenu' then
	
        print('luck-contextmenu')

 exports['luck-contextmenu']:AddBoxZone('radiomove', Config_escrow.radiomove, 2, 2, {
      name = 'radiomove',
      heading = Config_escrow.radioMoveHeading,
        minZ = Config_escrow.radioMoveMinZ,
        maxZ = Config_escrow.radioMoveMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'server',
          event = 'diables_radio:moveRadioUp',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStart,
        },
        {
          type = 'server',
          event = 'diables_radio:moveRadioDown',
          icon = 'fas fa-procedures',
          label = Config.TargetLabelStop,
        },
      },
      distance = 2.5
    })
 exports['luck-contextmenu']:AddBoxZone('radio', Config_escrow.radio, 1, 4, {
      name = 'radio',
      heading = Config_escrow.radioHeading,
        minZ = Config_escrow.radioMinZ,
        maxZ = Config_escrow.radioMaxZ,
      debugPoly = false,
    }, {
      options = {
        {
          type = 'client',
          event = 'diables_radio:startradio',
          icon = 'fas fa-bed',
          label = Config.TargetLabelSit,
        },
      },
      distance = 5.0
    })	
    end
end)
