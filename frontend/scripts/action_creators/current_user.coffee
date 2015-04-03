Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
CurrentUserConstants = require '../constants/current_user'
CurrentUserApi = require '../state_sources/current_user'
User = require '../models/user'

class CurrentUserActionCreators extends Marty.ActionCreators
  set: autoDispatch CurrentUserConstants.SET_CURRENT_USER

  logIn: (data) ->
    CurrentUserApi.logIn(data).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch CurrentUserConstants.SET_CURRENT_USER, user
      user

  logOut: ->
    CurrentUserApi.logOut().then ({body}) =>
      return unless body.success
      @dispatch CurrentUserConstants.SET_CURRENT_USER, null

  register: (data) ->
    CurrentUserApi.register(data).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch CurrentUserConstants.SET_CURRENT_USER, user
      user

module.exports = Marty.register CurrentUserActionCreators
