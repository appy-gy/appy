_ = require 'lodash'
mapObj = require 'map-obj'

snakecaseKeys = (obj, deep = false) ->
  mapObj obj, (key, value) ->
    key = _.snakeCase key
    value = snakecaseKeys value if deep and _.isObject value
    [key, value]

module.exports = snakecaseKeys
