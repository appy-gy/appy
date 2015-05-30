Marty = require 'marty'
Constants = require '../constants'
User = require '../models/user'

class CurrentUserQueries extends Marty.Queries
  get: ->
    @app.currentUserApi.load().then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch Constants.SET_CURRENT_USER, user

module.exports = CurrentUserQueries
