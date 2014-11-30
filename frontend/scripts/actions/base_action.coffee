Dispatcher = require '../dispatcher'

class BaseAction
  add: (type) ->
    action = [@name, type].join ':'
    @[type] = (data) ->
      Dispatcher.dispatch { action, data }

module.exports = BaseAction
