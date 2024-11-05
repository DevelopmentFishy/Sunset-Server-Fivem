fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

description 'QB Drug Trafficing by Project Sloth'

version '1.4.1'

shared_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua'
}

server_scripts {
	'server/meth.lua',
	
}

client_scripts {
	'client/sulfuricacid.lua',
	'client/target.lua',
}

files {
	'stream/mw_props.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mw_props.ytyp'
