_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'
findInStore = require '../helpers/find_in_store'

{autoDispatch} = Marty

class RatingsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_RATINGS

  create: ->
    @app.ratingsApi.create()

  change: (ratingId, changes) ->
    @dispatch Constants.CHANGE_RATING, ratingId, changes

  update: (ratingId, changes, notSync) ->
    notSync = _.keys changes if notSync == true
    @app.ratingsApi.update(ratingId, changes).then ({body, ok}) =>
      return unless ok
      prevRating = findInStore @app.ratingsStore, ratingId
      rating = _.merge(_.omit(body.rating, notSync), _.pick(prevRating, notSync))
      @dispatch Constants.REPLACE_RATING, rating

  remove: (ratingId) ->
    @app.ratingsApi.remove(ratingId).then ({body}) =>
      return unless body.success
      @dispatch Constants.REMOVE_RATING, ratingId

  addTag: (ratingId, name) ->
    tag = { name }
    @dispatch Constants.ADD_TAG_TO_RATING, ratingId, tag
    @app.tagsApi.addToRating ratingId, name

  removeTag: (ratingId, name) ->
    tag = { name }
    @dispatch Constants.REMOVE_TAG_FROM_RATING, ratingId, tag
    @app.tagsApi.removeFromRating ratingId, name

  like: (ratingId) ->
    @app.likesApi.create(ratingId).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.CHANGE_RATING, ratingId, like: body.like, likesCount: body.meta.likesCount

  unlike: (ratingId) ->
    @app.likesApi.destroy(ratingId).then ({body}) =>
      return unless body.success
      @dispatch Constants.CHANGE_RATING, ratingId, like: null, likesCount: body.meta.likesCount

  changePositions: (positions) ->
    @dispatch Constants.CHANGE_RATING_ITEM_POSITIONS, positions

  updatePositions: (ratingId) ->
    ratingItems = @app.ratingItemsStore.getForRating(ratingId).result
    positions = _.transform ratingItems, (result, {id, position}) ->
      result[id] = position
    , {}

    @app.ratingsApi.updatePositions(ratingId, positions).then ({body, ok}) =>
      return unless ok
      @changePositions body.positions

  view: (ratingId) ->
    @app.ratingsApi.view(ratingId).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.CHANGE_RATING, ratingId, viewsCount: body.viewsCount

module.exports = RatingsActions
