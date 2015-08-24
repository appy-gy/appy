Marty = require 'marty'
Qs = require 'qs'

class TagsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  autocomplete: (query) ->
    query = Qs.stringify { query }
    url = "tags?#{query}"
    @get { url }

  popular: ->
    @get url: 'tags/popular'

  addToRating: (ratingId, name) ->
    @post url: "ratings/#{ratingId}/tags", body: { name }

  removeFromRating: (ratingId, name) ->
    @delete url: "ratings/#{ratingId}/tags", body: { name }

module.exports = TagsApi
