Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class SectionsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_SECTIONS

module.exports = SectionsActions
