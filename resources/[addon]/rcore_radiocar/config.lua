Config = {}

-- translation
Config.Locale = "en"

-- What mysql should be active?
-- What type of mysql you want?
-- -1 automatic detection
-- 0 No mysql
-- 1 oxmysql (if you have older version where mysql-async bridge does not exists turn this on)
-- 2 Mysql async
-- 3 ghmattimysql
Config.MysqlType = -1

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 2

-- ###################################################################
-- ##### read me if you want player choose their own radio style #####
-- ###################################################################
-- simply zse one of the optional resource either "rcore_buyradio" or "rcore_itemradio"

-- this will force certain look for every car
-- 0 = random per vehicle model
-- 1 = gray style
-- 2 = blue style
Config.RadioStyle = 0

-- change specific model radio style
-- 1 = gray style
-- 2 = blue style
Config.RadioStyleSpecificModel = {
    [GetHashKey("sultan")] = 1,
}

-- will force trim even on standalone
Config.ForceTrim = true

-- force vip
-- you will need this "add_ace" permission and "add_principal" -> you can find them in readme.md
-- you can view more what the ace is here: https://forum.cfx.re/t/basic-aces-principals-overview-guide/90917
Config.ForceVip = false

-- well.. Do i have to explain what this blacklist?
Config.BlacklistedURL = {
    -- I am not responsible for you wanting puppy after watching this video
    "https://www.youtube.com/watch?v=o-YBDTqX_ZU",
}

-- this is domain name so allow anything that you would like to be allowed the blacklist will still take a place for certain music on youtube/other
Config.WhitelistedURL = {
    "youtube",
    "youtu",
    "discordapp",
}

-- do you want to disable saving this stuff to the mysql?
-- when you create your own playlist it will be there even after restart
Config.DisableLoadingOfPlayList = false

-- save interval for the playlist
Config.AutoSaveInterval = 1000 * 60 * 15

-- esx object share
Config.ESX = "esx:getSharedObject"

-- es_extended resource name
Config.esx_resource_name = "es_extended"

-- qbcore object
Config.QBCore = "QBCore:GetObject"

-- es_extended resource name
Config.qbcore_resource_name = "qb-core"

-- Debug
Config.Debug = false

-- enable playing music after reconnect for all cars
-- a few more notes this will just play the same music player heard before on the same time
Config.PlayMusicAfterReconnect = false

-- Thread Debug
Config.ThreadDebug = false

-- Function Debug
Config.FunctionDebug = false

-- this will disable radio for all vehicles no expection even police etc.
Config.DisableGTARadio = true

-- how much volume will adjust each +/- button
Config.VolumeAdjust = 0.05

-- Should this be opened only from command ?
Config.EnableCommand = true

-- Name for the command ?
Config.CommandLabel = "radiocar"

-- Key to open radio
Config.KeyForRadio = "G"

-- description of the key
Config.KeyDescription = "this will open a radio vehicle (can be rebinded)"

-- Distance playing from car
Config.DistancePlaying = 4.0

-- Distance playing from car if windows are closed / or if he has open any door
Config.DistancePlayingWindowsOpen = 10.0

--  if the engine is off the music will be disabled until the engine is on
Config.DisableMusicAfterEngineIsOFF = false

-- Only owner of the car can play a music from the vehicle.
Config.OnlyOwnerOfTheCar = false

-- Radio in car can be used only for people who own the car
-- this can prevent from trolling streamers, i believe many kids
-- will try play some troll music and try to get streamer banned.
Config.OnlyOwnedCars = false

-- this will only let use cars that have installed radio as an item in the car
-- means no car without installed radio before can use it..
-- you have to implement it somewhere by yourself.
-- if you wish to know more about this, please read "readme.md"
Config.OnlyCarWhoHaveRadio = false

-- this will just ignore the option above
Config.PermittedVehiclesForOwnedRadios = {
    "pbus2",
}

-- Default music volume
Config.defaultVolume = 0.3

-- who can touch the radio from what seat?
-- https://docs.fivem.net/natives/?_0xBB40DD2270B65366
Config.AllowedSeats = {
    [-1] = true,
    [0] = true,
}

