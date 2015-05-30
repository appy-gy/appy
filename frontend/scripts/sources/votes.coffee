Marty = require 'marty'

class VotesApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  create: (ratingItemId, kind) ->
    url = "rating_items/#{ratingItemId}/votes"
    body = vote: { kind }
    @post { url, body }

module.exports = VotesApi
