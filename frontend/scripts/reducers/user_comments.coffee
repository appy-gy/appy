_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  items: []
  pagesCount: 0
  isFetching: false

reducer = handleActions
  REQUEST_USER_COMMENTS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_USER_COMMENTS: (state, {payload: comments}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: _.uniq(comments.concat(state.items), 'id') }

  SET_USER_COMMENTS_PAGES_COUNT: (state, {payload: pagesCount}) ->
    update state, pagesCount: { $set: pagesCount }

, defaultState()

module.exports = reducer