-- if you have some car that has big speakers or something like that
-- you can increase/decrease distance of playing music
Config.CustomDistanceForVehicles = {
    [GetHashKey("pbus2")] = 100,
}

-- Blacklisted vehicles
Config.blacklistedCars = {
    -- bikes
    GetHashKey("bmx"),
    GetHashKey("cruiser"),
    GetHashKey("fixter"),
    GetHashKey("scorcher"),
    GetHashKey("tribike"),
    GetHashKey("tribike2"),
    GetHashKey("tribike3"),

    -- other
    GetHashKey("thruster"),
}

-- this will allow any car to have radio even if its blacklisted category
Config.whitelistedCars = {-- car
    --GetHashKey("car name here"),
}

-- true  = enabled
-- false = disabled
-- Blacklisted categories vehicles
Config.blackListedCategories = {
    anyVehicle = true,
    anyBoat = true,
    anyHeli = false,
    anyPlane = true,
    anyCopCar = true,
    anySub = false,
    anyTaxi = true,
    anyTrain = true,
}

-- List default station for radio
Config.defaultList = {
    {
        label = "2010s Nostalgia",
        url = "https://www.youtube.com/watch?v=kK0AHd9N7dk&ab_channel=RoseateMixes",
    },
    {
        label = "Lofi hip hop radio",
        url = "https://www.youtube.com/watch?v=jfKfPfyJRdk",
    },
    {
        label = "Night jazz",
        url = "https://www.youtube.com/watch?v=aixaT5NjGo8&ab_channel=RelaxingJazzBGM",
    },
    {
        label = "90s live radio",
        url = "https://www.youtube.com/watch?v=1Ep2eiM5X9U&ab_channel=BestofMix",
    },
    {
        label = "80s live radio",
        url = "https://www.youtube.com/watch?v=R6_3OchvW_c",
    },
    {
        label = "Doom live radio",
        url = "https://www.youtube.com/watch?v=JEuAYnjtJP0",
    },
}

-- lowpass intensity the lower the number is the more hard it will be to hear the sound
-- like it is far away behind door
-- the higher the number will be the opposite will happen
Config.LowpassIntensity = 500

Config.IgnoreLowpassOnCertainModels = {
    -- example bike doesnt have any windows / doors so there cant be applied lowpass filter
    "akuma",
}

-- this is for vehicles that their trunk does  not  connect interior of the vehicle and the sound have to be still like behind wall
-- if the car should not sound like behind the wall -> make an expection here
Config.IgnoreLowpassForCertainModelsWithTrunkNotFullyOpen = {
    [GetHashKey("sultan")] = true,
}

-- if set true you will see on your screen in what interior ID you're in
Config.InteriorDebug = false

-- Put ID of the interior you want to ignore the lowpass for
Config.IgnoreInteriorIdentifiersForLowPass = {
    -- those are entrances of tunnels I found across map (there might be more but this will do for now)
    [154369] = true,
    [155393] = true,
    [182017] = true,
    [183297] = true,
    [193025] = true,
    [192257] = true,
    [199681] = true,

    [248577] = true,
    [250369] = true,
    [194561] = true,
    [194817] = true,
    [195841] = true,
    [195585] = true,
    [55298] = true,
    [135169] = true,
}

-- How much ofter the player position is updated ?
Config.RefreshTime = 300

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- distance for checking vehicle if its close to the player and play music from cache
-- NOTE: keep in mind that FiveM onesync infinity will removed from player client after X meters away.
Config.DistanceVehicleCacheChecker = 50

-- Message list
Config.Messages = {
    ["streamer_on"] = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- if you want xsound separated from radiocar then turn this on.
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- if you want to use mx-surround
Config.MXSurround = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.MXSurround then
    Config.UseExternalxSound = true
    Config.xSoundName = "mx-surround"
end

if Config.UseHighSound then
    Config.UseExternalxSound = true
    Config.xSoundName = "high_3dsounds"

    Config.DistancePlaying = Config.DistancePlaying * 3
    Config.DistancePlayingWindowsOpen = Config.DistancePlayingWindowsOpen * 3
end