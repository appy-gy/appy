Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
RatingItemConstants = require '../constants/rating_items'
RatingItemsApi = require '../state_sources/rating_items'
RatingItem = require '../models/rating_item'

class RatingItemsActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingItemConstants.APPEND_RATING_ITEMS
  change: autoDispatch RatingItemConstants.CHANGE_RATING_ITEM

  update: (id, changes) ->
    RatingItemsApi.update(id, changes).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch RatingItemConstants.REPLACE_RATING_ITEM, rating_item

module.exports = Marty.register RatingItemsActionCreators
