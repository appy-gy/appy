_ = require 'lodash'
update = require 'react-addons-update'
constantize = require '../constantize'

itemReceiver = ({name}) ->
  defaultState = (state = {}) ->
    _.merge state,
      item: {}
      isFetching: false
      isFetched: false

  handlers =
    "REQUEST_#{constantize name}": (state) ->
      update state, isFetching: { $set: true }

    "RECEIVE_#{constantize name}": (state, {payload: item}) ->
      item ||= {}

      update state,
        item: { $set: item }
        isFetching: { $set: false }
        isFetched: { $set: true }

  { defaultState, handlers }

module.exports = itemReceiver
