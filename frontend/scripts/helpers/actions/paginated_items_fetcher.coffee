_ = require 'lodash'
ReduxActions = require 'redux-actions'
http = require '../http'
constantize = require '../constantize'

{createAction} = ReduxActions

paginatedItemsFetcher = ({name, url, responseKey}) ->
  responseKey ||= name

  request = createAction "REQUEST_#{constantize name}"
  receive = createAction "RECEIVE_#{constantize name}"

  fetch = (page, args...) ->
    (dispatch, getState) ->
      state = getState()
      items = state[name]

      return Promise.resolve(items.items) if _(items.fetchingPages).concat(items.fetchedPages).includes(page)

      dispatch request(page)

      http.get(url(page, args..., state), params: { page }).then ({data}) ->
        data[responseKey].each (item) -> item.page = page
        dispatch receive({ "#{name}": data[responseKey], page, pagesCount: data.meta.pagesCount })
        data[responseKey]

  { request, receive, fetch }

module.exports = paginatedItemsFetcher
