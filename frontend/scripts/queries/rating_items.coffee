Marty = require 'marty'
Constants = require '../constants'
RatingItem = require '../models/rating_item'

class RatingItemsQueries extends Marty.Queries
  getForRating: (ratingId) ->
    @app.ratingItemsApi.loadForRating(ratingId).then ({body}) =>
      return unless body?
      ratingItems = body.rating_items.map (item) -> new RatingItem item
      @dispatch Constants.APPEND_RATING_ITEMS, ratingItems

module.exports = RatingItemsQueries
