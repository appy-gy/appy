_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  items: []
  isFetching: false
  visible: []

reducer = handleActions
  REQUEST_RATING_ITEMS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_RATING_ITEMS: (state, {payload: ratingItems}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: ratingItems }

  APPEND_RATING_ITEM: (state, {payload: ratingItem}) ->
    update state, items: { $push: [ratingItem] }

  CHANGE_RATING_ITEM: (state, {payload}) ->
    {id, changes} = payload
    index = _.findIndex state.items, (item) -> item.id == id
    update state, items: { "#{index}": { $merge: changes } }

  REMOVE_RATING_ITEM: (state, {payload: id}) ->
    index = _.findIndex state.items, (item) -> item.id == id
    update state, items: { $splice: [[index, 1]] }

  CHANGE_RATING_ITEM_POSITIONS: (state, {payload: positions}) ->
    changes = _.transform positions, (result, position, id) ->
      index = _.findIndex state.items, (item) -> item.id == id
      result[index] = $merge: { position }
    update state, items: changes

  MARK_RATING_ITEM_VISIBLE: (state, {payload: ratingItemId}) ->
    update state, visible: { $push: [ratingItemId] }

  UNMARK_RATING_ITEM_VISIBLE: (state, {payload: ratingItemId}) ->
    index = _.findIndex state.visible, ratingItemId
    update state, visible: { $splice: [[index, 1]] }

, defaultState()

module.exports = reducer
