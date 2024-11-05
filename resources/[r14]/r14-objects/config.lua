local QBCore = exports['qb-core']:GetCoreObject()

Config = {}

Config.DB = {
    Table = 'objects', -- can be changed, make sure to match this name with the table you created using your sql
    Column = 'list', -- can be changed, make sure to match this name with the column you created using your sql
    MaxTime = 1800, -- time in days, before a persistent object is removed
    MinTime = 0, -- time in days, an object will persist unless otherwise specified, set to 0 or false if you do not want objects to persist
}

Config.Debug = {
    Spikes = {enabled = false, label = 'Enable debug mode on spike polyzones and draw the wheel position of vehicles.'}, -- change this to debug spike strips issue, if spikes are working, markers should be generated on the tires and polyzones be drawn on the spikes
    ObjectZones = {enabled = false, exclude = true}, -- change this to debug object zones created for targeting, cannot be set in runtime
    Print = {enabled = false, label = 'Enable debug prints to console for major events.'}, -- this will print most arguments so you can make sense of the data flowing through them
    Bucket = {enabled = false, label = 'Print your current bucket to console for testing instancing.'}, -- this will print your current bucket for testing routing buckets
    Database = {enabled = false, label = 'Print you database calls/writes to server console.'}, -- this will print the database update to your server console
}

Config.AdminAlert = false -- this generates admin log message in chat if player uses /spikestrips
Config.MaxPlaceDist = 3.0 -- this sets the max distance for object placement, can be overriden in objects
Config.TargetDist = 2.5 -- this sets the max distance for target options

Config.Bomb = {
    HackFailed = 0.3,
    WrongCode = 0.3,
    WrongWire = 0.5,
    MaxAttempts = 3, -- number of wires that can be cut before detonation
}

Config.Music = {
    DefaultVolume = 100, -- range of 0 to 1000
    VolumeStep = 20, -- amount volume will change per click in the music menu
    MusicDist = 30, -- distance music will play
}

Config.Messages = {
    NoIngredients = "Je hebt geen ingredienten.", -- do not have ingredients to grill
    HackFail = "Gefaald tijd verlaagd met 1/3!", -- hack failed
    WrongCode = "Gefaald tijd verlaagd met 1/3!", -- wrong code entered
    WrongWire = "Gefaald tijd verlaagd met 1/2!", -- wrong wire cut
    DoesNotExist = "Object bestaat niet.", -- wrong object entered in spawn command
    TooFastToPlace = "Rustig aan take it easy", -- moving to fast during placement
    StoppedTraffic = "Lokaal verkeer is gestopt.", -- traffic stopped by speed zone
    ResumeTraffic = "Lokaal verkeer mag terug rijden.", -- speed zone removed
    Overweight = "Je zakken zitten vol!", -- attempt to add to inventory failed
    Report = "Report is gemaakt voor mogelijks bugabuse.", -- item requested via event was not found, notifies user
    OvernightPlacement = "Verzoek aanvaard onze medewerkers komen deze nacht alles installeren !", -- can use up to one %s for the object label, do not use more than 1 %s in this string
    VendorExtend = 'Je leen tijd is verlopen %s', -- can use one %s for the date of the new lease expiration, for the vendor system
    VendorRekey = 'Je beveilinging moet vernieuwd worden!', -- for vendor system, will be used when requesting locks to be changed
    Refund = 'Je hebt je geld teruggekregen.', -- for vendors, if a refund is issued such as a players inventory is too full
    IncorrectCombo = 'The hendel draait niet verkeerde code.', -- for safes
    Deposited = 'Succesvol gestort $%s', -- for safes
    Withdrawn = 'Succesvol afgehaald $%s', -- for safes
}

-- this config allows you to create container vendors, it may be advantageous to create several so that criminals can have a better chance of hiding containers in their name
-- and for civilians it provides more options on where to go to rent a container. for police, more vendors makes criminal investigations take more effort, as they have to both
-- know about and track down the correct vendor to serve a warrant to in order to obtain records, instead of simply looking it up in the MEOS app

--[[ template for vendor peds

	['example'] = { -- the backend name of the ped's business, this is used to access to access the correct business when interacting with them
        inventory = {
            ['storage'] = 2000, -- the name of the container item for sale, and the price
            ['garage'] = 1000, -- the name of the container item for sale, and the price
        },
        ped = 'example ped', -- the name of the ped model as a string
        coords = vector4(1003.3, 121.5, 3413.2, 43.5), -- the coords, in vector4, of the ped
        dist = 3.0, -- the distance the ped can be targeted with L-ALT 
        label = 'Temporary Storage Business Name', -- the display name of the business
        anim = { -- the desired animation of the ped is set by this anim table
            dict = example_anim_dict, -- the name of the animation dictionary
            name = exampleanimname, -- the name of the animation itself
            flag = 1, -- the flag of the animation
        }, 
        scenario = examplescenario, -- a desired scenario for the ped to use, this replaces the animation
        minusOne = true, -- use this to lower the ped by 1.0 units if they are hovering in the air
        breakLeaseCost = 1000, -- cost to end a contract, can be 0
        minRenewal = 2, -- time in weeks before end of contract player can renew lease
        greeting = "Ay.", --  optional greeting text
        policegreeting = "ACAB motherfucker...  but yeah what you need.", -- optional police warrant response text 
        noresults = "I think this is the wrong ID, bro.", -- optional no units found text
        emailRenew = "Unit %s will expire on %s, please visit %s to renew.", -- email asking player to renew, uses three %s replacements for unit #, unit expiration date, and vendor name
        emailExpired = "Unit %s expired! Thank you for renting with %s!", -- email letting player know unit expired, two %s replacements, unit # and vendor name
        emailExpiredUnclaimedItems = "Unit %s expired, the property let inside has been disposed of by %s!" -- email to player if contract expired with items in its stash, two %s for unit # and vendor name
    },

--]] -- end of template

