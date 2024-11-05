Config = {}
Config.newQBFramework = false -- true if you have a new qbcore with type in the shared jobs.
-----------------------------------------------------------------------------------------------------------------------------------
Config.MaxPlayers = 64 -- the max players you can have on your server.
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.Command = "scoreboard" -- to open the scoreboard or HOME
-----------------------------------------------------------------------------------------------------------------------------------
Config.Notify = "qb-core" -- Default:(qb-core), you can also use (roda-notify/okokNotify)
Config.NotifyTitle = "Scoreboard" -- us used for other notify system than qb-core (dont change it)
-----------------------------------------------------------------------------------------------------------------------------------
-- show or not show admin ids, 
-- set use the trigger to set this to false if you go in spectate mode, 
-- if you dont set this false players are able to see your id in the air
Config.ShowAdminIds = false
Config.ShowWhowIsAdminOrGod = false
-----------------------------------------------------------------------------------------------------------------------------------
Config.Lang = {
    ['logo'] = "assets/images/logo.png", -- put here your logo (make sure it's 100px/100px not above, you can use a url, but make sure its a `https://`)
    -- don't change anything below, edit the language file in locales folder.
    ['server_info'] = Lang:t('label.server_info'),
    ['title_robbery'] = Lang:t('label.title_robbery'),
    ['title_status'] = Lang:t('label.title_status'),
    ['title_jobs'] = Lang:t('label.title_jobs'),
    ['title_active'] = Lang:t('label.title_active'),
    ['title_players'] = "🧑🏽‍🤝‍🧑🏻 | "..Lang:t('label.title_players'),
    ['no'] = Lang:t('label.no'),
    ['yes'] = Lang:t('label.yes'),
}
-----------------------------------------------------------------------------------------------------------------------------------
-- put all your other mechanic jobs here.
-- NOTE Do not add the `mechanic` job here.
-- the jobs below will be count with the mechanic job.
Config.MechanicsJobs = {
    ['fastcustoms'],
}
-----------------------------------------------------------------------------------------------------------------------------------
-- all jobs you have in the city with translation and icone
-- if you dont have a job in this list then set `active` to `false`.
-- dont change the `names` cause this are not the `names` that is showing on the screen.
-- the `label` thats what is showed on the screen.
Config.Jobs = {
    ['police']         = {name = 'police',         label = Lang:t('label.police'),         count = 0, active = true, icon = "👮"}, -- if you have the new qbcore change the first police to "leo"
    ['ambulance']      = {name = 'ambulance',      label = Lang:t('label.ambulance'),      count = 0, active = true, icon = "🚑"},
    ['mechanic']       = {name = 'mechanic',       label = Lang:t('label.mechanic'),       count = 0, active = true, icon = "👨‍🔧"},
    ['cardealer']      = {name = 'cardealer',      label = Lang:t('label.cardealer'),      count = 0, active = true, icon = "🤵"},
    ['realestate']     = {name = 'realestate',     label = Lang:t('label.realestate'),     count = 0, active = true, icon = "👨‍💼"},
    ['catcafe']         = {name = 'catcafe',    label = Lang:t('label.beanmachine'),    count = 0, active = true, icon = "😻"},
    ['upnatoms'] = {name = 'upnatom', label = Lang:t('label.drivingteacher'), count = 0, active = true, icon = "👨‍🍳"},
    ['lawyer'] = {name = 'lawyer', label = Lang:t('label.lawyer'), count = 0, active = true, icon = "👨‍⚖️"},
}
-----------------------------------------------------------------------------------------------------------------------------------
-- Minimum ops for illegal actions with translation and icone
-- you can change the `minimim` to your needs, you can also change the `icon`
-- if you dont have a job just jest `active` to `false`
Config.IllegalActions = {
    ["storerobbery"] = {label = Lang:t('illegal_actions.storerobbery'), minimum = 1, busy = false, active = true, icon = "🛒"},
    ["atmrobbery"]   = {label = Lang:t('illegal_actions.atmrobbery'),   minimum = 2, busy = false, active = true, icon = "🏧"},
    ["banktruck"]    = {label = Lang:t('illegal_actions.banktruck'),    minimum = 4, busy = false, active = true, icon = "🚚"},
    ["jewellery"]    = {label = Lang:t('illegal_actions.jewellery'),    minimum = 4, busy = false, active = true, icon = "💎"},
    ["Fleeca"]       = {label = Lang:t('illegal_actions.Fleeca'),       minimum = 3, busy = false, active = true, icon = "🏦"},
    ["Paleto"]       = {label = Lang:t('illegal_actions.Paleto'),       minimum = 4, busy = false, active = true, icon = "🏦"},
    ["Pacific"]      = {label = Lang:t('illegal_actions.Pacific'),      minimum = 6, busy = false, active = true, icon = "🏦"},
    ["ammunitionrobbery"]      = {label = Lang:t('illegal_actions.ammunitionrobbery'),      minimum = 3, busy = false, active = true, icon = "🔫"},
    ["vliegtuigheist"]      = {label = Lang:t('illegal_actions.vliegtuigheist'),      minimum = 3, busy = false, active = true, icon = "✈️"},
}
-----------------------------------------------------------------------------------------------------------------------------------
