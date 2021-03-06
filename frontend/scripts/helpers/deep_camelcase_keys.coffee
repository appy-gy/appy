_ = require 'lodash'
camelcaseKeys = require './camelcase_keys'

deepCamelcaseKeys = (obj) ->
  return obj.map deepCamelcaseKeys if _.isArray obj

  _.mapValues camelcaseKeys(obj), (value) ->
    if _.isPlainObject(value) or _.isArray(value) then deepCamelcaseKeys(value) else value

module.exports = deepCamelcaseKeys
