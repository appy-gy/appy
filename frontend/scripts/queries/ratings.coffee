Marty = require 'marty'
RatingConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
Rating = require '../models/rating'

class RatingQueries extends Marty.Queries
  getPage: (page) ->
    RatingsApi.for(@).loadPage(page).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch RatingConstants.APPEND_RATINGS, ratings

  get: (id) ->
    RatingsApi.for(@).load(id).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch RatingConstants.APPEND_RATINGS, rating

module.exports = Marty.register RatingQueries
