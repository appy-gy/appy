_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'

class RatingsQueries extends Marty.Queries
  getPage: (page) ->
    @app.ratingsApi.loadPage(page).then ({body, ok}) =>
      return unless ok
      ratings = body.ratings.map (rating) -> _.merge { page }, rating
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, 'ratings', body.meta.pagesCount

  getForUser: (userId, page) ->
    @app.ratingsApi.loadForUser(userId, page).then ({body, ok}) =>
      return unless ok
      ratings = body.ratings.map (rating) -> _.merge { page }, rating
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, 'userRatings', body.meta.pagesCount

  getForSection: (sectionId, page) ->
    @app.ratingsApi.loadForSection(sectionId, page).then ({body, ok}) =>
      return unless ok
      ratings = body.ratings.map (rating) -> _.merge { page }, rating
      @dispatch Constants.APPEND_RATINGS, ratings
      @dispatch Constants.SET_PAGES_COUNT, "sectionRatings-#{sectionId}", body.meta.pagesCount

  get: (id) ->
    @app.ratingsApi.load(id).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_RATINGS, body.rating

module.exports = RatingsQueries
