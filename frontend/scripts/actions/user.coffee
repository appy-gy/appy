ReduxActions = require 'redux-actions'
axios = require 'axios'
currentUserActions = require './current_user'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'
toFormData = require '../helpers/to_form_data'

{createAction} = ReduxActions
{changeCurrentUser} = currentUserActions

requestUser = createAction 'REQUEST_USER'
receiveUser = createAction 'RECEIVE_USER'

fetchUser = (id) ->
  (dispatch, getState) ->
    dispatch requestUser()

    axios.get("users/#{id}").then ({data}) ->
      dispatch receiveUser(data.user)

changeUser = (changes) ->
  (dispatch, getState) ->
    {currentUser, user} = getState()
    dispatch changeCurrentUser(changes) if currentUser.item.id == user.item.id
    dispatch type: 'CHANGE_USER', payload: changes

updateUser = (changes) ->
  (dispatch, getState) ->
    {user} = getState()
    data = toFormData user: deepSnakecaseKeys(changes)
    axios.put("users/#{user.item.id}", data).then ({data}) ->
      dispatch changeUser(data.user)

module.exports = { fetchUser, changeUser, updateUser }
