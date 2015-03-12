env = require '../env'
Marty = require 'marty'
User = require '../models/user'
CurrentUserActionCreators = require '../action_creators/current_user'

CurrentUserApi = Marty.createStateSource
  type: 'http'
  baseUrl: "#{env.host}/api/mobile/sessions"

  load: ->
    @get url: ''
      .then ({body}) ->
        return unless body?
        user = new User body.current_user
        CurrentUserActionCreators.set user

  logIn: (email, password) ->
    body = user: { email, password }
    @post { url: '', body }
      .then ({body}) ->
        user = new User body.current_user
        CurrentUserActionCreators.set user

  logOut: ->
    @delete url: ''
      .then ({body}) ->
        return unless body.success
        CurrentUserActionCreators.set null

module.exports = CurrentUserApi
