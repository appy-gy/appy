React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  item: {}
  isFetching: false

reducer = handleActions
  REQUEST_CURRENT_USER: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_CURRENT_USER: (state, {payload: user}) ->
    user ||= {}

    update state,
      isFetching: { $set: false }
      item: { $set: user }

, defaultState()

module.exports = reducer
