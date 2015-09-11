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
  REQUEST_RATINGS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_RATINGS: (state, {payload: ratings}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: _.uniq(ratings.concat(state.items), 'id') }

  SET_RATINGS_PAGES_COUNT: (state, {payload: pagesCount}) ->
    update state, pagesCount: { $set: pagesCount }

  CLEAR_RATINGS: (state) ->
    defaultState()

, defaultState()

module.exports = reducer
