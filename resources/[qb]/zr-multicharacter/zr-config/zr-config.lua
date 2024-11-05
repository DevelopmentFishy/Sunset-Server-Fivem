zr_config = {}
zr_config.zr_translation = {}
zr_trans = zr_config.zr_translation

-- We support the following frameworks: 'QB' / 'ESX'
zr_config.framework = 'QB'
zr_config.QB = 'qb-core'
zr_config.ESX = 'es_extended'

zr_config.ToggleInterior = true
zr_config.Interior = vector3(-169.286, 486.4938, 137.4436)
zr_config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86)
zr_config.PlaCoords = vector4(-176.0504, 491.7193, 133.8438, 190.9712)
zr_config.CamCoords = vector4(-176.5, 498.7330, 134.8, 12)
zr_config.EndCoords = vector4(-176.1338, 500.2804, 134.6434, 180)
zr_config.StartCoords = vector4(-179.7581, 499.4727, 134.6435, 281.5096)

zr_config.DefaultModels = {"mp_m_freemode_01","mp_f_freemode_01"}

zr_config.zr_notify = false

zr_config.clothing = 'illenium-appearance' -- 'qb-clothing' or 'illenium-appearance'
zr_config.spawn = 'qb-spawn' --  'qb-spawn'


zr_config.animDuration = 4000        -- Time before the character does the animation (default: 4000 = 4 seconds)
zr_config.Animslist = {              -- Add here as many animations as you want. 
    "WORLD_HUMAN_HANG_OUT_STREET",
    "WORLD_HUMAN_STAND_IMPATIENT",
    "WORLD_HUMAN_STAND_MOBILE",
    "WORLD_HUMAN_SMOKING_POT",
    "WORLD_HUMAN_LEANING",
    "WORLD_HUMAN_DRUG_DEALER_HARD"
}


zr_config.default_slots = 2 -- Minimum 1
zr_config.discord_enable = true
-- Token transfered to zr-build-s.lua
zr_config.discord_guild = 1201680101117272155
zr_config.discord_roles = {
    ["1201680101167861852"] = 1, -- Add extra 2 slots if player has this role.
    ["1209560589773570099"] = 1, -- Add extra 1 slot if player has this role.
}

zr_config.EnableDelete = false
zr_config.EnableDeleteByDiscord = false
zr_config.discord_roles_delete_button = {
    ["1000377003704336476"] = true,
    ["1004486369919373392"] = true, 
}

zr_config.Debug = false

zr_config.prefix = 'char'

zr_trans.chinfos = "Karakterinformatie."
zr_trans.otinfos = "Andere informatie."
zr_trans.delete = "Verwijder Karakter."
zr_trans.deleteconf = "Klik nogmaals om te bevestigen!"
zr_trans.play = "Speel als"
zr_trans.create = "Creëer een nieuw karakter."
zr_trans.fname = "Voornaam"
zr_trans.lname = "Achternaam"
zr_trans.gender = "Geslacht"
zr_trans.male = 'MAN'
zr_trans.female = 'VROUW'
zr_trans.dob = "Geboortedatum"
zr_trans.job = "Functie"
zr_trans.cash = "Geld"
zr_trans.bank = "Bank"
zr_trans.symb = "€"
zr_trans.aslots = "Standaard slots"
zr_trans.dslots = "Discord slots"

zr_trans.noslots = "Je hebt geen lege slots!"
zr_trans.deleted = "Karakter Verwijderen"
zr_trans.deldiscord = "Je moet een discord slot hebben om je personage te verwijderen"


zr_config.DefaultSkins = {
    ["m"] = {
        mom = 43,
        dad = 29,
        face_md_weight = 61,
        skin_md_weight = 27,
        nose_1 = -5,
        nose_2 = 6,
        nose_3 = 5,
        nose_4 = 8,
        nose_5 = 10,
        nose_6 = 0,
        cheeks_1 = 2,
        cheeks_2 = -10,
        cheeks_3 = 6,
        lip_thickness = -2,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = 0,
        chin_2 = 0,
        chin_13 = 0,
        chin_4 = 0,
        neck_thickness = 0,
        hair_1 = 76,
        hair_2 = 0,
        hair_color_1 = 61,
        hair_color_2 = 29,
        tshirt_1 = 4,
        tshirt_2 = 2,
        torso_1 = 23,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 1,
        arms_2 = 0,
        pants_1 = 28,
        pants_2 = 3,
        shoes_1 = 70,
        shoes_2 = 2,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 22,
        chain_2 = 2,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 0,
        glasses_2 = 0,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 0,
        eye_squint = 0,
        eyebrows_2 = 0,
        eyebrows_1 = 0,
        eyebrows_3 = 0,
        eyebrows_4 = 0,
        eyebrows_5 = 0,
        eyebrows_6 = 0,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 0,
        moles_2 = 0,
        beard_1 = 11,
        beard_2 = 10,
        beard_3 = 0,
        beard_4 = 0
    },
    ["f"] = {
        mom = 28,
        dad = 6,
        face_md_weight = 63,
        skin_md_weight = 60,
        nose_1 = -10,
        nose_2 = 4,
        nose_3 = 5,
        nose_4 = 0,
        nose_5 = 0,
        nose_6 = 0,
        cheeks_1 = 0,
        cheeks_2 = 0,
        cheeks_3 = 0,
        lip_thickness = 0,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = -10,
        chin_2 = 10,
        chin_13 = -10,
        chin_4 = 0,
        neck_thickness = -5,
        hair_1 = 43,
        hair_2 = 0,
        hair_color_1 = 29,
        hair_color_2 = 35,
        tshirt_1 = 111,
        tshirt_2 = 5,
        torso_1 = 25,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 3,
        arms_2 = 0,
        pants_1 = 12,
        pants_2 = 2,
        shoes_1 = 20,
        shoes_2 = 10,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 85,
        chain_2 = 0,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 33,
        glasses_2 = 12,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 8,
        eye_squint = -6,
        eyebrows_2 = 7,
        eyebrows_1 = 32,
        eyebrows_3 = 52,
        eyebrows_4 = 9,
        eyebrows_5 = -5,
        eyebrows_6 = -8,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 12,
        moles_2 = 8,
        beard_1 = 0,
        beard_2 = 0,
        beard_3 = 0,
        beard_4 = 0
    }
}