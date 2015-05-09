Marty = require 'marty'

class VotesApi extends Marty.HttpStateSource
  @id: 'VotesApi'

  baseUrl: '/api/private'

  create: (ratingItemId, kind) ->
    url = "rating_items/#{ratingItemId}/votes"
    body = vote: { kind }
    @post { url, body }

module.exports = Marty.register VotesApi
