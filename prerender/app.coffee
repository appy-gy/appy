require 'coffee-react/register'

_ = require 'lodash'
dotenv = require 'dotenv'
path = require 'path'
Router = require 'react-router'
express = require 'express'
martyExpress = require 'marty-express'
routes = require '../frontend/scripts/routes'

{RouteHander} = Router

dotenv.load()

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
  routes: routes
  error: (req, res, next, error) ->
    console.error error.message, error.stack
    res.sendStatus(500).end()

app.listen port
