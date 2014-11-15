_ = require 'lodash'

camelizeKeys = (obj, deep = false) ->
  _.each obj, (value, key) ->
    camelizedKey = _.str.camelize key
    valueIsObject = _.isObject value
    camelizeKeys value if deep and valueIsObject
    return true if key == camelizedKey and not valueIsObject
    obj[camelizedKey] = value
    delete obj[key]
    true

module.exports = camelizeKeys
