Marty = require 'marty'
PopupsConstants = require '../constants/popups'

PopupsActionCreators = Marty.createActionCreators
  append: PopupsConstants.APPEND_POPUPS (popups) ->
    @dispatch popups
  remove: PopupsConstants.REMOVE_POPUPS (popups) ->
    @dispatch popups

module.exports = PopupsActionCreators
