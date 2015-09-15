http = require '../../frontend/scripts/helpers/http'

tokenKey = 'remember_me_token'
checkUrl = "#{process.env.TOP_HOST}/api/private/sessions/check"

module.exports = ->
  (req, res, next) ->
    token = req.cookies[tokenKey]
    http.get(checkUrl, params: { token }).then ({data}) ->
      req.isLoggedIn = data.loggedIn
      next()
