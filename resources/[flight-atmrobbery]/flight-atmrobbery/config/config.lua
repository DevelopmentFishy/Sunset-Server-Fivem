Loc = {}
Config = Config or {}
AtmConfig = AtmConfig or {}


Config = {
    ExploitZones = true, -- exploit check box zone (Disable if causing polyzone issues)
    Framework = 'qb-core', -- 'qb-core' or 'esx' or 'standalone'
    Core = {resource = "qb-core", name = "QBCore", abbrev = "qb"}, -- (QBCore Only) If you arent using qb-core no need to change anything here
    EmoteMenu = "rpemotes", -- "dpemotes" or "rpemotes" or "scully", if you arent using any of these emote menus, put it as "other" and you will need to edit the emote export function, or open a ticket on discord.
    Inventory = "qb", -- "ox" or "qs" or "qb" or "esx" or "lj" or "ps", if you arent using any of these inventories, put it as "other" and you will need to edit the inventory export function, or open a ticket on discord.
    DispatchSystem = "ps", -- "ps" or "cd" or "qs", if you arent using any of these dispatch systems, put it as "other" and you will need to edit the dispatch export function, or open a ticket on discord.
    Target = 'qb-target', -- Change if you have a different named Target, if you use ox_target leave it as qb-target

    DiscordLogStatus = false, -- Choose whether u want to turn on discord logs or not, you need to add a webhook below for it to work
    -- To add your webhook go to opensource -> server, line 1 and add your webhook there

    Lan = "en", -- Pick your language here
    Debug = false,

    DrillWithTarget = true, -- Drill with target, if you set it to false, the drill will act as a useable item.
    EnableParticles = true, -- Enable particles when drilling the atm

    DeleteAtmsOnRestart = false, -- Determine if you want to delete the atms placed on the ground after restarts or not
    Resource = 1000, -- At 1000, the script runs at 0.00ms, makes the rope load slower on the player's hand/// At 1, the script runs at 0.07ms, makes the rope load constantly on the player's hand
    AtmWeightWhenBeingDragged = 170.0, -- Weight of the atm when being dragged with a car (Lowering it causes the atm to weigh down the car less)
    print = false, -- prints atm locations that are placed down for admins
    Cooldown = 30, -- Cooldown for atm robberies in minutes [0 for no cooldown]
    CooldownPlace = 'drill', -- 'drill' for cooldown initiation when drilling //// 'rope' for cooldown initiation when attaching the rope to the car

    MinimumAtmRobberyPolice = 2, -- How many cops are required to be online to start the atm robbery, 0 = no cops needed
    Job = "all", -- Which job is allowed to rob atms. "all" is for all jobs/or unemployeed
    RopeDisappear = false, -- removes rope from the player's inventory when they pick up the ATM.
    RopeCancelButton = 'X', -- Remove rope from hand default
    DrillDistance = 1, -- how far away they can third eye the atm to drill it, prefereably kept at a low distance around "1" to look realistic
    DestroyATMStatus = true, -- Choose whether u want to display the destroy atm option or not

    -- Icons
    PickupIcon = "fas fa-wrench", -- Icon for picking up the ATM from the ground
    RemovePanelIcon = "fas fa-wrench", -- Icon for removing the panel (1st step)
    RemoveCablesIcon = "fas fa-scissors", -- Icon for removing the cables (2nd step)
    RemoveMotherboardIcon = "fas fa-wrench", -- Icon for removing the motherboard (3rd step)
    TakeCashIcon = "fas fa-hand-holding-dollar", -- Icon for taking the cash from the atm
    DeleteAtmIcon = "fas fa-trash-can", -- Icon for delete the atm entity
    DrillIcon = "fas fa-power-off", -- Icon for drilling the atm

    -- Animations
    Animations = {
        Clear = "c", -- Clear animations
        StepOne = "mechanic4", -- First step Animation
        StepTwo = "mechanic4", -- Second step Animation
        StepThree = "mechanic4", -- Third step Animation
        StepFour = "mechanic4", -- Forth step Animation
        MiniGame = "mechanic", -- Minigame Animation
        CarRope = 'mechanic4', -- Rope animation
        AtmRope = 'mechanic4', -- Atm pickup animation
        AtmPickup = 'mechanic4', -- Atm pickup animation
        PlaceAtm = 'weld', -- Atm placing animation
    },

    -- Durations
    PlaceAtmDuration = 5000, -- Duration needed to place down the atm
    ProgressBarDuration = 5000, -- Progress bar duration during cracking steps
    NotifcationsDurations = 5000, -- Duarations of all notifications, success/errors
    AtmPickUpTime = 5000, -- How long it takes to pick up the atm from the ground
    DurationToRemoveAtm = {min = 40000, max = 50000}, -- How long it takes to remove the ATM from the wall(Preferably more than 40 seconds so cops can have a chance)
    RopeAttachmentTime = 5000, -- How long it takes to attach ropes to the car and atm
    RopeDrillingTime = 5000, -- Time needed for the drill animation to finish
    
    MinimumTime = 12, -- Minimum robbery time (clock)
    MaximumTime = 8, -- Maximum robbery time (clock)
}

