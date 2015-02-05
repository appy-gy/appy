Marty = require 'marty'
RatingsConstants = require '../constants/ratings_constants'

RatingsSourceActionCreators = Marty.createActionCreators
  displayName: 'Ratings'

  addRatings: RatingsConstants.ADD_RATINGS (ratings) ->
    @dispatch ratings

module.exports = RatingsSourceActionCreators
