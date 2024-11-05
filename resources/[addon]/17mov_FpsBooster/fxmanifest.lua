fx_version 'adamant'
game 'gta5'
author 'malizniak'
lua54 "yes"

files {
    "web/**/*.**",
    "web/*.**",
}

ui_page "web/driver.html"

client_script "client.lua"
shared_script "Config.lua"

escrow_ignore {
    "Config.lua",
}
dependency '/assetpacks'