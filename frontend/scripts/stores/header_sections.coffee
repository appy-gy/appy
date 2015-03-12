Marty = require 'marty'
HeaderSectionsConstants = require '../constants/header_sections'
HeaderSectionsApi = require '../state_sources/header_sections'

HeaderSectionsStore = Marty.createStore
  handlers:
    set: HeaderSectionsConstants.SET_HEADER_SECTIONS

  getInitialState: ->
    []

  getAll: ->
    @fetch
      id: 'getAll'
      locally: =>
        return unless @hasAlreadyFetched 'getAll'
        @state
      remotely: ->
        HeaderSectionsApi.loadAll()

  set: (sections) ->
    @state = sections

module.exports = HeaderSectionsStore
