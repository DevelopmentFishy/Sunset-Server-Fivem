resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_scripts {
	"client/*.lua",
	"config.lua",
}

server_scripts {
	"server/main.lua",
	"config.lua",
	'@oxmysql/lib/MySQL.lua',
}

shared_script { 	'@qb-core/shared/locale.lua',
'config.lua',
'locales/nl.lua',
}