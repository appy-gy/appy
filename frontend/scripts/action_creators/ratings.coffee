Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
RatingConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
RatingsStore = require '../stores/ratings'
Rating = require '../models/rating'
TagsApi = require '../state_sources/tags'
Tag = require '../models/tag'
LikesApi = require '../state_sources/likes'
Like = require '../models/like'

class RatingActionCreators extends Marty.ActionCreators
  @id: 'RatingActionCreators'

  append: autoDispatch RatingConstants.APPEND_RATINGS

  create: ->
    RatingsApi.create()

  change: (ratingId, changes) ->
    @dispatch RatingConstants.CHANGE_RATING, ratingId, changes

  update: (ratingId, changes) ->
    RatingsApi.update(ratingId, changes).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch RatingConstants.REPLACE_RATING, rating

  addTag: (ratingId, name) ->
    tag = new Tag { name }
    @dispatch RatingConstants.ADD_TAG_TO_RATING, ratingId, tag
    TagsApi.for(@).addToRating ratingId, name

  removeTag: (ratingId, name) ->
    tag = new Tag { name }
    @dispatch RatingConstants.REMOVE_TAG_FROM_RATING, ratingId, tag
    TagsApi.for(@).removeFromRating ratingId, name

  like: (ratingId) ->
    LikesApi.create(ratingId).then ({body, status}) =>
      return if status == 400
      like = new Like body.like
      likesCount = body.meta.likes_count
      @dispatch RatingConstants.CHANGE_RATING, ratingId, { like, likesCount }

module.exports = Marty.register RatingActionCreators
