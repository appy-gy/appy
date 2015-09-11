Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class LoaderVisibilityActions extends Marty.ActionCreators
  set: autoDispatch Constants.SET_LOADER_VISIBILITY

module.exports = LoaderVisibilityActions
