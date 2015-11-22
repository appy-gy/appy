http = require '../../frontend/scripts/helpers/http'

checkUrl = 'sessions/check'

module.exports = ->
  (req, res, next) ->
    http.get(checkUrl, params: { cookies: req.cookies }).then ({data}) ->
      req.isLoggedIn = data.loggedIn
      next()
