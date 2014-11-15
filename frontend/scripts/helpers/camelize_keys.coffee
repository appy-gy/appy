_ = require 'lodash'

camelizeKeys = (obj, deep = false) ->
  _.each obj, (value, key) ->
    camelizedKey = _.str.camelize key
    camelizeKeys value if deep and _.isObject value
    return true if key == camelizedKey
    obj[camelizedKey] = value
    delete obj[key]
    true

module.exports = camelizeKeys
