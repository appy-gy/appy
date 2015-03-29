Marty = require 'marty'

class HeaderSectionsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/header_sections'

  loadAll: ->
    @get ''

module.exports = Marty.register HeaderSectionsApi
