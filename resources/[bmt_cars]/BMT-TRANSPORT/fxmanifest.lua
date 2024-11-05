fx_version 'adamant'
game 'gta5'
lua54 'yes'

files {
	'handling.meta',
	'carcols.meta',
	'vehicles.meta',
	'carvariations.meta',
	'poltsprinter.xml',
}
client_scripts {
	'configs/*.config.lua'
	}

is_els 'true'

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

dependency '/assetpacks'
dependency '/assetpacks'