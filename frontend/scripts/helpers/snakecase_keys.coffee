_ = require 'lodash'

snakecaseKeys = (obj) ->
  _.mapKeys obj, (value, key) -> _.snakeCase key

module.exports = snakecaseKeys
