Marty = require 'marty'
CurrentUserConstants = require '../constants/current_user'
CurrentUserApi = require '../state_sources/current_user'
User = require '../models/user'

class CurrentUserQueries extends Marty.Queries
  get: ->
    CurrentUserApi.load().then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch CurrentUserConstants.SET_CURRENT_USER, user

module.exports = Marty.register CurrentUserQueries
