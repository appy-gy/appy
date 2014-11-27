AppDispatcher = require '../dispatcher/app_dispatcher'
BaseAction = require '../actions/base_action'

class CurrentUserAction extends BaseAction
  @login: (data) ->
    AppDispatcher.handleViewAction
      actionType: 'LOGIN',
      data: data

  @logout: (data) ->
    AppDispatcher.handleViewAction
      actionType: 'LOGOUT',
      data: data

module.exports = CurrentUserAction
