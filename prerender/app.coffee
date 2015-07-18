require 'coffee-react/register'

_ = require 'lodash'
fs = require 'fs'
path = require 'path'
dotenv = require 'dotenv'
Router = require 'react-router'
express = require 'express'
Marty = require 'marty'
martyExpress = require 'marty-express'

setup = require '../frontend/scripts/setup'
routes = require '../frontend/scripts/routes'
typesMap = require '../frontend/scripts/helpers/marty/types_map'

dotenv.load()
setup()

class Application extends Marty.Application
  constructor: (options) ->
    super options

    ['actions', 'queries', 'sources', 'stores'].each (dir) =>
      files = fs.readdirSync "./frontend/scripts/#{dir}"
      files.each (file) =>
        type = typesMap[dir] || dir
        name = file.split('.')[0]
        fullname = "#{name}_#{type}"
        object = require "../frontend/scripts/#{dir}/#{name}"
        @register _.camelCase(fullname), object

assetsHost = if process.env.TOP_ENV == 'development' then "#{process.env.TOP_WEBPACK_HOST}/" else '/assets/'
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
