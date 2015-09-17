_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver name: 'user'

handlers = _.merge handlers,
  CHANGE_USER: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

  CLEAR_USER: ->
    defaultState()

reducer = handleActions handlers, defaultState()

module.exports = reducer
