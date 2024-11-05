Config = {}

Config.Debug = false
--SERVER SETTINGS
Config.Framework = "qbcore" -- Set your framework! qbcore, ESX, standalone
Config.NewESX = true -- if you use esx 1.1 version set this to false
Config.InteractionType = "textui" -- target or textui or 3dtext | which type of interaction you want
Config.Target = "qb-target" -- Which Target system do u use? qb-target, qtarget
Config.Dispatch = { enabled = true, script = "ps-disptach" } -- cd_dispatch, linden_outlawalert, ps-disptach
Config.Bob74_ipl = true -- Loads lab interiors
Config.PoliceJobs = { 'police', 'sheriff' }
Config.NotificationType = "ox_lib" -- Notifications | types: ESX, ox_lib, qbcore
Config.Progress = "qbcore" -- ProgressBar | types: progressBars, ox_lib, qbcore
Config.Clothing = "illenium-appearance" -- illenium-appearance, esx_skin, qb-clothing, custom | change in client/cl_Utils.lua | GetSkin = function() | ApplySkin = function()
Config.TextUI = "ox_lib" -- TextUIs | types: esx, ox_lib, luke
Config.Input = "ox_lib" -- Input | types: ox_lib, qb-input
Config.Context = "qbcore" -- Context | types: ox_lib, qbcore
Config.SellingMoneyType = "cash" -- Selling Money Type | ESX types: bank, money, black_money or own types | QBCORE types: cash, bank, crypto or own types
--PLAYER CONTROL
Config.Logs = { enabled = true, type = "webhook" } -- use webhook or ox_lib (datadog) Can be changed in server > sv_utils.lua
Config.DropPlayer = false -- Drop (Kick) Player if tries to cheat!
Config.AnticheatBan = false -- Change in server/sv_Utils.lua!!! WIll not work by default you need to add your custom trigger to ban player!

--BLIPS
Config.Blips = {
    FlowerShop = { -- do not use same value twice (will result in overwriting of blip)
        BlipCoords = vec3(307.91, -1286.48, 29.53), -- Blip coords
        Sprite = 273, -- Blip Icon
        Display = 4, -- keep 4
        Scale = 0.6, -- Size of blip
        Colour = 69, -- colour
        Name = "Avevay" -- Blip name
    },
    ComicShop = {
        BlipCoords = vec3(-143.52, 229.53, 93.94),
        Sprite = 280,
        Display = 4,
        Scale = 0.8,
        Colour = 50,
        Name = "Geekshop"
    },
}

--Madrazo Trade
Config.Madrazo = {
    enabled = true,
    Header = "Madrazo",
    Title = "Koop Meth Toegangskaart",
    Description = "Ruil 40 coke figuurtjes in voor een Meth Toegangskaart !",
    Available = { -- Time
        enabled = false, from = 1, to = 22
    },
    RequiredItems = {
        { item = "coke_figure", count = 40, remove = true },
    },
    AddItems = {
        { item = "meth_access", count = 1 },
    },
    Location = {
        Coords = vec3(-1032.44, 686.0, 161.45),
        Heading = 270.7,
        radius = 0.7,
    },
    Log = "Heeft 40 coke figuurtjes geruild voor een meth labkaart"
}

--Gerald Trade
Config.Gerald = {
    enabled = true,
    Header = "Gerald",
    Title = "Koop Cocaïne Toegangskaart",
    Description = "Ruil 400 Wiedzakjes in voor een Cocaïne Toegangskaart !",
    Available = { -- Time
        enabled = false, from = 3, to = 10
    },
    RequiredItems = {
        { item = "weed_package", count = 400, remove = true },
    },
    AddItems = {
        { item = "coke_access", count = 1 },
    },
    Location = {
        Coords = vec3(-58.91, -1530.98, 34.5),
        Heading = 229.64,
        radius = 0.7,
    },
    Log = "Heeft 400 wiedzakjes geruild voor een Cocaïne Labkaart !"
}

