stores = require '../stores'
deepGet = require './deep_get'

module.exports = (path) ->
  deepGet stores, path
