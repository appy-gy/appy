_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'

{handleActions} = ReduxActions

defaultState = ->
  []

reducer = handleActions
  APPEND_TOAST: (state, {payload: toast}) ->
    update state, $push: [toast]

  REMOVE_TOAST: (state, {payload: toast}) ->
    index = _.findIndex state, toast, 'cid'
    update state, $splice: [[index, 1]]

, defaultState()

module.exports = reducer
