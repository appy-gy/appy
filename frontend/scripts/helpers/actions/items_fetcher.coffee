ReduxActions = require 'redux-actions'
http = require '../http'
constantize = require '../constantize'

{createAction} = ReduxActions

itemsFetcher = ({name, url, responseKey}) ->
  responseKey ||= name

  request = createAction "REQUEST_#{constantize name}"
  receive = createAction "RECEIVE_#{constantize name}"

  fetch = (args...) ->
    (dispatch, getState) ->
      state = getState()
      items = state[name]

      return Promise.resolve(items.items) if items.isFetching or items.isFetched

      dispatch request()

      http.get(url(args..., state)).then ({data}) ->
        dispatch receive(data[responseKey])
        data[responseKey]

  { request, receive, fetch }

module.exports = itemsFetcher
