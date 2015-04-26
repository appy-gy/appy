Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
findInStore = require '../helpers/find_in_store'
RatingConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
RatingsStore = require '../stores/ratings'
Rating = require '../models/rating'
TagsApi = require '../state_sources/tags'
Tag = require '../models/tag'

class RatingActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingConstants.APPEND_RATINGS

  change: (ratingOrId, changes) ->
    rating = findInStore RatingsStore, ratingOrId
    @dispatch RatingConstants.CHANGE_RATING, rating, changes

  save: (ratingOrId, changes) ->
    rating = findInStore RatingsStore, ratingOrId
    RatingsApi.update(rating.id, changes).then ({body}) =>
      return unless body?
      rating = new Rating body.rating
      @dispatch RatingConstants.REPLACE_RATING, rating

  addTag: (ratingOrId, name) ->
    rating = findInStore RatingsStore, ratingOrId
    tag = new Tag { name }
    @dispatch RatingConstants.ADD_TAG_TO_RATING, rating, tag
    TagsApi.addToRating rating.id, name

  removeTag: (ratingOrId, name) ->
    rating = findInStore RatingsStore, ratingOrId
    tag = new Tag { name }
    @dispatch RatingConstants.REMOVE_TAG_FROM_RATING, rating, tag
    TagsApi.removeFromRating rating.id, name

module.exports = Marty.register RatingActionCreators
