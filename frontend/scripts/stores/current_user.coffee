Marty = require 'marty'
Constants = require '../constants'

class CurrentUserStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_CURRENT_USER
      maybeSet: Constants.REPLACE_USER

  getInitialState: ->
    {}

  get: ->
    @fetch
      id: 'get'
      locally: ->
        return unless @hasAlreadyFetched 'get'
        @state
      remotely: ->
        @app.currentUserQueries.get()

  set: (user) ->
    @state = user || {}

  maybeSet: (user) ->
    return unless user.id == @state.id
    @set user

module.exports = CurrentUserStore
