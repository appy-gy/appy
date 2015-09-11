require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
express = require 'express'
cookieParser = require 'cookie-parser'
setup = require './setup'
localsMerger = require './middlewares/locals_merger'
maybeSkipPrerender = require './middlewares/maybe_skip_prerender'
memcachedServe = require './middlewares/memcached_serve'
# marty = require './middlewares/marty'

setup()

port = _.parseInt _.last process.env.TOP_PRERENDER_HOST.split(':')

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join(__dirname, 'views')

app.use cookieParser()
app.use localsMerger()
app.use maybeSkipPrerender()
app.use memcachedServe() if process.env.TOP_ENV == 'production'
# app.use marty()

app.listen port
