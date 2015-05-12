_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
RatingItemConstants = require '../constants/rating_items'
RatingItemQueries = require '../queries/rating_items'
RatingItem = require '../models/rating_item'

{update} = React.addons

class RatingItemsStore extends Marty.Store
  @id: 'RatingItemsStore'

  constructor: ->
    super
    @handlers =
      change: RatingItemConstants.CHANGE_RATING_ITEM
      replace: RatingItemConstants.REPLACE_RATING_ITEM
      append: RatingItemConstants.APPEND_RATING_ITEMS
      changePositions: RatingItemConstants.CHANGE_RATING_ITEM_POSITIONS

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
        @state.filter (ratingItem) -> ratingItem.ratingId == ratingId
      remotely: ->
        RatingItemQueries.for(@).getForRating(ratingId)

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

module.exports = Marty.register RatingItemsStore
