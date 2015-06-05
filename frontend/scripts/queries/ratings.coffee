Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'

class RatingsQueries extends Marty.Queries
  getPage: (page) ->
    @app.ratingsApi.loadPage(page).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch Constants.APPEND_RATINGS, ratings

  getForUser: (userId) ->
    @app.ratingsApi.loadForUser(userId).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch Constants.APPEND_RATINGS, ratings

  getForSection: (sectionSlug) ->
    @app.ratingsApi.loadForSection(sectionSlug).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch Constants.APPEND_RATINGS, ratings

  get: (id) ->
    @app.ratingsApi.load(id).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch Constants.APPEND_RATINGS, rating

module.exports = RatingsQueries
