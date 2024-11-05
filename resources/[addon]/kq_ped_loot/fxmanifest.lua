fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Advanced ped looting'
version '1.0.2'

client_scripts {
    'constants.lua',
    'config.lua',
    'locale.lua',
    'client/editable/target.lua',
    'client/editable/editable.lua',
    'client/cache.lua',
    'client/inputs.lua',
    'client/functions.lua',
    'client/client.lua',
}

server_scripts {
    'locale.lua',
    'constants.lua',
    'config.lua',
    'server/server.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
    'server/editable/editable.lua',
}

escrow_ignore {
    'constants.lua',
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependencies {
    '/onesync',
}

dependency '/assetpacks'