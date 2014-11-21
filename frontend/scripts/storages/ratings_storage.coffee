BaseStorage = require './base_storage'
Rating = require '../models/rating'

class RatingsStorage extends BaseStorage
  constructor: ->
    @clear()

  getRatings: ->
    @ratings

  preload: (ratings) ->
    @ratings = ratings.map (rating) -> new Rating rating

  clear: ->
    @ratings = []

module.exports = new RatingsStorage
