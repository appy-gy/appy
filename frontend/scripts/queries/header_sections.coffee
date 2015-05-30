Marty = require 'marty'
Constants = require '../constants'
Section = require '../models/section'

class HeaderSectionsQueries extends Marty.Queries
  getAll: ->
    @app.headerSectionsApi.loadAll().then ({body}) =>
      return unless body?
      sections = body.sections.map (section) -> new Section section
      @dispatch Constants.SET_HEADER_SECTIONS, sections

module.exports = HeaderSectionsQueries
