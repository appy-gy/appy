Marty = require 'marty'
Constants = require '../constants'

class UsersQueries extends Marty.Queries
  get: (id) ->
    @app.usersApi.load(id).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_USERS, body.user

module.exports = UsersQueries
