Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
PopupConstants = require '../constants/popups'

class PopupActionCreators extends Marty.ActionCreators
  @id: 'PopupActionCreators'

  append: autoDispatch PopupConstants.APPEND_POPUPS
  remove: autoDispatch PopupConstants.REMOVE_POPUPS

module.exports = Marty.register PopupActionCreators
