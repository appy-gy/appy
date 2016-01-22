http = require '../../frontend/scripts/helpers/http'

checkUrl = 'sessions/check'

module.exports = ->
  (req, res, next) ->
    http.get(checkUrl, params: { token: req.cookies.remember_me_token }).then ({data}) ->
      req.isLoggedIn = data.loggedIn
      next()
