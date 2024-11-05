fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'diables_scripts'
version      '1.0.0'
description  'Script for Diables MLO Hospital'
author       'Le Diable'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'config-escrow.lua',
    'locale.lua',
    'locales/*.lua'
}

client_scripts {
    'client/perf1.lua',
    'client/perf2.lua',
    'client/bed1.lua',
    'client/showers.lua',
    'client/wash.lua',
    'client/target/*.lua',
    'client/framework/*.lua',
}

escrow_ignore {
    'config.lua',
    'client/target/*.lua',
    'locales/*.lua'
}
dependency '/assetpacks'