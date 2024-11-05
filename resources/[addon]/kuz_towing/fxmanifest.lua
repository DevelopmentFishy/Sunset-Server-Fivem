fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Towing script made by KuzQuality'
version '1.0.7'


ui_page 'html/index.html'

--
-- Files
--

files {
    'html/js/jquery.js',
    'html/fonts/quicksand.ttf',
    'html/img/*.png',
    'html/index.html',
}


--
-- Server
--

server_scripts {
    'shared/config.lua',
    'server/server.lua',
}

--
-- Client
--

client_scripts {
    'shared/config.lua',
    'client/client.lua',
}

escrow_ignore {
    'shared/config.lua',
    'server/server.lua',
    'html/fonts/quicksand.ttf',
    'html/img/*.png',
    'html/index.html',
}

dependency '/assetpacks'