Config.Dispatch = { -- When do you want the dispatch notification to be sent
    Chance = 100, -- (Only works on CrackFail) Chance of the dispatch notification being sent from the below settings (100 = 100%)
    Drill = true, -- When a player is drilling the atm
    PullingAtm = false, -- When a player is pulling the atm from the wall
    CrackFail = true, -- Everytime a player fails at the minigame while cracking
}

AtmConfig.Settings = {
    ['Atms'] = {
        ['Atmred'] = {
            ['Prop'] = 'flight_atm_03', -- Prop of the atm 
            ['ItemName'] = 'atmred', -- Item to use to place atm.
        },
        ['Atmblue'] = {
            ['Prop'] = 'flight_atm_02', -- Prop of the atm
            ['ItemName'] = 'atmblue', -- Item to use to place atm.
        },
        ['Atmgreen'] = {
            ['Prop'] = 'flight_fleeca_atm', -- Prop of the atm
            ['ItemName'] = 'atmgreen', -- Item to use to place atm.
        },
    }
}

AtmConfig.RemoveItems = true -- Removes step items after each step, false = to not remove -- "Can use items for other purposes if u want, pawnshop, crafting..."

AtmConfig.Rewards = { -- Atm step requirements and rewards
    ['FirstStep'] = {
        ['RewardName'] = 'atmpanel',
        ['RewardAmount'] = 1,
        ['ToolName'] = 'blowtorch', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
    ['SecondStep'] = {
        ['RewardName'] = 'atmcables',
        ['RewardAmount'] = 1,
        ['ToolName'] = 'atmpanel', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
    ['ThirdStep'] = {
        ['RewardName'] = 'atmmotherboard',
        ['RewardAmount'] = 1,
        ['ToolName'] = 'atmcables', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
}

AtmConfig.Items = { -- Items list used
    Rope = "nylonrope", -- Rope name
    Drill = "laserdrill", -- Laser drill name
    ToolOne = "screwdriverset", -- This won't be removed after cracking
    ToolTwo = "blowtorch", -- This will be removed after cracking
    StepOne = "atmpanel", -- First step item reward name
    StepTwo = "atmcables", -- Second step item reward name
    StepThree = "atmmotherboard", -- Third step item reward name
}

AtmConfig.Cash = {
    ['OnPickUp'] = {
        ['ItemForCash'] = true, -- set this to true to use a cash "item", or keep it false to use normal cash
        ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
        ['CashItem'] = "geldrol", -- Item you want to use for cash (['ItemForCash'] = true)
        ['CashAmount'] = {min = 20000, max = 25000}, -- Cash that is recieved from robbing the atm
        ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
    },
}

AtmConfig.CashTime = 10000 -- How long until the atm eats the cash (Atm will not disappear if no time is set)

Config.Jackpot = { -- Jackpot atms, allowing players to have a small chance of getting rewarded a bigger reward
    Status = true, -- Allow jackpot atms, or not
    Chance = 10, -- Edit this if needed, each number corresponds to a percentage chance, 5 = 5%
    Multiplier = 2, -- Multiplier for cash reward amount
    min = 1, -- Chance, you shouldn't edit this
    max = 100, -- Chance, you shouldn't edit this
}

Config.Vehicles = { -- black listed vehicles from robbing the atms, commented out numbers are the white listed cars, 
    0, -- Compacts 
    1, -- Sedans
    -- 2, -- SUVs (Example: This is White Listed)
    3, -- Coupes (Example: This is Black Listed)
    -- 4, -- Muscle
    5, -- Sports Classics
    -- 6, -- Sports
    7, -- Super
    8, -- Motorcycles
    -- 9, -- Off-road
    -- 10, -- Industrials
    -- 11, -- Utility
    -- 12, -- Vans
    13, -- Cycles
    14, -- Boats
    15, -- Helicopters
    16, -- Planes
    17, -- Service 
    18, -- Emergency
    -- 19, -- Military
    -- 20, -- Commercial  
    21, -- Trains  
    22, -- Open Wheel
}

Config.RopeCheck = false
Config.RopeCheck2 = false