fx_version 'bodacious'

game 'gta5'

lua54 'yes'

version '2.0.2'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/custom/framework/*.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

escrow_ignore {
    'config.lua',
    'client/custom/framework/*.lua'
}

dependencies {
    'qs-inventory' -- Required
}

dependency '/assetpacks'