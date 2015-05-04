Marty = require 'marty'
RatingItemConstants = require '../constants/rating_items'
RatingItemsApi = require '../state_sources/rating_items'
RatingItem = require '../models/rating_item'

class RatingItemQueries extends Marty.Queries
  @id: 'RatingItemQueries'

  getForRating: (ratingId) ->
    RatingItemsApi.for(@).loadForRating(ratingId).then ({body}) =>
      return unless body?
      ratingItems = body.rating_items.map (item) -> new RatingItem item
      @dispatch RatingItemConstants.APPEND_RATING_ITEMS, ratingItems

module.exports = Marty.register RatingItemQueries
