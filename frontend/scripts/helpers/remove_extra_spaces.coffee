_ = require 'lodash'

removeExtraSpaces = (string) ->
  return unless _.isString string
  _.trim(string)
    .replace /((\r?\n){2})(\r?\n)+/g, '$1'
    .replace /( |\u00a0){2,}/g, ''

module.exports = removeExtraSpaces
