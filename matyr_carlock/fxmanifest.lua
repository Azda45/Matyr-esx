fx_version 'cerulean'
game 'gta5'

client_scripts {
	"@core/locale.lua",
    "client.lua",
	'@mysql-async/lib/MySQL.lua'
}

server_scripts {
	"server.lua",
	'@core/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}