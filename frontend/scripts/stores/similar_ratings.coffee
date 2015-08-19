_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'

{update} = React.addons

class SimilarRatingsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_SIMILAR_RATINGS

  getInitialState: ->
    {}

  rehydrate: (state) ->
    @state = _.mapValues state, (ratings) ->
      ratings.map (rating) -> new Rating rating

  getFor: (ratingId) ->
    id = "getFor-#{ratingId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state[ratingId]
      remotely: ->
        @app.similarRatingsQueries.getFor(ratingId)

  set: (ratingId, similarRatings) ->
    @state = update @state, "#{ratingId}": { $set: similarRatings }

module.exports = SimilarRatingsStore
