martyExpress = require 'marty-express'
Application = require '../application'
routes = require '../../frontend/scripts/routes'

module.exports = ->
  martyExpress
    routes: routes
    application: Application
    error: (req, res, next, error) ->
      console.error 'Failed to render', error, error.stack
      res.sendStatus(500).end()
