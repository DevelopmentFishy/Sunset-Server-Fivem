-- Generated with https://configurator.jgscripts.com at 4/15/2024, 11:09:11 PM

Config = {}
Config.Framework = 'QBCore'
Config.FuelSystem = 'LegacyFuel'
Config.VehicleKeys = 'qb-vehiclekeys'
Config.Notifications = 'ox_lib'
Config.Locale = 'nl'
Config.DateFormat = 'nl-BE'
Config.CurrencySymbol = '€'
Config.DrawText = 'jg-textui'
Config.OpenGarageKeyBind = 38
Config.OpenImpoundKeyBind = 38
Config.InsertVehicleKeyBind = 38
Config.OpenGaragePrompt = '[E] Open Garage'
Config.OpenImpoundPrompt = '[E] Open Impound'
Config.InsertVehiclePrompt = '[E] Parkeer voertuig'
Config.ShowVehicleImages = false
Config.DoNotSpawnInsideVehicle = false
Config.SaveVehicleDamage = true
Config.AdvancedVehicleDamage = true
Config.SaveVehiclePropsOnInsert = false
Config.TransferHidePlayerNames = false
Config.GarageVehicleTransferCost = 500
Config.EnableTransfers = {
  betweenGarages = true,
  betweenPlayers = true,
}
Config.AllowInfiniteVehicleSpawns = false
Config.JobGaragesAllowInfiniteVehicleSpawns = false
Config.GangGaragesAllowInfiniteVehicleSpawns = false
Config.GarageVehicleReturnCost = 500
Config.GarageVehicleReturnCostSocietyFund = false
Config.GarageShowBlips = true
Config.GarageUniqueBlips = false
Config.GarageLocations = {
  ['Legion Square'] = {
    coords = vector3(215.09, -805.17, 30.81),
    spawn = {
      vector4(216.84, -802.02, 30.78, 69.82),
      vector4(218.09, -799.42, 30.76, 66.17),
      vector4(219.29, -797.23, 30.75, 65.4),
      vector4(219.59, -794.44, 30.75, 69.35),
      vector4(220.63, -792.03, 30.75, 63.76),
      vector4(206.81, -798.35, 30.99, 248.53),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Islington South'] = {
    coords = vector3(273.0, -343.85, 44.91),
    spawn = vector4(270.75, -340.51, 44.92, 342.03),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Grove Street'] = {
    coords = vector3(14.66, -1728.52, 29.3),
    spawn = vector4(23.93, -1722.9, 29.3, 310.58),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Mirror Park'] = {
    coords = vector3(1032.84, -765.1, 58.18),
    spawn = vector4(1023.2, -764.27, 57.96, 319.66),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Beach = {
    coords = vector3(-1248.69, -1425.71, 4.32),
    spawn = vector4(-1244.27, -1422.08, 4.32, 37.12),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Great Ocean Highway'] = {
    coords = vector3(-2971.07, 358.61, 14.77),
    spawn = {
      vector4(-2966.77, 356.34, 14.77, 32),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Sandy South'] = {
    coords = vector3(217.33, 2605.65, 46.04),
    spawn = vector4(216.94, 2608.44, 46.33, 14.07),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Sandy North'] = {
    coords = vector3(1878.44, 3760.1, 32.94),
    spawn = vector4(1880.14, 3757.73, 32.93, 215.54),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['North Vinewood Blvd'] = {
    coords = vector3(365.21, 295.65, 103.46),
    spawn = vector4(364.84, 289.73, 103.42, 164.23),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Grapeseed = {
    coords = vector3(1713.06, 4745.32, 41.96),
    spawn = vector4(1710.64, 4746.94, 41.95, 90.11),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Paleto Bay'] = {
    coords = vector3(107.32, 6611.77, 31.98),
    spawn = vector4(110.84, 6607.82, 31.86, 265.28),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Boats = {
    coords = vector3(-795.15, -1510.79, 1.6),
    spawn = {
      vector4(-798.66, -1507.73, -0.47, 102.23),
    },
    distance = 20,
    type = 'sea',
    hideBlip = false,
    blip = {
      id = 410,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Hangar = {
    coords = vector3(-1243.49, -3391.88, 13.94),
    spawn = vector4(-1258.4, -3394.56, 13.94, 328.23),
    distance = 20,
    type = 'air',
    hideBlip = false,
    blip = {
      id = 423,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Fast Custom Garage'] = {
    coords = vector3(-967.2, -758.98, 15.2),
    spawn = {
      vector4(-960.39, -779.07, 14.68, 90.4),
      vector4(-975.07, -772.86, 14.67, 267.66),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Casino Garage'] = {
    coords = vector3(872.85, -27.67, 78.35),
    spawn = {
      vector4(862.29, -23.47, 78.35, 236.84),
      vector4(860.3, -26.5, 78.35, 238.5),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Haven garage'] = {
    coords = vector3(1133.98, -3133.32, 5.48),
    spawn = {
      vector4(1125.89, -3124.95, 5.48, 178.07),
      vector4(1120.2, -3125.64, 5.48, 181.31),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Recyle = {
    coords = vector3(755.33, -1355.89, 26.42),
    spawn = {
      vector4(755.36, -1354.28, 25.86, 358),
    },
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Rode garage'] = {
    coords = vector3(-290.67, -763.47, 33.97),
    spawn = {
      vector4(-295.32, -761.38, 33.97, 157.47),
    },
    distance = 10,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Helipad Haven'] = {
    coords = vector3(-730.3, -1438.95, 5.0),
    spawn = {
      vector4(-724.88, -1444.12, 5.0, 318.97),
    },
    distance = 20,
    type = 'air',
    hideBlip = false,
    blip = {
      id = 64,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Boot garage sandy'] = {
    coords = vector3(1299.46, 4217.53, 33.91),
    spawn = {
      vector4(1291.72, 4220.99, 30.39, 167.58),
    },
    distance = 20,
    type = 'sea',
    hideBlip = false,
    blip = {
      id = 410,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Helipad Sandy'] = {
    coords = vector3(1778.0, 3234.16, 42.38),
    spawn = {
      vector4(1771.19, 3239.99, 42.14, 102.96),
    },
    distance = 20,
    type = 'air',
    hideBlip = false,
    blip = {
      id = 64,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
}
Config.JobGarageShowBlips = true
Config.JobGarageUniqueBlips = false
Config.JobGarageSetVehicleCommand = 'setjobvehicle'
Config.JobGarageRemoveVehicleCommand = 'removejobvehicle'
Config.JobGarageLocations = {
  Mechanic = {
    coords = vector3(-942.92, -765.99, 15.2),
    spawn = {
      vector4(-944.61, -774.62, 15.2, 174.02),
    },
    distance = 7,
    job = 'mechanic',
    type = 'car',
    vehiclesType = 'spawner',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehicles = {
      {
        vehicle = 'flatbed3',
        plate = 'Mech1',
        minJobGrade = 0,
        nickname = 'Takel wagen',
      },
      {
        vehicle = 'energyafricatmec',
        plate = 'Mech2',
        minJobGrade = 0,
        nickname = 'Motor',
      },
      {
        vehicle = 'energyraptor',
        plate = 'Mech3',
        minJobGrade = 0,
        nickname = 'raptor',
      },
    },
  },
  Police = {
    coords = vector3(542.19, -0.47, 70.63),
    spawn = {
      vector4(534.67, -9.48, 70.63, 151),
    },
    distance = 5,
    job = 'police',
    type = 'car',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehiclesType = 'spawner',
    showLiveriesExtrasMenu = false,
    vehicles = {
      {
        vehicle = 'lpv902',
        plate = '',
        minJobGrade = 0,
        nickname = 'Volvo 902',
        livery = 1,
        extras = {
          1,
          2,
        },
      },
      {
        vehicle = 'lpv90',
        plate = false,
        minJobGrade = 2,
        livery = 2,
        extras = {},
        nickname = 'Volvo 90',
      },
      {
        vehicle = 'lpx5',
        plate = '',
        minJobGrade = 2,
        nickname = 'Bmw X5',
      },
      {
        vehicle = 'upcla45',
        plate = '',
        minJobGrade = 4,
        nickname = 'uca cla45',
      },
      {
        vehicle = 'upm5',
        plate = '',
        minJobGrade = 4,
        nickname = 'Bmw m5 uca',
      },
      {
        vehicle = 'uprs6',
        plate = '',
        minJobGrade = 4,
        nickname = 'uca Rs6',
      },
      {
        vehicle = 'upx6',
        plate = '',
        minJobGrade = 3,
        nickname = 'uca x6',
      },
      {
        vehicle = 's3',
        plate = '',
        minJobGrade = 0,
        nickname = 's3',
      },
      {
        vehicle = 'audia6',
        plate = '',
        minJobGrade = 1,
        nickname = 'audi a6',
      },
      {
        vehicle = 't6lpa',
        plate = '',
        minJobGrade = 0,
        nickname = 't6',
      },
      {
        vehicle = 'skoda',
        plate = '',
        minJobGrade = 0,
        nickname = 'skoda',
      },
      {
        vehicle = 'touran',
        plate = '',
        minJobGrade = 0,
        nickname = 'touran',
      },
      {
        vehicle = 'a45',
        plate = '',
        minJobGrade = 0,
        nickname = 'Mercedes amg A45',
      },
      {
        vehicle = '5seriesp',
        plate = '',
        minJobGrade = 0,
        nickname = 'Bmw 5 series',
      },
      {
        vehicle = 'fedM5',
        plate = '',
        minJobGrade = 3,
        nickname = 'federaal m5',
      },
      {
        vehicle = 'imprezap',
        plate = '',
        minJobGrade = 0,
        nickname = 'impreza sti',
      },
      {
        vehicle = 'inprezaoud',
        plate = '',
        minJobGrade = 0,
        nickname = 'impreza 2 sti',
      },
      {
        vehicle = 'jaguarfp',
        plate = '',
        minJobGrade = 0,
        nickname = 'jaguar fpace',
      },
      {
        vehicle = 'lokxc90',
        plate = '',
        minJobGrade = 0,
        nickname = 'lokaal xc90',
      },
      {
        vehicle = 'poltsprinter',
        plate = '',
        minJobGrade = 0,
        nickname = 'gevangenis transport',
      },
      {
        vehicle = '22m5sal',
        plate = '',
        minJobGrade = 2,
        nickname = 'bmw m5',
      },
      {
        vehicle = 'PolitieRS6',
        plate = '',
        minJobGrade = 3,
        nickname = 'Lokaal rs6',
      },
    },
  },
  Ambulance = {
    coords = vector3(295.62, -606.87, 43.25),
    spawn = {
      vector4(290.01, -608.07, 43.2, 64.17),
    },
    distance = 15,
    job = 'ambulance',
    type = 'car',
    vehiclesType = 'spawner',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehicles = {
      {
        vehicle = 'audi_a6_2020_smur',
        plate = '',
        minJobGrade = 0,
        nickname = 'Audi A6',
      },
      {
        vehicle = 'merc_gls_smur',
        plate = '',
        minJobGrade = 0,
        nickname = 'mercedes gls',
      },
      {
        vehicle = 'asprinter',
        plate = '',
        minJobGrade = 0,
        nickname = 'sprinter',
      },
      {
        vehicle = 'merc_spr_hvz_kempen',
        plate = '',
        minJobGrade = 0,
        nickname = 'Ambulance sprinter',
      },
      {
        vehicle = 'GD-X7MUG',
        plate = '',
        minJobGrade = 0,
        nickname = 'Ambulance bmw x7',
      },
      {
        vehicle = 'mugranger',
        plate = '',
        minJobGrade = 0,
        nickname = 'Ambulance mug ranger',
      },
    },
    showLiveriesExtrasMenu = false,
  },
  Police2 = {
    coords = vector3(534.75, 6.95, 70.63),
    spawn = {
      vector4(534.67, -9.48, 70.63, 151),
    },
    distance = 5,
    job = 'police',
    type = 'car',
    vehiclesType = 'spawner',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehicles = {
      {
        vehicle = 'fpmoto3',
        plate = '',
        minJobGrade = 1,
        nickname = 'Motor',
      },
    },
    showLiveriesExtrasMenu = true,
  },
  Advocaat = {
    coords = vector3(-252.04, -800.55, 31.97),
    spawn = {
      vector4(-253.53, -806.57, 31.9, 67.82),
    },
    distance = 5,
    job = 'lawyer',
    type = 'car',
    vehiclesType = 'personal',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehicles = {},
    showLiveriesExtrasMenu = true,
  },
  catcafe = {
    coords = vector3(-608.79, -1060.24, 21.79),
    spawn = {
      vector4(-612.61, -1066.13, 21.79, 176),
    },
    distance = 5,
    job = 'catcafe',
    type = 'car',
    vehiclesType = 'spawner',
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    vehicles = {
      {
        vehicle = 'cat_car',
        plate = 'catcafe',
        minJobGrade = 0,
        nickname = 'Catcafe Dienst Voertuig',
      },
    },
    showLiveriesExtrasMenu = true,
  },
}
Config.GangGarageShowBlips = true
Config.GangGarageUniqueBlips = false
Config.GangGarageSetVehicleCommand = 'setgangvehicle'
Config.GangGarageRemoveVehicleCommand = 'removegangvehicle'
Config.GangGarageLocations = {}
Config.ImpoundShowBlips = true
Config.ImpoundUniqueBlips = false
Config.ImpoundCommand = 'iv'
Config.ImpoundJobRestriction = {
  'police',
}
Config.ImpoundFeesSocietyFund = 'police'
Config.ImpoundLocations = {
  ['Impound A'] = {
    coords = vector3(-191.82, -1163.77, 23.67),
    spawn = vector4(-173.42, -1166.77, 22.46, 179.84),
    distance = 15,
    type = 'car',
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Impound B'] = {
    coords = vector3(1649.71, 3789.61, 34.79),
    spawn = vector4(1643.66, 3798.36, 34.49, 216.16),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Impound C'] = {
    coords = vector3(-1108.04, -2875.37, 13.95),
    spawn = vector4(-1112.42, -2883.51, 13.95, 149.72),
    distance = 20,
    type = 'air',
    hideBlip = false,
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Impound D'] = {
    coords = vector3(-850.39, -1498.21, 1.63),
    spawn = vector4(-851.32, -1495.59, -0.08, 288.55),
    distance = 20,
    type = 'sea',
    hideBlip = false,
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
}
Config.PrivGarageCreateCommand = 'privategarages'
Config.PrivGarageCreateJobRestriction = {
  'realestate',
}
Config.ChangeVehiclePlate = 'vplate'
Config.DeleteVehicleFromDB = 'dvdb'
Config.ReturnVehicleToGarage = 'vreturn'
Config.VehicleLabels = {
  spawnName = 'Pretty Vehicle Label',
}
Config.__v2Config = true
Config.Config = {}
Config.DisableServerVehicleSpawning = false
Config.PlayerTransferBlacklist = {
  'spawnName',
}
Config.HideWatermark = false
