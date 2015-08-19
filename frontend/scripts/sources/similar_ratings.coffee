Marty = require 'marty'

class SimilarRatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/ratings'

  loadFor: (ratingId) ->
    @get "#{ratingId}/similar"

module.exports = SimilarRatingsApi
