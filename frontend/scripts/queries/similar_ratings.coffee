Marty = require 'marty'
Constants = require '../constants'

class SimilarRatingsQueries extends Marty.Queries
  getFor: (ratingId) ->
    @app.similarRatingsApi.loadFor(ratingId).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.SET_SIMILAR_RATINGS, ratingId, body.ratings

module.exports = SimilarRatingsQueries
