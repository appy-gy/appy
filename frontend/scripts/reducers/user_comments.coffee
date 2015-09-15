_ = require 'lodash'
ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver name: 'userComments'

handlers = _.merge handlers,
  CLEAR_USER_COMMENTS: ->
    defaultState()

reducer = handleActions handlers, defaultState()

module.exports = reducer
