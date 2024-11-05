fx_version 'cerulean'

game 'gta5'

author 'okok#3488'
description 'okokContract'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua'
}
dependency '/assetpacks'