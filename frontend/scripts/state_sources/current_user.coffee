Marty = require 'marty'
User = require '../models/user'
CurrentUserActionCreators = require '../action_creators/current_user'

CurrentUserApi = Marty.createStateSource
  type: 'http'
  baseUrl: "/api/private"

  load: ->
    @get url: 'sessions'
      .then ({body}) ->
        return unless body?
        user = new User body.user
        CurrentUserActionCreators.set user

  logIn: ({email, password}) ->
    body = session: { email, password }

    @post { url: 'sessions', body }
      .then ({body}) ->
        return unless body?
        user = new User body.user
        CurrentUserActionCreators.set user
        user

  logOut: ->
    @delete url: 'sessions'
      .then ({body}) ->
        return unless body.success
        CurrentUserActionCreators.set null

  register: ({email, password}) ->
    body = user: { email, password }

    @post { url: 'users', body }
      .then ({body}) ->
        return unless body?
        user = new User body.user
        CurrentUserActionCreators.set user
        user

module.exports = CurrentUserApi
