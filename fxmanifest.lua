fx_version 'adamant'

lua54 'yes'

shared_script {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua'
} 

games {'gta5'}

author 'Haze#3355'

version '1.0.0'

client_scripts {
  'client.lua',
  'config.lua'
}

server_scripts{
  '@oxmysql/lib/MySQL.lua',
  'server.lua',
  'config.lua',
  'versioncheck.lua'
}server_scripts { '@mysql-async/lib/MySQL.lua' }