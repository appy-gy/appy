_ = require 'lodash'
RatingsApi = require '../sources/ratings_api'
RatingsConstants = require '../constants/ratings_constants'
Rating = require '../models/rating'
Marty = require 'marty'

RatingsStore = Marty.createStore
  displayName: 'Ratings'

  handlers:
    addRatings: RatingsConstants.ADD_RATINGS

  getInitialState: ->
    {}

  show: (id) ->
    @fetch
      id: id
      dependsOn: @index()
      locally: ->
        _.findWhere _.values @state, { id } || null

  index: ->
    @fetch
      id: 'get'
      locally: ->
        return unless @hasAlreadyFetched 'get'
        @state
      remotely: ->
        RatingsApi.index()

  addRatings: ({ratings}) ->
    ratings.each (rating) => @state[rating.id] =  new Rating rating
    @hasChanged()

module.exports = RatingsStore
