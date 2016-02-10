_ = require 'lodash'
strip = require 'strip'

ratingShortDescription = (description) ->
    _.truncate strip(description),
      length: 150
      separator: /,? +/

module.exports = ratingShortDescription
