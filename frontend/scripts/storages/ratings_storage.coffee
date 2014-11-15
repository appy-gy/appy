BaseStorage = require './base_storage'
Rating = require '../models/rating'

class RatingsStorage extends BaseStorage
  getRatings: ->
    @ratings

  preload: (ratings) ->
    @ratings = ratings.map (rating) -> new Rating rating

module.exports = new RatingsStorage
