ReduxActions = require 'redux-actions'
itemFetcher = require '../helpers/actions/item_fetcher'
http = require '../helpers/http'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

changeCurrentUser = createAction 'CHANGE_CURRENT_USER'

{request: requestCurrentUser, receive: receiveCurrentUser, fetch: fetchCurrentUser} = itemFetcher
  name: 'currentUser'
  url: -> 'sessions'
  responseKey: 'user'

updateCurrentUser = (changes) ->
  (dispatch, getState) ->
    {currentUser} = getState()

    data = user: deepSnakecaseKeys(changes)
    http.put("users/#{currentUser.item.id}", data).then ({data}) ->
      dispatch changeCurrentUser(data.user)

logIn = ({email, password}) ->
  (dispatch, getState) ->
    dispatch requestCurrentUser()

    http.post 'sessions', session: { email, password }
      .then ({data}) ->
        dispatch receiveCurrentUser(data.user)
        data
      .catch ({data}) -> throw data.error

logOut = ->
  (dispatch, getState) ->
    http.delete('sessions').then ({data}) ->
      dispatch receiveCurrentUser(null)

register = ({email, password}) ->
  (dispatch, getState) ->
    http.post 'users', user: { email, password }
      .then ({data}) ->
        dispatch receiveCurrentUser(data.user)
        data
      .catch ({data}) -> throw data.error

changePassword = (oldPassword, newPassword) ->
  (dispatch, getState) ->
    {currentUser} = getState()

    data = deepSnakecaseKeys { oldPassword, newPassword }
    http.put "users/#{currentUser.item.id}/change_password", data

sendResetPassword = (email) ->
  (dispatch, getState) ->
    http.post 'reset_passwords', { email }

resetPassword = ({token, password}) ->
  (dispatch, getState) ->
    http.put 'reset_passwords', { token, password }
      .then ({data}) ->
        dispatch receiveCurrentUser(data.user)
        data

module.exports = { fetchCurrentUser, changeCurrentUser, updateCurrentUser,
  logIn, logOut, register, changePassword, sendResetPassword, resetPassword }
