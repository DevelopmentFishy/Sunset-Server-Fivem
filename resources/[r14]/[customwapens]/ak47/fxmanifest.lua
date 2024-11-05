fx_version 'cerulean'
games {'gta5'}
description 'Walther PDP'

files{
	'weaponcomponents.meta',
	'weaponarchetypes.meta',
	'weaponanimations.meta',
	'weapons.meta',
	'components/**/weaponcomponents.meta'
}

client_script "names.lua"

data_file 'WEAPONCOMPONENTSINFO_FILE' 'weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'WEAPONINFO_FILE' 'weapons.meta'



