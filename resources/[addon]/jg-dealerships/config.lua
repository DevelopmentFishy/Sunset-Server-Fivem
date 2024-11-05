-- Generated with https://configurator.jgscripts.com at 4/19/2024, 9:53:41 PM

Config = {}
Config.Locale = 'en'
Config.NumberAndDateFormat = 'en-GB'
Config.Currency = 'EUR'
Config.SpeedUnit = 'KM/U'
Config.Logging = false
Config.Framework = 'QBCore'
Config.FuelSystem = 'LegacyFuel'
Config.VehicleKeys = 'qb-vehiclekeys'
Config.Notifications = 'ox_lib'
Config.PlateFormat = '1AA111AA'
Config.DrawText = 'ox_lib'
Config.OpenShowroomPrompt = '[E] Open Showroom'
Config.OpenShowroomKeyBind = 38
Config.ViewInShowroomPrompt = '[E] Bekijk in Showroom'
Config.ViewInShowroomKeyBind = 38
Config.OpenManagementPrompt = '[E] Dealership Management'
Config.OpenManagementKeyBind = 38
Config.SellVehiclePrompt = '[E] Verkoop voertuig'
Config.SellVehicleKeyBind = 38
Config.FinancePayments = 12
Config.FinanceDownPayment = 0.1
Config.FinanceInterest = 0.1
Config.FinancePaymentInterval = 12
Config.FinancePaymentFailedHoursUntilRepo = 1
Config.MaxFinancedVehiclesPerPlayer = 5
Config.DisplayVehiclesPlate = 'DEALER'
Config.DealerPurchasePrice = 0.8
Config.VehicleOrderTime = 1
Config.TestDrivePlate = 'TESTER'
Config.TestDriveTimeSeconds = 120
Config.Categories = {
  planes = 'Planes',
  sportsclassics = 'Sports Classics',
  sedans = 'Sedans',
  compacts = 'Compacts',
  motorcycles = 'Motorcycles',
  super = 'Super',
  offroad = 'Offroad',
  helicopters = 'Helicopters',
  coupes = 'Coupes',
  muscle = 'Muscle',
  boats = 'Boats',
  vans = 'Vans',
  sports = 'Sports',
  suvs = 'SUVs',
  commercial = 'Commercial',
  cycles = 'Cycles',
  industrial = 'Industrial',
  audi = 'Audi',
  bmw = 'Bmw',
  alpha = 'alpha',
  brabus = 'brabus',
  bugatti = 'bugatti',
  dodge = 'dodge',
  ferarri = 'ferarri',
  ford = 'ford',
  honda = 'honda',
  lambo = 'lambo',
  mclaren = 'mclaren',
  mercedes = 'mercedes',
  nissan = 'nissan',
  porsche = 'porsche',
  rangerover = 'rangerover',
  renault = 'renault',
  subaru = 'subaru',
  toyota = 'toyota',
  volkswagen = 'volkswagen',
  maserati = 'maserati',
  rolls = 'rolls',
  bentley = 'bentley',
  lada = 'lada',
  escalade = 'escalade',
  rimac = 'rimac',
}
Config.DealershipLocations = {
  pdm = {
    type = 'self-service',
    showroomType = 'car',
    openShowroom = vector3(-32.98, -1097.67, 27.27),
    openManagement = vector3(-30.43, -1106.84, 26.42),
    purchaseSpawn = vector4(-13.68, -1092.31, 26.67, 159.82),
    testDriveSpawn = vector4(-49.77, -1110.83, 26.44, 75.94),
    sellVehicle = vector3(-27.89, -1082.1, 26.64),
    camera = {
      name = 'Car',
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {
        5,
        8,
        12,
        8,
      },
    },
    categories = {
      'vans',
      'sedans',
      'compacts',
      'motorcycles',
      'offroad',
      'coupes',
      'muscle',
      'suvs',
      'cycles',
      'bmw',
      'audi',
      'alpha',
      'brabus',
      'dodge',
      'ford',
      'honda',
      'mercedes',
      'nissan',
      'porsche',
      'rangerover',
      'renault',
      'subaru',
      'toyota',
      'volkswagen',
      'sports',
      'sportsclassics',
    },
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 326,
      color = 2,
      scale = 0.6,
    },
    societyPurchaseJobWhitelist = {
      police = {
        4,
        5,
      },
    },
    societyPurchaseGangWhitelist = {},
    enableSellVehicle = true,
    sellVehiclePercent = 0.6,
    enableFinance = true,
    hideMarkers = false,
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
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    disableShowroomPurchase = false,
    directSaleDistance = 50,
    job = 'cardealer',
  },
  luxury = {
    type = 'self-service',
    showroomType = 'car',
    openShowroom = vector3(-1257.4, -369.12, 36.98),
    openManagement = vector3(-1249.04, -346.96, 37.34),
    purchaseSpawn = vector4(-1233.46, -346.81, 37.33, 23.36),
    testDriveSpawn = vector4(-1233.46, -346.81, 37.33, 23.36),
    sellVehicle = vector4(-1233.46, -346.81, 37.33, 23.36),
    enableSellVehicle = true,
    sellVehiclePercent = 0.6,
    camera = {
      name = 'Car',
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {
        5,
        8,
        12,
        8,
      },
    },
    categories = {
      'sportsclassics',
      'super',
      'sports',
    },
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 523,
      color = 2,
      scale = 0.6,
    },
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    enableFinance = true,
    hideMarkers = false,
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
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    disableShowroomPurchase = false,
    directSaleDistance = 50,
    job = 'cardealer',
  },
  boats = {
    type = 'self-service',
    showroomType = 'car',
    openShowroom = vector3(-739.55, -1333.75, 1.6),
    openManagement = vector3(-731.37, -1310.35, 5.0),
    purchaseSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    testDriveSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    sellVehicle = vector4(-714.42, -1340.01, -0.18, 139.38),
    enableSellVehicle = true,
    sellVehiclePercent = 0.6,
    camera = {
      name = 'Sea',
      coords = vector4(-808.28, -1491.19, -0.47, 113.53),
      positions = {
        5,
        8,
        12,
        8,
      },
    },
    categories = {
      'boats',
    },
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 410,
      color = 2,
      scale = 0.6,
    },
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    enableFinance = true,
    hideMarkers = false,
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
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    disableShowroomPurchase = false,
    directSaleDistance = 50,
    job = 'cardealer',
  },
  air = {
    type = 'self-service',
    showroomType = 'car',
    openShowroom = vector3(-1623.0, -3151.56, 13.99),
    openManagement = vector3(-1637.78, -3177.94, 13.99),
    purchaseSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    testDriveSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    sellVehicle = vector4(-1654.9, -3147.58, 13.99, 324.78),
    enableSellVehicle = true,
    sellVehiclePercent = 0.6,
    camera = {
      name = 'Air',
      coords = vector4(-1267.0, -3013.14, -48.5, 310.96),
      positions = {
        12,
        15,
        20,
        15,
      },
    },
    categories = {
      'planes',
      'helicopters',
    },
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 423,
      color = 2,
      scale = 0.6,
    },
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    enableFinance = true,
    hideMarkers = false,
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
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    disableShowroomPurchase = false,
    directSaleDistance = 50,
    job = 'cardealer',
  },
  fastart = {
    type = 'owned',
    openShowroom = vector3(-785.64, -230.07, 37.00),
    openManagement = vector3(-782.68, -212.17, 37.00),
    purchaseSpawn = vector4(-775.38, -230.95, 37.00, 208),
    testDriveSpawn = vector4(-775.38, -230.95, 37.00, 208),
    sellVehicle = vector4(-778.68, -219.81, 37.00, 177),
    enableSellVehicle = false,
    sellVehiclePercent = 0.6,
    camera = {
      name = 'Car',
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {
        5,
        8,
        12,
        8,
      },
    },
    categories = {
      'bugatti',
      'mclaren',
      'lambo',
      'ferarri',
      'rolls',
      'maserati',
      'mercedes',
      'audi',
      'lada',
      'escalade',
      'rimac',
      'bentley',
    },
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 523,
      color = 46,
      scale = 0.6,
    },
    enableFinance = false,
    hideMarkers = false,
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
    disableShowroomPurchase = true,
    directSaleDistance = 50,
    job = 'cardealer',
  },
}
Config.Config = {}
Config.WebhookTestDrive = ''
Config.WebhookPurchase = 'https://discord.com/api/webhooks/1189278261306466304/vhk9uA7zMiUA8SmKfY40HFg6GeTVn6hFRYRXtOTybYcWCT7uY-ukBsyTlSRtOmHsBMD8'
Config.WebhookFinance = 'https://discord.com/api/webhooks/1189278184353570826/R7vI43eLHkP3ke5yhswLvWPGkXCT1wp7aNrzZLeHp_N15OrOu8ncs-uO_ivS8BxL4QWj'
Config.WebhookDealership = ''
Config.WebhookAdmin = ''
