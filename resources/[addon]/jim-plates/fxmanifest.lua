name "Jim-Plates"
author "Jimathy"
version "1.5"
description "Plate Changing Script By Jimathy"
fx_version "cerulean"
game "gta5"
lua54 'yes'

shared_scripts { 'config.lua', 'shared.lua', 'locales/*.lua', }
client_scripts { 'client.lua' }
server_scripts { 'server.lua', '@oxmysql/lib/MySQL.lua', }

escrow_ignore { 'locales/*.lua', 'client.lua', 'config.lua', 'server.lua' }
dependency '/assetpacks'