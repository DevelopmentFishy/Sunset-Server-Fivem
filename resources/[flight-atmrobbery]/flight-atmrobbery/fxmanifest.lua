fx_version "cerulean"

game "gta5"

author 'Flight Development'

description 'Atm Robbery by Flight Development'

version '0.1'

shared_scripts{
    '@ox_lib/init.lua',
    -- '@es_extended/imports.lua',
    "config/*.lua",
    'locales/*.lua',
}

client_scripts{
    'opensource/client/client.lua',
    "encrypted/client/atms-utils.lua",
    "encrypted/client/client.lua",
}

server_scripts{ 
    '@oxmysql/lib/MySQL.lua',
    "opensource/server/server.lua",
    'encrypted/server/server.lua',
}

lua54 "yes"

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'opensource/client/client.lua',
    "opensource/server/server.lua",
}

dependency '/assetpacks'
dependency '/assetpacks'