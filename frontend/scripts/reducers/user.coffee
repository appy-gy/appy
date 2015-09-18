_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver 'user'

handlers = _.merge handlers, cleaner('user', defaultState),
  CHANGE_USER: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

reducer = handleActions handlers, defaultState()

module.exports = reducer
