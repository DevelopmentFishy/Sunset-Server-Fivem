fx_version 'cerulean'
game 'gta5'

name 'diables_irm'
description 'IRM script for Hospital Los Diablos Mapping'
author 'ClownPEACE x Diables'
version '1.0.3'
alias 'diables_irm'
lua54 'yes'

shared_scripts {
  'config.lua',
  'config_escrow.lua',
}

client_scripts {
  'client/client.lua',
  'client/target/target.lua',
  'client/target/target_custom.lua',
}

server_scripts {
  'server/server.lua',
}

ui_page 'html/index.html'

files {
  'html/index.html',  
  'html/IRM.mp3',
  'html/index.js',
  'html/index.css',
  'html/images/*.svg',
  'html/images/*.png',
  'html/images/*.jpg',
}

escrow_ignore {
  'config.lua',
  'client/target/*.lua',
}
dependency '/assetpacks'