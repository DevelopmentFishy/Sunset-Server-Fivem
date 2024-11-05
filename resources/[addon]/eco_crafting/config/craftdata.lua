Config.craftData = {

    chemist = {
        -- joint = {
        --     labor = 5,
        --     ingredients = {
        --         weed_budclean = 1,
        --         plastic_bag = 1,
        --     },
        --     time = 5,
        --     amount = 1,
        --     proficiency = 0,
        --     price = 0
        -- },
        -- oxy = {
        --     labor = 5,
        --     ingredients = {
        --         pillen = 1,
        --         plastic_cup = 1,
        --     },
        --     time = 5,
        --     amount = 1,
        --     proficiency = 0,
        --     price = 0,
        -- },
        -- bandage = {
        --     labor = 5,
        --     ingredients = {
        --         stof = 1,
        --     },
        --     time = 5,
        --     amount = 1,
        --     proficiency = 0,
        --     price = 0,
        -- },
        -- painkillers = {
        --     labor = 5,
        --     ingredients = {
        --         pillen = 1,
        --     },
        --     time = 5,
        --     amount = 1,
        --     proficiency = 0,
        --     price = 0,
        -- },
    },
    -- cooking = {
    --     tosti = {
    --         labor = 5,
    --         ingredients = {
    --             plastic = 1,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0
    --     },
    --     twerks_candy = {
    --         labor = 5,
    --         ingredients = {
    --             plastic = 1,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0
    --     },
    --     snikkel_candy = { -- only the defined job and on a special 'hookies' workplace
    --         labor = 10,
    --         ingredients = {
    --             plastic = 1,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0,
    --         exclusive = {
    --             mechanic = { 0, 1 }, -- selected ranks in a job (optional)
    --             vagos = {}, -- all ranks in a job
    --             'crips', -- all ranks in a job
    --         },
    --         special = 'hookies'
    --     },
    --     sandwich = {
    --         labor = 5,
    --         ingredients = {
    --             plastic = 1,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0,
    --         special = 'hotdog_stand'
    --     },
    -- },
    weaponry = {
        weapon_dagger = {
            labor = 5,
            ingredients = {
                rubber = 10,
                steel = 25,
                aluminum = 20, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,

        },
        weapon_knife = {
            labor = 5,
            ingredients = {
                rubber = 10,
                steel = 30,
                aluminum = 20,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        weapon_switchblade = {
            labor = 5,
            ingredients = {
                aluminum = 20,
                steel = 30,
                rubber = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        weapon_machete = {
            labor = 5,
            ingredients = {
                aluminum = 25,
                steel = 35,
                rubber = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        weapon_snspistol  = {
            labor = 50,
            ingredients = {
                snsblauwprint = 1,
                snspistol_trigger = 1,
                snspistol_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 25000
        },
        snspistol_loop = {
            labor = 50,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        snspistol_trigger = {
            labor = 50,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        snspistol_clip = {
            labor = 50,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        snspistol_body = {
            labor = 50,
            ingredients = {
                snspistol_loop = 1,
                snspistol_clip = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        weapon_combatpistol  = {
            labor = 50,
            ingredients = {
                bpcombatpistol = 1,
                combat_trigger = 1,
                combat_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 1000,
            price = 50000
        },
        combat_loop = {
            labor = 5,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        combat_trigger = {
            labor = 5,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        combat_clip = {
            labor = 5,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        combat_body = {
            labor = 5,
            ingredients = {
                combat_loop = 1,
                combat_clip = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        weapon_heavypistol  = {
            labor = 50,
            ingredients = {
                bpheavypistol = 1,
                heavypistol_trigger = 1,
                heavypistol_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 1000,
            price = 50000
        },
        heavypistol_loop = {
            labor = 5,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        heavypistol_trigger = {
            labor = 5,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        heavypistol_clip = {
            labor = 5,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        heavypistol_body = {
            labor = 5,
            ingredients = {
                heavypistol_loop = 1,
                heavypistol_clip = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 1000,
            price = 0,
        },
        weapon_pistol50   = {
            labor = 75,
            ingredients = {
                bpdeagle = 1,
                deagle_trigger = 1,
                deagle_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 1500,
            price = 75000
        },
        deagle_loop = {
            labor = 5,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 1500,
            price = 0,
        },
        deagle_trigger = {
            labor = 5,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 1500,
            price = 0,
        },
        deagle_clip = {
            labor = 5,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 1500,
            price = 0,
        },
        deagle_body = {
            labor = 5,
            ingredients = {
                deagle_clip = 1,
                deagle_loop = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 1500,
            price = 0,
        },
        weapon_machinepistol   = {
            labor = 100,
            ingredients = {
                bptec9 = 1,
                tec9_trigger = 1,
                tec9_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 5000,
            price = 100000
        },
        tec9_loop = {
            labor = 5,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 5000,
            price = 0,
        },
        tec9_trigger = {
            labor = 5,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 5000,
            price = 0,
        },
        tec9_clip = {
            labor = 5,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 5000,
            price = 0,
        },
        tec9_body = {
            labor = 5,
            ingredients = {
                tec9_clip = 1,
                tec9_loop = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 5000,
            price = 0,
        },
        weapon_compactrifle   = {
            labor = 150,
            ingredients = {
                bpcompactrifle = 1,
                rifle_trigger = 1,
                rifle_body = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 10000,
            price = 150000
        },
        rifle_part1 = {
            labor = 5,
            ingredients = {
                metalscrap = 100,
                steel = 200,
            },
            time = 10,
            amount = 1,
            proficiency = 10000,
            price = 0,
        },
        rifle_trigger = {
            labor = 5,
            ingredients = {
                metalscrap = 50,
                steel = 150,
            },
            time = 10,
            amount = 1,
            proficiency = 10000,
            price = 0,
        },
        rifle_part2 = {
            labor = 5,
            ingredients = {
                metalscrap = 150,
                rubber = 50,
            },
            time = 10,
            amount = 1,
            proficiency = 10000,
            price = 0,
        },
        rifle_body = {
            labor = 5,
            ingredients = {
                rifle_part2 = 1,
                rifle_part1 = 1,
            },
            time = 10,
            amount = 1,
            proficiency = 10000,
            price = 0,
        },
        pistol_ammo = {
            labor = 5,
            ingredients = {
                copper = 50,
                aluminum = 25,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 250,
        },
        rifle_ammo = {
            labor = 5,
            ingredients = {
                copper = 50,
                aluminum = 25,
            },
            time = 10,
            amount = 1,
            proficiency = 10000,
            price = 750,
        },
        pistol_suppressor = {
            labor = 5,
            ingredients = {
                rubber = 50,
                aluminum = 25,
                steel = 10,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 5000,
        },
        pistol_extendedclip = {
            labor = 5,
            ingredients = {
                rubber = 50,
                plastic = 25,
                steel = 10,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 5000,
        },
        green_weapontint = {
            labor = 5,
            ingredients = {
                plastic = 25,
                steel = 10,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 500,
        },
        gold_weapontint= {
            labor = 5,
            ingredients = {
                plastic = 25,
                steel = 10,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 500,
        },
        pink_weapontint = {
            labor = 5,
            ingredients = {
                plastic = 25,
                steel = 10,
            },
            time = 10,
            amount = 1,
            proficiency = 0,
            price = 500,
        },
    },

    -- foundry = {
    --     aluminum = {
    --         labor = 5,
    --         ingredients = {
    --             aluminumoxide = 3,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0
    --     },pistol_ammo
    --     iron = {
    --         labor = 5,
    --         ingredients = {
    --             ironoxide = 3,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 0,
    --         price = 0
    --     },
    --     steel = {
    --         labor = 5,
    --         ingredients = {
    --             iron = 2,
    --         },
    --         time = 5,
    --         amount = 1,
    --         proficiency = 10,
    --         price = 5,
    --         special = 'f_extend'
    --     },
    -- },
    handicraft = { -- normale craft tafel
        lockpick = {
            labor = 5,
            ingredients = {
                metalscrap = 10,
                plastic = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        advancedlockpick = {
            labor = 5,
            ingredients = {
                lockpick = 1,
                screwdriverset = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        electronickit = {
            labor = 5,
            ingredients = {
                plastic = 10,
                copper = 10,
                aluminum  = 20,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        gatecrack = {
            labor = 5,
            ingredients = {
                copper = 12,
                rubber = 15,
                plastic = 10,
                electronickit = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        trojan_usb = {
            labor = 5,
            ingredients = {
                gatecrack = 1,
                plastic = 20,
                copper = 15,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        screwdriverset = {
            labor = 5,
            ingredients = {
                plastic = 10,
                copper = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        drill = {
            labor = 5,
            ingredients = {
                screwdriverset = 1,
                electronickit = 2,
                plastic = 50,
                copper = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        plastic_bag = {
            labor = 5,
            ingredients = {
                plastic = 25,
            },
            time = 5,
            amount = 100,
            proficiency = 0,
            price = 0
        },
        aluminumoxide  = {
            labor = 5,
            ingredients = {
                aluminum = 100,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        ironoxide = {
            labor = 5,
            ingredients = {
                iron = 100,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        thermite = {
            labor = 5,
            ingredients = {
                ironoxide = 1,
                aluminumoxide = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        thermite2 = {
            labor = 5,
            ingredients = {
                ironoxide = 1,
                aluminumoxide = 1,
                steel = 50,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        kthermite = {
            labor = 5,
            ingredients = {
                ironoxide = 1,
                aluminumoxide = 1,
                metalscrap = 50,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        armor = {
            labor = 5,
            ingredients = {
                rubber = 25,
                plastic = 25,
                stof= 5,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 500
        },
        repairkit = {
            labor = 5,
            ingredients = {
                screwdriverset = 2,
                plastic = 25,
                steel = 20,
                metalscrap = 20,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500
        },
        weapon_bat = {
            labor = 5,
            ingredients = {
                rubber = 10,
                steel = 25 -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500,

        },
        weapon_knuckle = {
            labor = 5,
            ingredients = {
                aluminum = 10,
                steel = 25 -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500,

        },
        weapon_wrench = {
            labor = 5,
            ingredients = {
                aluminum = 10,
                steel = 25 -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500,

        },
        weapon_golfclub = {
            labor = 5,
            ingredients = {
                aluminum = 15,
                steel = 25,
                rubber = 10, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500,

        },
        weapon_hammer = {
            labor = 5,
            ingredients = {
                aluminum = 15,
                steel = 25,
                rubber = 10, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 2500,

        },
        handcuffs = {
            labor = 5,
            ingredients = {
                aluminum = 15,
                steel = 25, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 500,

        },
        laptop_green = {
            labor = 5,
            ingredients = {
                electronickit = 1,
                trojan_usb = 1,
                gatecrack = 1,
                glass = 25,
                plastic = 50,
                aluminum = 10, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 50,
            price = 5000,

        },
        hacking_laptop = {
            labor = 5,
            ingredients = {
                electronickit = 1,
                trojan_usb = 1,
                gatecrack = 1,
                glass = 25,
                plastic = 50,
                aluminum = 10, -- [minus prefix]permanent ingredient(will not be taken away)
            },
            time = 5,
            amount = 1,
            proficiency = 50,
            price = 5000,

        },
        joint = {
            labor = 5,
            ingredients = {
                weed_budclean = 1,
                plastic_bag = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0
        },
        oxy = {
            labor = 5,
            ingredients = {
                painkillers = 1,
                plastic_cup = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        bandage = {
            labor = 5,
            ingredients = {
                stof = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        painkillers = {
            labor = 5,
            ingredients = {
                pillen = 5,
                plastic_cup = 1,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        crack_kit = {
            labor = 5,
            ingredients = {
                electronickit = 2,
                trojan_usb = 1,
                metalscrap = 10,
                plastic = 20,
            },
            time = 5,
            amount = 1,
            proficiency = 150,
            price = 5000,
        },
        nylonrope = {
            labor = 5,
            ingredients = {
                stof = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        blowtorch = {
            labor = 5,
            ingredients = {
                lighter = 1,
                metalscrap = 25,
                plastic = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        copper = {
            labor = 5,
            ingredients = {
                koperdraad = 5,
            },
            time = 5,
            amount = 5,
            proficiency = 0,
            price = 0,
        },
        cutter = {
            labor = 5,
            ingredients = {
                glass = 15,
                steel = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        bag = {
            labor = 5,
            ingredients = {
                rubber = 15,
                steel = 10,
            },
            time = 5,
            amount = 1,
            proficiency = 0,
            price = 0,
        },
        boostingtablet = { --Boosting DLC
            labor = 5,
            ingredients = {
                electronickit = 1,
                iphone = 1,
            },
            time = 8,
            amount = 1,
            proficiency = 0,
            price = 150,
        },
        hackingdevice = { --Boosting DLC
            labor = 5,
            ingredients = {
                electronickit = 1,
                trojan_usb = 1,
            },
            time = 8,
            amount = 1,
            proficiency = 0,
            price = 150,
        },
        gpshackingdevice = { --Boosting DLC
        labor = 5,
        ingredients = {
            electronickit = 1,
            trojan_usb = 1,
            koperdraad = 10,
        },
        time = 8,
        amount = 1,
        proficiency = 0,
        price = 150,
     }
      
    }
}
