fx_version 'cerulean'
games { 'gta5' }

author 'Your Name'
description 'Instance Commands'
version '1.0.0'

shared_scripts {
    'config.lua'
}

server_script {
    'server/server.lua',
    'server/drugtables.lua',
    'server/weedpicking.lua'
}   


client_script {
    'client/client.lua',
    'client/drugtables.lua',
    'client/target.lua'
} 

dependencies {
    'qb-core'
}