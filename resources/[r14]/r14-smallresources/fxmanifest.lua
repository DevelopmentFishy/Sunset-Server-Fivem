fx_version 'cerulean'
game 'gta5'

description 'r14-smallresources'
version '1.11 hotfix'

shared_scripts {
    'config.lua',
}

ui_page 'html/index.html'

client_scripts {
	'config.lua',
	'client/*.lua',
}

server_scripts {	
    'server/main.lua'
}

files {
	'html/index.html',
	'html/main.js',
}

lua54 'yes'
