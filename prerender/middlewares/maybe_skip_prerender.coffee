isLoggedIn = require '../helpers/is_logged_in'

module.exports = ->
  (req, res, next) ->
    # return next() unless isLoggedIn req
    res.render 'index', body: '', state: ''
