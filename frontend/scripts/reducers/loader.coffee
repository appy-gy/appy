React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  visible: false

reducer = handleActions
  SET_LOADER_VISIBILITY: (state, {payload: visible}) ->
    update state, visible: { $set: visible }

, defaultState()

module.exports = reducer
