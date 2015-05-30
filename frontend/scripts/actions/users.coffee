Marty = require 'marty'
Constants = require '../constants'
User = require '../models/user'

{autoDispatch} = Marty

class UsersActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_USERS
  change: autoDispatch Constants.CHANGE_USER

  update: (id, changes) ->
    @app.usersApi.update(id, changes).then ({body}) =>
      return unless body?
      user = new User body.user
      @dispatch Constants.REPLACE_USER, user

module.exports = UsersActions
