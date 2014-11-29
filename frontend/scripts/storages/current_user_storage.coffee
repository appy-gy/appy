$ = require 'jquery'
BaseStorage = require './base_storage'
User = require '../models/user'
Dispatcher = require '../dispatcher'

class CurrentUserStorage extends BaseStorage
  constructor: ->
    super()
    @name = 'current_user'
    @clear()

    @register 'login', @login
    @register 'logout', @logout

  preload: (user) ->
    @user = new User user

  clear: ->
    @user = new User

  getUser: ->
    @user

  login: (data) =>
    $.post '/api/private/user_sessions', user_session: data
      .done ({user}) =>
        return unless user?
        @user = new User user
        @emit 'change'

  logout: =>
    $.ajax(
      url: "/api/private/user_sessions/#{@user.id}"
      type: 'DELETE'
    ).done =>
      @clear()
      @emit 'change'

module.exports = new CurrentUserStorage
