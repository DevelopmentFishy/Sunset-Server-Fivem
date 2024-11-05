fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
lua54 'yes'
author 'Fiv3Devs'
description 'Bahama Mamas'
version '1.0.5'

client_script {
  'client.lua'
 }

files {		
	"audio/*.dat151.rel",
	"sp_manifest.ymt"
}

data_file "AUDIO_GAMEDATA" "audio/5d_bahamamamas_col_game.dat"
data_file 'AUDIO_DYNAMIXDATA' 'audio/5d_bahamamamas_col_mix.dat'
data_file "SCENARIO_POINTS_OVERRIDE_PSO_FILE" "sp_manifest.ymt"
dependency '/assetpacks'