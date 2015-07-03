_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'

{update} = React.addons

class WaypointsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_WAYPOINT
      remove: Constants.REMOVE_WAYPOINT

  getInitialState: ->
    []

  getAll: ->
    @state

  append: (waypoints) ->
    @state = update @state, $push: toArray(waypoints)

  remove: (waypoints) ->
    @state = _.without @state, toArray(waypoints)...

module.exports = WaypointsStore
