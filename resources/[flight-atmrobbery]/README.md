# Flight Atm Robbery

[QB/ESX/Standalone] Flight Atm Robbery - Flight Development

## Links

[Discord](https://discord.gg/dXzkPaRaq3)
[Tebex](https://fivem.flightdev.co)

## Features

- Optimized: runs at 0.00ms (Resmon)
- Support available on discord (Open a ticket)
- Supports [QB/ESX/Standalone] Frameworks
- Supports Skills systems (EXP)
- Supports All emote menus
- Supports Ox_target and Ox_inventory
- Supports discord logs

- QBCore and ESX ready templates
- Full translation available
- Detailed README on how to install
- Exploitation protected, players can't do steps at the same time
- Players can't start another step if they are currently doing one
- Atms props/ Atms on the wall/ Stolen Atms / Rope are all synced for everyone
- Can add a cooldown for atm robberies
- Custom Atm props when pulled
- Custom Atm frames props (stays on the wall)
- Completely customizable minigames, can change each step seperately
- Atms get pulled by a rope attached to a vehicle
- Atms act as an object that can be pulled around with a rope
- Atms placed are saved after restart (Configurable)
- Change Core name
- Change Target name
- Police alert
- Drill animation/sound/effects
- Atms steps are synced through SQL for everyone, meaning people can do steps together
- Atms can’t be robbed more than once per restart
- When placing down an Atm, you get to navigate how and where you want to place it
- Choose which vehicles can rob the Atms (Ex: only heavy vehicles)
- Completely customizable items/durations/animations/rewards
- Ability for players/cops to destroy the Atm (to stop criminals from cracking them)
- Chance for players to find jackpot atms (multiplied money, configurable)

- Everything framework related is opensource:
    Client:
        - Police dispatch
        - Function that is triggerd when an atm is robbed (Ex: add EXP)
        - Seperate minigame for each step for customizability
        - Exploit Zone creation/destruction
        - Progressbar
        - Emote execution
        - Several Framework functions
        - How police count is calculated
        - Item check
        - Notification
        - Command

    Server:
        - Creation of useable items
        - Adding items
        - Removing items
        - Item box
        - Adding money
        - Server side notifications
        - Discord log
        - Discord log for cash gained
        - On player loaded event

## Config features

- Change framework and core names
- Change target and target names
- Change translation
- Debug mode
- Choose wether the drill is a useable item or target
- Choose wether you want the placed ATMs to get deleted on restarts
- Ability(On/Off) to print for admins the ATM coords that were placed
- Change the cooldown
- Change where cooldown initiates
- Change required job
- Choose if the rope gets destroyed on use
- Choose if the atm parts get destroyed in steps
- Change the botton that cancels the rope
- Change drilling distance
- Change Icons/Animations/Durations
- Change the timeframe for robberies
- Choose if a police alert is sent for failed cracking
- Change item names used
- Choose amount of money gained
- Choose chance and amount of money gained from jackpot ATMs
- Choose which vehicles are Blacklisted/Whitelisted

## Dependencies

[ox_lib](https://github.com/overextended/ox_lib) (Drag and drop)
[ps-ui](https://github.com/Project-Sloth/ps-ui) (If you wanna use the default minigame)
[Target] qb-target/ox_target

## Installation

## (ESX only) add items through the SQL provided

### Edit the fxmanifest.lua

- (QBCore) Nothing needs to be changed

- (ESX) Remove the double dashes (--) that are before:
    '@es_extended/imports.lua'
    'opensource/client/client_esx.lua'
    'opensource/server/server_esx.lua'

    Add double dashes (--) before:
    'opensource/client/client_qbcore.lua'
    'opensource/server/server_qbcore.lua'

- (Standalone) Remove the double dashes (--) that are before:
    'opensource/client/client_standalone.lua'
    'opensource/server/server_standalone.lua'

    Add double dashes (--) before:
    'opensource/client/client_qbcore.lua'
    'opensource/server/server_qbcore.lua

### (QBCore or others) Items to add in qb-core/shared/items.lua on the bottom of the list

-- Atm Robbery

```lua
 ['nylonrope']        = {['name'] = 'nylonrope',      ['label'] = 'Nylon Rope',     ['weight'] = 500,   ['type'] = 'item',   ['image'] = 'nylonrope.png',    ['unique'] = false,  ['useable'] = true,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'The strongest rope material..'},
 ['atmred']         = {['name'] = 'atmred',       ['label'] = 'Red Atm',      ['weight'] = 25000,  ['type'] = 'item',   ['image'] = 'atmred.png',     ['unique'] = true,   ['useable'] = true,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A console of an ATM'},
 ['atmblue']          = {['name'] = 'atmblue',       ['label'] = 'Blue Atm',     ['weight'] = 25000,  ['type'] = 'item',   ['image'] = 'atmblue.png',     ['unique'] = true,   ['useable'] = true,  ['shouldClose'] = true,    ["combinable"] = nil,   ['description'] = 'A console of an ATM'},
 ['atmgreen']        = {['name'] = 'atmgreen',       ['label'] = 'Green Atm',     ['weight'] = 25000,  ['type'] = 'item',   ['image'] = 'atmgreen.png',    ['unique'] = true,   ['useable'] = true,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A console of an ATM'},
 ['atmpanel']        = {['name'] = 'atmpanel',       ['label'] = 'Atm Panel',     ['weight'] = 5000,   ['type'] = 'item',   ['image'] = 'atmpanel.png',    ['unique'] = true,   ['useable'] = false,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A back panel for an ATM'},
 ['atmcables']        = {['name'] = 'atmcables',      ['label'] = 'Atm Cables',     ['weight'] = 2000,   ['type'] = 'item',   ['image'] = 'atmcables.png',    ['unique'] = true,   ['useable'] = false,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Cables..'},
 ['atmmotherboard']       = {['name'] = 'atmmotherboard',     ['label'] = 'Atm Motherboard',    ['weight'] = 2000,   ['type'] = 'item',   ['image'] = 'atmmotherboard.png',   ['unique'] = true,   ['useable'] = false,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A motherboard for an ATM'},
 ['blowtorch']        = {['name'] = 'blowtorch',      ['label'] = 'Blow Torch',     ['weight'] = 1000,   ['type'] = 'item',   ['image'] = 'blowtorch.png',    ['unique'] = true,   ['useable'] = false,  ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Ooo hot..'},
 ["laserdrill"]        = {["name"] = "laserdrill",          ["label"] = "Laser Drill",     ["weight"] = 1000,   ["type"] = "item",   ["image"] = "laserdrill.png",    ["unique"] = true,   ["useable"] = true,  ["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "" },

```

### (Ox_inventory item list)

```lua
    ['nylonrope'] = {
        label = 'Nylon Rope',
        description = 'The strongest rope material..',
        weight = 125,
        close = true,
        stack = true,
        client = {
   image = "nylonrope.png",
  }
    },
    ['atmred'] = {
        label = 'Red ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
   image = "atmred.png",
  }
    },
    ['atmblue'] = {
        label = 'Blue ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
   image = "atmblue.png",
  }
    },
    ['atmgreen'] = {
        label = 'Green ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
   image = "atmgreen.png",
  }
    },
    ['atmpanel'] = {
        label = 'ATM Panel',
        description = 'A back panel from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
   image = "atmpanel.png",
  }
    },
    ['atmcables'] = {
        label = 'ATM Cables',
        description = 'Cables from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
   image = "atmcables.png",
  }
    },
    ['atmmotherboard'] = {
        label = 'ATM Motherboard',
        description = 'A motherboard from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
   image = "atmmotherboard.png",
  }
    },
    ['blowtorch'] = {
        label = 'Blow Torch',
        description = 'Ooo hot...',
        weight = 125,
        close = true,
        stack = false,
        client = {
   image = "blowtorch.png",
  }
    },
    ['laserdrill'] = {
        label = 'Laser Drill',
        description = 'I wonder what this does...',
        weight = 125,
        close = true,
        stack = false,
        client = {
   image = "laserdrill.png",
  }
    },
    ['screwdriverset'] = {
        label = 'Screwdriverset',
        description = 'A Screw driver set',
        weight = 50,
        close = true,
        stack = false,
        client = {
   image = "screwdriverset.png",
  }
    },
```

### Add this to server.cfg

```lua
ensure ox_lib -- (if thats the first time you download ox_lib this should be added right above your framework's ensure)
ensure [flight-atmrobbery]
```

### Add this to Renewed-Weaponscarry in the client file (Optional, **Not Required**)

[Renewed-Weaponscarry](https://github.com/Renewed-Scripts/Renewed-Weaponscarry)

```lua
    ["atmred"] =  { carry = true, model = "flight_atm_03", bone = 28422, x = 0.01, y = -0.22, z = -0.8, xr = 0.0,
    yr = 0.0, zr = 0.0, blockAttack = true, blockCar = false, blockRun = true},
    ["atmblue"] =  { carry = true, model = "flight_atm_02", bone = 28422, x = 0.01, y = -0.22, z = -0.8, xr = 0.0,
    yr = 0.0, zr = 0.0, blockAttack = true, blockCar = false, blockRun = true},
    ["atmgreen"] =  { carry = true, model = "flight_fleeca_atm", bone = 28422, x = 0.01, y = -0.22, z = -0.8, xr = 0.0,
    yr = 0.0, zr = 0.0, blockAttack = true, blockCar = false, blockRun = true},
```

```lua
    ['atmred'] = {
        model = 'flight_atm_03',
        bone = 28422,
        offset = vec3(0.01, -0.22, -0.8),
        rotation = vec3(0.0, 0.0, 0.0),
        blockAttack = true,
        blockCar = true,
        blockRun = true
    },
    ['atmblue'] = {
        model = 'flight_atm_02',
        bone = 28422,
        offset = vec3(0.01, -0.22, -0.8),
        rotation = vec3(0.0, 0.0, 0.0),
        blockAttack = true,
        blockCar = true,
        blockRun = true
    },
    ['atmgreen'] = {
        model = 'flight_fleeca_atm',
        bone = 28422,
        offset = vec3(0.01, -0.22, -0.8),
        rotation = vec3(0.0, 0.0, 0.0),
        blockAttack = true,
        blockCar = true,
        blockRun = true
    },
```

```lua
    Renewed-Weaponscarry runs at 0.04ms in the resource monitor, you can change the Wait()
    for the loop where he is carrying the prop in their client file. Wait(1) Doesnt allow the
    player to run around with the prop in hand, If you change to Wait(50), the player will be
    able to run around with the prop in hand, but also runs at 0.00ms
```

[Where to change the Wait()](https://i.imgur.com/3OnYdxO.png)
