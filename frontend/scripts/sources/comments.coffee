Marty = require 'marty'
Qs = require 'qs'
snakecaseKeys = require '../helpers/snakecase_keys'

class CommentsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  loadForRating: (ratingId) ->
    @get "ratings/#{ratingId}/comments"

  loadForUser: (userId, page) ->
    query = Qs.stringify { page }
    @get "users/#{userId}/comments?#{query}"

  create: (ratingId, data) ->
    url = "ratings/#{ratingId}/comments"
    body = comment: snakecaseKeys(data)
    @post { url, body }

module.exports = CommentsApi
