lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Pug#8008'
description 'Simple Drug Selling'
version '1.0'

shared_scripts {
    'config.lua'
}
server_scripts {    
    'server/server.lua'
}
client_scripts { 
    'client/client.lua'
}

escrow_ignore {
    'config.lua',
    'client/client.lua',
    'server/server.lua',
}
dependency '/assetpacks'