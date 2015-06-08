Marty = require 'marty'
Qs = require 'qs'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  loadPage: (page) ->
    query = Qs.stringify { page }
    @get "ratings?#{query}"

  loadForUser: (userId, page) ->
    query = Qs.stringify { page }
    @get "users/#{userId}/ratings?#{query}"

  loadForSection: (sectionId) ->
    @get "sections/#{sectionId}/ratings"

  load: (id) ->
    @get "ratings/#{id}"

  create: ->
    @post "ratings"

  update: (id, changes) ->
    url = "ratings/#{id}"
    body = toFormData rating: snakecaseKeys(changes)
    @put { url, body }

  updatePositions: (id, positions) ->
    url = "ratings/#{id}/rating_items/positions"
    body = { positions }
    @put { url, body }

module.exports = RatingsApi
