Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/ratings'

  loadPage: (page) ->
    @get ''

  load: (id) ->
    @get id

  update: (id, changes) ->
    body = toFormData(rating: snakecaseKeys(changes))
    @put { url: id, body}

module.exports = Marty.register RatingsApi
