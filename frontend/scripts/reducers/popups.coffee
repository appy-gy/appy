_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  []

reducer = handleActions
  APPEND_POPUP: (state, {payload: popup}) ->
    update state, $push: [popup]

  REMOVE_POPUP: (state, {payload: popup}) ->
    index = _.findIndex state, popup, 'cid'
    update state, $splice: [[index, 1]]

  REMOVE_POPUPS_WITH_TYPE: (state, {payload: type}) ->
    state.filter (popup) -> popup.type != type

, defaultState()

module.exports = reducer
