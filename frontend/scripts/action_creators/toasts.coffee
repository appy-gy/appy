Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
ToastsConstants = require '../constants/toasts'

class ToastsActionCreators extends Marty.ActionCreators
  @id: 'ToastsActionCreators'

  append: autoDispatch ToastsConstants.APPEND_TOASTS
  remove: autoDispatch ToastsConstants.REMOVE_TOASTS

module.exports = Marty.register ToastsActionCreators
