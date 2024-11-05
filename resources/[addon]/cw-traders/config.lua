Config = {}
Config.Debug = false
Config.UseOxInv = false -- toggle to true if you use ox inventory

Config.UseTokens = false
Config.UseRGB = true

Config.SecretTrades = false -- set this to true if you want trades to not show up if player does not have items

local smelterGuy = {
    name = 'smelterGuy',
    model = 'a_m_y_juggalo_01',
    tradeName = 'SandwichToBeer',
    tradeLabel = 'Wissel 20000 geldrollen in voor Wiet Toegangskaart',
    coords = vector4(748.65, -529.05, 27.78, 62.7),
    animation = 'WORLD_HUMAN_DRUG_DEALER_HARD',
        --available = {from = 9, to = 17}
}

local golfGuy = {
    name = 'golfGuy',
    model = 'g_m_y_lost_03',
    tradeName = 'FoodToGolfClub',
    tradeLabel = 'Wissel 50000 geldrollen in voor Coke Toegangskaart',
    coords = vector4(-1164.36, -2022.15, 13.16, 123),
    animation = 'WORLD_HUMAN_DRUG_DEALER_HARD',
}

-- local bumGuy = {
--     name = 'bumGuy',
--     model = 'a_f_y_golfer_01',
--     tradeName = 'RollsToMeth',
--     tradeLabel = 'Wissel 1 geldzak voor 1000 geldrollen',
--     coords = vector4(0, 0, 0, 0),-- Deze is nog niet ingame! 
--     animation = 'WORLD_HUMAN_AA_COFFEE',
-- }

local phoneGuy = {
    name = 'golfGuy',
    model = 'g_m_m_chicold_01',
    tradeName = 'PhoneToCash',
    tradeLabel = 'Wissel 75000 geldrollen in voor Meth Toegangskaart',
    coords = vector4(2675.65, 3499.31, 53.30, 338),
    animation = 'WORLD_HUMAN_DRUG_DEALER_HARD',
}

-- local shadyGuy = { -- Note that this guy is NOT included in the below Config.Traders, as he uses items not included with stock qb-core (rolled bills)
--     name = 'shadyGuy',
--     model = 'g_m_y_famfor_01',
--     trades = {
--         { tradeLabel = 'Trade 10 rolls to 10 bags of meth', tradeName = 'RollsToMeth', batchTradeLabel = 'Trade multiple rolls to multiple bags of meth', allowBatchTrade = true }, -- example of how to enable batch trading per trade
--         { tradeLabel = 'Trade 200 rolls to heavy pistol', tradeName = 'RollsToHeavyPistol' },
--         { tradeLabel = 'Trade 300 rolls to uzi', tradeName = 'RollsToUzi' },
--     }, 
--     coords = vector4(1131.48, -2202.64, 31.7, 137.99),
--     animation = 'WORLD_HUMAN_DRUG_DEALER_HARD', 
-- }

Config.Traders = {
    smelterGuy,
    bumGuy,
    golfGuy,
    phoneGuy,
}

------------------------------
-- RELATED TO CW-RGBPAINTER --
------------------------------

-- local paintGuy = {
--     name = 'paintGuy',
--     model = 's_m_m_gaffer_01',
--     trades = {
--         { tradeLabel = 'Trade cash to paint gun', tradeName = 'CashToPaintGun' },
--         { tradeLabel = 'Trade cash to paint canisters', tradeName = 'CashToPaintCanisters' },
--         { tradeLabel = 'Trade cash to paint remover', tradeName = 'CashToPaintRemovalSpray' },
--     }, 
--     coords = vector4(875.2, -1014.9, 31.1, 4.14),
--     animation = 'WORLD_HUMAN_SEAT_WALL',
-- }
 
Config.RGBTraders = {
    paintGuy,
}
--------------------------
-- RELATED TO CW-TOKENS --
--------------------------
-- local uziGuy = {
--     name = 'uziGuy',
--     model = 'csb_ramp_gang',
--     gang = 'ballas',
--     trades = {
--         { tradeLabel = 'Trade token for uzi', tradeName = 'TokenToUzi', },
--         { tradeLabel = 'Trade token for pistol', tradeName = 'TokenToPistol' },
--         { tradeLabel = 'Trade token for sawed off', tradeName = 'TokenToSawedOff' },
--     },
--     coords = vector4(139.08, -1921.67, 21.38, 298.39),
--     animation = 'WORLD_HUMAN_DRUG_DEALER',
-- }

-- local hoboGuy = {
--     name = 'hoboGuy',
--     model = 'a_m_o_tramp_01',
--     trades = {
--         { tradeLabel = 'Trade token for molotov', tradeName = 'TokenToMolotov', },
--         { tradeLabel = 'Trade token for double barrel sawed off', tradeName = 'TokenToDoubleBarrel' },
--     },
--     coords = vector4(1443.26, 6331.79, 23.98, 2.27),
--     animation = 'WORLD_HUMAN_LEANING',
-- }

-- local milRifleGuy = {
--     name = 'milRifleGuy',
--     model = 'ig_old_man1a',
--     tradeLabel = 'Trade token for gear',
--     tradeName = 'TokenToMilRifle',
--     coords = vector4(880.39, 2888.02, 56.51, 311.04),
--     animation = 'WORLD_HUMAN_BINOCULARS',
-- }

-- local eastSideGuy = {
--     name = 'eastSideGuy',
--     model = 'a_f_m_tramp_01',
--     trades = {
--         { tradeLabel = 'Trade token for 30 meth baggies', tradeName = 'TokenToMeth', },
--         { tradeLabel = 'Trade token for 30 crack baggies', tradeName = 'TokenToCrack' },
--     },
--     coords = vector4(931.56, -1499.05, 30.33, 40.57),
--     animation = 'WORLD_HUMAN_BUM_STANDING',
-- }

-- local weedGuy = {
--     name = 'weedGuy',
--     model = 'a_m_m_hillbilly_02',
--     trades = {
--         { tradeLabel = 'Trade token for 5 AK seeds', tradeName = 'TokenToAKSeed' },
--         { tradeLabel = 'Trade token for 5 Amnesia seeds', tradeName = 'TokenToAmnesiaSeed' },
--         { tradeLabel = 'Trade token for 5 OG Kush seeds', tradeName = 'TokenToOGSeed' },
--         { tradeLabel = 'Trade token for 5 Purple Haze seeds', tradeName = 'TokenToPurpleHazeSeed' },
--         { tradeLabel = 'Trade token for 5 Skunk seeds', tradeName = 'TokenToSkunkSeed' },
--         { tradeLabel = 'Trade token for 5 White Widow seeds', tradeName = 'TokenToWhiteWidowSeed' },
--         { tradeLabel = 'Trade token for 10 bags of weed nutrition', tradeName = 'TokenToWeedNutrition' },
--     },
--     coords = vector4(2226.79, 5575.66, 53.64, 193.85),
--     animation = 'WORLD_HUMAN_GARDENER_PLANT',
-- }

Config.TokenTraders = {
    uziGuy,
    milRifleGuy,
    hoboGuy,
    eastSideGuy,
    weedGuy
}


-- animation pastebin https://pastebin.com/6mrYTdQv