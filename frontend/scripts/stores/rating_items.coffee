_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
RatingItemConstants = require '../constants/rating_items'
RatingItem = require '../models/rating_item'
RatingItemQueries = require '../queries/rating_items'

{update} = React.addons

class RatingItemsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      change: RatingItemConstants.CHANGE_RATING_ITEM
      replace: RatingItemConstants.REPLACE_RATING_ITEM
      append: RatingItemConstants.APPEND_RATING_ITEMS

  rehydrate: (state) ->
    ratingItems = state.map (ratingItem) -> new RatingItem ratingItem
    @append ratingItems

  getForRating: (ratingId) ->
    id = "getForRating-#{ratingId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        RatingItemQueries.for(@).getForRating(ratingId)

  change: (ratingItemOrId, changes) ->
    ratingItem = findInStore @, ratingItemOrId
    return unless ratingItem?
    ratingItem.update changes
    @hasChanged()

  replace: (ratingItem) ->
    index = findIndexInStore @, ratingItem
    return if index < 0
    @state = update @state, $splice: [[index, 1, ratingItem]]

  append: (ratingItems) ->
    @state = update @state, $push: toArray(ratingItems)

module.exports = Marty.register RatingItemsStore
