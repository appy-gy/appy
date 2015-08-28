_ = require 'lodash'

removeExtraSpaces = (string) ->
  return unless _.isString string
  _.trim(string)
    .replace /(\r?\n){3,}/g, '\n\n'
    .replace /( |\u00a0){2,}/g, ' '

module.exports = removeExtraSpaces
