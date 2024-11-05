fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_scripts {
    'config/*.lua',
    'utils/*.lua'
}

client_script {
    'client/custom/framework/*.lua',
    'client/*.lua'
}

escrow_ignore {
    'config/*.lua',
    'client/main.lua',
    'client/custom/framework/*.lua'
}

dependencies {
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
    'progressbar' -- Required
}
dependency '/assetpacks'