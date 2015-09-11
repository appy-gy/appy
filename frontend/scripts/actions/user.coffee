ReduxActions = require 'redux-actions'
axios = require 'axios'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'
toFormData = require '../helpers/to_form_data'

{createAction} = ReduxActions

requestUser = createAction 'REQUEST_USER'
receiveUser = createAction 'RECEIVE_USER'
changeUser = createAction 'CHANGE_USER'

fetchUser = (id) ->
  (dispatch, getState) ->
    dispatch requestUser()

    axios.get("users/#{id}").then ({data}) ->
      dispatch receiveUser(data.user)

updateUser = (id, changes) ->
  (dispatch, getState) ->
    data = toFormData user: deepSnakecaseKeys(changes)
    axios.put("users/#{id}", data).then ({data}) ->
      dispatch changeUser(data.user)

module.exports = { changeUser, fetchUser, updateUser }
