ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver name: 'userComments'

reducer = handleActions handlers, defaultState()

module.exports = reducer
