Marty = require 'marty'
Constants = require '../constants'
Section = require '../models/section'

class SectionsQueries extends Marty.Queries
  get: (id) ->
    @app.sectionsApi.load(id).then ({body}) =>
      return unless body?
      section = new Section body.section
      @dispatch Constants.APPEND_SECTIONS, section

  getAll: ->
    @app.sectionsApi.loadAll().then ({body}) =>
      return unless body?
      sections = body.sections.map (section) -> new Section section
      @dispatch Constants.APPEND_SECTIONS, sections

module.exports = SectionsQueries
