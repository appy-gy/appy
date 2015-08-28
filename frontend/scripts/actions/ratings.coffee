_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'
Tag = require '../models/tag'
Like = require '../models/like'

{autoDispatch} = Marty

class RatingsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_RATINGS

  create: ->
    @app.ratingsApi.create()

  change: (ratingId, changes) ->
    @dispatch Constants.CHANGE_RATING, ratingId, changes

  update: (ratingId, changes) ->
    @app.ratingsApi.update(ratingId, changes).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch Constants.REPLACE_RATING, rating

  remove: (ratingId) ->
    @app.ratingsApi.remove(ratingId).then ({body}) =>
      return unless body.success
      @dispatch Constants.REMOVE_RATING, ratingId

  addTag: (ratingId, name) ->
    tag = new Tag { name }
    @dispatch Constants.ADD_TAG_TO_RATING, ratingId, tag
    @app.tagsApi.addToRating ratingId, name

  removeTag: (ratingId, name) ->
    tag = new Tag { name }
    @dispatch Constants.REMOVE_TAG_FROM_RATING, ratingId, tag
    @app.tagsApi.removeFromRating ratingId, name

  like: (ratingId) ->
    @app.likesApi.create(ratingId).then ({body, status}) =>
      return unless status == 200
      like = new Like body.like
      likesCount = body.meta.likes_count
      @dispatch Constants.CHANGE_RATING, ratingId, { like, likesCount }

  unlike: (ratingId) ->
    @app.likesApi.destroy(ratingId).then ({body}) =>
      return unless body.success
      likesCount = body.meta.likes_count
      @dispatch Constants.CHANGE_RATING, ratingId, { like: null, likesCount }

  changePositions: (positions) ->
    @dispatch Constants.CHANGE_RATING_ITEM_POSITIONS, positions

  updatePositions: (ratingId) ->
    ratingItems = @app.ratingItemsStore.getForRating(ratingId).result
    positions = _.transform ratingItems, (result, {id, position}) ->
      result[id] = position
    , {}

    @app.ratingsApi.updatePositions(ratingId, positions).then ({body, status}) =>
      return unless status == 200
      @changePositions body.positions

  view: (ratingId) ->
    @app.ratingsApi.view(ratingId).then ({body, status}) =>
      return unless status == 200
      @dispatch Constants.CHANGE_RATING, ratingId, viewsCount: body.viewsCount

module.exports = RatingsActions
