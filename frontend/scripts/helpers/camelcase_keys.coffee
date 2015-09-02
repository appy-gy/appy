_ = require 'lodash'
mapObj = require 'map-obj'

camelcaseKeys = (obj, deep = false) ->
  mapObj obj, (key, value) ->
    key = _.camelCase key
    value = camelcaseKeys value if deep and _.isObject value
    [key, value]

module.exports = camelcaseKeys
