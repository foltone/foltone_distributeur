fx_version 'cerulean'

author 'Foltone#6290'

games { 'gta5' };

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'Config.lua',
	'client/*.lua',
}

server_script {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
    'server/*.lua'
}

dependencies {
	'es_extended'
}
