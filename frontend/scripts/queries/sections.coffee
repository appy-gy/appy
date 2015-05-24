Marty = require 'marty'
SectionConstants = require '../constants/sections'
SectionsApi = require '../state_sources/sections'
Section = require '../models/section'

class SectionQueries extends Marty.Queries
  @id: 'SectionQueries'

  get: (id) ->
    SectionsApi.for(@).load(id).then ({body}) =>
      return unless body?
      section = new Section body.section
      @dispatch SectionConstants.APPEND_SECTIONS, section

  getAll: ->
    SectionsApi.for(@).loadAll().then ({body}) =>
      return unless body?
      sections = body.sections.map (section) -> new Section section
      @dispatch SectionConstants.APPEND_SECTIONS, sections

module.exports = Marty.register SectionQueries
