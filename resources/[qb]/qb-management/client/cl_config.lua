-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(577.88, 10.12, 77.04),
    },
    ['ambulance'] = {
        vector3(310.96, -569.42, 43.27),
    },
    ['realestate'] = {
        vector3(-716.04, 261.31, 84.14),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(577.88, 10.12, 77.04), length = 1.6, width = 1, heading = 341.0, minZ = 76.54, maxZ = 77.54 } ,
    },
    ['ambulance'] = {
        { coords = vector3(310.96, -569.42, 43.27), length = 2.3, width = 1.2, heading = 250.0, minZ = 42.07, maxZ = 43.87 },
    },
    ['realestate'] = {
        { coords = vector3(-716.04, 261.31, 84.14), length = 2.1, width = 1.0, heading = 295.0, minZ = 83.14, maxZ = 84.74 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0,0, 0),
    },
    ['familiehoffa'] = {
        vector3(1394.02, 1160.91, 114.33),
    },
    ['lariffa'] = {
        vector3(484.9, -1535.76, 29.32),
    },
    ['kaffatime'] = {
        vector3(-112.06, -1781.48, 28.59),
    },
}

Config.GangMenuZones = {
    ['kaffatime'] = {
         { coords = vector3(-112.06, -1781.48, 28.59), length = 2.1, width = 1.5, heading = 320.0, minZ = 27.59, maxZ = 29.39 },
    },
    ['lariffa'] = {
        { coords = vector3(484.9, -1535.76, 29.32), length = 2.6, width = 1.0, heading = 320.0, minZ = 27.92, maxZ = 29.92 },
   }, 
   ['familiehoffa'] = {
    { coords = vector3(1394.02, 1160.91, 114.33), length = 1.4, width = 3.0, heading = 0.0, minZ = 113.33, maxZ = 114.93 },
    },  



}
