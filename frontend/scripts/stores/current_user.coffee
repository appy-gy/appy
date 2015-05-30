Marty = require 'marty'
Constants = require '../constants'
User = require '../models/user'

class CurrentUserStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_CURRENT_USER

  getInitialState: ->
    new User

  rehydrate: (state) ->
    user = new User state
    @set user

  get: ->
    @fetch
      id: 'get'
      locally: ->
        return unless @hasAlreadyFetched 'get'
        @state
      remotely: ->
        @app.currentUserQueries.get()

  set: (user) ->
    user = new User unless user?
    @state = user

module.exports = CurrentUserStore
