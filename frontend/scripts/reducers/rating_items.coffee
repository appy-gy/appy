_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'ratingItems'

defaultState = _.flowRight defaultState, ->
  waypoint: null
  order: 'author'

handlers = _.merge handlers, cleaner('ratingItems', defaultState),
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

  CHANGE_RATING_ITEM_WAYPOINT: (state, {payload: id}) ->
    update state, waypoint: { $set: id }

  CHANGE_RATING_ITEMS_ORDER: (state, {payload: order}) ->
    update state, order: { $set: order }

reducer = handleActions handlers, defaultState()

module.exports = reducer