Config.Containers = {
    Enabled = true, -- set to false to disable containers and vendors
    CloseOnReset = false, -- set to true if you want containers to close on server/script reset
    LockOnReset = false, -- set to true if you want containers to lock on server/script reset, will close the doors regardless of closeonreset
    VendorDefaults = {
        breakLeaseCost = 1000,
        rekey = 500,
        duplicateKey = 100,
        minRenewal = 2, -- number in weeks before end of contract a player can renew a lease
        emailRenewalStart = 8, -- number in days when a vendor will send player an email on script restart that their lease is expiring
        emailRenew = "Uw contract voor eenheid %s loopt af op %s. Bezoek ons ​​als u uw contract wilt verlengen! Als u niet van plan bent te verlengen, dient u uw artikelen vóór de einddatum van het contract op te ruimen. Alle niet-geclaimde eigendommen worden eigendom van %s", -- email asking player to renew, uses three %s replacements for unit #, unit expiration date, and vendor name
        emailExpired = "Je contract voor eenheid %s is verlopen! Bedankt voor uw zaken, en houd %s in gedachten voor eventuele toekomstige opslagbehoeften!", -- email letting player know unit expired, two %s replacements, unit # and vendor name
        emailExpiredUnclaimedItems = "Je contract voor eenheid %s is verlopen. Helaas lijkt het erop dat je verschillende items hebt achtergelaten en deze zijn doorverkocht of weggegooid. Houd %s in gedachten voor toekomstige opslagbehoeften!" -- email to player if contract expired with items in its stash, two %s for unit # and vendor name
    },
    Vendors = {
	    ['secureshit'] = {
            inventory = {
                ["storage_container"] = {price = 20000, perm = true}, -- price in full dollars, length in weeks
            }, 
            ped = 'ig_claypain', 
            coords = vector4(88.52, -1744.37, 29.09, 295.54), 
            dist = 3.0, 
            label = 'Beveilig Yo Shit',
            dict = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", 
            anim = "idle_a", 
            flag = 1,
            breakLeaseCost = 1000,
            rekey = 500,
            duplicateKey = 100,
            minRenewal = 2, -- time in weeks before end of contract player can renew lease
            greeting = "Dat klopt, beveilig je shit, bro. Er komt waarschijnlijk niets in deze container..",
            policegreeting = "Ah shit bro, wat wil je verdomme?",
            noresults = "Nee, ik heb hier niets voor je, bro",
            emailRenew = "Yo, je contract voor %s loopt af, dawg. Als je het wilt houden, moet je mij mijn geld voor %s bezorgen, anders verkoop ik die rommel en alles wat erin zit.", 
            emailExpired = "Bedankt voor het gebruik van Beveilig Yo Shit, we hebben dat contract voor eenheid %s gerespecteerd en nu is het klaar, dawg. Heb een goede. <br /><br /> - Mike",
            emailExpiredUnclaimedItems = "Hé, ik heb je spullen verkocht, dawg. Ik zei dat je het moest komen halen. Veel plezier, kom terug als je meer geld hebt.<br /><br />Bedankt,<br />-Mike", 
        },
        ['secureshitwest'] = {
            inventory = {
                ["storage_container"] = {price = 20000, perm = true}, -- price in full dollars, length in weeks
            }, 
            ped = 'ig_josef', 
            coords = vector4(-1111.45, -1689.32, 3.38, 308.29), 
            dist = 3.0, 
            label = 'Beveilig Yo Shit West', 
            greeting = "Hé dawg, maak je geen zorgen, dit is een legitieme zakelijke franchise en zo.",
            policegreeting = "Echt, dawg, ga je me zo aanpakken?",
            scenario = "WORLD_HUMAN_LEANING",
            breakLeaseCost = 1000,
            rekey = 500,
            duplicateKey = 100,
            minRenewal = 2, -- time in weeks before end of contract player can renew lease
            noresults = "Verspil je mijn tijd, dawg? Tijd is geld, joh.",
            emailRenew = "Hey dawg, eenheid %s verloopt op %s. Als u niet komt en het contract verlengt, wordt het apparaat opgehaald. Als u er iets in heeft, kom het dan halen, anders is het weg. <br /><br /> - Tony", 
            emailExpired = "Bedankt voor het gebruik van Secure Yo Shit West, we hebben dat contract voor eenheid %s gehonoreerd. Kom terug als je iets nodig hebt, kerel.<br /><br /> - Tony",
            emailExpiredUnclaimedItems = "Yo, ik zei dat je je spullen moest pakken, dawg. Ik zei het je. Dat spul is nu weg. <br /><br /> - Tony", 
        },
	    ['cypress'] = {
            inventory = {
                ["storage_container"] = {price = 20000, perm = true}, -- price in full dollars, length in weeks
            }, 
            ped = 'ig_chengsr', 
            coords = vector4(960.24, -2503.08, 27.45, 311.4), 
            dist = 3.0, 
            label = 'Cypress Storage', 
            scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
            breakLeaseCost = 1000,
            minRenewal = 2, -- time in weeks before end of contract player can renew lease
            greeting = "Welkom bij Cypress Storage, wat heb je nodig?",
            policegreeting = "Natuurlijk, ik heb die gegevens waarschijnlijk hier ergens, agent.", 
        },
	    ['jetsam'] = {
            inventory = {
                ["storage_container"] = {price = 20000, perm = true},  -- price in full dollars, length in weeks
            }, 
            ped = 'ig_floyd', 
            coords = vector4(-249.62, 6158.41, 30.48, 321.31), 
            dist = 3.0, 
            label = 'Jetsam', 
            scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
            breakLeaseCost = 1000,
            minRenewal = 2, -- time in weeks before end of contract player can renew lease
            greeting = "Bedankt dat je voor Jetsam hebt gekozen. Hoe kan ik je helpen?",
            policegreeting = "Ja, wat kan ik voor u doen, agent.", 
        },
	    ['lockandkey'] = {
            inventory = {
                ["largesafe"] = {price = 45000, perm = true}, -- price in full dollars, length in weeks
                ["smallsafe"] = {price = 30000, perm = true}
            }, 
            norecords = true,
            ped = 'A_M_O_SOUCENT_01', 
            coords = vector4(169.76, -1799.09, 29.32, 298.88),
            minusOne = true,
            dist = 3.0, 
            label = 'Locksmith & Keyshop', 
            scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        },
    },
    EmailHandler = 'qb-phone',
    SendEmail = function(data) -- the function that will be run when an email is triggered by the script, you can remove ones you don't need
        if Config.Containers.EmailHandler == 'qb-phone' or 'npwd' then
            TriggerEvent('qb-phone:server:sendNewMailToOffline', data.cid, data)
        elseif Config.Containers.EmailHandler == 'qs-smartphone' then
            TriggerEvent('qs-smartphone:server:sendNewMailToOffline', data.cid, data)
        end
    end,
    ValidID = { -- list of valid ID items in your server, must identify the name of the field that contains the first name, last name, and cid. alternatively, can use fullname if its the only field
        --['driver_license'] = {firstname = 'firstname', lastname = 'lastname', cid = 'citizenid', fullname = false}, -- not valid in base qb-core due to no CID in item info!
        ['id_card'] = {firstname = 'firstname', lastname = 'lastname', cid = 'citizenid', fullname = false}, -- has citizenid so is valid!
    },
    Tender = {['cash'] = 'Cash', ['bank'] = "Bank kaart"} -- allows you to change which payments are accepted, do not include crypto as there is no way to modulate price, key is money type and value is label
}

