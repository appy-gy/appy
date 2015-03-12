Marty = require 'marty'
CurrentUserConstants = require '../constants/current_user'

CurrentUserActionCreators = Marty.createActionCreators
  set: CurrentUserConstants.SET_CURRENT_USER (user) ->
    @dispatch user

module.exports = CurrentUserActionCreators
