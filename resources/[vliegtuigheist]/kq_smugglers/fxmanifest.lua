fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Smugglers Plane Heist by KuzQuality'
version '1.1.3'


ui_page 'html/index.html'

--
-- Files
--

files {
    'html/js/jquery.js',
    'html/js/card.js',
    'html/fonts/FjallaOne.ttf',
    'html/index.html',
    'html/img/hint.png',
}

--
-- Server
--

server_scripts {
    'config.lua',
    'locale.lua',
    'server/server.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
    'server/editable/kq_lootareas.lua',
    'server/editable/editable.lua',
    'server/plane.lua',
    'server/atc.lua',
    'server/lootsecure.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'locale.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/plane.lua',
    'client/atc.lua',
    'client/radio.lua',
    'client/hacking.lua',
    'client/hint.lua',
    'client/editable/target.lua',
    'client/editable/editable.lua',
    'client/editable/esx.lua',
    'client/editable/qb.lua',
    'client/editable/dispatch.lua',
    'client/editable/selling.lua',
    'client/lootsecure.lua',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependencies {
    'kq_lootareas',
}

dependency '/assetpacks'