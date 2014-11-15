components = require '../components'
deepGet = require './deep_get'

module.exports = (path) ->
  deepGet components, path
