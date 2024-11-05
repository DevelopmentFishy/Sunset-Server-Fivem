fx_version 'cerulean'
game 'gta5'

description 'Job Blips Script'
version '1.2.0'
author 'Snipe'

lua54 'yes'

shared_scripts{
    '@ox_lib/init.lua',
    'shared/**/*.lua'
}

client_scripts{
    'client/**/*.lua',
} 

server_scripts{
    'server/**/*.lua'
}

escrow_ignore{
    'shared/**/*.lua',
    'client/open/*.lua',
    'server/open/*.lua'
}

dependency '/assetpacks'