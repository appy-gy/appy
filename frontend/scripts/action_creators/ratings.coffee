Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
findInStore = require '../helpers/find_in_store'
RatingConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
RatingsStore = require '../stores/ratings'
Rating = require '../models/rating'

class RatingActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingConstants.APPEND_RATINGS

  change: (ratingOrId, changes) ->
    rating = findInStore RatingsStore, ratingOrId
    @dispatch RatingConstants.CHANGE_RATING, rating, changes

  save: (ratingOrId, changes) ->
    rating = findInStore RatingsStore, ratingOrId
    RatingsApi.update(rating.id, changes).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch RatingConstants.REPLACE_RATING, rating

module.exports = Marty.register RatingActionCreators
