fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

description 'Radial Progress'

author 'Karl Saunders'

version '0.7.9'

client_scripts {
    'config.lua',
    'utils.lua',
    'client.lua',
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js',
}

exports {
    "Start",
    "Custom",
    "Stop",
    "Static",
    "Linear",
    "MiniGame"
}
