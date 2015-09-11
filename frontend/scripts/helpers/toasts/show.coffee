_ = require 'lodash'
buildToast = require './build'
toastActions = require '../../actions/toasts'

{appendToast} = toastActions

showToast = (dispatch, content, opts) ->
  opts = type: opts if _.isString opts
  toast = buildToast content, opts
  dispatch appendToast(toast)

module.exports = showToast
