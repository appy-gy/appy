_ = require 'lodash'
Marty = require 'marty'
findInStore = require '../helpers/find_in_store'
Constants = require '../constants'
RatingItem = require '../models/rating_item'

class RatingItemsActions extends Marty.ActionCreators
  create: (ratingId) ->
    position = (_.max(@app.ratingItemsStore.getState(), 'position')?.position or 0) + 1
    data = { ratingId, position }

    @app.ratingItemsApi.create(ratingId, data).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch Constants.APPEND_RATING_ITEMS, ratingItem

  change: (ratingItemId, changes) ->
    @dispatch Constants.CHANGE_RATING_ITEM, ratingItemId, changes

  update: (ratingItemId, changes) ->
    ratingItem = findInStore @app.ratingItemsStore, ratingItemId

    @app.ratingItemsApi.update(ratingItem.id, ratingItem.ratingId, changes).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch Constants.REPLACE_RATING_ITEM, ratingItem

  updatePosition: (ratingItemId, newPosition) ->
    ratingItem = findInStore @app.ratingItemsStore, ratingItemId
    ratingItems = @app.ratingItemsStore.getState()
    max = _.max(ratingItems, 'position').position
    return unless 0 <= newPosition <= max

    ratingItems = _.without ratingItems, ratingItem
    index = _.findIndex ratingItems, (item) -> item.position == newPosition
    index += 1 if ratingItem.position < newPosition
    ratingItems.splice index, 0, ratingItem

    positions = _.transform ratingItems, (result, ratingItem, index) ->
      result[ratingItem.id] = index
    , {}

    @app.ratingItemsApi.updatePositions(ratingItem.ratingId, positions).then ({body}) =>
      return unless body?
      @dispatch Constants.CHANGE_RATING_ITEM_POSITIONS, body.positions

module.exports = RatingItemsActions
