_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  item: {}
  isFetching: false
  updateStatus: 'done'

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

  CHANGE_UPDATE_STATUS: (state, {payload: status}) ->
    update state, updateStatus: { $set: status }

  ADD_TAG_TO_RATING: (state, {payload: name}) ->
    update state, item: { tags: { $push: [{ name }] } }

  REMOVE_TAG_FROM_RATING: (state, {payload: name}) ->
    index = _.findIndex state.item.tags, (tag) -> tag.name == name
    update state, item: { tags: { $splice: [[index, 1]] } }

, defaultState()

module.exports = reducer
