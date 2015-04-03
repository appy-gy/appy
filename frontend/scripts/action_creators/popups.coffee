Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
PopupConstants = require '../constants/popups'

class PopupActionCreators extends Marty.ActionCreators
  append: autoDispatch PopupConstants.APPEND_POPUPS
  remove: autoDispatch PopupConstants.REMOVE_POPUPS

module.exports = Marty.register PopupActionCreators
