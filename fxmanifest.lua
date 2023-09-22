fx_version "cerulean"

author "Foltone#6290"

games { "gta5" };

client_scripts {
	"@es_extended/locale.lua",
	"Config.lua",
	"client/*.lua",
}

server_script {
	"@es_extended/locale.lua",
    "server/*.lua"
}

dependencies {
	"es_extended"
}
