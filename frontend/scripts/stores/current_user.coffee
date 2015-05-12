Marty = require 'marty'
CurrentUserConstants = require '../constants/current_user'
CurrentUserQueries = require '../queries/current_user'
User = require '../models/user'

class CurrentUserStore extends Marty.Store
  @id: 'CurrentUserStore'

  constructor: ->
    super
    @handlers =
      set: CurrentUserConstants.SET_CURRENT_USER

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
        CurrentUserQueries.for(@).get()

  set: (user) ->
    user = new User unless user?
    @state = user

module.exports = Marty.register CurrentUserStore
