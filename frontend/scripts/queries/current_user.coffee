Marty = require 'marty'
Constants = require '../constants'

class CurrentUserQueries extends Marty.Queries
  get: ->
    @app.currentUserApi.load().then ({body, ok}) =>
      return unless ok
      @dispatch Constants.SET_CURRENT_USER, body.user

module.exports = CurrentUserQueries