-- this config allows you to create custom objects that you can spawn using in game items, or even through vendor peds, the script comes with
-- a large number of prebuilt options to add functionality to items, or you can simply create static props that can add to roleplay scenes,
-- you can use this guide to set up objects with specific functionalities outlined below!

--[[ template for custom objects

    ["customitemname"] = {
        label = "Custom Item", 
        model = `prop_generic`, -- can be found via pleb masters forge
        broken = 'diffusedbomb', -- broken item that will be given back if a custom target option is created that sets broken = true
        zoffset = 0.0, -- vertical offset used to adjust height an object is spanwed at, used to fix floating or sunken objects
        ghostoff = 0.3, -- vertical offset used to adjust height of the transparent version of an object during placement, sometimes is different than zoffset for some reason
        freeze = true, -- this variable sets if the item is frozen in the world
        noitem = true, -- this variable runs AddUseableItem for the item name to make an inventory item of the same name useable
        overnight = true, -- this variable causes the object to spawn after the next reset, rather than instantly, mainly for containers
        nopickup = true, -- this variable determines if the item has an option to be picked up
        speedzone = true, -- creates a speedzone 
        admin = true, -- this allows the admin object to be spawned with a custom model
        shortProgressBar = true, -- this will shorten the progress bar and remove the animation
        policecheck = true, -- allows police to check the object ID of an placed object, allows them to query vendors for info
        persist = 14, -- days object will persist in database
        speedlimit = 20.0, -- sets the speedlimit of the speedzone, 0 will stop traffic and produce a notification that traffic has been stopped, unless hidespeed is used
        hidespeed = true, -- bool that sets if it hides the notification that traffic has been stopped if speedlimit set to 0
        checklevel = true, -- this item checks if the ground is level below the object, preventing it from being placed on most slopes
        jobs = {["police"] = 0, ["ambulance"] = 0}, -- used to specify which jobs can access the qb-target option, must use same format of job for the key and lowest rank available for the value-pair (0 for all)
        TargetDist = 3.0, -- used to override maximum target distance
        MaxPlaceDist = 5.0, -- used to override maximum placement distance
        customTarget = { -- used to add custom target info, can be a single option, or a table of options
            type = 'client', -- if ommited, defaults to client
            event = "r14-obj:client:deleteObject", -- event to be triggered
            icon = "fas fa-chair", -- icon to be used in target
            label = "Sit Down", -- label to be created in target
            citizenid = true, -- set to true if you want it to be limited to the player that places the item
        },
        customEventObjectCreate = { -- triggered when the object is first created
            type = 'server', -- can be 'server', 'client', or 'action', defaults to client, action will run the event field as a function
            event = 'event:server:example', -- name of event to be triggered
        },
        customEventObjectDelete = { -- triggred when the object is removed/deleted entirely
            type = 'client', -- can be 'server', 'client', or 'action', defaults to client, action will run the event field as a function
            event = 'event:client:example', -- name of event to be triggered
        },
        customEventEntityCreate = { -- this event will be triggered when the object's entity is spawned by the script, it will trigger multiple times
            type = 'action', -- can be 'server', 'client', or 'action', defaults to client, action will run the event field as a function
            event = function() print('here!') end, -- name of event to be triggered
        },
        customEventEntityDelete = { -- this event will be triggered when the entity is deleted, but the object is still active
            type = 'client', -- can be 'server', 'client', or 'action', defaults to client, action will run the event field as a function
            event = 'event:client:example', -- name of event to be triggered
        },
        give = { -- crafting recipe used by object
            ['bandage'] = {
                get = 1, -- specifies how many items you get
                req = false, -- specifies requirements to craft item, if false, it does not require anything to get
                icon = "fas fa-band-aid", -- custom target icon
                label = "Bandage" -- name of item
                targetlabel = "Get Bandage", -- custom target label
            },
            ['hotdog'] = {
                get = 1,
                req = {['coldweiner'] = 1, ['hotdogbun'] = 1}, -- specifies crafting recipe, key is the item, and value is how many is required
                icon = "fas fa-fire",
                label = "Hotdog" -- name of item
                targetlabel = "Roast Weiner",
                progresslabel = "Roasting weiner...", -- progresslabel sets a custom text for the progress bar
                emote = 'warmth', -- emote sets a custom emote for crafting progressbar
            },
        },
        locks = true, -- this variable allows the item and its subinventories to be locked with a key, it will automatically give the player a key item
        cutlock = { -- these are for containers or objects you want to be able to cut into using an angle grinder, you must specify offsets
            [1] = {lock = vector3(0, -3.4, 0), stand = vector3(0, -3.9, 0)}, -- lock indicates position of lock, stand indicates where player ped will start the cut animation at
            [2] = {lock = vector3(0, 3.4, 0), stand = vector3(0, 3.9, 0)},
        },
        subentities = { -- this variable allows you to spawn a group of props along with the original item
            [1] = {
                model = `prop_subentity`, -- model of the prop, can be found via pleb masters forge
                offset = vector3(-1.295, -3.4, 0.09), -- the offset from the original object, NOT COORDS
                ghostoff = 1.0, -- a z offset for the ghost subent generated during placement, use if its floating or sinking into the ground
                rotation = vector3(0, 0, 0), -- the rotation of the subentity
                subtarget = true, -- allows you to add target options for the subentity, if not set to true it wont gain any specific target options
                open = vector3(0, 0, -110), -- a subtarget option which allows the subentity to function as a door, needs a rotation offset from its original rotation
                cutlock = 1 -- allows the door to be cut into with angle grinder, must specify one of the cutlock options in the main object
                freeze = true, -- freezes the subentity
                inherit = true, -- this allows the subentity to inherit the target options of the main object, such as being able to pick up the entire object set
                inventory = { -- allows the subentity to open an inventory stash
                    maxweight = 100000, -- specifies the maxweight of the stash
                    slots = 25, -- specifies how many slots the stash has
                    icon = 'fas fa-box-open', -- adds custom icon for target
                    label = 'Access Storage' -- sets custom label for target
                } 
            },
            [4] = {model = `prop_container_door_mb_r`, offset = vector3(-1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, 110),  freeze = true, cutlock = 2}, -- door 4
        },
    },

--]] -- end of template

