fx_version 'cerulean'

game { 'gta5' }

description ''

files {
    'data/**/*.meta'
}
 
data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
-- data_file 'DLCTEXT_FILE' 'data/**/dlctext.meta'
-- data_file 'CARCONTENTUNLOCKS_FILE' 'data/**/carcontentunlocks.meta'

--client_script 'vehicle_names.lua'
files {
	'audioconfig/*.dat151.rel',
	'audioconfig/*.dat54.rel',
	'sfx/**/*.awc',
	'sfx/**/*.awc',
  }

  data_file 'AUDIO_GAMEDATA' 'audioconfig/severo_game.dat151'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/severo_sounds.dat54'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_severo'