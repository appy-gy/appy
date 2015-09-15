ReduxActions = require 'redux-actions'
http = require '../http'
constantize = require '../constantize'

{createAction} = ReduxActions

itemFetcher = ({name, url, responseKey}) ->
  responseKey ||= name

  request = createAction "REQUEST_#{constantize name}"
  receive = createAction "RECEIVE_#{constantize name}"

  fetch = (args...) ->
    (dispatch, getState) ->
      state = getState()
      item = state[name]

      return Promise.resolve(item.item) if item.isFetching or item.isFetched

      dispatch request()

      http.get(url(args..., state)).then ({data}) ->
        dispatch receive(data[responseKey])
        data[responseKey]

  { request, receive, fetch }

module.exports = itemFetcher
