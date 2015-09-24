isLoggedIn = require '../helpers/is_logged_in'

module.exports = ->
  (req, res, next) ->
    return next() unless req.isLoggedIn
    res.render 'index', head: {}, body: '', state: ''
