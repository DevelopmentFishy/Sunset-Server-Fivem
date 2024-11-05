fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PlasmaGame'
version '1.0.3'
author 'Sarish'


ui_page 'html/index.html'

files {

	'html/font/*.*',
	'html/index.html',
	'html/img/*.*',
	'html/app.js',
	'html/style.css',
	-- 'WeaponData/dlctext.meta',
	-- 'WeaponData/pedpersonalitySPR.meta',
	-- 'WeaponData/weaponarchetypesSPR.meta',
	-- 'WeaponData/weaponanimationsSPR.meta',
	-- 'WeaponData/weaponSPR.meta',
	-- 'WeaponData/weapons.meta'
}

server_scripts {
	'unencrypted/serverFunc.lua',
	"unencrypted/serverSpec.lua",
	'lang/configLang.lua',
	'config.lua',
	"server.lua"
}

client_scripts {
	'unencrypted/clientFunc.lua',
	'unencrypted/clientSpec.lua',
	'lang/configLang.lua',
	'config.lua',
	
	'unencrypted/target.lua',
    'client.lua'
}

escrow_ignore {
	'lang/configLang.lua',
	'unencrypted/*.*',
	'config.lua'
 }
-- data_file 'WEAPON_METADATA_FILE'   'WeaponData/weaponarchetypesSPR.meta'
-- data_file 'WEAPON_ANIMATIONS_FILE' 'WeaponData/weaponanimationsSPR.meta'
-- data_file 'WEAPONINFO_FILE'        'WeaponData/weaponSPR.meta'
-- data_file 'WEAPONINFO_FILE_PATCH'  'WeaponData/weapons.meta'
-- data_file 'TEXTFILE_METAFILE'      'WeaponData/dlctext.meta'
-- data_file 'PED_PERSONALITY_FILE'   'WeaponData/pedpersonalitySPR.meta'

dependency '/assetpacks'