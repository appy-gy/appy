Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class WaypointsActions extends Marty.ActionCreators
  append: autoDispatch Constants.APPEND_WAYPOINT
  remove: autoDispatch Constants.REMOVE_WAYPOINT

module.exports = WaypointsActions
