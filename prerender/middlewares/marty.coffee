# martyExpress = require 'marty-express'
# Application = require '../application'
# memcached = require '../helpers/memcached'
# routes = require '../../frontend/scripts/routes'
#
# cacheLifetime = 1 * 60 # 1 minute
#
# module.exports = ->
#   martyExpress
#     routes: routes
#     application: Application
#     rendered: ({req, htmlBody, htmlState}) ->
#       memcached.set req.url, body: htmlBody, state: htmlState, cacheLifetime, ->
#     error: (req, res, next, error) ->
#       console.error 'Failed to render', error, error.stack
#       res.sendStatus(500).end()
