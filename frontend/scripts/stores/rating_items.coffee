_ = require 'lodash'
toArray = require '../helpers/to_array'
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
      append: RatingItemConstants.APPEND_RATING_ITEMS

  rehydrate: (state) ->
    ratingItems = state.map (item) -> new RatingItem item
    @append ratingItems

  change: (item, changes) ->
    ratingItem = _.find @state, (ratingItem) -> if ratingItem.id then item.id == ratingItem.id else item.cid == ratingItem.cid
    return unless ratingItem?
    ratingItem.update changes
    @hasChanged()

  getForRating: (ratingId) ->
    @fetch
      id: "getForRating-#{ratingId}"
      locally: ->
        return unless @hasAlreadyFetched "getForRating-#{ratingId}"
        @state
      remotely: ->
        RatingItemQueries.for(@).getForRating(ratingId)

  append: (ratingItems) ->
    @state = update @state, $push: toArray(ratingItems)

  replace: (rating) ->
    index = _.findIndex @state, (r) -> if rating.id then r.id == rating.id else r.cid == rating.cid
    return if index < 0
    @state = update @state, $splice: [[index, 1, rating]]

module.exports = Marty.register RatingItemsStore
