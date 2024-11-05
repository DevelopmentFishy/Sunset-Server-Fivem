fx_version 'cerulean'
game 'gta5'
version '1.0.0'
author 'discord.gg/codem'

shared_scripts {
	'config.lua',
	'GetCore.lua',

}



client_scripts {
	'client.lua',
	'client_editable.lua',
}

server_scripts {
	'botToken.lua',
	'server.lua',
	
}

ui_page "html/index.html"

files {
	'html/index.html',
	'html/index.css',
	'html/responsive.css',


	'html/index.js',
	'html/assets/**/*.png',
	'html/assets/**/*.ttf',
	'html/assets/**/*.svg',

}

escrow_ignore{
	'config.lua',
	'GetCore.lua',
	'botToken.lua',
	'client_editable.lua',
}

lua54 'yes'
dependency '/assetpacks'