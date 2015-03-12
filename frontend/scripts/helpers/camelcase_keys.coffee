_ = require 'lodash'

camelcaseKeys = (obj, deep = false) ->
  _.each obj, (value, key) ->
    camelcasedKey = _.camelCase key
    camelcaseKeys value if deep and _.isObject value
    return true if key == camelcasedKey
    obj[camelcasedKey] = value
    delete obj[key]
    true

module.exports = camelcaseKeys
