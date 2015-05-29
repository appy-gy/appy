_ = require 'lodash'
Marty = require 'marty'
findInStore = require '../helpers/find_in_store'
RatingItemConstants = require '../constants/rating_items'
RatingItemsApi = require '../state_sources/rating_items'
RatingItemsStore = require '../stores/rating_items'
RatingItem = require '../models/rating_item'

class RatingItemActionCreators extends Marty.ActionCreators
  @id: 'RatingItemActionCreators'

  create: (ratingId) ->
    position = (_.max(RatingItemsStore.getState(), 'position')?.position or 0) + 1
    data = { ratingId, position }

    RatingItemsApi.create(ratingId, data).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch RatingItemConstants.APPEND_RATING_ITEMS, ratingItem

  change: (ratingItemId, changes) ->
    @dispatch RatingItemConstants.CHANGE_RATING_ITEM, ratingItemId, changes

  update: (ratingItemId, changes) ->
    ratingItem = findInStore RatingItemsStore, ratingItemId

    RatingItemsApi.update(ratingItem.id, ratingItem.ratingId, changes).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch RatingItemConstants.REPLACE_RATING_ITEM, ratingItem

  updatePosition: (ratingItemId, newPosition) ->
    ratingItem = findInStore RatingItemsStore, ratingItemId
    @getRatingItemsFor ratingItem.ratingId, (ratingItems) =>
      max = _.max(ratingItems, 'position').position
      return unless 0 <= newPosition <= max

      ratingItems = _.without ratingItems, ratingItem
      index = _.findIndex ratingItems, (item) -> item.position == newPosition
      index += 1 if ratingItem.position < newPosition
      ratingItems.splice index, 0, ratingItem

      positions = _.transform ratingItems, (result, ratingItem, index) ->
        result[ratingItem.id] = index
      , {}

      RatingItemsApi.updatePositions(ratingItem.ratingId, positions).then ({body}) =>
        return unless body?
        @dispatch RatingItemConstants.CHANGE_RATING_ITEM_POSITIONS, body.positions

module.exports = Marty.register RatingItemActionCreators
