Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
PopupsConstants = require '../constants/popups'

class PopupActionCreators extends Marty.ActionCreators
  append: autoDispatch PopupsConstants.APPEND_POPUPS
  remove: autoDispatch PopupsConstants.REMOVE_POPUPS

module.exports = Marty.register PopupActionCreators
