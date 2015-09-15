_ = require 'lodash'
React = require 'react/addons'
constantize = require '../constantize'

{update} = React.addons

itemsReceiver = ({name}) ->
  defaultState = (state = {}) ->
    _.merge state,
      items: []
      isFetching: false
      isFetched: false

  handlers =
    "REQUEST_#{constantize name}": (state) ->
      update state, isFetching: { $set: true }

    "RECEIVE_#{constantize name}": (state, {payload: items}) ->
      items ||= []

      update state,
        items: { $set: items }
        isFetching: { $set: false }
        isFetched: { $set: true }

  { defaultState, handlers }

module.exports = itemsReceiver
