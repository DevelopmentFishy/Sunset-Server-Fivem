fx_version 'cerulean'
game 'gta5'
version '1.0.3'
author 'l0d.'

shared_scripts {
	'shared/config.lua',
    'locales/locales.lua',
	'shared/GetCore.lua',
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'shared/config.lua',
	'shared/GetCore.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.
	'@oxmysql/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'oxmysql'.:warning:
	'server/main.lua',
	'server/functions.lua',
	'shared/config.lua',
	'shared/GetCore.lua',

}

ui_page "html/index.html"

files {
	'html/index.html',
	'html/assets/fonts/*.*',
    'html/assets/images/*.*',
    'html/assets/scripts/*.*',
	'html/assets/scripts/*.js',
    'html/assets/style/*.*',
}

lua54 'yes'

escrow_ignore {
	'shared/config.lua',
    'locales/locales.lua',
	'shared/GetCore.lua',
	'server/functions.lua',
	'client/functions.lua',
}

dependency '/assetpacks'