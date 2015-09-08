Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class CurrentUserActions extends Marty.ActionCreators
  set: autoDispatch Constants.SET_CURRENT_USER

  logIn: (data) ->
    @app.currentUserApi.logIn(data).then ({body, ok}) =>
      return error: body.error unless ok
      @dispatch Constants.SET_CURRENT_USER, body.user
      body.user

  logOut: ->
    @app.currentUserApi.logOut().then ({body}) =>
      return unless body.success
      @dispatch Constants.SET_CURRENT_USER, null

  register: (data) ->
    @app.currentUserApi.register(data).then ({body, ok}) =>
      return error: body.error unless ok
      @dispatch Constants.SET_CURRENT_USER, body.user
      body.user

module.exports = CurrentUserActions
