_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  item: {}
  isFetching: false

reducer = handleActions
  REQUEST_SECTION: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_SECTION: (state, {payload: section}) ->
    section ||= {}

    update state,
      isFetching: { $set: false }
      item: { $set: section }

, defaultState()

module.exports = reducer
