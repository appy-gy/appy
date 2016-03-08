_ = require 'lodash'
strip = require 'strip'

ratingShortDescription = (description) ->
  _.truncate _.unescape(strip(description)),
    length: 150
    separator: /,? +/

module.exports = ratingShortDescription
