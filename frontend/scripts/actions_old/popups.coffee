Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class PopupsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_POPUPS
  remove: autoDispatch Constants.REMOVE_POPUPS

module.exports = PopupsActions
