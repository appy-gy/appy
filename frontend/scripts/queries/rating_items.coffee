Marty = require 'marty'
Constants = require '../constants'

class RatingItemsQueries extends Marty.Queries
  getForRating: (ratingId) ->
    @app.ratingItemsApi.loadForRating(ratingId).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_RATING_ITEMS, body.ratingItems

module.exports = RatingItemsQueries
