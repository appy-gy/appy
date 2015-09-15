_ = require 'lodash'
ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver name: 'userRatings'

handlers = _.merge handlers,
  CLEAR_USER_RATINGS: ->
    defaultState()

reducer = handleActions handlers, defaultState()

module.exports = reducer
