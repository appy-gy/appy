_ = require 'lodash'
memcached = require '../helpers/memcached'

module.exports = ->
  (req, res, next) ->
    memcached.get req.url, (err, data) ->
      return next() unless data?
      res.render 'index', _.pick(data, 'body', 'state')
