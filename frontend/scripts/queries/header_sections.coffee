Marty = require 'marty'
Constants = require '../constants'

class HeaderSectionsQueries extends Marty.Queries
  getAll: ->
    @app.headerSectionsApi.loadAll().then ({body, ok}) =>
      return unless ok
      @dispatch Constants.SET_HEADER_SECTIONS, body.sections

module.exports = HeaderSectionsQueries
