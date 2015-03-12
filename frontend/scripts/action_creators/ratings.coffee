Marty = require 'marty'
RatingsConstants = require '../constants/ratings'

RatingsActionCreators = Marty.createActionCreators
  append: RatingsConstants.APPEND_RATINGS (ratings) ->
    @dispatch ratings

module.exports = RatingsActionCreators
