_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
findInStore = require '../helpers/find_in_store'

{update} = React.addons

class WaypointsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_WAYPOINT
      remove: Constants.REMOVE_WAYPOINT
      change: Constants.CHANGE_WAYPOINT

  getInitialState: ->
    []

  getAll: ->
    @state

  append: (waypoints) ->
    @state = update @state, $push: toArray(waypoints)

  remove: (waypoints) ->
    @state = _.without @state, toArray(waypoints)...

  change: (ratingItemId, changes) ->
    ratingItem = findInStore @, ratingItemId
    return unless ratingItem?
    _.merge ratingItem, changes
    @hasChanged()

module.exports = WaypointsStore
