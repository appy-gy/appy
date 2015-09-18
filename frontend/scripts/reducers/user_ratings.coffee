_ = require 'lodash'
ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver 'userRatings'

handlers = _.merge handlers, cleaner('userRatings', defaultState)

reducer = handleActions handlers, defaultState()

module.exports = reducer
