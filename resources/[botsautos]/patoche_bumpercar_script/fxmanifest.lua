fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'patoche_bumpercar_script'
version '1.0'
description 'Bonk your friend with a bumpercar'
author 'Tiwabs'


shared_scripts{
  -- "@es_extended/imports.lua",
  -- "@qb-core/shared/locale.lua",
  "shared/**/*.lua",
  "bridge/init.lua",
  "bridge/*.lua"
}

client_scripts{
  "client/**/*.lua"
}

server_script { 
  "server/**/*.lua"
}

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'web/media/**/*',
  'locales/*.json',
}

escrow_ignore {
  "client/vehicle_keys.lua",
  "shared/**/*",
  "bridge/**/*"
}
dependency '/assetpacks'