Marty = require 'marty'
SectionConstants = require '../constants/sections'
SectionsApi = require '../state_sources/sections'
Section = require '../models/section'

class SectionQueries extends Marty.Queries
  getAll: ->
    SectionApi.loadAll().then ({body}) =>
      return unless body?
      sections = body.sections.map (section) -> new Section section
      @dispatch SectionConstants.APPEND_SECTIONS, sections

module.exports = Marty.register SectionQueries
