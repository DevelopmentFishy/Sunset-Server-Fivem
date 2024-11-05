fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PlasmaRandom'
version '1.0.1'
author 'Sarish'


ui_page 'html/index.html'

files {

	'img/Scoreboard_Death_Match.png'
	-- 'WeaponData/dlctext.meta',
	-- 'WeaponData/pedpersonalitySPR.meta',
	-- 'WeaponData/weaponarchetypesSPR.meta',
	-- 'WeaponData/weaponanimationsSPR.meta',
	-- 'WeaponData/weaponSPR.meta',
	-- 'WeaponData/weapons.meta'
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

escrow_ignore {
	'config.lua'
 }
dependencies {
  'PlasmaLobby'
}
-- data_file 'WEAPON_METADATA_FILE'   'WeaponData/weaponarchetypesSPR.meta'
-- data_file 'WEAPON_ANIMATIONS_FILE' 'WeaponData/weaponanimationsSPR.meta'
-- data_file 'WEAPONINFO_FILE'        'WeaponData/weaponSPR.meta'
-- data_file 'WEAPONINFO_FILE_PATCH'  'WeaponData/weapons.meta'
-- data_file 'TEXTFILE_METAFILE'      'WeaponData/dlctext.meta'
-- data_file 'PED_PERSONALITY_FILE'   'WeaponData/pedpersonalitySPR.meta'

dependency '/assetpacks'