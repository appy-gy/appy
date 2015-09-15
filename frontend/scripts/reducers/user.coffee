_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'

{update} = React.addons
{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver name: 'user'

handlers = _.merge handlers,
  CHANGE_USER: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

  CLEAR_USER: ->
    defaultState()

reducer = handleActions handlers, defaultState()

module.exports = reducer
