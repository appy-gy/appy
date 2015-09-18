_ = require 'lodash'
ReduxActions = require 'redux-actions'
http = require '../http'
constantize = require '../constantize'

{createAction} = ReduxActions

defaultOpts = (opts) ->
  responseKey = opts.responseKey || opts.name

  responseKey: responseKey
  shouldUseCache: -> false
  shouldClearState: -> false
  requestOpts: -> {}
  requestPayload: -> undefined
  receivePayload: ({data}) -> data[responseKey]

fetcher = (opts) ->
  {name, url, responseKey, getItems, shouldUseCache, shouldClearState, requestOpts,
    requestPayload, receivePayload} = _.defaults opts, defaultOpts(opts)

  request = createAction "REQUEST_#{constantize name}"
  receive = createAction "RECEIVE_#{constantize name}"
  clear = createAction "CLEAR_#{constantize name}"

  fetch = (args...) ->
    (dispatch, getState) ->
      state = getState()
      items = getItems state
      info = { state, args }

      if shouldClearState info
        dispatch clear()
      else
        return Promise.resolve items if shouldUseCache info

      dispatch request(requestPayload(info))

      http.get(url(info), requestOpts(info)).then ({data}) ->
        dispatch receive(receivePayload(_.merge({ data }, info)))
        data[responseKey]

  { request, receive, clear, fetch }

module.exports = fetcher
