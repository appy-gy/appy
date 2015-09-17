update = require 'react-addons-update'
ReduxActions = require 'redux-actions'

{handleActions} = ReduxActions

defaultState = ->
  visible: false

reducer = handleActions
  SET_LOADER_VISIBILITY: (state, {payload: visible}) ->
    update state, visible: { $set: visible }

, defaultState()

module.exports = reducer
