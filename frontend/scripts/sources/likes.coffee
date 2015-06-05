Marty = require 'marty'

class LikesApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  create: (ratingId) ->
    @post "ratings/#{ratingId}/likes"

  destroy: (ratingId) ->
    @delete "ratings/#{ratingId}/likes"

module.exports = LikesApi