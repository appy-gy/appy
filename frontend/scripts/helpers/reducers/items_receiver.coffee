_ = require 'lodash'
update = require 'react-addons-update'
constantize = require '../constantize'

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
