_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
RatingItemConstants = require '../constants/rating_items'
RatingItem = require '../models/rating_item'

{update} = React.addons

class RatingItemsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      change: RatingItemConstants.CHANGE_RATING_ITEM
      append: RatingItemConstants.APPEND_RATING_ITEMS

  change: (id, changes) ->
    console.log @state
    ratingItem = _.find @state, (ratingItem) -> ratingItem.id == id
    return unless ratingItem?
    ratingItem.update changes
    @hasChanged()

  append: (ratingItems) ->
    @state = update @state, $push: toArray(ratingItems)

module.exports = Marty.register RatingItemsStore
