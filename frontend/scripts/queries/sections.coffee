Marty = require 'marty'
Constants = require '../constants'

class SectionsQueries extends Marty.Queries
  get: (id) ->
    @app.sectionsApi.load(id).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_SECTIONS, body.section

  getAll: ->
    @app.sectionsApi.loadAll().then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_SECTIONS, body.sections

module.exports = SectionsQueries
