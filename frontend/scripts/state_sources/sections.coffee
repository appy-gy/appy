Marty = require 'marty'
SectionsActionCreators = require '../action_creators/sections'
Section = require '../models/section'

SectionsApi = Marty.createStateSource
  type: 'http'
  baseUrl: '/api/private/sections'

  getAll: (page) ->
    @get url: ''
      .then ({body}) ->
        return unless body?
        sections = body.sections.map (section) -> new Section section
        SectionsActionCreators.append sections

module.exports = SectionsApi
