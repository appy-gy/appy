_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver 'currentUser'

handlers = _.merge handlers,
  CHANGE_CURRENT_USER: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

reducer = handleActions handlers, defaultState()

module.exports = reducer
