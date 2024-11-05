fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
lua54 'yes'

file 'sp_manifest.ymt'
-- SCENARIO_POINTS_FILE may work, too
data_file 'SCENARIO_POINTS_OVERRIDE_FILE' 'sp_manifest.ymt'

escrow_ignore {
	"script/client/main.lua",
	"script/server/main.lua",
	"script/config.lua",
	"stream/**/*.ymt"
}

dependency '/assetpacks'

author "Rudzik"
description "Legion Square"
version "1.23"

client_script 'script/client/main.lua'

server_script 'script/server/main.lua'

shared_script 'script/config.lua'



dependency '/assetpacks'