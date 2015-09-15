require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
express = require 'express'
cookieParser = require 'cookie-parser'
setup = require './setup'
setLoggedIn = require './middlewares/set_logged_in'
localsMerger = require './middlewares/locals_merger'
maybeSkipPrerender = require './middlewares/maybe_skip_prerender'
maybeUseCache = require './middlewares/maybe_use_cache'
prerender = require './middlewares/prerender'

setup()

port = _.parseInt _.last process.env.TOP_PRERENDER_HOST.split(':')

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join(__dirname, 'views')

app.use cookieParser()
app.use setLoggedIn()
app.use localsMerger()
app.use maybeSkipPrerender()
app.use maybeUseCache() if process.env.TOP_ENV == 'production'
app.use prerender()

app.listen port
