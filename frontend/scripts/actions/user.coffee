ReduxActions = require 'redux-actions'
itemFetcher = require '../helpers/actions/item_fetcher'
http = require '../helpers/http'
currentUserActions = require './current_user'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'
toFormData = require '../helpers/to_form_data'

{createAction} = ReduxActions
{changeCurrentUser} = currentUserActions

{fetch: fetchUser} = itemFetcher name: 'user', url: ({args}) -> "users/#{args[0]}"

changeUser = (changes) ->
  (dispatch, getState) ->
    {currentUser, user} = getState()
    dispatch changeCurrentUser(changes) if currentUser.item.id == user.item.id
    dispatch type: 'CHANGE_USER', payload: changes

updateUser = (changes) ->
  (dispatch, getState) ->
    {user} = getState()
    data = toFormData user: deepSnakecaseKeys(changes)
    http.put("users/#{user.item.id}", data).then ({data}) ->
      dispatch changeUser(data.user)

module.exports = { fetchUser, changeUser, updateUser }
