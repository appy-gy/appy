_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
findInStore = require '../helpers/find_in_store'

{update} = React.addons

class RatingItemsActions extends Marty.ActionCreators
  create: (ratingId, position) ->
    @app.ratingItemsApi.create(ratingId, { position }).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_RATING_ITEMS, body.ratingItem

  change: (ratingItemId, changes) ->
    @dispatch Constants.CHANGE_RATING_ITEM, ratingItemId, changes

  update: (ratingItemId, changes, notSync) ->
    notSync = _.keys changes if notSync == true
    ratingItem = findInStore @app.ratingItemsStore, ratingItemId

    @app.ratingItemsApi.update(ratingItem.id, ratingItem.ratingId, changes).then ({body, ok}) =>
      return unless ok
      prevRatingItem = findInStore @app.ratingItemsStore, ratingItemId
      ratingItem = _.merge(_.omit(body.ratingItem, notSync), _.pick(prevRatingItem, notSync))
      @dispatch Constants.REPLACE_RATING_ITEM, ratingItem

  remove: (ratingItemId) ->
    ratingItem = findInStore @app.ratingItemsStore, ratingItemId

    @app.ratingItemsApi.remove(ratingItem.id, ratingItem.ratingId).then ({body}) =>
      return unless body.success
      @dispatch Constants.REMOVE_RATING_ITEM, ratingItem

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
