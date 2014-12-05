BaseStore = require './base_store'
Rating = require '../models/rating'

class RatingsStore extends BaseStore
  constructor: ->
    super()
    @name = 'ratings'
    @clear()

  getRatings: ->
    @ratings

  preload: (ratings) ->
    @ratings = ratings.map (rating) -> new Rating rating

  clear: ->
    @ratings = []

module.exports = new RatingsStore
