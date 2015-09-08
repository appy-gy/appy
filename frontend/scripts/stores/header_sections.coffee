Marty = require 'marty'
Constants = require '../constants'

class HeaderSectionsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_HEADER_SECTIONS

  getInitialState: ->
    []

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
