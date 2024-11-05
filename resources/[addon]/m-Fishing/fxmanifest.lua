fx_version 'cerulean'
author 'marcinhu#0001'
Description 'm-Fishing V2'
game 'gta5'

data_file 'DLC_ITYP_REQUEST' 'stream/m-fishing.ytyp'

shared_scripts {
    "@ox_lib/init.lua",
    "config/**",
    "server/s_utils.lua",
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    "server/**.lua",
}

client_script {
    "client/**.lua",
}

escrow_ignore {
    "client/c_utils.lua",
    "server/s_utils.lua",
    "config/**",
    "README.lua",
    "SQL.sql",
}

lua54 'yes'
dependency '/assetpacks'

dependency '/assetpacks'