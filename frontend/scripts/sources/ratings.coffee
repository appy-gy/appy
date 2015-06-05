Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  loadPage: (page) ->
    @get "ratings"

  loadForUser: (userId) ->
    @get "users/#{userId}/ratings"

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
