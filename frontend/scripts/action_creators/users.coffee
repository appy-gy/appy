Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
UserConstants = require '../constants/users'
UsersApi = require '../state_sources/users'
User = require '../models/user'

class UserActionCreators extends Marty.ActionCreators
  append: autoDispatch UserConstants.APPEND_USERS
  change: autoDispatch UserConstants.CHANGE_USER

  update: (user) ->
    UsersApi.update(user).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch UserConstants.REPLACE_USER, user

module.exports = Marty.register UserActionCreators
