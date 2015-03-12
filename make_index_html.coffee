env = require './.env.coffee'
fs = require 'fs'
jade = require 'jade'

host = if env.TOP_ENV == 'development' then "http://#{env.WEBPACK_HOST}:#{env.WEBPACK_PORT}/" else ''

template = jade.compileFile 'frontend/index.jade'
html = template { host }

fs.writeFileSync 'public/index.html', html
