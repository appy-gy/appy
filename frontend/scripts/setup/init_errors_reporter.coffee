_ = require 'lodash'
isClient = require '../helpers/is_client'
http = require '../helpers/http'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

reportError = (info) ->
  addCommonInfo(info).then (info) ->
    data = deepSnakecaseKeys { info }
    http.post "client_errors", data

addCommonInfo = (info) ->
  canGetStore = _.includes ['interactive', 'complete'], document.readyState
  info = _.merge {}, info, url: location.toString(), userAgent: navigator.userAgent

  return Promise.resolve info unless canGetStore

  getStore = require '../get_store'
  getStore().then (store) ->
    _.merge info, userId: getStore()?.getState()?.currentUser?.item?.id

module.exports = ->
  return unless isClient()

  window.addEventListener 'error', (event) ->
    info = _.pick event, 'message', 'filename', 'lineno', 'colno'
    info.stack = event.error?.stack
    reportError info

  window.addEventListener 'unhandledrejection', ({detail}) ->
    info = message: detail.reason.message, stack: detail.reason.stack
    reportError info
