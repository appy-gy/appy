Marty = require 'marty'

class SectionsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/sections'

  loadAll: (page) ->
    @get ''

module.exports = Marty.register SectionsApi
