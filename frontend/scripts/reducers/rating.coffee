_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  item: {}
  isFetching: false

reducer = handleActions
  REQUEST_RATING: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_RATING: (state, {payload: rating}) ->
    rating ||= {}

    update state,
      isFetching: { $set: false }
      item: { $set: rating }

  CHANGE_RATING: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

, defaultState()

module.exports = reducer
