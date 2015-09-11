_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
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
