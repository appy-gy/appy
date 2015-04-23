Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  loadPage: (page) ->
    @get 'ratings'

  loadForUser: (userId) ->
    @get "users/#{userId}/ratings"

  load: (id) ->
    @get "ratings/#{id}"

  update: (id, changes) ->
    url = "ratings/#{id}"
    body = toFormData rating: snakecaseKeys(changes)
    @put { url, body }

module.exports = Marty.register RatingsApi
