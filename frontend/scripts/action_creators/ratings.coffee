Marty = require 'marty'
RatingsConstants = require '../constants/ratings'

RatingsActionCreators = Marty.createActionCreators
  append: RatingsConstants.APPEND_RATINGS (ratings) ->
    @dispatch ratings

  change: RatingsConstants.CHANGE_RATINGS (id, changes) ->
    @dispatch id, changes

module.exports = RatingsActionCreators
