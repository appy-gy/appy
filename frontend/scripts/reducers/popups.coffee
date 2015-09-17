_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'

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
