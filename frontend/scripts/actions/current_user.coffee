ReduxActions = require 'redux-actions'
axios = require 'axios'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

requestCurrentUser = createAction 'REQUEST_CURRENT_USER'
receiveCurrentUser = createAction 'RECEIVE_CURRENT_USER'
changeCurrentUser = createAction 'CHANGE_CURRENT_USER'

fetchCurrentUser = ->
  (dispatch, getState) ->
    dispatch requestCurrentUser()

    axios.get('sessions').then ({data}) ->
      dispatch receiveCurrentUser(data.user)

logIn = ({email, password}) ->
  (dispatch, getState) ->
    dispatch requestCurrentUser()

    axios.post 'sessions', session: { email, password }
      .then ({data}) ->
        dispatch receiveCurrentUser(data.user)
        data
      .catch ({data}) -> data

logOut = ->
  (dispatch, getState) ->
    axios.delete('sessions').then ({data}) ->
      dispatch receiveCurrentUser(null)

register = ({email, password}) ->
  (dispatch, getState) ->
    axios.post 'users', user: { email, password }
      .then ({data}) ->
        dispatch receiveCurrentUser(data.user)
        data
      .catch ({data}) -> data

changePassword = (oldPassword, newPassword) ->
  (dispatch, getState) ->
    {currentUser} = getState()

    data = deepSnakecaseKeys { oldPassword, newPassword }
    axios.put "users/#{currentUser.item.id}/change_password", data

module.exports = { changeCurrentUser, fetchCurrentUser, logIn, logOut, register, changePassword }
