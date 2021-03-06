require 'coffee-react/register'

dotenv = require 'dotenv'
setup = require '../frontend/scripts/setup'

dotenv.load()
setup()

_ = require 'lodash'
path = require 'path'
express = require 'express'
newrelic = require 'newrelic'
cookieParser = require 'cookie-parser'
setPixelRatio = require './middlewares/set_pixel_ratio'
setLoggedIn = require './middlewares/set_logged_in'
localsMerger = require './middlewares/locals_merger'
maybeSkipPrerender = require './middlewares/maybe_skip_prerender'
maybeUseCache = require './middlewares/maybe_use_cache'
prerender = require './middlewares/prerender'

port = _.parseInt _.last process.env.TOP_PRERENDER_HOST.split(':')

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join(__dirname, 'views')

app.locals.newrelic = newrelic

app.use cookieParser()
app.use setLoggedIn()
app.use setPixelRatio()
app.use localsMerger()
app.use maybeSkipPrerender()
app.use maybeUseCache() if process.env.TOP_ENV == 'production'
app.use prerender()

app.listen port
