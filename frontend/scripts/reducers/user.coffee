_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  item: {}
  isFetching: false

reducer = handleActions
  REQUEST_USER: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_USER: (state, {payload: user}) ->
    user ||= {}

    update state,
      isFetching: { $set: false }
      item: { $set: user }

  CHANGE_USER: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

, defaultState()

module.exports = reducer
