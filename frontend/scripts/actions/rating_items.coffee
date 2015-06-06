_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
findInStore = require '../helpers/find_in_store'
Constants = require '../constants'
RatingItem = require '../models/rating_item'

{update} = React.addons

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

  changePosition: (ratingItemId, newPosition) ->
    positions = @computePositions ratingItemId, newPosition
    @dispatch Constants.CHANGE_RATING_ITEM_POSITIONS, positions

  computePositions: (ratingItemId, newPosition) ->
    ratingItem = findInStore @app.ratingItemsStore, ratingItemId
    ratingItems = _.sortBy @app.ratingItemsStore.getState(), 'position'
    index = _.findIndex ratingItems, ratingItem
    afterIndex = _.findIndex ratingItems, ({position}) -> position == newPosition

    newRatingItems = update ratingItems,
      $splice: [
        [index, 1]
        [afterIndex, 0, ratingItem]
      ]

    positions = _.transform newRatingItems, (result, ratingItem, index) ->
      result[ratingItem.id] = index
    , {}

module.exports = RatingItemsActions
