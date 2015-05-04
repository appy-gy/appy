Marty = require 'marty'

class LikesApi extends Marty.HttpStateSource
  @id: 'LikesApi'

  baseUrl: '/api/private'

  create: (ratingId) ->
    @post "ratings/#{ratingId}/likes"

module.exports = Marty.register LikesApi
