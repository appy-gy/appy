Marty = require 'marty'
UsersConstants = require '../constants/users'
UsersApi = require '../state_sources/users'
User = require '../models/user'

class UsersQueries extends Marty.Queries
  get: (id) ->
    UsersApi.for(@).load(id).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch UsersConstants.APPEND_USERS, user

module.exports = Marty.register UsersQueries
