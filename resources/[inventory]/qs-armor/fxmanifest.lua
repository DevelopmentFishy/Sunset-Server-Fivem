fx_version 'adamant'

game 'gta5'

version '2.0.1'

lua54 'yes'

shared_scripts {
	'config/*.lua',
	'locales/*.lua',
	'shared/*.lua',
}

server_scripts {
	'server/custom/framework/*.lua',
	'server/modules/*.lua',
	'server/*.lua',
}

client_scripts {
	'client/custom/framework/*.lua',
    'client/*.lua',
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/custom/framework/*.lua',
	'server/custom/framework/*.lua',
}

dependencies {
	'progressbar', -- Required.
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}
dependency '/assetpacks'