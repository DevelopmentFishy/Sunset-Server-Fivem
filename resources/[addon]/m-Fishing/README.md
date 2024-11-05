# m-Fishing script for QB-Core

| If you are intested in recieving updates join the community on **[Discord](https://discord.gg/marcinhu)**! |

# About:

- Highly Optimized
- Many Features
- Full and easy customization
- 0.00ms
- Drops configured for each fishing rod
- Drops configured for each fishing net
- Compatible with qb/ox target
- Compatible with qb/ox inventory
- Compatible with qb/ox menu
- Compatible with qb/qs/renewed vehicle keys
- Minigame on normal fishing. ( optional )
- Configurable zones with radius, type of zone
- Experience system
- Boats are rented depending on the experience of the player
- Custom fishingrod props
- Custom fishingnet props
- Custom shell's props
- Custom coral's props
- Illegal bait can only be obtained with a specific fish.
- Illegal bait can only be created in illegal zones. ( optional )
- Minigame on creating illegal bait. ( optional )
- Webhooks on all events server-side
- Crafting system to upgrade the fishingnet / fishingrod.
- Protected server-side events.
- Treasure chests
- Fishing license
- Fishing tournaments
- Illegal selling corals
- Illegal fishing
- 47 new items

# How the script works:

**Fishing Rod (config_fishingrod.lua):**
- Configurable drops for each level
- Configurable amount for each drop for each level
- Configurable props for each level
- Configurable progress bar time for each level
- Configurable zones and their radius
- Each zone can be chosen as "legal," "illegal," or "all"
- Configurable animations

**Fishing Net (config_fishingnet.lua):**
- Configurable drops for each level
- Configurable amount for each drop for each level
- Configurable props for each level
- Configurable progress bar time for each level
- Configurable zones with radius and associated blip
- Ability to activate the running net and the chance of it happening
- Listing of props for the fish that appear in the net
- Configurable animations

**Seashell Harvesting (config_seashell.lua):**
- Configurable animations
- 15 predefined locations
- Configurable progress bar time
- Configurable props for each location
- Configurable list of drops
- Configurable the items for selling
- Configurable blips, peds

**Fishing Tournaments (config_tournament.lua):**
- Configurable maximum number of participants
- Configurable entry time for tournament participation
- Configurable payment type "cash" or "bank"
- Configurable bait type "legal" or "illegal"
- Configurable commands and their permissions
- Configurable blips
- List of fish that can be caught when participating in a tournament
- Configurable requirements when creating a tournament

**Upgrades (config_upgrades.lua):**
- Ability to change the required items for each upgrade
- Configurable names

**General (config.lua):**
- Configurable qb-core name
- Configurable display as "target" or "showHelpText"
- Configurable inventory for "qb," "ox," and "qs"
- Configurable help text for "qb" or "ox"
- Configurable emote menu "rp" or "dp"
- Configurable vehicle keys for "qb" or "qs"
- Configurable dispatch for 'ps-dispatch' -- "ps-dispatch" or "cd_dispatch" or "qs-dispatch"
- Configurable fuel for "LegacyFuel" or "okokFuel" or "ox_fuel" or "ti_fuel" or "qs-fuel"
- Configurable notify for "qb" or "okok" or "ox"
- Enable/disable the minigame ("ps-ui" or "bl_ui" or "ox_lib")
- Enable/disable debug system
- Blips for Fishing Shop, Selling Items, and Renting Boats
- Configurable fish selling with minimum and maximum prices
- Configurable boat rentals based on player experience
- Configurable experience gain for legal fishing, illegal fishing, or fishing with a net
  - Illegal Bait:
    - Possibility to activate a mini-game
    - Possibility to only create it in illegal zones
    - Configurable required item
    - Configurable creation time
    - Configurable fish required for creation
    - Configurable amount received for illegal bait per fish
- Configurable cooking items
    - Option to change the items for players cooking
    - Amount receive after cooking
- Configurable usable items cooking
    - Item used to consume
    - Effects for each item
    - Values of the effect for each item
- Configurable trasure opening
    - Reward items list

**Diving Fishing (config_diving.lua):**
- Configurable mask model
- Configurable oxygen tank model
- Configurable animation for when the player searches corals
- Configurable ped, zone, and sell locations
- Configurable each coral price selling
- Configurable animations when player collect a coral
- Configurable chance to get a trasure chest
- Enable/disable treasure chests and the chance of it happening
- Unlimited locations with defined props for each location and rewards

**Other Things:**
- *File sv_utils.lua:*
    - Configurable webhooks in the file
    - Event to provide experience to the player
    - Open functions:
        - Get Player
        - Has Item
        - Register Usable Item
        - Add Item
        - Remove Item
        - Add Money
        - Remove Money
- *File cl_utils.lua:*
    - Upgrades function
    - Sell Fishing function
    - Sell Seashell function
    - Sell Corals function
    - Tournament menu
- *File config_functions.lua*
    - Customizable Notify function
    - Customizable GiveKeys function
    - Customizable SetFuel function
    - Customizable SendHelpText function
    - Customizable RemoveHelpText function
    - Customizable OpenFishingShop function
    - Customizable StartMinigame function
    - Customizable StartAnimation function
    - Customizable CallCops function
    

# Required:

You need to SetUp `fishing.sql`. Basically click on the file and run it using HeidSQL.


# Installation:

1. qb-core/shared/items.lua

```lua

    -- Fishing rods
    ['fishingrod1']          = {['name'] = 'fishingrod1',           ['label'] = 'Fishingrod Level 1',       ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishingrod1.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},
    ['fishingrod2']          = {['name'] = 'fishingrod2',           ['label'] = 'Fishingrod Level 2',       ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishingrod2.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},
    ['fishingrod3']          = {['name'] = 'fishingrod3',           ['label'] = 'Fishingrod Level 3',       ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishingrod3.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},
    ['fishingrod4']          = {['name'] = 'fishingrod4',           ['label'] = 'Fishingrod Level 4',       ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishingrod4.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},
    ['fishingrod5']          = {['name'] = 'fishingrod5',           ['label'] = 'Fishingrod Level 5',       ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishingrod5.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},
    
    -- Fishing nets
    ['fishnet1']             = {['name'] = 'fishnet1',              ['label'] = 'Fishing net Nivel 1',      ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishnet1.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},  
    ['fishnet2']             = {['name'] = 'fishnet2',              ['label'] = 'Fishing net Nivel 2',      ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishnet2.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},  
    ['fishnet3']             = {['name'] = 'fishnet3',              ['label'] = 'Fishing net Nivel 3',      ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishnet3.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},  
    ['fishnet4']             = {['name'] = 'fishnet4',              ['label'] = 'Fishing net Nivel 4',      ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishnet4.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},  
    ['fishnet5']             = {['name'] = 'fishnet5',              ['label'] = 'Fishing net Nivel 5',      ['weight'] = 1000,   ['type'] = 'item',    ['image'] = 'fishnet5.png',              ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = ''},  

    -- Regular Fish
    ['mackerel']             = {['name'] = 'mackerel',              ['label'] = 'Mackerel',                 ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'mackerel.png',         ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['cod']                  = {['name'] = 'cod',                   ['label'] = 'Cod',                      ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'cod.png',              ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['seabass']              = {['name'] = 'seabass',               ['label'] = 'Sea Bass',                 ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'seabass.png',          ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['sole']                 = {['name'] = 'sole',                  ['label'] = 'Sole',                     ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'sole.png',             ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['stingray']             = {['name'] = 'stingray',              ['label'] = 'Stingray',                 ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'stingray.png',         ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['salmon']               = {['name'] = 'salmon',                ['label'] = 'Salmon',                   ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'salmon.png',           ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['tunafish']             = {['name'] = 'tunafish',              ['label'] = 'Tuna fish',                ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'tunafish.png',         ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['sardine']              = {['name'] = 'sardine',               ['label'] = 'Sardine',                  ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'sardine.png',          ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ['catfish']              = {['name'] = 'catfish',               ['label'] = 'Catfish',                  ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'catfish.png',          ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
    ["monkfish"]             = {['name'] = "monkfish",              ['label'] = 'Monkfish',                 ['weight'] = 25,      ['type'] = 'item',        ['image'] = 'monkfish.png',         ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},

    -- Trash Items
    ['fishingtin']           = {['name'] = 'fishingtin',            ['label'] = 'Fishing Tin',              ['weight'] = 2500,    ['type'] = 'item',        ['image'] = 'fishingtin.png',       ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},   
    ['fishingboot']          = {['name'] = 'fishingboot',           ['label'] = 'Fishing Boot',             ['weight'] = 2500,    ['type'] = 'item',        ['image'] = 'fishingboot.png',      ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},  
    
    -- Exotic Fish
    ['dolphin']              = {['name'] = 'dolphin',               ['label'] = 'Dolphin',                  ['weight'] = 15000,   ['type'] = 'item',        ['image'] = 'dolphin.png',          ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},  
    ['tigershark']           = {['name'] = 'tigershark',            ['label'] = 'Tiger shark',              ['weight'] = 5000,    ['type'] = 'item',        ['image'] = 'tigershark.png',       ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},
    ['hammershark']          = {['name'] = 'hammershark',           ['label'] = 'Hammer shark',             ['weight'] = 5000,    ['type'] = 'item',        ['image'] = 'hammershark.png',      ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},
    ['whale']                = {['name'] = 'whale',                 ['label'] = 'Whale',                    ['weight'] = 5000,    ['type'] = 'item',        ['image'] = 'whale.png',            ['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,    ['description'] = ''},
    
    -- Gear
    ['fishbait']             = {['name'] = 'fishbait',              ['label'] = 'Fish Bait',                ['weight'] = 400,     ['type'] = 'item',        ['image'] = 'fishbait.png',         ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},
    ['illegalfishbait']      = {['name'] = 'illegalfishbait',       ['label'] = 'Illegal Fish Bait',        ['weight'] = 400,     ['type'] = 'item',        ['image'] = 'illegalfishbait.png',  ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},
    ['anchor']               = {['name'] = 'anchor',                ['label'] = 'Boat Anchor',              ['weight'] = 2500,    ['type'] = 'item',        ['image'] = 'anchor.png',           ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},   
    ['diving_gear']          = {['name'] = 'diving_gear',           ['label'] = 'Diving Gear',              ['weight'] = 30000,   ['type'] = 'item',        ['image'] = 'diving_gear.png',      ['unique'] = true,      ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},
    ['diving_fill']          = {['name'] = 'diving_fill',           ['label'] = 'Diving Tube',              ['weight'] = 3000,    ['type'] = 'item',        ['image'] = 'diving_tube.png',      ['unique'] = true,      ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['discription'] = ''},
   
    -- Rewards,    
    ['treasurechest']        = {['name'] = 'treasurechest',         ['label'] = 'Treasure Chest',           ['weight'] = 2500,    ['type'] = 'item',        ['image'] = 'treasurechest.png',    ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''}, 
    ['fishingkey']           = {['name'] = 'fishingkey',            ['label'] = 'Corroded Key',             ['weight'] = 100,     ['type'] = 'item',        ['image'] = 'fishingkey.png',       ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},   

    -- Cooking 
    ['bonfire']              = {['name'] = 'bonfire',               ['label'] = 'Campfire',                 ['weight'] = 20,      ['type'] = 'item',        ['image'] = 'bonfire.png',          ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},  
    ['cookedcod']            = {['name'] = 'cookedcod',             ['label'] = 'Cooked Cod',               ['weight'] = 20,      ['type'] = 'item',        ['image'] = 'cookedcod.png',        ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},  
    ['cookedmackerel']       = {['name'] = 'cookedmackerel',        ['label'] = 'Cooked Mackerel',          ['weight'] = 20,      ['type'] = 'item',        ['image'] = 'cookedmackerel.png',   ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,    ['description'] = ''},     
    
    -- Seashells
    ["conch"]                = {["name"] = "conch",                 ["label"] = "Conch",                    ["weight"] = 500,      ["type"] = "item",       ["image"] = "conch.png",            ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["sea_snail"]            = {["name"] = "sea_snail",             ["label"] = "Sea Snail",                ["weight"] = 500,      ["type"] = "item",       ["image"] = "sea_snail.png",        ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["shell"]                = {["name"] = "shell",                 ["label"] = "Shell",                    ["weight"] = 500,      ["type"] = "item",       ["image"] = "shell.png",            ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["conch_shell"]              = {["name"] = "conch_shell",               ["label"] = "Shell",                    ["weight"] = 500,      ["type"] = "item",       ["image"] = "conch_shell.png",          ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["starfish"]             = {["name"] = "starfish",              ["label"] = "Starfish",                 ["weight"] = 500,      ["type"] = "item",       ["image"] = "starfish.png",         ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["knife"]                = {["name"] = "knife",                 ["label"] = "Knife",                    ["weight"] = 500,      ["type"] = "item",       ["image"] = "knife.png",            ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},

    -- Coral
    ["red_coral"]            = {["name"] = "red_coral",             ["label"] = "Red Coral",                ["weight"] = 500,      ["type"] = "item",       ["image"] = "red_coral.png",        ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["yellow_coral"]         = {["name"] = "yellow_coral",          ["label"] = "Yellow Coral",             ["weight"] = 500,      ["type"] = "item",       ["image"] = "yellow_coral.png",     ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["blue_coral"]           = {["name"] = "blue_coral",            ["label"] = "Blue Coral",               ["weight"] = 500,      ["type"] = "item",       ["image"] = "blue_coral.png",       ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["pink_coral"]           = {["name"] = "pink_coral",            ["label"] = "Pink Coral",               ["weight"] = 500,      ["type"] = "item",       ["image"] = "pink_coral.png",       ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["white_coral"]          = {["name"] = "white_coral",           ["label"] = "White Coral",              ["weight"] = 500,      ["type"] = "item",       ["image"] = "white_coral.png",      ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["green_coral"]          = {["name"] = "green_coral",           ["label"] = "Green Coral",              ["weight"] = 500,      ["type"] = "item",       ["image"] = "green_coral.png",      ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},
    ["babyblue_coral"]       = {["name"] = "babyblue_coral",        ["label"] = "Baby Blue Coral",          ["weight"] = 500,      ["type"] = "item",       ["image"] = "babyblue_coral.png",   ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,     ["combinable"] = nil,   ["description"] = ""},

```

