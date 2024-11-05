fx_version 'cerulean'
game 'gta5'

description 'QB-AmbulanceJob'
version '1.2.4'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua',
}

server_scripts{
    'server/server.lua',
}

client_scripts{
    'client/client.lua',
}

lua54 'yes'