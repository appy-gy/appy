_ = require 'lodash'
Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
findInStore = require '../helpers/find_in_store'
RatingItemConstants = require '../constants/rating_items'
RatingItemsApi = require '../state_sources/rating_items'
RatingItemsStore = require '../stores/rating_items'
RatingItem = require '../models/rating_item'

class RatingItemActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingItemConstants.APPEND_RATING_ITEMS

  new: (ratingId) ->
    ratingItems = RatingItemsStore.getState()
    position = (_.max(ratingItems, 'position')?.position or 0) + 1

    ratingItem =  new RatingItem { ratingId, position }
    @dispatch RatingItemConstants.APPEND_RATING_ITEMS, ratingItem

  change: (ratingItemOrId, changes) ->
    ratingItem = findInStore RatingItemsStore, ratingItemOrId
    @dispatch RatingItemConstants.CHANGE_RATING_ITEM, ratingItem, changes

  save: (ratingItemOrId, changes) ->
    ratingItem = findInStore RatingItemsStore, ratingItemOrId
    method = if ratingItem.isPersisted() then 'update' else 'create'
    ids = [ratingItem.ratingId]
    ids.unshift ratingItem.id if ratingItem.isPersisted()
    _.merge changes, _.pick(ratingItem, 'position') if ratingItem.isNewRecord()

    RatingItemsApi[method](ids..., changes).then ({body}) =>
      return unless body?
      newRatingItem = new RatingItem body.rating_item
      newRatingItem.cid = ratingItem.cid
      @dispatch RatingItemConstants.REPLACE_RATING_ITEM, newRatingItem

module.exports = Marty.register RatingItemActionCreators
