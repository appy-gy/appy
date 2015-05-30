Marty = require 'marty'
Constants = require '../constants'
User = require '../models/user'

class UsersQueries extends Marty.Queries
  get: (id) ->
    @app.usersApi.load(id).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch Constants.APPEND_USERS, user

module.exports = UsersQueries
