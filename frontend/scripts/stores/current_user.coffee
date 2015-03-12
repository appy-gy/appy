Marty = require 'marty'
CurrentUserConstants = require '../constants/current_user'
CurrentUserApi = require '../state_sources/current_user'
User = require '../models/user'

CurrentUserStore = Marty.createStore
  handlers:
    set: CurrentUserConstants.SET_CURRENT_USER

  getInitialState: ->
    new User

  get: ->
    @fetch
      id: 'get'
      locally: ->
        return unless @hasAlreadyFetched 'get'
        @state
      remotely: ->
        CurrentUserApi.load()

  set: (user) ->
    user = new User unless user?
    @state = user

module.exports = CurrentUserStore
