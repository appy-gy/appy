_ = require 'lodash'
isClient = require '../helpers/is_client'
http = require '../helpers/http'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

reportError = (info) ->
  data = deepSnakecaseKeys { info: addCommonInfo(info) }
  http.post "client_errors", data

addCommonInfo = (info) ->
  canGetStore = _.includes ['interactive', 'complete'], document.readyState
  getStore = if canGetStore then require('../get_store') else null
  _.merge {}, info,
    userId: getStore()?.getState()?.currentUser?.item?.id
    url: location.toString()
    userAgent: navigator.userAgent

module.exports = ->
  return unless isClient()

  window.addEventListener 'error', (event) ->
    info = _.pick event, 'message', 'filename', 'lineno', 'colno'
    info.stack = event.error?.stack
    reportError info

  window.addEventListener 'unhandledrejection', ({detail}) ->
    info = message: detail.reason.message, stack: detail.reason.stack
    reportError info
