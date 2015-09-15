_ = require 'lodash'

constantize = (str) ->
  _.snakeCase(str).toUpperCase()

module.exports = constantize
