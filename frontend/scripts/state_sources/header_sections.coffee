Marty = require 'marty'

class HeaderSectionsApi extends Marty.HttpStateSource
  @id: 'HeaderSectionsApi'

  baseUrl: '/api/private/header_sections'

  loadAll: ->
    @get ''

module.exports = Marty.register HeaderSectionsApi
