Marty = require 'marty'
HeaderSectionConstants = require '../constants/header_sections'
HeaderSectionQueries = require '../queries/header_sections'
Section = require '../models/section'

class HeaderSectionsStore extends Marty.Store
  @id: 'HeaderSectionsStore'

  constructor: ->
    super
    @handlers =
      set: HeaderSectionConstants.SET_HEADER_SECTIONS

  getInitialState: ->
    []

  rehydrate: (state) ->
    sections = state.map (section) -> new Section section
    @set sections

  getAll: ->
    @fetch
      id: 'getAll'
      locally: =>
        return unless @hasAlreadyFetched 'getAll'
        @state
      remotely: ->
        HeaderSectionQueries.for(@).getAll()

  set: (sections) ->
    @state = sections

module.exports = Marty.register HeaderSectionsStore
