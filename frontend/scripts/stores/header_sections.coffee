Marty = require 'marty'
HeaderSectionConstants = require '../constants/header_sections'
HeaderSectionQueries = require '../queries/header_sections'

class HeaderSectionsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      set: HeaderSectionConstants.SET_HEADER_SECTIONS

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
