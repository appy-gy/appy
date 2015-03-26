Marty = require 'marty'
RatingsActionCreators = require '../action_creators/ratings'
Rating = require '../models/rating'
snakecaseKeys = require '../helpers/snakecase_keys'

RatingsApi = Marty.createStateSource
  type: 'http'
  baseUrl: '/api/private/ratings'

  loadPage: (page) ->
    @get url: ''
      .then ({body}) ->
        return unless body?
        ratings = body.ratings.map (rating) -> new Rating rating
        RatingsActionCreators.append ratings

  load: (id) ->
    @get url: id
      .then ({body}) ->
        return unless body?
        rating = new Rating body.rating
        RatingsActionCreators.append rating

  update: (rating) ->
    console.log rating
    @put url: rating.id, body: { rating: snakecaseKeys(rating) }
      .then ({body}) ->
        rating = new Rating body.user
        RatingsActionCreators.change rating

module.exports = RatingsApi
