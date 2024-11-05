fx_version 'bodacious'
game 'gta5'

lua54 'yes'

author 'Cologic Development'
discord 'https://discord.gg/WqyU8pWrek'
website 'https://cologic.tebex.io'
description 'A highly configurable implementation of ELS.'

ui_page 'client/index.html'

is_els 'true'

client_script {
    'client/client.lua',
    'client/util.lua',
    'client/api.lua',
    'client/patterns/*.lua',
    'client/input.lua'
}

server_script {
    'server/vcf.lua',
    'server/*.lua'
}

shared_script {
    'enums.lua',
    'config.lua',
}

files {
    -- Add custom panels here
    'panels/luxart.html',
    'panels/minimal.html',
    'panels/be200.html',
    'panels/be200alt.html',
    'panels/beep.wav',
    'client/index.html'
}

escrow_ignore {
    'client/patterns/*.lua',
    'panels/*.*',
    'config.lua'
}

dependencies {
    '/onesync'
}
dependency '/assetpacks'