fx_version 'cerulean'

games { 'gta5' }

description 'Printer for QB-Core by Messy Scripts'

version '1.2'

author 'SHOOTYMANE'

ui_page 'index.html'

shared_scripts {
    'config.lua'
}
client_script 'client.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

files {
	'*.png',
	'*.ttf',
	'*.html',
	'*.css',
	'*.js'
}	

escrow_ignore {
	'config.lua'
}

lua54 'yes'
dependency '/assetpacks'