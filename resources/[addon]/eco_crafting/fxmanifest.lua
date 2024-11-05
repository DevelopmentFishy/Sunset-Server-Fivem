fx_version 'cerulean'
game 'gta5'

author 'Tutya & Ekhion'
description 'Economy - Crafting'
version '2.4'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'libs/functions.lua',
    'libs/notify.lua',
    'config/config.lua',
    'config/blips.lua',
    'config/craftdata.lua',
    'config/workstations.lua',
    'config/ranks.lua',
    'config/restrictedarea.lua'
}

client_scripts {
    'client/workplace.lua',
    'client/portable.lua',
    'client/main.lua',
}

server_scripts {
    'db/portable_ws.json',
    'server/log.lua',
    'server/main.lua',
    'server/usableitem.lua',
    'server/save.lua',
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/main.css',
    'html/js/player.js',
    'html/js/model.js',
    'html/js/view.js',
    'html/js/app.js',
    'html/js/jquery-ui.js',
    'html/img/*.png'
}

exports {
    'open' -- table: { workstation = '', special = '', animation = {} } See: export_examples.md
}

server_exports {
    'addLabor', -- playerData or serverId, amount
    'removeLabor', -- playerData or serverId, amount
    'addProficiency', -- playerData or serverId, profession, amount
    'removeProficiency', -- playerData or serverId, profession, amount

    'getLabor', -- serverId
    'getProficiency', -- serverId

    'addPortableWorkstation', -- workstationData, usableItemName(optional), ownerId(optional:source)
    'removePortableWorkstation', -- workstationId, requesterId(optional:source)
    'getPortableWorkstations' -- get all portable workstation
}

-- Use only if you modified QBCore and do not use the default core name!
-- core_name 'qb-core' -- default 'qb-core' -- QBCore = exports[core_name]:GetCoreObject(), exports[core_name]:DrawText/HideText()

lua54 'yes'

--https://forum.cfx.re/t/introducing-asset-escrow-for-your-resources/4777151
escrow_ignore {
    'locales/*.lua',
    'config/*.*',
    'db/*.*',
    'client/workplace.lua',
    'client/portable.lua',
    'libs/functions.lua',
    'libs/notify.lua',
    'server/usableitem.lua',
    'server/save.lua',
    'QBCore_addition/*.*'
}
dependency '/assetpacks'