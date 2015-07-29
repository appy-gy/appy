require 'coffee-react/register'

_ = require 'lodash'
path = require 'path'
Router = require 'react-router'
express = require 'express'
Marty = require 'marty'
martyExpress = require 'marty-express'

setup = require './setup'
Application = require './application'
routes = require '../frontend/scripts/routes'

setup()

assetsHost = if process.env.TOP_ENV == 'development' then "#{process.env.TOP_WEBPACK_HOST}/" else '/static/'
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
  routes: routes
  application: Application
  error: (req, res, next, error) ->
    console.error 'Failed to render', error, error.stack
    res.sendStatus(500).end()

app.listen port
