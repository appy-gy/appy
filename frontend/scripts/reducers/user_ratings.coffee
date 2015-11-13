_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver 'userRatings'

handlers = _.merge handlers, cleaner('userRatings', defaultState),
  REMOVE_RATING: (state, {payload: id}) ->
    index = _.findIndex state.items, (rating) -> rating.id == id
    return state if index == -1
    update state, items: { $splice: [[index, 1]] }

reducer = handleActions handlers, defaultState()

module.exports = reducer
