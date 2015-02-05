Marty = require 'marty'
RatingsSourceActionCreators = require '../actions/ratings_source_action_creators'

RatingsApi = Marty.createStateSource
  type: 'http'
  baseUrl: '/api/private/ratings'

  index: ->
    @get(url: '').then ({body}) ->
      return unless body?
      RatingsSourceActionCreators.addRatings body

module.exports = RatingsApi
