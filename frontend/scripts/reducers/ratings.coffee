ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver name: 'ratings'

reducer = handleActions handlers, defaultState()

module.exports = reducer
