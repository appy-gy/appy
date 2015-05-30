Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class ToastsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_TOASTS
  remove: autoDispatch Constants.REMOVE_TOASTS

module.exports = ToastsActions
