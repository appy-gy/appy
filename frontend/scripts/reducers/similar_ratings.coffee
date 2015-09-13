_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  items: []
  isFetching: false

reducer = handleActions
  REQUEST_SIMILAR_RATINGS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_SIMILAR_RATINGS: (state, {payload: ratings}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: ratings }

, defaultState()

module.exports = reducer
