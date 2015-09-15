_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'

{update} = React.addons
{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver name: 'rating'

defaultState = _.backflow defaultState, ->
  updateStatus: 'done'

handlers = _.merge handlers,
  CHANGE_RATING: (state, {payload: changes}) ->
    update state, item: { $merge: changes }

  CHANGE_UPDATE_STATUS: (state, {payload: status}) ->
    update state, updateStatus: { $set: status }

  ADD_TAG_TO_RATING: (state, {payload: name}) ->
    update state, item: { tags: { $push: [{ name }] } }

  REMOVE_TAG_FROM_RATING: (state, {payload: name}) ->
    index = _.findIndex state.item.tags, (tag) -> tag.name == name
    update state, item: { tags: { $splice: [[index, 1]] } }

reducer = handleActions handlers, defaultState()

module.exports = reducer
