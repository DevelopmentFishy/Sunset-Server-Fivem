fx_version 'cerulean'

game 'gta5'

author 'okok#3488'
description 'okokBanking'
version '1.1.1'

ui_page 'web/ui.html'

files {
	'web/*.*',
	'web/img/*.*'
}

shared_scripts {
    'config.lua',
    'locales/*.lua'
}

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
	'server.lua',
	'client.lua',
	'locales/*.lua'
}

server_exports {
    'AddMoney',
    'RemoveMoney',
    'GetAccount',
}
dependency '/assetpacks'