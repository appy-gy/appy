Marty = require 'marty'
RatingsActionCreators = require '../action_creators/ratings'
Rating = require '../models/rating'

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
        RatingsActionCreators.append [rating]

module.exports = RatingsApi
