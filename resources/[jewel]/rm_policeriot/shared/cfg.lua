cfg = {
    ['framework'] = 'qb', -- qb / esx / standalone

    ['vehicleModels'] = {
        [`poltsprinter`] = true,
    },

    ['doorlockJobList'] = {
        ['police'] = 0, --jobname = gradeLevel
        -- ['ambulance'] = 0,
    },

    ['backupExit'] = vec4(535.87, -21.72, 70.63, 117), --mrpd
    ['mapExit'] = vec4(883.65, -2122.44, -50.02, 2.63),
    ['mapDoor'] = vec3(883.24, -2119.63, -50.05),
    ['mapSeats'] = {
        vec4(883.1, -2122.0, -50.0, 270.0),
        vec4(883.1, -2121.2, -50.0, 270.0),
        vec4(883.1, -2120.25, -50.0, 270.0),
        vec4(884.3, -2122.0, -50.0, 90.0),
        vec4(884.3, -2121.2, -50.0, 90.0),
        vec4(884.3, -2120.25, -50.0, 90.0),
        vec4(883.1, -2118.5, -50.0, 270.0), --cell inside
        vec4(884.3, -2118.5, -50.0, 90.0),  --cell inside
    },

    ['drawLockSprite'] = true,
    ['closeMinimapOnExit'] = true,

    --key settings
    ['sitKey'] = 'g',                --keybind for sit in vehicle
    ['sitKeyDescription'] = '',      --keybind description for settings
    ['doorlockKey'] = 'k',           --keybind for doorlock in vehicle
    ['doorlockKeyDescription'] = '', --keybind description for settings

    ['locales'] = {
        ['vehicle_locked'] = 'Vehicle locked!',
        ['vehicle_too_fast'] = 'Vehicle is too fast to get off!',
        ['enter_vehicle_keybind_warning'] = 'Must be the same as the Enter Vehicle key',
        ['enter_riot'] = 'Default: Exit: [F], Sit: [G], Lock: [K]',
    },
}
