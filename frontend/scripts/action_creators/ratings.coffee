Marty = require 'marty'
RatingsConstants = require '../constants/ratings'

RatingsActionCreators = Marty.createActionCreators
  append: RatingsConstants.APPEND_RATINGS (ratings) ->
    @dispatch ratings

  replace: RatingsConstants.REPLACE_RATINGS (rating) ->
    @dispatch rating

module.exports = RatingsActionCreators
