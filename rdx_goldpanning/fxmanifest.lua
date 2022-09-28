fx_version 'adamant'
author 'Vision'
version '2.0'
description ""

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'settings/local.lua',
	'settings/config.lua',	
	'data/main_sv.lua'
}

client_scripts {	
	'settings/local.lua',
	'settings/config.lua',
	'data/main_cl.lua',
	'data/functions.lua'
}