Config.Objects = {
    ["adminobject"] = {
        label = "Admin Object",
        admin = true,
        nopickup = true,
        noitem = true,
        shortProgressBar = true,
        maxPlaceDist = 10.0,
    },
    ["cone"] = {
        label = "Cone", 
        model = `prop_roadcone02a`, 
        freeze = true,
        speedzone = false, 
        speedlimit = 0.0,
    },
    ["barricade"] = {
        label = "Barricade", 
        model = `prop_barrier_work05`, 
        freeze = true, --false, 
        speedzone = true, 
        speedlimit = 0.0
    },
    ["roadblock"] = {
        label = "Roadblock", 
        model = `prop_mp_barrier_02b`, 
        freeze = true, 
        speedzone = true, 
        speedlimit = 0.0,
    },
    ["tent"] = {
        label = "Canopy", 
        model = `prop_gazebo_02`, 
        freeze = true, 
        TargetDist = 3.0 -- used to override minimum target distance
    },
    ["light"] = {
        label = "Mobile Lighting", 
        model = `prop_worklight_03b`, 
        freeze = true, 
        zoffset = 0.1,
        ghostoff = 0.0
    },
    ["medbag"] = {
        label = "Medical Bag", 
        icon = "fas fa-medkit",
        jobs = {["police"] = 0, ["ambulance"] = 0}, -- used to specify which jobs can access the qb-target option, must use same format of job for the key and lowest rank available for the value-pair (0 for all)
        model = `xm_prop_x17_bag_med_01a`, 
        freeze = true, 
        give = { -- crafting recipe used by object, here the requirements are set to false, meaning you don't need anything to get the item from the object
            ['bandage'] = {
                get = 1,
                req = false,
                icon = "fas fa-band-aid",
                label = "Bandage",
            },
            ['painkillers'] = {
                get = 1,
                req = false,
                icon = "fas fa-capsules", 
                label = "Painkillers",
            },
            ['firstaid'] = {
                get = 1,
                req = false,
                icon = "fas fa-band-aid", 
                label = "ehbo kit",
            }
        }
    },
    ["stoppedvehicles"] = {
        label = "Caution Sign", 
        model = `prop_consign_02a`, 
        freeze = false
    },
    ["generator"] = {
        label = "Generator", 
        model = `ch_prop_ch_generator_01a`, 
        freeze = true,
    },
    ["cooler"] = {
        label = "Cooler",
        model = `prop_coolbox_01`,
        freeze = true, 
        inventory = {maxweight = 100000, slots = 25, icon = "fas fa-snowflake", label = 'Open Cooler'},
        speedzone = true,
        speedlimit = 0.0,
        hidespeed = true,
        persist = 14, -- days object will persist in database
    },
    ["spikestrip"] = {
        label = "Spike Strips", 
        model = `P_ld_stinger_s`, 
        freeze = true, 
        speedzone = true, 
        speedlimit = 20.0,
        spikelength = 2, -- set to number of spikestrips you want to spawn per spikestrip item
    },

    ["bomb"] = {
        label = "Bomb", 
        model = `ch_prop_ch_ld_bomb_01a`, 
        hidespeed = true, 
        rotation = vector3(-90.0, 0.0, 0.0), 
        freeze = true, 
        speedzone = true, 
        speedlimit = 0.0, 
        broken = 'diffusedbomb', 
        zoffset = -0.05, 
        ghostoff = 0.3,
        wires = {'blue', 'red', 'green', 'yellow', 'purple', 'pink'},
        bomb = true,
        persist = 7, -- days object will persist in database
    },
    ["foldingchair"] = {
        label = "Folding Chair", 
        model = `prop_skid_chair_01`, 
        freeze = true,
        sit = true,
        ghostoff = 0.5,
    },
    ["foldingchair2"] = {
        label = "Folding Chair", 
        model = `prop_skid_chair_02`, 
        freeze = true,
        sit = true,
        ghostoff = 0.5,
    },
    ["monobloc"] = {
        label = "Monobloc Chair", 
        model = `prop_table_03b_chr`, 
        rotation = vector3(0.0, 0.0, 90.0), 
        freeze = true,
        sit = true,
    },
    ["campfire"] = {
        label = "Campfire", 
        model = `prop_beach_fire`, 
        freeze = true, 
        zoffset = -0.1, 
        ghostoff = 0.1,
        nopickup = true,
        give = {
            ['hotdog'] = {
                get = 1,
                req = {['coldweiner'] = 1, ['hotdogbun'] = 1},
                icon = "fas fa-fire",
                label = "Hotdog",
                targetlabel = "Roast Weiner",
                progresslabel = "Roasting weiner...",
                emote = 'warmth',
            },   --[[
            ['smore'] = {
                get = 1,
                req = {['grahamcracker'] = 1, ['meteorite'] = 1, ["marshmallow"] = 1},
                icon = "fas fa-fire",
                label = "S'more'"
                targetlabel = "Roast Smore",
                progresslabel = "Making a s'more...",
                emote = 'warmth',
            }    --]]
        }
    },
    ["camptent"] = {
        label = "Tent", 
        model = `prop_skid_tent_01`, 
        freeze = true, 
        zoffset = -0.5, 
        ghostoff = 0.6,
        persist = 7, -- days object will persist in database
    },
    ["camptent2"] = {
        label = "Tent", 
        model = `prop_skid_tent_03`, 
        freeze = true, 
        zoffset = -0.6, 
        ghostoff = 0.6,
        persist = 7, -- days object will persist in database
    },
    ["camptent3"] = {
        label = "Tent", 
        model = `ba_prop_battle_tent_01`, 
        freeze = true, 
        zoffset = 0.3, 
        ghostoff = 0.0,
        persist = 7, -- days object will persist in database
    },
    ["camptent4"] = {
        label = "Tent", 
        model = `ba_prop_battle_tent_02`, 
        freeze = true, 
        zoffset = 0.3, 
        ghostoff = 0.0,
        persist = 7, -- days object will persist in database
    },
    ["picnictable"] = {
        label = "Picnic Table", 
        model = `prop_picnictable_01`, 
        freeze = true,
        persist = 7, -- days object will persist in database
    },
    ["foldingtable"] = {
        label = "Folding Table", 
        model = `prop_ven_market_table1`, 
        freeze = true,
        persist = 7, -- days object will persist in database
    },
    ["umbrella"] = {
        label = "Beach Umbrella", 
        model = `prop_beach_parasol_01`, 
        rotation = vector3(10.0, 10.0, 0.0), 
        zoffset = -0.5, 
        ghostoff = -0.2, 
        freeze = true,
    },
    ["umbrella2"] = {
        label = "Beach Umbrella", 
        model = `prop_beach_parasol_02`, 
        rotation = vector3(10.0, 10.0, 0.0), 
        zoffset = 0.4, 
        ghostoff = -0.2, 
        freeze = true,
    },
    ["umbrella3"] = {
        label = "Beach Umbrella", 
        model = `prop_beach_parasol_03`, 
        rotation = vector3(10.0, 10.0, 0.0), 
        zoffset = 0.4, 
        ghostoff = -0.4, 
        freeze = true
    },
    ["beachtowel"] = {
        label = "Beach Towel",
        model = `p_cs_beachtowel_01_s`, 
        freeze = true
    },
    ["boombox"] = {
        label = "Boombox", 
        model = `prop_boombox_01`, 
        rotation = vector3(0.0, 0.0, -180.0), 
        freeze = true, 
        ghostoff = 0.4, 
        music = true,
    },
    ["miniradio"] = {
        label = "Mini Radio", 
        model = `prop_radio_01`, 
        freeze = true, 
        ghostoff = 0.2, 
        music = true,
    },
    ["cdplayer"] = {
        label = "CD Player", 
        model = `prop_portable_hifi_01`, 
        freeze = true, 
        ghostoff = 0.2, 
        music = true,
    },
    ["bbq"] = {
        label = "Grill", 
        model = `prop_bbq_5`, 
        freeze = true, 
        persist = 3, -- days object will persist in database
        inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-burger', label = 'Grab Food'},
        give = {
            ['hotdog'] = {
                get = 1,
                req = {['coldweiner'] = 1, ['hotdogbun'] = 1},
                icon = "fas fa-fire",
                label = "Hotdog",
                targetlabel = "Grill Hotdog",
                time = 12000,
                progresslabel = 'Grilling weiner...',
                emote = 'bbq',
            },
            ['burger'] = {
                get = 1,
                req = {['burger_bun'] = 1, ['burger_raw'] = 1, ["americancheese"] = 1},
                icon = "fas fa-fire",
                label = "Hamburger",
                targetlabel = "Grill Burger",
                progresslabel = 'Grilling burger...',
                time = 12000,
                emote = 'bbq',
            }
        }
    },    
    ["storage_container"] = {
        label = "Storage Container", 
        model = `prop_container_04mb`,
        freeze = true,
        noitem = true, -- does not create a inventory item
        overnight = true,
        nopickup = true,
        maxPlaceDist = 10.0,
        checklevel = true,
        policecheck = true,
        container = true,
        persist = 500, -- days object will persist in database
        locks = true,
        key = true,
        cutlock = { -- locations of 'locks', aka the center of the doors on the object, the cut lock event will find the closest one
            [1] = {lock = vector3(0, -3.4, 0), stand = vector3(0, -3.9, 0)}, -- lock indicates position of lock, stand indicates where player ped will start the cut animation at
            [2] = {lock = vector3(0, 3.4, 0), stand = vector3(0, 3.9, 0)},
        },
        subentities = {
            [1] = {model = `prop_container_door_mb_l`, offset = vector3(-1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, -110), freeze = true}, -- door 1
            [2] = {model = `prop_container_door_mb_r`, offset = vector3(1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, 110),  freeze = true}, -- door 2
            [3] = {model = `prop_container_door_mb_l`, offset = vector3(1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, -110),  freeze = true}, -- door 3
            [4] = {model = `prop_container_door_mb_r`, offset = vector3(-1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, 110),  freeze = true}, -- door 4
            [5] = {model = `ba_prop_battle_crate_closed_bc`, offset = vector3(0.0, -1.5, 0.09), rotation = vector3(0, 0, 0), subtarget = true, freeze = true, inventory = {maxweight = 1000000, slots = 50, icon = "fas fa-box-open", label = 'Open opslag'}}, -- crates
            [6] = {model = `ba_prop_battle_crate_closed_bc`, offset = vector3(0.0, 1.5, 0.09), rotation = vector3(0, 0, 0), subtarget = true, freeze = true, inventory = {maxweight = 1000000, slots = 50, icon = "fas fa-box-open", label = 'Open opslag'}}, -- crates
        },
    },
    ["gunrepair_container"] = {
        label = "Firearm Repair Container", 
        model = `prop_container_04mb`,
        freeze = true,
        noitem = true, -- does not create a inventory item
        overnight = true,
        maxPlaceDist = 10.0,
        nopickup = true,
        checklevel = true,
        container = true,
        policecheck = true, -- allows police to check the object ID of an placed object, allows them to query vendors for info
        persist = 21, -- days object will persist in database
        locks = true,
        key = true,
        cutlock = { -- locations of 'locks', aka the center of the doors on the object, the cut lock event will find the closest one
            [1] = {lock = vector3(0, -3.4, 0), stand = vector3(0, -3.9, 0)}, -- lock indicates position of lock, stand indicates where player ped will start the cut animation at
            [2] = {lock = vector3(0, 3.4, 0), stand = vector3(0, 3.9, 0)},
        },
        subentities = {
            [1] = {model = `prop_container_door_mb_l`, offset = vector3(-1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, -110), freeze = true, cutlock = 1}, -- door 1
            [2] = {model = `prop_container_door_mb_r`, offset = vector3(1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, 110),  freeze = true, cutlock = 1}, -- door 2
            [3] = {model = `prop_container_door_mb_l`, offset = vector3(1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, -110),  freeze = true, cutlock = 2}, -- door 3
            [4] = {model = `prop_container_door_mb_r`, offset = vector3(-1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, 110),  freeze = true, cutlock = 2}, -- door 4
            [5] = {model = `gr_prop_gr_crates_rifles_01a`, offset = vector3(-0.75, -2.65, 0.09), rotation = vector3(0, 0, 0), freeze = true, subtarget = true, inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-box-open', label = 'Access Storage'}}, -- 
            [6] = {model = `gr_prop_gr_bench_02a`, offset = vector3(-0.8, -0.92, 0.09), rotation = vector3(0, 0, 90), freeze = true}, -- 
            [7] = {model = `gr_prop_gr_lathe_01a`, offset = vector3(-0.73, 1.7, 0.09), rotation = vector3(0, 0, 90), freeze = true}, -- 
            [8] = {model = `gr_prop_gr_prop_welder_01a`, offset = vector3(0.95, -2.9, 0.2), rotation = vector3(0, 0, 180), freeze = true}, -- 
            [9] = {model = `gr_prop_gr_vice_01a`, offset = vector3(-0.65, -1.45, 0.88), rotation = vector3(0, 0, 90), freeze = true}, -- 
            [10] = {model = `gr_prop_gr_grinder_01a`, offset = vector3(-0.60, -0.1, 0.88), rotation = vector3(0, 0, 90), freeze = true}, -- 
            [11] = {model = `gr_prop_gr_rsply_crate03a`, offset = vector3(0.97, -1.2, 0.15), rotation = vector3(0, 0, 90), freeze = true, subtarget = true, inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-box-open', label = 'Access Storage'}}, -- 
            [12] = {model = `gr_prop_gr_rsply_crate03a`, offset = vector3(0.97, -1.2, 0.625), rotation = vector3(0, 0, 90), freeze = true, subtarget = true, inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-box-open', label = 'Access Storage'}}, -- 
            [13] = {model = `gr_prop_gr_rsply_crate03a`, offset = vector3(0.97, -0.2, 0.15), rotation = vector3(0, 0, 90), freeze = true, subtarget = true, inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-box-open', label = 'Access Storage'}}, -- 
            [14] = {model = `gr_prop_gr_rsply_crate03a`, offset = vector3(0.97, -0.2, 0.625), rotation = vector3(0, 0, 90), freeze = true, subtarget = true, inventory = {maxweight = 100000, slots = 25, icon = 'fas fa-box-open', label = 'Access Storage'}}, -- 
            [15] = {model = `prop_cementbags01`, offset = vector3(-2.0, 2.3, 0.0), rotation = vector3(0, 0, 0), freeze = true}, -- 
            [16] = {model = `prop_cementbags01`, offset = vector3(-2.0, 2.3, 1.2), rotation = vector3(0, 0, -90), freeze = true}, -- 
            [17] = {model = `prop_cementbags01`, offset = vector3(-2.0, 1.0, 0.0), rotation = vector3(0, 0, 90), freeze = true}, -- 
            [18] = {model = `prop_cementbags01`, offset = vector3(-2.0, 1.0, 1.2), rotation = vector3(0, 0, -90), freeze = true}, -- 
            [19] = {model = `ch_prop_ch_generator_01a`, offset = vector3(-2.0, -0.4, -0.01), rotation = vector3(0, 0, 47), freeze = true}, -- 
        },
    },
    ["garage_container"] = {
        label = "Vehicle Storage Container", 
        model = `prop_container_04mb`,
        freeze = true,
        noitem = true, -- does not create a inventory item
        overnight = true,
        maxPlaceDist = 10.0,
        nopickup = true,
        checklevel = true,
        policecheck = true, -- allows police to check the object ID of an placed object, allows them to query vendors for info
        container = true,
        persist = 21, -- days object will persist in database
        locks = true,
        key = true,
        cutlock = { -- locations of 'locks', aka the center of the doors on the object, the cut lock event will find the closest one
            [1] = {lock = vector3(0, -3.4, 0), stand = vector3(0, -3.9, 0)}, -- lock indicates position of lock, stand indicates where player ped will start the cut animation at
            [2] = {lock = vector3(0, 3.4, 0), stand = vector3(0, 3.9, 0)},
        },
        subentities = {
            [1] = {model = `prop_container_door_mb_l`, offset = vector3(-1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, -110), freeze = true, cutlock = 1}, -- door 1
            [2] = {model = `prop_container_door_mb_r`, offset = vector3(1.295, -3.4, 0.09), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, 110),  freeze = true, cutlock = 1}, -- door 2
            [3] = {model = `prop_container_door_mb_l`, offset = vector3(1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, -110),  freeze = true, cutlock = 2}, -- door 3
            [4] = {model = `prop_container_door_mb_r`, offset = vector3(-1.295, 3.4, 0.09), rotation = vector3(0, 0, 180), subtarget = true, open = vector3(0, 0, 110),  freeze = true, cutlock = 2}, -- door 4
        },
    },
    ["largesafe"] = {
        label = "Large Safe",
        model = `bkr_prop_biker_safebody_01a`,
        freeze = true,
        overnight = true, 
        safe = {maxweight = 100000, slots = 20, icon = "fas fa-vault", label = 'Open Safe'},
        nopickup = true,
        persist = 1000, -- days object will persist in database
        ghostoff = 1.0,
        subentities = {
            [1] = {model = `bkr_prop_biker_safedoor_01a`, offset = vector3(0.0, 0.0, -0.67), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, 30), ghostoff = 0.65, freeze = true, cutlock = 1}, -- door 1
        },
    },
    ["smallsafe"] = {
        label = "Small Safe",
        model = `ch_prop_ch_arcade_safe_body`,
        freeze = true, 
        overnight = true,
        safe = {maxweight = 50000, slots = 10, icon = "fas fa-vault", label = 'Open Safe'},
        nopickup = true,
        persist = 1000, -- days object will persist in database
        subentities = {
            [1] = {model = `ch_prop_ch_arcade_safe_door`, offset = vector3(0.0, 0.0, 0.0), rotation = vector3(0, 0, 0), subtarget = true, open = vector3(0, 0, 30), freeze = true, cutlock = 1}, -- door 1
        },
    },
}

-- this config allows you to customize the notification events that are used by the script

Config.Functions = {
    Notify = function(string, notifytype)
        QBCore.Functions.Notify(string, notifytype)
    end,
    Chat = function(args)
        TriggerEvent('chat:addMessage', args)
    end,
    ServerNotify = function(target, string, notifytype)
        TriggerClientEvent('QBCore:Notify', target, string, notifytype)
    end,
}

-- this is a job check function that can be used in place of comparing playerdata to a set name, it can also be used for a better job checking and job type checking in qb-target
-- to set it up, simply set up your job types or job names for your police and ems jobs in the LEO and EMS categories. the frist responder category will automatically combined those
-- two and allow you to give access to all your emergency service jobs

Config.AuthorizedJobs = {
    LEO = { -- this is for job checks which should only return true for police officers
        Jobs = {['police'] = true, ['fib'] = true},
        Types = {['police'] = true, ['leo'] = true},
        Check = function(source)
            local PlyData = nil
            if source and QBCore.Functions.GetPlayer then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end
    },
    EMS = { -- this if for job checks which should only return true for ems workers
        Jobs = {['ambulance'] = true, ['fire'] = true},
        Types = {['ambulance'] = true, ['fire'] = true, ['ems'] = true},
        Check = function(source)
            local PlyData = nil
            if source and QBCore.Functions.GetPlayer then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.EMS.Jobs[job] or Config.AuthorizedJobs.EMS.Types[jobtype] then return true end
        end
    },
    FirstResponder = { -- do not touch, this is a combined job checking function for emergency services (police and ems)
        Check = function(source)
            local PlyData = nil
            if source and QBCore.Functions.GetPlayer then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype = PlyData.job.name, PlyData.job.type

            if Config.AuthorizedJobs.LEO.Check() or Config.AuthorizedJobs.EMS.Check() then return true end            
        end
    },
    Frisk = { -- this is for configuring the frisk job check, you can enable it for all civlians, or specific jobs
        All = false, -- set this to true if you want everyone to have access to frisk
        Jobs = {['police'] = true, ['fib'] = true, ['sheriff'] = true, ['ambulance'] = {['1'] = true, ['2'] = true,},}, -- you can add a rank table here to give the option to only specific job ranks, like bounchers
        Types = {['police'] = true, ['leo'] = true},
        Check = function(source)
            local PlyData = nil
            if source and QBCore.Functions.GetPlayer then PlyData = QBCore.Functions.GetPlayer(source) if PlyData then PlyData = PlyData.PlayerData else return end else PlyData = QBCore.Functions.GetPlayerData() end

            local job, jobtype, rank = PlyData.job.name, PlyData.job.type, tostring(PlyData.job.grade.level)

            if Config.AuthorizedJobs.Frisk.All then return true end
            if type(Config.AuthorizedJobs.Frisk.Jobs[job]) == 'table' then if Config.AuthorizedJobs.Frisk.Jobs[job][rank] then return true end end
            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end,
    }
}
