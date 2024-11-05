Config = Config or {}
Locales = Locales or {}

--[[
    Welcome to the qs-smartphone configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]

--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'none' -- You can change to 'qb' or 'esx'

--[[
    Put the language you want or just create your own in the locales/* folder
]]

Config.Language = 'en' -- Set your lang in locales folder

--[[
    'old' (Esx 1.1).
    'new' (Esx 1.2, v1 final, legacy or extendedmode).
]]

Config.esxVersion = 'new'

local oxHas = GetResourceState('ox_inventory') == 'started'
local codemHas = GetResourceState('codem_inventory') == 'started'

Config.ox_inventory = oxHas and 'esx' or false
Config.codem_inventory = codemHas and 'esx' or false

-- Target script
Config.Target = false             -- Enable or disable target system
Config.TargetScript = 'ox_target' -- 'ox_target' or 'qb-target' only!

-- Leave it as default if you dont know what you are doing
Config.ScreenshotBasic = 'screenshot-basic'
Config.RepeatTimeout = 2000            -- Don't touch here
Config.CallRepeats = 999999            -- Don't touch here
Config.WhatsappMaxMessages = 50        -- Recommended 50, More than 50 poor performance
Config.DeleteStoriesAndNotifies = true -- Do you want the notifications and stories to be deleted after a certain time?
Config.MaxApp = 40                     -- Dont touch.
Config.RequiredPhone = true            -- Do you need the item to be able to use your smartphone
Config.DisableMovement = false         -- Block all the movement while you are using the smartphone

Config.okokTextUI = {
    enable = false,       -- If you use false, by default there will be DrawText3D
    colour = 'darkgreen', -- Change the color of your TextUI here
    position = 'left',    -- Change the position of the TextUI here
}

-- Choose the default ringtones for your players!
Config.setVolumeMax = 0.2 -- Volume

Config.Ringtones = {
    defaultRingtone = 'https://www.youtube.com/watch?v=HRtC2sDiKqM',
    ringtones = {
        { url = 'https://www.youtube.com/watch?v=AoWVtJQBgYs', name = 'Cradles' },
        { url = 'https://www.youtube.com/watch?v=iLBBRuVDOo4', name = 'Astronomia' },
        { url = 'https://www.youtube.com/watch?v=t6-cCh9bTG4', name = 'Oh no' },
        { url = 'https://www.youtube.com/watch?v=Z6dqIYKIBSU', name = 'Funkytown' },
        { url = 'https://www.youtube.com/watch?v=cR2XilcGYOo', name = 'Bangarang' },
        { url = 'https://www.youtube.com/watch?v=OT216Rrg0jY', name = 'Life Goes On' },
    }
}

--[[
    The sound system comes by default with xsound, but you can purchase mx-surround,
    this script will work natively by default without you configuring anything, a high
    quality sound asset with 3d/8d sounds that will give you a great realistic system.

    You can buy mx-surround here: https://mxstore.tebex.io/package/5864855
]]

Config.MXSurround = GetResourceState('mx-surround') == 'started'
Config.MXSurroundPanner = {        -- This is a custom 3d panner for mx-surround. It doesn't work with xsound
    panningModel = 'HRTF',
    refDistance = 1.2,             -- Distance of the volume dropoff start
    rolloffFactor = 1.5,           -- How fast the volume drops off (don't 0.1)
    distanceModel = 'exponential', -- How the volume drops off (linear, inverse, exponential)
}

--[[
    Be careful editing this because every phone need to have a frame, prop and wallpaper sets to work properly.
    Name of the items with the frame.
]]

Config.Phones = {
    ['classic_phone'] = 'classic_frame.png', -- Never remove or delete this from the first position.
    ['black_phone'] = 'black_frame.png',
    ['blue_phone'] = 'blue_frame.png',
    ['gold_phone'] = 'gold_frame.png',
    ['red_phone'] = 'red_frame.png',
    ['green_phone'] = 'green_frame.png',
    ['greenlight_phone'] = 'greenlight_frame.png',
    ['pink_phone'] = 'pink_frame.png',
    ['white_phone'] = 'white_frame.png',
    ['phone'] = 'classic_frame.png',
}

-- Name of the item with the prop
Config.PhonesProps = {
    ['classic_phone'] = `prop_phone_mega_1`, -- Never remove or delete this from the first position.
    ['black_phone'] = `prop_phone_mega_2`,
    ['blue_phone'] = `prop_phone_mega_3`,
    ['gold_phone'] = `prop_phone_mega_4`,
    ['red_phone'] = `prop_phone_mega_5`,
    ['green_phone'] = `prop_phone_mega_6`,
    ['greenlight_phone'] = `prop_phone_mega_7`,
    ['pink_phone'] = `prop_phone_mega_8`,
    ['white_phone'] = `prop_phone_mega_9`,
    ['phone'] = `prop_phone_mega_10`,
}

-- Name of the item with the default wallpaper.
Config.PhonesCustomWallpaper = {
    ['classic_frame.png'] = 'b5', -- Never remove or delete this from the first position.
    ['black_frame.png'] = 'b4',
    ['blue_frame.png'] = 'b4',
    ['gold_frame.png'] = 'b1',
    ['red_frame.png'] = 'b3',
    ['green_frame.png'] = 'b1',
    ['greenlight_frame.png'] = 'b1',
    ['pink_frame.png'] = 'b2',
    ['white_frame.png'] = 'b1',
}

--██╗░░░██╗░█████╗░██╗░█████╗░███████╗
--██║░░░██║██╔══██╗██║██╔══██╗██╔════╝
--╚██╗░██╔╝██║░░██║██║██║░░╚═╝█████╗░░
--░╚████╔╝░██║░░██║██║██║░░██╗██╔══╝░░
--░░╚██╔╝░░╚█████╔╝██║╚█████╔╝███████╗
--░░░╚═╝░░░░╚════╝░╚═╝░╚════╝░╚══════╝

--[[
    It is very important that you choose the name of your script and what voice script you use on your server.
    If your voice system does not appear here, you can configure in config_calls_client and config_calls_server

    'pma'     Most Recommended script `https://github.com/AvarianKnight/pma-voice`
    'mumble'  Deprecated script `https://github.com/FrazzIe/mumble-voip-fivem`
    'toko'   `https://tokovoip.vip/`
    'salty'  `https://github.com/v10networkscom/saltychat-fivem` `https://gaming.v10networks.com/SaltyChat`
]]

Config.Voice = 'pma'

-- That is only to verify that your script is started, it is necessary that you put the name of the folder of your script
Config.VoiceScriptName = 'pma-voice'

--██████╗░░█████╗░███╗░░██╗██╗░░██╗██╗███╗░░██╗░██████╗░
--██╔══██╗██╔══██╗████╗░██║██║░██╔╝██║████╗░██║██╔════╝░
--██████╦╝███████║██╔██╗██║█████═╝░██║██╔██╗██║██║░░██╗░
--██╔══██╗██╔══██║██║╚████║██╔═██╗░██║██║╚████║██║░░╚██╗
--██████╦╝██║░░██║██║░╚███║██║░╚██╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░

--[[
    YOU CAN ONLY CHOOSE ONE

    'id'            to use the ID of the player.
    'iban'          Use the IBAN
    'okokBanking'    IBAN of okokBanking
]]

Config.BankSystem = 'id'

--██████╗░██╗██╗░░░░░██╗░░░░░██╗███╗░░██╗░██████╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║████╗░██║██╔════╝░
--██████╦╝██║██║░░░░░██║░░░░░██║██╔██╗██║██║░░██╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║██║╚████║██║░░╚██╗
--██████╦╝██║███████╗███████╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝╚══════╝╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░

--[[
    'false'            if you are not using one
    'default'          Works with default QBCore and ESX system
    'okokBilling'      Works on ESX (QBCore compatible but dont have code) https://okok.tebex.io/package/5246431
    'rcore_billing'    Old resource (Discontinued)
    'jim-payments'     Free QBCore billing (https://github.com/jimathy/jim-payments)
    'billing_ui'       Works on ESX and QBCore (https://jaksam1074-fivem-scripts.tebex.io/package/5369991)
    'codem-billing'    Works on ESX and QBCore (https://codem.tebex.io/package/5920201)
]]

Config.billingSystem = 'okokBilling'

--[[
    ESX                     = 'esx_billing:payBill'
    okokBilling             = 'okokBilling:PayInvoice'
    rcoreBilling            = 'rcore_billing'
    qbcore or jim-payments  = 'nothing'
    billing_ui              = 'billing_ui:payInvoice'
    codem-billing           = 'codem-billing:billing'
    False if you are not using one
]]

Config.billingpayBillEvent = 'okokBilling:PayInvoice'


--░██████╗░░█████╗░██████╗░░█████╗░░██████╗░███████╗░██████╗
--██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔════╝░██╔════╝██╔════╝
--██║░░██╗░███████║██████╔╝███████║██║░░██╗░█████╗░░╚█████╗░
--██║░░╚██╗██╔══██║██╔══██╗██╔══██║██║░░╚██╗██╔══╝░░░╚═══██╗
--╚██████╔╝██║░░██║██║░░██║██║░░██║╚██████╔╝███████╗██████╔╝
--░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═════╝░

Config.AvailableValet = true   -- Enable or disable the Valet button from here
Config.ValetNPC = true         -- An NPC comes and leaves it next to you. If it is false it appears near you without NPC
Config.ValetKeysBefore = false -- Does he give you the keys when you call the car, or when the car is delivered to you?
Config.ValetPrice = 1000       -- Price to bring your vehicle to you

---@param This option is for impound system
-- 'default'
-- 'cd_garage'
-- 'loaf_garage'
-- 'qb-garages'
-- 'esx_garages'
-- 'okokGarage'
-- 'jg-advanced-garages'
-- 'rcore_garages'
-- 'qs-garages'
-- 'qs-advancedgarages'

Config.GarageScript = 'jg-advanced-garages'

-- ██╗░░░██╗███████╗██╗░░██╗██╗░█████╗░██╗░░░░░███████╗ ██╗░░██╗███████╗██╗░░░██╗░██████╗
-- ██║░░░██║██╔════╝██║░░██║██║██╔══██╗██║░░░░░██╔════╝ ██║░██╔╝██╔════╝╚██╗░██╔╝██╔════╝
-- ╚██╗░██╔╝█████╗░░███████║██║██║░░╚═╝██║░░░░░█████╗░░ █████═╝░█████╗░░░╚████╔╝░╚█████╗░
-- ░╚████╔╝░██╔══╝░░██╔══██║██║██║░░██╗██║░░░░░██╔══╝░░ ██╔═██╗░██╔══╝░░░░╚██╔╝░░░╚═══██╗
-- ░░╚██╔╝░░███████╗██║░░██║██║╚█████╔╝███████╗███████╗ ██║░╚██╗███████╗░░░██║░░░██████╔╝
-- ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░╚════╝░╚══════╝╚══════╝ ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░

---@param vehicle Give the ID of local vehicle
---@param hash Give the HASH of vehicle
---@param plate Return the plate of vehicle
---@param model Give the model IsNamedRendertargetLinked
function VehicleKeys(vehicle, hash, plate, model)
    if GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveKeys(plate, model)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
    elseif GetResourceState('vehicles_keys') == 'started' then
        TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)
    elseif GetResourceState('mono_carkeys') == 'started' then
        exports.mono_carkeys:ClientInventoryKeys('add', plate)
    else
        print('^4[QS Smartphone] ^3[Debug]^0: If you have any vehiclekeys remember to add your vehiclekeys event in config.lua line 1249...') -- You can remove this.
    end
end

--░██╗░░░░░░░██╗███████╗████████╗  ██████╗░██╗░░██╗░█████╗░███╗░░██╗███████╗
--░██║░░██╗░░██║██╔════╝╚══██╔══╝  ██╔══██╗██║░░██║██╔══██╗████╗░██║██╔════╝
--░╚██╗████╗██╔╝█████╗░░░░░██║░░░  ██████╔╝███████║██║░░██║██╔██╗██║█████╗░░
--░░████╔═████║░██╔══╝░░░░░██║░░░  ██╔═══╝░██╔══██║██║░░██║██║╚████║██╔══╝░░
--░░╚██╔╝░╚██╔╝░███████╗░░░██║░░░  ██║░░░░░██║░░██║╚█████╔╝██║░╚███║███████╗
--░░░╚═╝░░░╚═╝░░╚══════╝░░░╚═╝░░░  ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝

Config.WetPhone = false                  -- Being in the water, the phone will break and will give you the same item but with the prefix "wet_".
Config.RepairWetPhone = 'phone_module'   -- With said item, we can repair the wet phone.
Config.RepairWetPhoneNpc = true          -- Be able to repair your phone with the NPC Telephone Technician.
Config.RepairWetPhoneNpcPrice = 100      -- Price to repair a wet phone in the Technician.
Config.RepairWetPhoneNpcAccount = 'bank' -- Choose here the account to pay the technician for repairing the wet phone.


--░░░░░██╗░█████╗░██████╗░░██████╗  ░█████╗░██████╗░██████╗░░██████╗
--░░░░░██║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--░░░░░██║██║░░██║██████╦╝╚█████╗░  ███████║██████╔╝██████╔╝╚█████╗░
--██╗░░██║██║░░██║██╔══██╗░╚═══██╗  ██╔══██║██╔═══╝░██╔═══╝░░╚═══██╗
--╚█████╔╝╚█████╔╝██████╦╝██████╔╝  ██║░░██║██║░░░░░██║░░░░░██████╔╝
--░╚════╝░░╚════╝░╚═════╝░╚═════╝░  ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═════╝░

-- These works will have permission to publish in the News app.
Config.WeazelJob = {
    'weazelnews',
    'police',
    'weazel',
}

-- Jobs available to receive Police App alerts.
Config.PoliceAppJobs = {
    [1] = 'police',
    -- [2] = 'sheriff',
}

--- @param job 'Name of job who will receive the message'
--- @param name 'Visible label'
--- @param img  'Image of contact'
Config.Jobs = {
    { job = 'police',    name = 'Politie',  img = './img/apps/police.png' },
    { job = 'ambulance', name = 'Ems',      img = './img/apps/ambulance.png' },
    { job = 'mechanic',  name = 'Mechanic', img = './img/apps/mechanic.png' },
}

--[[
    IMPORTANT these are commands to receive or not receive messages NO MESSAGE IS SENT WITH THESE.
    to put it another way it is to enter and exit of duty.
]]
Config.jobCommands = { -- Just enter a number here, this is the number that will appear when you call.
    ['police'] = '112',
    ['ambulance'] = '113',
    ['mechanic'] = '114',
}

--██████╗░██╗░░░██╗░██████╗██╗███╗░░██╗███████╗░██████╗░██████╗
--██╔══██╗██║░░░██║██╔════╝██║████╗░██║██╔════╝██╔════╝██╔════╝
--██████╦╝██║░░░██║╚█████╗░██║██╔██╗██║█████╗░░╚█████╗░╚█████╗░
--██╔══██╗██║░░░██║░╚═══██╗██║██║╚████║██╔══╝░░░╚═══██╗░╚═══██╗
--██████╦╝╚██████╔╝██████╔╝██║██║░╚███║███████╗██████╔╝██████╔╝
--╚═════╝░░╚═════╝░╚═════╝░╚═╝╚═╝░░╚══╝╚══════╝╚═════╝░╚═════╝░

Config.JobsInPhone = {
    ['police'] = {
        order = 1,
        name = 'police',
        label = 'Police',
        info = 'The police of the saints always at your service',
        score = '4',
        duty = false,
    },
    ['ambulance'] = {
        order = 2,
        name = 'ambulance',
        label = 'EMS',
        info = 'We solve all your health problems',
        score = '4',
        duty = false,
    },
    -- ['tabac'] = {
    --     order = 3,
    --     name = 'tabac',
    --     label = 'Tabac',
    --     info = 'Food and party tables provided',
    --     score = '3',
    --     duty = false,
    -- },
    ['upnatoms'] = {
        order = 4,
        name = 'upnatoms',
        label = 'Up-N-Atoms',
        info = '100% vegan burgers, I\'m kidding...',
        score = '4',
        duty = false,
    },
    -- ['noodle'] = {
    --     order = 5,
    --     name = 'noodle',
    --     label = 'Noodle',
    --     info = 'The best fried noodles in Los Santos',
    --     score = '4',
    --     duty = false,
    -- },
    -- ['unicorn'] = {
    --     order = 6,
    --     name = 'unicorn',
    --     label = 'Unicorn',
    --     info = 'Come move your body to the best nightclub',
    --     score = '5',
    --     duty = false,
    -- },
    -- ['paradise'] = {
    --     order = 7,
    --     name = 'paradise',
    --     label = 'Paradise Club',
    --     info = 'We do not sell alcohol to minors',
    --     score = '2',
    --     duty = false,
    -- },
    ['mechanic'] = {
        order = 8,
        name = 'mechanic',
        label = 'Fast Customs',
        info = 'Fast and Faster',
        score = '4',
        duty = false,
    },
    -- ['recycle'] = {
    --     order = 9,
    --     name = 'recycle',
    --     label = 'Recyclage',
    --     info = 'Protect the environment and take care of the streets',
    --     score = '1',
    --     duty = false,
    -- },
    ['catcafe'] = {
        order = 10,
        name = 'catcafe',
        label = 'Cat Cafe',
        info = 'Lots of coffee, but above all, lots of kittens',
        score = '5',
        duty = false,
    },
}

-- ░█████╗░███╗░░██╗██╗░█████╗░███╗░░██╗  ░█████╗░██████╗░██████╗░
-- ██╔══██╗████╗░██║██║██╔══██╗████╗░██║  ██╔══██╗██╔══██╗██╔══██╗
-- ██║░░██║██╔██╗██║██║██║░░██║██╔██╗██║  ███████║██████╔╝██████╔╝
-- ██║░░██║██║╚████║██║██║░░██║██║╚████║  ██╔══██║██╔═══╝░██╔═══╝░
-- ╚█████╔╝██║░╚███║██║╚█████╔╝██║░╚███║  ██║░░██║██║░░░░░██║░░░░░
-- ░╚════╝░╚═╝░░╚══╝╚═╝░╚════╝░╚═╝░░╚══╝  ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░

Config.WeaponsItems = false         -- This will work for Onion Browser, weapons are items?
Config.BlackMarketAccount = 'bank' -- Account with which you want to pay in Onion Browser.

--[[
    Onion browser items!
    It is important that you follow the order of the numbers [1], [2], [3]...

    item     'Item name'
    label    'label that will show in the app'
    isItem   false 'Is a weapons' true 'is a item'
    price    'Price of the product'
]]

Config.Darkweb = {
    List = {
        [1] = { item = 'WEAPON_PISTOL', label = 'Pistol', isItem = true, price = 8000 },
        [2] = { item = 'WEAPON_PISTOL50', label = 'Pistol 50', isItem = true, price = 9000 },
        [3] = { item = 'WEAPON_PISTOL_MK2', label = 'Pistol MK2', isItem = true, price = 10000 },
        [4] = { item = 'WEAPON_KNUCKLE', label = 'Knucle', isItem = true, price = 5000 },
        [5] = { item = 'WEAPON_GRENADE', label = 'Pistol', isItem = true, price = 20000 },
        [6] = { item = 'WEAPON_CARBINERIFLE_MK2', label = 'Carbine Rifle MK2', isItem = true, price = 35000 },
        [7] = { item = 'WEAPON_BULLPUPRIFLE_MK2', label = 'Bullpup Rifle MK2', isItem = true, price = 40000 },
        [8] = { item = 'WEAPON_SNIPERRIFLE', label = 'Sniper Rifle', isItem = true, price = 55000 },
        -- [9] = { item = 'laptop', label = 'Hacker Laptop', isItem = true, price = 700}, -- If you use `Config.WeaponsItems = false` then you can choose if it's an item with `isItem = true`.
    },
}

--██████╗░░█████╗░░█████╗░████████╗██╗░░██╗  ░██████╗██╗░░░██╗░██████╗████████╗███████╗███╗░░░███╗
--██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║░░██║  ██╔════╝╚██╗░██╔╝██╔════╝╚══██╔══╝██╔════╝████╗░████║
--██████╦╝██║░░██║██║░░██║░░░██║░░░███████║  ╚█████╗░░╚████╔╝░╚█████╗░░░░██║░░░█████╗░░██╔████╔██║
--██╔══██╗██║░░██║██║░░██║░░░██║░░░██╔══██║  ░╚═══██╗░░╚██╔╝░░░╚═══██╗░░░██║░░░██╔══╝░░██║╚██╔╝██║
--██████╦╝╚█████╔╝╚█████╔╝░░░██║░░░██║░░██║  ██████╔╝░░░██║░░░██████╔╝░░░██║░░░███████╗██║░╚═╝░██║
--╚═════╝░░╚════╝░░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝  ╚═════╝░░░░╚═╝░░░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝

Config.EnableBooth = false -- Do you want to enable the phone booths?

-- Configure here the props that will be phone booths.
Config.Booth = {
    [1158960338] = false, -- Hash of booths
    [1511539537] = false,
    [1281992692] = false,
    [-429560270] = false,
    [-1559354806] = false,
    [-78626473] = false,
    [295857659] = false,
    [-2103798695] = true,
    -- You can add more!
}

--██████╗░░█████╗░████████╗████████╗███████╗██████╗░██╗░░░██╗
--██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗╚██╗░██╔╝
--██████╦╝███████║░░░██║░░░░░░██║░░░█████╗░░██████╔╝░╚████╔╝░
--██╔══██╗██╔══██║░░░██║░░░░░░██║░░░██╔══╝░░██╔══██╗░░╚██╔╝░░
--██████╦╝██║░░██║░░░██║░░░░░░██║░░░███████╗██║░░██║░░░██║░░░
--╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░

Config.EnableBattery = false -- Do you want to enable the battery?
Config.HousingCharge = false -- Phone charger inside the houses?

-- Only load battery information when a player enters the server: playerLoaded, !! Don't restart the live resource because it will break. !!
Config.BatteryPersistData = true   -- Persist data on battery.json
Config.TimeSavePersistData = 20000 -- x 20 sec - less than this number is not recommended

Config.PowerBank = 'powerbank'     -- Item name?
Config.RemoveItemPowerBank = true  -- Do you want the powerbank to be removed once used?

-- Usage /adminbattery id ammount
Config.AdminCommand = true -- Recharge the batery for admins?
Config.AdminCommandName = 'adminbattery'
Config.AdminCommandDescription = 'Recharge your battery like a elon musk'
Config.AdminPermissions = 'admin'

--Customize your own marker or disable it.
-- Remember that here is the charger marker inside your house too.
Config.ChargerMarker = {
    enable = true,
    type = 2,
    scale = { x = 0.2, y = 0.2, z = 0.1 },
    colour = { r = 71, g = 181, b = 255, a = 120 },
    movement = 1 --Use 0 to disable movement.
}

Config.Battery = {
    default = 0.01, -- This is the rate at which the battery drains by default.
    apps = {        -- The following applications will make your battery go down faster.
        ['phone'] = 0.02,
        ['photos'] = 0.02,
        ['messages'] = 0.02,
        ['settings'] = 0.02,
        ['clock'] = 0.02,
        ['camera'] = 0.02,
        ['mail'] = 0.02,
        ['bank'] = 0.02,
        ['calendar'] = 0.02,
        ['notes'] = 0.02,
        ['calculator'] = 0.02,
        ['store'] = 0.02,
        ['music'] = 0.02,
        ['ping'] = 0.02,
        ['instagram'] = 0.02,
        ['garage'] = 0.02,
        ['whatsapp'] = 0.02,
        ['twitter'] = 0.02,
        ['advert'] = 0.02,
        ['tinder'] = 0.02,
        ['cs-stories'] = 0.02,
        ['youtube'] = 0.02,
        ['uber'] = 0.02,
        ['darkweb'] = 0.02,
        ['state'] = 0.02,
        ['meos'] = 0.02,
        ['jump'] = 0.02,
        ['business'] = 0.02,
        ['society'] = 0.02,
        ['spotify'] = 0.02,
        ['flappy'] = 0.02,
        ['kong'] = 0.02,
        ['group-chats'] = 0.02,
        ['uberDriver'] = 0.02,
        ['rentel'] = 0.02,
        ['racing'] = 0.02,
        ['labyrinth'] = 0.02,
        ['tower'] = 0.02,
        ['tiktok'] = 0.02,
        -- ['example'] = 0.02,
    }
}

-- Here you can add plugs to charge your phone wherever you want.
Config.ChargerSpots = {
    {
        coords = vec3(1430.043945, -2004.237305, 62.659302),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge.
    },
}

Config.DefaultChargeCoords = #Config.ChargerSpots -- Don't touch this please.
Config.PowerbankSpeed = 1.0                       -- Charging speed of the item `powerbank`.


--░█████╗░░█████╗░███╗░░██╗███╗░░██╗███████╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
--██╔══██╗██╔══██╗████╗░██║████╗░██║██╔════╝██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
--██║░░╚═╝██║░░██║██╔██╗██║██╔██╗██║█████╗░░██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║
--██║░░██╗██║░░██║██║╚████║██║╚████║██╔══╝░░██║░░██╗░░░██║░░░██║██║░░██║██║╚████║
--╚█████╔╝╚█████╔╝██║░╚███║██║░╚███║███████╗╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║
--░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

-- You can check signal in clien-side using: exports['qs-smartphone']:CheckSignal()
Config.Signal = false      -- If you want to enable this system, use true.
Config.visibleZone = false -- Leave this false whenever you are going to use the server, it is only for zone testing.

--[[
    Mountains and zones blocked for low signal, here is the complete PolyZone.
    Within this PolyZone, you will not be able to use certain apps or receive calls.
]]

Config.Mountains = {
    {
        coords = {
            vector2(-331.82, 5704.55),
            vector2(1383.33, 6353.03),
            vector2(2492.42, 5231.82),
            vector2(1486.36, 5159.09),
            vector2(1413.64, 4516.67),
            vector2(771.21, 4262.12),
            vector2(-210.61, 4219.70),
            vector2(-240.91, 3759.09),
            vector2(19.70, 3334.85),
            vector2(-1331.82, 2807.58),
            vector2(-1665.15, 3365.15),
            vector2(-2307.58, 3607.58),
            vector2(-1998.48, 4334.85),
        },
        minz = 0,
        maxz = 800

    },
    {
        coords = {
            vector2(1868.18, 1656.06),
            vector2(1631.82, 831.82),
            vector2(1280.30, 425.76),
            vector2(1346.97, 25.76),
            vector2(1516.67, -901.52),
            vector2(2056.06, -453.03),
            vector2(2456.06, 365.15),
            vector2(2274.24, 1062.12)
        },
        minz = 0,
        maxz = 800
    },
    {
        coords = {
            vector2(4177.27, 50.00),
            vector2(3068.18, 1819.70),
            vector2(2734.85, 171.21),
            vector2(1322.73, -1228.79),
            vector2(1789.39, -2883.33),
            vector2(2486.36, -2780.30),
            vector2(3425.76, -2513.64),
            vector2(4165.15, -1816.67)
        },
        minz = 0,
        maxz = 800
    },

}


--██╗░░░██╗██████╗░███████╗██████╗░  ██████╗░██████╗░██╗██╗░░░██╗███████╗██████╗░
--██║░░░██║██╔══██╗██╔════╝██╔══██╗  ██╔══██╗██╔══██╗██║██║░░░██║██╔════╝██╔══██╗
--██║░░░██║██████╦╝█████╗░░██████╔╝  ██║░░██║██████╔╝██║╚██╗░██╔╝█████╗░░██████╔╝
--██║░░░██║██╔══██╗██╔══╝░░██╔══██╗  ██║░░██║██╔══██╗██║░╚████╔╝░██╔══╝░░██╔══██╗
--╚██████╔╝██████╦╝███████╗██║░░██║  ██████╔╝██║░░██║██║░░╚██╔╝░░███████╗██║░░██║
--░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚═════╝░╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝

Config.Decimals = false           -- Use decimal numbers?
Config.UberMinimumMoney = 5000    -- Minimum money to enter service or to request a vehicle.
Config.UberMaximumMoney = 8000    -- Maximum price per trip, you can not earn more than this for each trip.
Config.UberDriverAccount = 'bank' -- Remember that if you use QBCore, the account 'money' does not exist, it is 'cash'.

Config.Classes = {                -- You can ignore this setting, it will be executed in future updates.
    [0] = 'COMPACT',              -- Compacts
    [1] = 'SEDAN',                -- Sedans
    [2] = 'SUV',                  -- SUVs
    [3] = 'COUPE',                -- Coupes
    [4] = 'MUSCLE',               -- Muscle
    [5] = 'SPORT CLASSIC',        -- Sports Classics
    [6] = 'SPORT',                -- Sports
    [7] = 'SUPER',                -- Super
    [8] = 'MOTOR',                -- Motorcycles
    [9] = 'OFFROAD',              -- Off-road
}

--██╗░░░██╗██████╗░███████╗██████╗░  ███████╗░█████╗░████████╗░██████╗
--██║░░░██║██╔══██╗██╔════╝██╔══██╗  ██╔════╝██╔══██╗╚══██╔══╝██╔════╝
--██║░░░██║██████╦╝█████╗░░██████╔╝  █████╗░░███████║░░░██║░░░╚█████╗░
--██║░░░██║██╔══██╗██╔══╝░░██╔══██╗  ██╔══╝░░██╔══██║░░░██║░░░░╚═══██╗
--╚██████╔╝██████╦╝███████╗██║░░██║  ███████╗██║░░██║░░░██║░░░██████╔╝
--░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░

Config.uberPriceMultiplier = 1.5
Config.uberTipMin = 30
Config.uberTipMax = 50

Config.uberDelivery = {
    [1] = { ['x'] = 8.69, ['y'] = -243.09, ['z'] = 47.66 },
    [2] = { ['x'] = 113.74, ['y'] = -277.95, ['z'] = 54.51 },
    [3] = { ['x'] = 201.56, ['y'] = -148.76, ['z'] = 61.47 },
    [4] = { ['x'] = -206.84, ['y'] = 159.49, ['z'] = 74.08 },
    [5] = { ['x'] = 38.83, ['y'] = -71.64, ['z'] = 63.83 },
    [6] = { ['x'] = 47.84, ['y'] = -29.16, ['z'] = 73.71 },
    [7] = { ['x'] = -264.41, ['y'] = 98.82, ['z'] = 69.27 },
    [8] = { ['x'] = -419.34, ['y'] = 221.12, ['z'] = 83.6 },
    [9] = { ['x'] = -998.43, ['y'] = 158.42, ['z'] = 62.31 },
    [10] = { ['x'] = -1026.57, ['y'] = 360.64, ['z'] = 71.36 },
    [11] = { ['x'] = -967.06, ['y'] = 510.76, ['z'] = 82.07 },
    [12] = { ['x'] = -1009.64, ['y'] = 478.93, ['z'] = 79.41 },
    [13] = { ['x'] = -1308.05, ['y'] = 448.59, ['z'] = 100.86 },
    [14] = { ['x'] = 557.39, ['y'] = -1759.57, ['z'] = 29.31 },
    [15] = { ['x'] = 325.1, ['y'] = -229.59, ['z'] = 54.22 },
    [16] = { ['x'] = 414.82, ['y'] = -217.57, ['z'] = 59.91 },
    [17] = { ['x'] = 430.85, ['y'] = -941.91, ['z'] = 29.19 },
    [18] = { ['x'] = -587.79, ['y'] = -783.53, ['z'] = 25.4 },
    [19] = { ['x'] = -741.54, ['y'] = -982.28, ['z'] = 17.44 },
    [20] = { ['x'] = -668.23, ['y'] = -971.58, ['z'] = 22.34 },
    [21] = { ['x'] = -664.21, ['y'] = -1218.25, ['z'] = 11.81 },
    [22] = { ['x'] = 249.99, ['y'] = -1730.79, ['z'] = 29.67 },
    [23] = { ['x'] = 405.77, ['y'] = -1751.18, ['z'] = 29.71 },
    [24] = { ['x'] = 454.96, ['y'] = -1580.25, ['z'] = 32.82 },
    [25] = { ['x'] = 278.81, ['y'] = -1117.96, ['z'] = 29.42 },
    [26] = { ['x'] = 101.82, ['y'] = -819.49, ['z'] = 31.31 },
    [27] = { ['x'] = -416.72, ['y'] = -186.79, ['z'] = 37.45 },
}

Config.uberItems = {
    [1] = { ['item'] = 'bobatea', ['name'] = 'bobatea', ['price'] = 50 },
    [2] = {["item"] = "nekolatte", ["name"] = "neko latte", ["price"] = 40},
    [3] = {["item"] = "catcoffee", ["name"] = "cat coffee", ["price"] = 30},
    [4] = {["item"] = "miso", ["name"] = "miso", ["price"] = 45},
    [5] = {["item"] = "cake", ["name"] = "cake", ["price"] = 35},
    [6] = {["item"] = "bento", ["name"] = "bento", ["price"] = 80},
    [7] = {["item"] = "nekocookie", ["name"] = "neko cookie", ["price"] = 30},
    [8] = {["item"] = "nekodonut", ["name"] = "neko donut", ["price"] = 30},
    [9] = {["item"] = "bmochi", ["name"] = "bmochi", ["price"] = 40},
    [10] = {["item"] = "pizza", ["name"] = "pizza", ["price"] = 50},
    [11] = {["item"] = "pancake", ["name"] = "pancake", ["price"] = 35},
    [12] = {["item"] = "cakepop", ["name"] = "cakepop", ["price"] = 35},
    [13] = {["item"] = "ramen", ["name"] = "ramen", ["price"] = 50},
}

--████████╗███████╗░█████╗░██╗░░██╗███╗░░██╗██╗░█████╗░██╗░█████╗░███╗░░██╗
--╚══██╔══╝██╔════╝██╔══██╗██║░░██║████╗░██║██║██╔══██╗██║██╔══██╗████╗░██║
--░░░██║░░░█████╗░░██║░░╚═╝███████║██╔██╗██║██║██║░░╚═╝██║███████║██╔██╗██║
--░░░██║░░░██╔══╝░░██║░░██╗██╔══██║██║╚████║██║██║░░██╗██║██╔══██║██║╚████║
--░░░██║░░░███████╗╚█████╔╝██║░░██║██║░╚███║██║╚█████╔╝██║██║░░██║██║░╚███║
--░░░╚═╝░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░╚════╝░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝

Config.ResetPassword = {
    spawnNPC = true,
    spots = {
        {
            coords = vec3(-1524.32, -409.3, 35.6),
            money = 500,
            text = '[E] - Telephone Technician',
            ped = {
                h = 230.65,
                model = `hc_hacker`
            },
            blip = {
                name = 'Telephone technician',
                sprite = 89,
                color = 1,
                scale = 0.7
            }
        },

        --[[ {
            coords = vec3(-1500.553833, -432.039551, 35.547974),
            money = 500,
            text = '[E] - Telephone Technician',
            ped = {
                h = 230.65,
                model = `hc_hacker`
            },
            blip = {
                name = 'Telephone technician',
                sprite = 89,
                color = 1,
                scale = 0.7
            }
        }, ]]

        -- Add more spots here
    },
    okokTextUI = {
        enable = true,                                   -- Habilitar el sistema de UI de texto
        colour = { r = 255, g = 255, b = 255, a = 255 }, -- Color del texto UI
        position = 'center'                              -- Posición del texto UI
    }
}

-- ██████╗ ██╗███████╗██████╗  █████╗ ████████╗ ██████╗██╗  ██╗
-- ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║
-- ██║  ██║██║███████╗██████╔╝███████║   ██║   ██║     ███████║
-- ██║  ██║██║╚════██║██╔═══╝ ██╔══██║   ██║   ██║     ██╔══██║
-- ██████╔╝██║███████║██║     ██║  ██║   ██║   ╚██████╗██║  ██║
-- ╚═════╝ ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝

Config.CustomDispatch = false -- Use a custom dispatch script? (Jobs message only)
--[[
    'client' excute on client side go to (qs-smartphone/client/custom/misc/dispatch.lua 'qs-smartphone:client:CustomClientDispatch')
    'server' excute on server side go to (qs-smartphone/server/custom/misc/dispatch.lua 'qs-smartphone:server:CustomServerDispatch')
]]
Config.CustomDispatchSide = 'client'


Config.Debug = false -- Debug mode, only for development.
