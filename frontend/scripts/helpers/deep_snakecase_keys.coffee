_ = require 'lodash'
snakecaseKeys = require './snakecase_keys'

deepSnakecaseKeys = (obj) ->
  return obj.map deepSnakecaseKeys if _.isArray obj

  _.mapValues snakecaseKeys(obj), (value) ->
    if _.isPlainObject(value) then deepSnakecaseKeys(value) else value

module.exports = deepSnakecaseKeys
