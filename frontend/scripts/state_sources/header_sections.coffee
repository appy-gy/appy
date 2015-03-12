Marty = require 'marty'
HeaderSectionsActionCreators = require '../action_creators/header_sections'
Section = require '../models/section'

HeaderSectionsApi = Marty.createStateSource
  type: 'http'
  baseUrl: '/api/private/header_sections'

  loadAll: ->
    @get url: ''
      .then ({body}) ->
        return unless body?
        sections = body.sections.map (section) -> new Section section
        HeaderSectionsActionCreators.set sections

module.exports = HeaderSectionsApi
