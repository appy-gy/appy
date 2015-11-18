_ = require 'lodash'
update = require 'react-addons-update'
constantize = require '../constantize'

receiver = ({name, key, defaultValue}) ->
  defaultState = (state = {}) ->
    _.merge state,
      "#{key}": defaultValue
      isFetching: false
      isFetched: false
      isFailed: false

  handlers =
    "REQUEST_#{constantize name}": (state) ->
      update state, isFetching: { $set: true }

    "RECEIVE_#{constantize name}": (state, {payload: value}) ->
      value ||= defaultValue

      update state,
        "#{key}": { $set: value }
        isFetching: { $set: false }
        isFetched: { $set: true }

    "FAILED_#{constantize name}": (state) ->
      update state,
        isFailed: { $set: true }
        isFetching: { $set: false }

  { defaultState, handlers }

module.exports = receiver
