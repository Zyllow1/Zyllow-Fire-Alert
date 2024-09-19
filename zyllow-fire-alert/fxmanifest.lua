fx_version 'adamant'
lua54 'on'
game 'gta5'
author 'Zyllow'
version '1.1'

dependency 'es_extended'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
}