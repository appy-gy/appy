storages = require '../storages'
deepGet = require './deep_get'

module.exports = (path) ->
  deepGet storages, path
