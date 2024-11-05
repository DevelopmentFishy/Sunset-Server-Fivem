Config = {}

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx'

Config.WeaponPositions = {
    ['weapon_bat'] = {
        model = 'w_me_bat',
        hash = -1786099057,
        bone = 24816,
        x = -0.10, --- hoogte
        y = -0.15, --- dicht bij de ped
        z = -0.10, --- links/ rechts
        x_rotation = 0.0,
        y_rotation = 75.0,
        z_rotation = 0.0
    },
    ['weapon_compactrifle'] = {
        model = 'w_ar_compactrifle',
        hash = 1649403952,
        bone = 24816,
        x = 0.15,
        y = -0.15,
        z = -0.0,
        x_rotation = 0.0,
        y_rotation = 20.0,
        z_rotation = 0.0
    },
    ['weapon_machete'] = {
        model = 'w_me_machete',
        hash = -581044007,
        bone = 24816,
        x = 0.05,
        y = -0.15,
        z = -0.10,
        x_rotation = 0.0,
        y_rotation = 75.0,
        z_rotation = 0.0
    },
    ['weapon_golfclub'] = {
        model = 'w_me_gclub',
        hash = 1141786504,
        bone = 24816,
        x = -0.10, --- hoogte
        y = -0.15, --- dicht bij de ped
        z = -0.10, --- links/ rechts
        x_rotation = 0.0,
        y_rotation = 75.0,
        z_rotation = 0.0
    },


    -- Add more weapons as needed
}