--Locate Dealer
Config.LocateDealer = {
    enabled = false,
    RequiredItems = {
        -- { item = "cryptostick", count = 1, remove = true }, -- Add you hacking usb item from your server or just create one!
    },
    DealerPos = { -- Location of dealers
        vec2(-1301.67, -776.34),
        vec2(819.61, -2348.83),
    },
    Location = { --Target
        Coords = vector3(-1055.31, -243.29, 44.05),
        radius = 0.4,
    },
}

--Pharmacist
Config.Pharmacist = {
    enabled = true,
    Header = "Apotheker",
    Available = { -- Time
        enabled = false, from = 18, to = 23
    },
    Items = {
        { label = 'Lege Natrium biddon', item = 'meth_emptysacid', description = "Koop een Lege Natrium biddon voor: € ",
            price = 2500, MinAmount = 1, MaxAmount = 100 },
        { label = 'Ammoniak', item = 'meth_amoniak', description = "Koop Ammoniak voor: € ", price = 800, MinAmount = 1,
            MaxAmount = 100 },
        { label = 'Spuit', item = 'syringe', description = "Koop Spuit voor: € ", price = 100, MinAmount = 1,
            MaxAmount = 1 },
        { label = 'Meth Pijp', item = 'meth_pipe', description = "Koop Meth Pijp voor: € ", price = 100, MinAmount = 1,
            MaxAmount = 1 },
        { label = 'Crack Pijp', item = 'crack_pipe', description = "Koop Meth Pijp voor: € ", price = 160, MinAmount = 1,
            MaxAmount = 1 },
    },

    Ped = {
        { model = "s_m_m_doctor_01", coords = vec4(156.96, 6657.34, 30.56, 49.78), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Dealer
Config.Dealer = {
    enabled = true,
    Header = "Weed Dealer",
    Items = {
        { label = 'Wiet Labkaart', item = 'weed_access', description = "Koop Wiet Toegangskaart voor: € ", price = 40000,
            MinAmount = 1, MaxAmount = 1 },
        { label = 'Weed Papers', item = 'weed_papers', description = "Buy Weed Papers for:  ", price = 100, MinAmount = 1,
            MaxAmount = 5 },
        { label = 'Blunt Wraps', item = 'weed_wrap', description = "Buy Blunt wraps for: € ", price = 200, MinAmount = 1,
            MaxAmount = 5 },
        { label = 'Plastic Bag', item = 'plastic_bag', description = "Buy Plastic Bag for: € ", price = 3, MinAmount = 1,
            MaxAmount = 10 },
    },
    Ped = {
        { model = "s_m_y_dealer_01", coords = vec4(0, 0, 0, 0), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Medicament dealer
Config.MedicamentsShop = {
    enabled = true,
    Header = "Medicatie Dealer",
    Items = {
        { label = 'LSD', item = 'lsd', description = "Koop LSD voor: € ", price = 100, MinAmount = 1, MaxAmount = 2 },
        { label = 'Alprazolam', item = 'xanaxpack', description = "Koop Xanax voor: € ", price = 1500, MinAmount = 1,
            MaxAmount = 2 },
        { label = 'XTC', item = 'ecstasy', description = "Koop XTC voor: € ", price = 200, MinAmount = 1,
            MaxAmount = 2 },
    },
    Ped = {
        { model = "s_m_y_dealer_01", coords = vec4(201.02, -1846.74, 26.78, 142.95), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--ComicShop
Config.ComicShop = {
    enabled = true,
    Header = "Geekshop",
    Items = {
        { label = 'Actiefiguur', item = 'coke_figureempty', description = "Koop een Actiefiguur voor: € ", price = 200,
            MinAmount = 1, MaxAmount = 100 },
    },
    Ped = {
        { model = "u_m_y_imporage", coords = vec4(-143.52, 229.53, 93.94, 1.4), scenario = "WORLD_HUMAN_MUSCLE_FLEX" },
    },
    Log = "Has bought Item %s, Count %s"
}

--Flowershop
Config.FlowerShop = {
    enabled = true,
    Header = "Avevay",
    Items = {
        { label = 'Hamer', item = 'hammer', description = "Koop een hamer voor: € ", price = 63, MinAmount = 1, MaxAmount = 2 },
        { label = 'Schepje', item = 'trowel', description = "Koop een schepje voor: € ", price = 29, MinAmount = 1, MaxAmount = 2 },
        { label = 'Schaar', item = 'scissors', description = "Koop een Schaar voor: € ", price = 35, MinAmount = 1,
            MaxAmount = 2 },
        { label = 'Lijm', item = 'glue', description = "Koop lijm voor: € ", price = 24, MinAmount = 1, MaxAmount = 100 },
        { label = 'Natriumbicarbonaat', item = 'baking_soda', description = "Koop Natriumbicarbonaat voor: € ", price = 100, MinAmount = 1,
            MaxAmount = 100 },
    },
    Ped = {
        { model = "s_m_m_gardener_01", coords = vec4(307.91, -1286.48, 29.53, 165.26), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Weed
Config.Weed = {
    --LABORATORY
    ElectricityNeeded = true,
    --Lab circlezone
    Lab = {
        coords = vector3(1054.33, -3196.17, -39.17),
        radius = 23.85,
        DebugPoly = false,
        name = "WeedLab",
    },
    --Air Conditioner
    AC = {
        coords = vector3(1045.32, -3194.84, -38.33),
        radius = 0.4,
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = false
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(48.17, 6306.15, 31.49),
        radius = 1.2,
        teleport = vector3(1066.12, -3183.43, -40.16),
        NeedItem = true,
        ItemName = "weed_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(1066.57, -3183.46, -38.96), radius = 1.0, teleport = vector3(48.17, 6306.15, 31.49),
    },
    --Collecting weed
    Pickup = {
        Models = { [`bkr_prop_weed_lrg_01a`] = true, [`bkr_prop_weed_lrg_01b`] = true },
        radius = 0.2,
        RequiredItems = {
            { item = "scissors", count = 1, remove = false },
        },
        AddItems = {
            { item = "weed_bud", count = 1 },
        },
        Log = "Has Picked up Weed bud With leaves"
    },
    --Clean
    Clean = {
        header = "Kuis wiet",
        description = "Ingrediënten: 1x Wietknop met blaadjes",
        coords = vector3(1038.67, -3205.93, -38.3),
        radius = 0.8,
        teleport = vector3(1039.3 - 0.8, -3205.95, -37.69 - 1.4),
        heading = 90.0,
        leave = vector3(1039.28, -3205.38, -39.17),
        RequiredItems = {
            { item = "weed_bud", count = 1, remove = true },
        },
        AddItems = {
            { item = "weed_budclean", count = 5 },
        },
        Log = "Has proccessed 1x Weed bud with leaves into 1x Weed bud"
    },
    --Package
    Package = {
        header = "Verpak Wiet",
        description = "Ingredienten: 5x Wietknop, 5x Plastiek Zak",
        coords = vector3(1036.35, -3203.13, -38.24),
        radius = 0.8,
        RequiredItems = {
            { item = "weed_budclean", count = 5, remove = true },
            { item = "plastic_bag", count = 5, remove = true },
        },
        AddItems = {
            { item = "weed_package", count = 5 },
        },
        Log = "Has proccessed 5x Weed bud, 5x Plastic bag into 5x Weed Packed"
    },
}

--Meth
Config.Meth = {
    --LABORATORY
    ElectricityNeeded = true,
    --Electricity
    Electricity = {
        coords = vector3(998.33, -3202.35, -38.48), radius = 1,
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = false
    },
    --Lab circlezone
    Lab = {
        coords = vector3(1013.22, -3194.95, -37.88),
        radius = 18.85,
        DebugPoly = false,
        name = "MethLab",
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(2583.18, 4660.78, 34.08),
        radius = 1.6,
        teleport = vector3(996.99, -3200.7, -37.39),
        NeedItem = true,
        ItemName = "meth_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(996.49, -3200.62, -36.32),
        radius = 1.0,
        teleport = vector3(2583.18, 4660.78, 34.08),
    },
    --GET ACID
    GetSacid = {
        coords = vector3(3561.55, 3675.75, 28.12),
        radius = 1.0,
        teleport = vector3(3561.55, 3675.75, 28.12),
        RequiredItems = {
            { item = "meth_emptysacid", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_sacid", count = 1 },
        },
        Log = "Has refill his Can with Sodium Benzoate"
    },
    --HEAT
    Heat = {
        coords = vector3(1001.97, -3198.86, -38.53),
        radius = 0.4,
        teleport = vector3(1002.38, -3198.91, -39.99),
        heading = 82.52,
    },
    --Pouring
    Pouring = {
        header = "Start met koken",
        description = "Ingredienten: 1x Ammoniak, 1x Natriumbenzoaat",
        coords = vector3(1005.76, -3200.91, -38.1),
        radius = 0.6,
        teleport = vector3(1005.71, -3200.39, -38.51),
        heading = 180.0,
        -- Items are in Complete
    },
    --Complete
    Complete = {
        coords = vector3(1007.84, -3201.51, -38.53),
        radius = 0.5,
        teleport = vector3(1007.89, -3201.09, -39.99),
        heading = 188.27,
        RequiredItems = {
            { item = "meth_amoniak", count = 1, remove = true },
            { item = "meth_sacid", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_glass", count = 1 },
            { item = "meth_emptysacid", count = 1 },
        },
        Log = "Has proccessed 1x Amoniak, 1x Sodium benzoate into 1x Meth tray"
    },
    --Break
    Break = {
        header = "Breek Meth",
        description = "Ingredienten: 1x Meth Plateau, 1x Hamer",
        coords = vector3(1016.47, -3194.15, -39.01),
        radius = 0.5,
        teleport = vector3(1016.70 - 3.6, -3195.64 - 1.0, -38.99 - 1.0),
        heading = 180.0,
        RequiredItems = {
            { item = "meth_glass", count = 1, remove = true },
            { item = "hammer", count = 1, remove = false },
        },
        AddItems = {
            { item = "meth_sharp", count = 1 },
        },
        Log = "Has proccessed 1x Meth tray, 1x Hammer into 1x Broken Meth tray"
    },
    --Package
    Package = {
        header = "Verpak Meth",
        description = "Ingredienten: 1x Gebroken Meth, 1x Plastiek Zak",
        coords = vector3(1011.28, -3194.15, -39.04),
        radius = 0.5,
        teleport = vector3(1012.24, -3196.25, -38.99),
        heading = 180.0,
        RequiredItems = {
            { item = "meth_sharp", count = 1, remove = true },
            { item = "plastic_bag", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_bag", count = 3 },
        },
        Log = "Has proccessed 1x Broken Meth tray, 1x Plastic bag into 2x Meth bag"

    },
}

--Heroin
Config.Heroin = {
    --Field
    Field = {
        coords = vec3(-819.47, 5665.35, 21.57),
        radius = 20.85,
        Duration = 10000,
        name = "Papaverveld",
        debugPoly = false,
        RequiredItems = {
            { item = "trowel", count = 1, remove = false },
        },
        AddItems = {
            { item = "poppyplant", count = 5 },
        },
        prop = `prop_plant_01b`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE
        Log = "Has picked up 5x Poppy Plant"
    },
    --Process
    Process = {
        header = "Verwerk Poppyplant",
        description = "Ingredienten: 3x Poppyplant, 1x Zwavelzuur, 5x Plastiek Zak",
        coords = vector3(1391.41, 3605.55, 39.07),
        radius = 0.4,
        Teleport = vector3(1391.87, 3605.64, 37.94),
        Duration = 30000,
        RequiredItems = {
            { item = "poppyplant", count = 3, remove = true },
            { item = "sulfuric_acid", count = 1, remove = true },
            { item = "plastic_bag", count = 5, remove = true },
        },
        AddItems = {
            { item = "heroin", count = 5 },
        },
        Log = "Has proccessed 3x Poppy plant, 1x Zwavelzuur, 5x Plastic bag into 5x heroin"
    },
}

--Crack
Config.Crack = {
    --Process
    Process = {
        header = "Maak Crack",
        description = "Ingrediënten: 1x Pure Cocaïne, 1x Natriumbicarbonaat, 1x Water",
        coords = vector3(3534.83, 3660.67, 28.12),
        radius = 0.4,
        Teleport = vector3(3534.83, 3660.67, 28.12),
        Duration = 60000,
        RequiredItems = {
            { item = "coke_pure", count = 1, remove = true },
            { item = "baking_soda", count = 1, remove = true },
            { item = "water_bottle", count = 1, remove = true },
        },
        AddItems = {
            { item = "crack", count = 8 },
        },
        Log = "Has proccessed 1x Pure Coke, 1x Baking Soda, Water Bottle into 8X Crack"
    },
}

--Coke
Config.Coke = {
    --LABORATORY
    ElectricityNeeded = false,
    --Lab circlezone
    Electricity = {
        coords = vector3(1091.5, -3191.67, -39.7),
        radius = 0.4
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = false
    },
    --Lab Circlezone
    Lab = {
        coords = vector3(1092.68, -3194.89, -38.99),
        radius = 18.85,
        DebugPoly = false,
        name = "CokeLab",
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(752.94, -3198.62, 6.19),
        radius = 1.2,
        teleport = vector3(1088.76, -3187.68, -39.99),
        NeedItem = true,
        ItemName = "coke_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(1088.66, -3187.51, -38.83),
        radius = 0.8,
        teleport = vector3(752.94, -3198.62, 6.19),
    },
    --Field
    Field = {
        coords = vector3(881.84, 3003.53, 42.62),  --locatie die werkt vector3(1459.41, -2663.37, 41.1)
        radius = 30.0,
        DebugPoly = false,
        name = "Cocaïneveld",
        prop = `prop_plant_01a`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE
        RequiredItems = {
            { item = "trowel", count = 1, remove = false },
        },
        AddItems = {
            { item = "coke_leaf", count = 1 },
        },
        Log = "Has Picked up Coke Leaf"
    },
    --LeafProcess
    LeafProcess = {
        header = "Verwerk Coca Bladeren",
        description = "Ingredienten: 2x Coca Bladeren", coords = vector3(1101.8, -3193.06, -38.98), radius = 0.4,
        boxcoords = vector4(1101.81, -3193.14, -39.18, 90),
        RequiredItems = {
            { item = "coke_leaf", count = 2, remove = true },
        },
        AddItems = {
            { item = "coke_box", count = 1 },
        },
        Log = "Has proccessed 2x Coke Leaves into 1x Coke Box"
    },
    --CokeBox
    CokeBox = {
        header = "Giet cocaïnepoeder uit",
        description = "Ingredienten: 1x Doos met Coke",
        coords = vector3(1086.8, -3195.31, -39.15), radius = 0.4, teleport = vector3(1087.31, -3196.04, -38.99),
        heading = 0.0,
        RequiredItems = {
            { item = "coke_box", count = 1, remove = true },
        },
        AddItems = {
            { item = "coke_raw", count = 6 },
        },
        Log = "Has proccessed 1x Coke Box into 6x Raw Coke"
    },
    --Coke Cleaning
    Soda = {
        header = "Zuiver Cocaïne",
        description = "Ingredienten: 6x Ruwe Cocaïne",
        RequiredItems = {
            { item = "coke_raw", count = 6, remove = true },
        },
        AddItems = {
            { item = "coke_pure", count = 4 },
        },
        Log = "Has proccessed 6x Raw Coke into 3x Pure Coke"
    },
    SodaTables = {
        -- use only headingtotable 0.0 or 180.0 | 270 and 90 dont work
        { coords = vector3(1095.39, -3196.3, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1093.04, -3196.36, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1090.33, -3196.2, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1095.36, -3195.34, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
        { coords = vector3(1093.09, -3195.33, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
        { coords = vector3(1090.28, -3195.3, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
    },
    --Packaging
    FigurePackage = {
        header = "Verpak Cocaïne",
        description = "Ingredienten: 2x Lege Actiefiguur, 4x Pure Cocaïne",
        coords = vector3(1100.43, -3199.39, -39.26), radius = 0.5,
        teleport = vector3(1100.62 - 7.0, -3198.83 + 2.2, -38.99 - 1.0), heading = 180.0,
        RequiredItems = {
            { item = "coke_pure", count = 4, remove = true },
            { item = "coke_figureempty", count = 2, remove = true },
        },
        AddItems = {
            { item = "coke_figure", count = 2 },
        },
        Log = "Has proccessed 3x Empty Action figure, 3x Pure Coke into 3x Coke Figure"
    },
}

--Mushrooms
Config.MushroomsField = {
    --Field!
    coords = vec3(-582.9, 5834.17, 30.61),
    radius = 18.85,
    name = "Paddenstoelenveld",
    debugPoly = false,
    prop = `prop_stoneshroom2`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
    RequiredItems = {
        { item = "trowel", count = 1, remove = false },
    },
    AddItems = {
        { item = "magicmushroom", count = 1 },
    },
    Log = "Has picked up Mushroom"
}

--Peyote
Config.PeyoteField = {
    --Field!
    coords = vec3(318.78, 4319.8, 48.09),
    radius = 38.85,
    name = "Peyoteveld",
    debugPoly = false,
    RequiredItems = {
        { item = "trowel", count = 1, remove = false },
    },
    AddItems = {
        { item = "peyote", count = 1 },
    },
    prop = `prop_peyote_highland_01`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
    Log = "Has picked up Peyote"
}

--Selling
Config.PhoneBooths = { -- use hash
    -429560270,
    -1559354806,
    -78626473,
    295857659,
    -2103798695,
    1158960338,
    1511539537,
    1281992692
}

Config.Drugs = {
    weed_package = { -- Item name
        Label = "Weed", -- Item label
        ReqPolice = 0, -- Police count
        ReportChance = 50, --Dispatch Chance 0 - 100 %
        MinPrice = 100, -- Min price
        MaxPrice = 150, -- Max price
        MinCount = 7, -- Min Count
        MaxCount = 13, -- Max Count
        Chance = 85, -- 0 - 100% succes of negotiate for better price
        AttackChance = 0, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        }
    },
    meth_bag = { -- Item name
        Label = "Meth", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 100, --Dispatch Chance 0 - 100 %
        MinPrice = 2342, -- Min price
        MaxPrice = 2958, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 50, -- 0 - 100% succes of negotiate for better price
        AttackChance = 25, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `prop_meth_bag_01`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    crack = { -- Item name
        Label = "Crack", -- Item label
        ReqPolice = 0, -- Police count
        ReportChance = 50, --Dispatch Chance 0 - 100 %
        MinPrice = 186, -- Min price
        MaxPrice = 214, -- Max price
        MinCount = 7, -- Min Count
        MaxCount = 19, -- Max Count
        Chance = 50, -- 0 - 100% succes of negotiate for better price
        AttackChance = 0, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    heroin = { -- Item name
        Label = "Heroin", -- Item label
        ReqPolice = 0, -- Police count
        ReportChance = 50, --Dispatch Chance 0 - 100 %
        MinPrice = 294, -- Min price
        MaxPrice = 426, -- Max price
        MinCount = 13, -- Min Count
        MaxCount = 29, -- Max Count
        Chance = 70, -- 0 - 100% succes of negotiate for better price
        AttackChance = 0, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    coke_figure = { -- Item name
        Label = "Action Figure with Coke", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 90, --Dispatch Chance 0 - 100 %
        MinPrice = 1369, -- Min price
        MaxPrice = 1943, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 10, -- Max Count
        Chance = 50, -- 0 - 100% succes of negotiate for better price
        AttackChance = 25, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_coke_doll`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        }
    }
}

--Consumables
Config.Consumables = {
    weed_joint = { -- Item name
        Remove = true, -- Remove item
        Log = "Has smoked joint",
        RemoveItem = "weed_joint", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Smoking pot",
        duration = 5500,
        effect = "weed",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = false,
                add = 5,
            },
            strength = {
                enabled = false,
                time = 60 --TIME IS IN SECONDS
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = true,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    meth_syringe = { -- Item name
        Remove = true, -- Remove item
        Log = "Has used Syringe with Meth",
        RemoveItem = "meth_syringe", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Shooting Meth",
        duration = 13500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 10,
            },
            strength = {
                enabled = true,
                time = 25
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    heroin_syringe = { -- Item name
        Remove = true, -- Remove item
        Log = "Has used Syringe with Heroin",
        RemoveItem = "heroin_syringe", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Shooting Heroin",
        duration = 13500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 50,
            },
            armor = {
                enabled = true,
                add = 10,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    meth_pipe = { -- Item name
        Remove = true, -- Remove item
        Log = "Has smoked Meth pipe",
        RemoveItem = "meth_bag", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Smoking Meth",
        duration = 17500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 10,
            },
            strength = {
                enabled = true,
                time = 25
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'switch@trevor@trev_smoking_meth',
                    clip = 'trev_smoking_meth_loop',
                },
                prop = {
                    model = `prop_cs_meth_pipe`,
                    pos = vec3(0.12, -0.05, -0.03),
                    rot = vec3(19.0, 10.0, -10.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    xanaxpill = { -- Item name
        Remove = true, -- Remove item
        Log = "Has popped Xanax Pill",
        RemoveItem = "xanaxpill", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Poppin pill",
        duration = 2500,
        effect = "xanax",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 5,
            },
            armor = {
                enabled = true,
                add = 15,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 10
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    lsd = { -- Item name
        Remove = true, -- Remove item
        Log = "Has swalowed LSD",
        RemoveItem = "lsd", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Taking LSD",
        duration = 2500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = false,
                add = 50,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = true,
                time = 30
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    ecstasy = { -- Item name
        Remove = true, -- Remove item
        Log = "Has swalowed Ecstasy",
        RemoveItem = "ecstasy", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Taking Ecstasy",
        duration = 2500,
        effect = "ecstasy",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 50,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    coke_pure = { -- Item name
        Remove = true, -- Remove item
        Log = "Has snorted Pure Coke",
        RemoveItem = "coke_pure", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Snorting Coke",
        duration = 4000,
        effect = "coke",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 10,
            },
            strength = {
                enabled = true,
                time = 25
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'anim@amb@nightclub@peds@',
                    clip = 'missfbi3_party_snort_coke_b_male3',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    crack_pipe = { -- Item name
        Remove = true, -- Remove item
        Log = "Has smoked Crack Pipe",
        RemoveItem = "crack", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Smoking Crack",
        duration = 17500,
        effect = "alien",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 50,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'switch@trevor@trev_smoking_meth',
                    clip = 'trev_smoking_meth_loop',
                },
                prop = {
                    model = `prop_cs_crackpipe`,
                    pos = vec3(0.13, -0.09, -0.05),
                    rot = vec3(29.0, 28.0, -1.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    magicmushroom = { -- Item name
        Remove = true, -- Remove item
        Log = "Has eaten Magic Mushroom",
        RemoveItem = "magicmushroom", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Eating Magic Mushroom",
        duration = 17500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 90, 
            },
            strength = {
                enabled = false,
                time = 60 --TIME IS IN SECONDS
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c',
                },
                prop = {
                    model = `ng_proc_leaves08`,
                    pos = vec3(0.14, 0.01, -0.03),
                    rot = vec3(0.0, 0.0, 50.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    peyote = { -- Item name
        Remove = true, -- Remove item
        Log = "Has eaten Peyote",
        RemoveItem = "peyote", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Eating Peyote",
        duration = 1500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 90,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c',
                },
                prop = {
                    model = `prop_peyote_highland_01`,
                    pos = vec3(0.15, 0.01, -0.09),
                    rot = vec3(-90.0, -9.0, 0.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    weed_blunt = { -- Item name
        Remove = true, -- Remove item
        Log = "Has smoked Blunt",
        RemoveItem = "weed_blunt", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Smoking blunt",
        duration = 17500,
        effect = "weed",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = true,
                add = 5,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    }
}
