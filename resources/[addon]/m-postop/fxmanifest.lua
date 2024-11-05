fx_version 'cerulean'
game 'gta5'
description 'CODEM POSTOP JOB'
version '1.1.1'

shared_scripts { 
    'GetFrameworkObject.lua',
	'editable/config.lua'
}

client_scripts {
    'GetFrameworkObject.lua',
    'editable/config.lua',
    'client/*.lua',
    'editable/client-editable.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'oxmysql'.⚠️
        -- '@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'mysql-async'.⚠️
    'GetFrameworkObject.lua',
    'server/*.lua',
    'editable/server-editable.lua',
}

ui_page {
    'ui/index.html',
}

files {
    'ui/index.html',
    'ui/fonts/*.otf',
    'ui/fonts/*.OTF',
    'ui/img/*.png',
    'ui/*.js',
    'ui/tailwind.config.js',
    'ui/package-lock.json',
    'ui/package.json',
}

escrow_ignore{
    'editable/*.lua',
}

lua54 'yes'
dependency '/assetpacks'