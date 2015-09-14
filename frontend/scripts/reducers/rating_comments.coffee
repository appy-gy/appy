_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  items: []
  isFetching: false

reducer = handleActions
  REQUEST_RATING_COMMENTS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_RATING_COMMENTS: (state, {payload: comments}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: comments }

  APPEND_RATING_COMMENT: (state, {payload: comment}) ->
    update state, items: { $push: [comment] }

, defaultState()

module.exports = reducer
