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

  getForUser: (userId, page) ->
    @app.ratingsApi.loadForUser(userId, page).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating _.merge(rating, { page })
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, 'userRatings', body.meta.pages_count

  getForSection: (sectionId, page) ->
    @app.ratingsApi.loadForSection(sectionId, page).then ({body}) =>
      return unless body?
      ratings = body.ratings.map (rating) -> new Rating _.merge(rating, { page })
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, "sectionRatings-#{sectionId}", body.meta.pages_count

  get: (id) ->
    @app.ratingsApi.load(id).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch Constants.APPEND_RATINGS, rating

module.exports = RatingsQueries
