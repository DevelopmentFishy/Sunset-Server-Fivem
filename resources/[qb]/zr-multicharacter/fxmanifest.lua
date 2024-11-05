fx_version 'cerulean'
game 'gta5'

author '0BugScripts Remastered: <0bugscripts.tebex.io>'
description 'zr-multicharacter'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'zr-config/zr-config.lua',
}

client_scripts {
    'zr-build/zr-build-c.lua',
    'zr-config/zr-build-c.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'zr-build/zr-build-s.lua',
    'zr-config/zr-build-s.lua',
}

ui_page 'zr-nui/zr-index.html'

files { 
    'zr-nui/*',
    'zr-nui/zr-assets/*', 
}

escrow_ignore {
    'zr-config/*.lua'
}
dependency '/assetpacks'