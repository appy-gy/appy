Marty = require 'marty'

class RatingsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/ratings'

  loadPage: (page) ->
    @get ''

  load: (id) ->
    @get id

module.exports = Marty.register RatingsApi
