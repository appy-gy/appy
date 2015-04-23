Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'

class CommentsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  loadForRating: (ratingId) ->
    @get "ratings/#{ratingId}/comments"

  create: (ratingId, data) ->
    url = "ratings/#{ratingId}/comments"
    body = comment: snakecaseKeys(data)
    @post { url, body }

module.exports = Marty.register CommentsApi
