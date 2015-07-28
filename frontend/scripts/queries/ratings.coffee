_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'

class RatingsQueries extends Marty.Queries
  getPage: (page) ->
    @app.ratingsApi.loadPage(page).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating _.merge(rating, { page })
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, 'ratings', body.meta.pages_count

  getForUser: (userId, {status, page}) ->
    @app.ratingsApi.loadForUser(userId, { status, page }).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating _.merge(rating, { page })
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, "user#{_.classify status}Ratings", body.meta.pages_count

  getForSection: (sectionId) ->
    @app.ratingsApi.loadForSection(sectionId).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch Constants.APPEND_RATINGS, ratings

  get: (id) ->
    @app.ratingsApi.load(id).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch Constants.APPEND_RATINGS, rating

module.exports = RatingsQueries
