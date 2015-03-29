Marty = require 'marty'
HeaderSectionConstants = require '../constants/header_sections'
HeaderSectionsApi = require '../state_sources/header_sections'
Section = require '../models/section'

class HeaderSectionQueries extends Marty.Queries
  getAll: ->
    HeaderSectionsApi.loadAll().then ({body}) =>
      return unless body?
      sections = body.sections.map (section) -> new Section section
      @dispatch HeaderSectionConstants.SET_HEADER_SECTIONS, sections

module.exports = Marty.register HeaderSectionQueries
