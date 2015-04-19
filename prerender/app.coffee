require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
dotenv = require 'dotenv'
Router = require 'react-router'
express = require 'express'
marty = require 'marty'
martyExpress = require 'marty-express'

# Marty uses isomorphic-fetch 1.6 which can't set cookies even on server-side
# So we replace it with isomorphic-fetch 2.0
delete global.fetch
require 'isomorphic-fetch'

setup = require '../frontend/scripts/setup'
routes = require '../frontend/scripts/routes'

{RouteHander} = Router

dotenv.load()
setup()

assetsHost = if process.env.TOP_ENV == 'development' then "#{process.env.TOP_WEBPACK_HOST}/" else '/'
port = _.parseInt _.last process.env.TOP_PRERENDER_HOST.split(':')

app = express()

app.set 'view engine', 'jade'
app.set 'views', path.join(__dirname, 'views')

app.use (req, res, next) ->
  prevRender = res.render

  res.render = (view, locals) ->
    _.merge locals, host: assetsHost
    prevRender.call res, view, locals

  next()

app.use martyExpress
  marty: marty
  routes: routes
  error: (req, res, next, error) ->
    console.error error.message, error.stack
    res.sendStatus(500).end()

app.listen port
