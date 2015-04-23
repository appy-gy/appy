Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
RatingConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
Rating = require '../models/rating'

class RatingActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingConstants.APPEND_RATINGS
  change: autoDispatch RatingConstants.CHANGE_RATING

  update: (rating, changes) ->
    RatingsApi.update(rating, changes).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch RatingConstants.REPLACE_RATING, rating

module.exports = Marty.register RatingActionCreators
