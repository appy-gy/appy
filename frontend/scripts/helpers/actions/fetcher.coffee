_ = require 'lodash'
ReduxActions = require 'redux-actions'
http = require '../http'
constantize = require '../constantize'

{createAction} = ReduxActions

defaultOpts = (opts) ->
  responseKey = opts.responseKey || opts.name

  responseKey: responseKey
  shouldUseCache: -> false
  requestOpts: -> {}
  requestPayload: -> undefined
  receivePayload: ({data}) -> data[responseKey]
  failedPayload: ({error}) -> error

fetcher = (opts) ->
  {name, url, responseKey, getItems, shouldUseCache, requestOpts,
    requestPayload, receivePayload, failedPayload} = _.defaults opts, defaultOpts(opts)

  request = createAction "REQUEST_#{constantize name}"
  receive = createAction "RECEIVE_#{constantize name}"
  clear = createAction "CLEAR_#{constantize name}"
  failed = createAction "FAILED_#{constantize name}"

  fetch = (args...) ->
    (dispatch, getState) ->
      state = getState()
      items = getItems state
      info = { state, args }

      return Promise.resolve items if state[name].isFailed
      return Promise.resolve items if shouldUseCache info

      dispatch request(requestPayload(info))

      http.get(url(info), requestOpts(info))
        .then ({data}) ->
          dispatch receive(receivePayload(_.merge({ data }, info)))
          data[responseKey]
        .catch (error) ->
          dispatch failed(failedPayload(_.merge({ error }, info)))
          error

  { request, receive, clear, fetch, failed }

module.exports = fetcher
