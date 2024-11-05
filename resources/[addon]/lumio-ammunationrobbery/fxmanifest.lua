fx_version 'cerulean'
game 'gta5'

shared_scripts {
	'configNormal.lua', --If you don't have gabz map uncomment it
	--'configGabz.lua', --If you don't have gabz map comment it
	'translations/en.lua' --CHOOSE YOUR LANGUAGE, YOU CAN ADD OTHERS (README)
}

client_scripts {
    'client/cl_mainNormal.lua', --If you don't have gabz map uncomment it
	--'client/cl_mainGabz.lua',  --If you don't have gabz map comment it
    'client/functions.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
}

server_scripts {
	'server/sv_main.lua',
}

files {'meta/*'}

data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'
data_file 'WEAPON_SHOP_INFO' 'meta/shop_weapon.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'meta/contentunlocks.meta'
data_file 'LOADOUTS_FILE' 'meta/loadouts.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'

escrow_ignore {
	'configGabz.lua',
	'configNormal.lua',
	'README.md',
	'translations/*',
	'client/*',
	'server/*',
	'images/*',
	'stream/*',
	'meta/*',
}

lua54 'yes'
dependency '/assetpacks'