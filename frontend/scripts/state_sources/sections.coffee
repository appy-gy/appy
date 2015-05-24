Marty = require 'marty'

class SectionsApi extends Marty.HttpStateSource
  @id: 'SectionsApi'

  baseUrl: '/api/private/sections'

  load: (id) ->
    @get id

  loadAll: (page) ->
    @get ''

module.exports = Marty.register SectionsApi
