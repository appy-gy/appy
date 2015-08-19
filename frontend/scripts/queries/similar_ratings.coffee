Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'

class SimilarRatingsQueries extends Marty.Queries
  getFor: (ratingId) ->
    @app.similarRatingsApi.loadFor(ratingId).then ({body, status}) =>
      return unless status == 200
      ratings = body.ratings.map (rating) -> new Rating rating
      @dispatch Constants.SET_SIMILAR_RATINGS, ratingId, ratings

module.exports = SimilarRatingsQueries
