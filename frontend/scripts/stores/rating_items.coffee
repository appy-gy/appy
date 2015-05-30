_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
RatingItem = require '../models/rating_item'

{update} = React.addons

class RatingItemsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      change: Constants.CHANGE_RATING_ITEM
      replace: Constants.REPLACE_RATING_ITEM
      append: Constants.APPEND_RATING_ITEMS
      changePositions: Constants.CHANGE_RATING_ITEM_POSITIONS

  getInitialState: ->
    []

  rehydrate: (state) ->
    ratingItems = state.map (ratingItem) -> new RatingItem ratingItem
    @append ratingItems

  getForRating: (ratingId) ->
    id = "getForRating-#{ratingId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, ratingId, all: true, fields: ['ratingId', 'ratingSlug']
      remotely: ->
        @app.ratingItemsQueries.getForRating(ratingId)

  change: (ratingItemId, changes) ->
    ratingItem = findInStore @, ratingItemId
    return unless ratingItem?
    ratingItem.update changes
    @hasChanged()

  replace: (ratingItem) ->
    index = findIndexInStore @, ratingItem
    return if index < 0
    @state = update @state, $splice: [[index, 1, ratingItem]]

  append: (ratingItems) ->
    @state = update @state, $push: toArray(ratingItems)

  changePositions: (positions) ->
    @state.each (ratingItem) ->
      position = positions[ratingItem.id]
      ratingItem.position = position if position?
    @hasChanged()

module.exports = RatingItemsStore
