fx_version "adamant"
game "gta5"

client_script {
	'client/client.lua',
}

shared_script {
    'configs/**.lua'
}

server_script {
	'server/server.lua',
}

escrow_ignore {
  "server/s_editable.lua",
  "configs/**.lua",
  "fxmanifest.lua",
  "README.lua",
}


lua54 'yes'

dependency '/assetpacks'