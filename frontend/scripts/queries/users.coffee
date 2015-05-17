Marty = require 'marty'
UserConstants = require '../constants/users'
UsersApi = require '../state_sources/users'
User = require '../models/user'

class UserQueries extends Marty.Queries
  @id: 'UserQueries'

  get: (id) ->
    UsersApi.for(@).load(id).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch UserConstants.APPEND_USERS, user

module.exports = Marty.register UserQueries
