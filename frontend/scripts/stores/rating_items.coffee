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

  change: (id, changes) ->
    ratingItem = _.find @state, (ratingItem) -> ratingItem.id == id
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

module.exports = Marty.register RatingItemsStore
