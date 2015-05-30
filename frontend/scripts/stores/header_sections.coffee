Marty = require 'marty'
Constants = require '../constants'
Section = require '../models/section'

class HeaderSectionsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_HEADER_SECTIONS

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
        @app.headerSectionsQueries.getAll()

  set: (sections) ->
    @state = sections

module.exports = HeaderSectionsStore
