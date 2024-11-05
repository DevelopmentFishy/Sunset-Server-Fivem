fx_version 'cerulean'
game 'gta5'
author 'Aiakos#8317'
description 'CodeM Taxijob'
version '1.3.9'

shared_script{
	'shared/config.lua',
	'shared/GetFrameworkObject.lua',
}

client_scripts {
	'shared/GetFrameworkObject.lua',
	'client/*.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'mysql-async'.⚠️
    '@oxmysql/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'oxmysql'.⚠️
	'shared/server_config.lua',
	'server/main.lua',
	'server/commands.lua',
	'server/discord.lua',
	'server/achivements.lua',
	'server/level.lua',
	'shared/GetFrameworkObject.lua',
}


ui_page {
	'html/index.html',
}

files {
	'html/css/*.css',
	'html/app/*.js',
	'html/lib/*.js',
	'html/*.html',
	'html/images/*.png',
	'html/fonts/*.otf',
}

escrow_ignore {
	'shared/*.lua',
	'server/commands.lua',
	'server/discord.lua',
	'server/achivements.lua',
	'server/level.lua',
	'client/function.lua',
}

dependencies {
	'/onesync',
}

lua54 'yes'
dependency '/assetpacks'