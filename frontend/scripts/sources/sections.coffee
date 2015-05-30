Marty = require 'marty'

class SectionsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/sections'

  load: (id) ->
    @get id

  loadAll: (page) ->
    @get ''

module.exports = SectionsApi
