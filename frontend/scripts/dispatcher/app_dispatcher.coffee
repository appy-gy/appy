Dispatcher = require('flux').Dispatcher
AppDispatcher = new Dispatcher

AppDispatcher.handleViewAction = (action) ->
  console.log action
  @dispatch
    source: 'VIEW_ACTION',
    action: action

module.exports = AppDispatcher
