Marty = require 'marty'

class SectionsApi extends Marty.HttpStateSource
  @id: 'SectionsApi'

  baseUrl: '/api/private/sections'

  loadAll: (page) ->
    @get ''

module.exports = Marty.register SectionsApi
