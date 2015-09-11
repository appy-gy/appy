React = require 'react/addons'
ReduxActions = require 'redux-actions'

{update} = React.addons
{handleActions} = ReduxActions

defaultState = ->
  items: []
  isFetching: false

reducer = handleActions
  REQUEST_HEADER_SECTIONS: (state) ->
    update state, isFetching: { $set: true }

  RECEIVE_HEADER_SECTIONS: (state, {payload: sections}) ->
    update state,
      isFetching: { $set: false }
      items: { $set: sections }

, defaultState()

module.exports = reducer
