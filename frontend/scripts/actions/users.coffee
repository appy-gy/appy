Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class UsersActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_USERS
  change: autoDispatch Constants.CHANGE_USER

  update: (id, changes) ->
    @app.usersApi.update(id, changes).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.REPLACE_USER, body.user

module.exports = UsersActions
