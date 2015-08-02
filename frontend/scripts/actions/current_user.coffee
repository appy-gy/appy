Marty = require 'marty'
Constants = require '../constants'
User = require '../models/user'

{autoDispatch} = Marty

class CurrentUserActions extends Marty.ActionCreators
  set: autoDispatch Constants.SET_CURRENT_USER

  logIn: (data) ->
    @app.currentUserApi.logIn(data).then ({body, status}) =>
      return error: body.error unless status == 200
      user = new User body.user
      @dispatch Constants.SET_CURRENT_USER, user
      user

  logOut: ->
    @app.currentUserApi.logOut().then ({body}) =>
      return unless body.success
      @dispatch Constants.SET_CURRENT_USER, null

  register: (data) ->
    @app.currentUserApi.register(data).then ({body, status}) =>
      return error: body.error unless status == 200
      user = new User body.user
      @dispatch Constants.SET_CURRENT_USER, user
      user

module.exports = CurrentUserActions
