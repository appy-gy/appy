{Dispatcher} = require 'flux'
AppDispatcher = new Dispatcher

AppDispatcher.handleViewAction = (action) ->
  @dispatch
    source: 'VIEW_ACTION',
    action: action

module.exports = AppDispatcher
