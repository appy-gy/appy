Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingsApi extends Marty.HttpStateSource
  @id: 'RatingsApi'

  baseUrl: '/api/private'

  loadPage: (page) ->
    @get "ratings"

  loadForUser: (userId) ->
    @get "users/#{userId}/ratings"

  loadForSection: (sectionId) ->
    @get "sections/#{sectionId}/ratings"

  load: (id) ->
    @get "ratings/#{id}"

  update: (id, changes) ->
    url = "ratings/#{id}"
    body = toFormData rating: snakecaseKeys(changes)
    @put { url, body }

  create: ->
    @post "ratings"

module.exports = Marty.register RatingsApi
