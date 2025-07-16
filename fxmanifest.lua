fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nubetastic'
lua54 'yes'
name 'Nt_hunting'
description 'Advanced hunting and animal skinning system for RedM/RSG servers'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

-- Optional: Lua 5.4 support
lua54 'yes'
