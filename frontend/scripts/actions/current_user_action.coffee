Dispatcher = require '../dispatcher'
BaseAction = require '../actions/base_action'

class CurrentUserAction extends BaseAction
  constructor: ->
    super()
    @name = 'current_user'

    @add 'login'
    @add 'logout'

module.exports = new CurrentUserAction
