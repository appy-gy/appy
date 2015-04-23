_ = require 'lodash'
Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
RatingItemConstants = require '../constants/rating_items'
RatingItemsApi = require '../state_sources/rating_items'
RatingItem = require '../models/rating_item'
RatingItemsStore = require '../stores/rating_items'

class RatingItemActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingItemConstants.APPEND_RATING_ITEMS
  change: autoDispatch RatingItemConstants.CHANGE_RATING_ITEM

  new: (ratingId) ->
    ratingItems = RatingItemsStore.getState()
    position = (_.last(ratingItems)?.position or 0) + 1

    ratingItem =  new RatingItem { ratingId, position }
    @dispatch RatingItemConstants.APPEND_RATING_ITEMS, ratingItem

  update: (item, changes) ->
    method = if item.isPersisted() then 'update' else 'create'
    _.merge changes, _.pick(item, 'position') if item.isNewRecord()

    RatingItemsApi[method](item, changes).then ({body}) =>
      return unless body?
      ratingItem = new RatingItem body.rating_item
      @dispatch RatingItemConstants.REPLACE_RATING_ITEM, ratingItem

module.exports = Marty.register RatingItemActionCreators
