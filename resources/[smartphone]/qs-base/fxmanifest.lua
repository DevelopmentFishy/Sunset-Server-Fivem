fx_version 'bodacious'

game 'gta5'

lua54 'yes'

version '2.7.9'

shared_scripts {
    'config/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/custom/framework/*.lua',
    'server/*.lua',
}

escrow_ignore {
    'config/*.lua',
    'server/custom/framework/*.lua',
}

server_exports {
    'isPlayerLoaded',
}

dependencies {
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
    'mysql-async',  -- Required.
}

dependency '/assetpacks'