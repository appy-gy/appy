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

  update: (rating, changes) ->
    url = "ratings/#{rating.id}"
    body = toFormData rating: snakecaseKeys(changes)
    @put { url, body }

module.exports = Marty.register RatingsApi
