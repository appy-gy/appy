ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestCurrentUser = createAction 'REQUEST_CURRENT_USER'
receiveCurrentUser = createAction 'RECEIVE_CURRENT_USER'

fetchCurrentUser = ->
  (dispatch, getState) ->
    dispatch requestCurrentUser()

    axios.get('sessions').then ({data, ok}) ->
      return unless ok
      dispatch receiveCurrentUser(data.user)

logIn = ({email, password}) ->
  (dispatch, getState) ->
    dispatch requestCurrentUser()

    axios.post('sessions', session: { email, password }).then ({data, ok}) ->
      return data.error unless ok
      dispatch receiveCurrentUser(data.user)

logOut = ->
  (dispatch, getState) ->
    axios.delete('sessions').then ({data, ok}) ->
      return unless ok
      dispatch receiveCurrentUser(null)

register = ->

module.exports = { fetchCurrentUser, logIn, logOut, register }
