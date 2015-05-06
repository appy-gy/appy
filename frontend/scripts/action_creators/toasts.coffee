Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
ToastsConstants = require '../constants/toasts'

class ToastActionCreators extends Marty.ActionCreators
  @id: 'ToastActionCreators'

  append: autoDispatch ToastsConstants.APPEND_TOASTS
  remove: autoDispatch ToastsConstants.REMOVE_TOASTS

module.exports = Marty.register ToastActionCreators
