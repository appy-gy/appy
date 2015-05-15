require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
dotenv = require 'dotenv'
Router = require 'react-router'
express = require 'express'
marty = require 'marty'
martyExpress = require 'marty-express'

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
    _.merge locals, host: assetsHost, facebookAppId: process.env.TOP_FACEBOOK_APP_ID
    prevRender.call res, view, locals

  next()

app.use martyExpress
  marty: marty
  routes: routes

app.listen port
