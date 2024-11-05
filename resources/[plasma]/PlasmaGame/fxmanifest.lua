fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PlasmaGame'
version '4.0.3'
author 'Sarish'


files {
	'img/Scoreboard_Death_Match.png'
}

server_scripts {
	'@PlasmaLobby/unencrypted/serverFunc.lua',
	'@PlasmaLobby/lang/configLang.lua',
	'@PlasmaLobby/config.lua',
	"server.lua"
}

client_scripts {
	'@PlasmaLobby/unencrypted/clientFunc.lua',
	'@PlasmaLobby/lang/configLang.lua',
	'@PlasmaLobby/config.lua',
    'client.lua'
}


dependencies {
  'PlasmaLobby'
}


dependency '/assetpacks'