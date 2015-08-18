_ = require 'lodash'

removeExtraSpaces = (string) ->
  _.trim(string)
    .replace(/\n+/g, "\n")
    .replace(/ +/g, ' ')

module.exports = removeExtraSpaces
