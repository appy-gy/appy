_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'

{update} = React.addons
{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver name: 'ratingItems'

defaultState = _.backflow defaultState, ->
  visibilities: []
  waypoints: []

handlers = _.merge handlers,
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

  CHANGE_RATING_ITEM_VISIBILITY: (state, {payload}) ->
    {id, visibility} = payload
    update state, visibilities: { "#{id}": { $set: visibility } }

  ADD_RATING_ITEM_WAYPOINT: (state, {payload: id}) ->
    update state, waypoints: { $push: [id] }

  REMOVE_RATING_ITEM_WAYPOINT: (state, {payload: id}) ->
    index = _.indexOf state.waypoints, id
    update state, waypoints: { $splice: [[index, 1]] }

reducer = handleActions handlers, defaultState()

module.exports = reducer
