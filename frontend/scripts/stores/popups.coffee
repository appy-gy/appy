_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
PopupsConstants = require '../constants/popups'

{update} = React.addons

class PopupsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      append: PopupsConstants.APPEND_POPUPS
      remove: PopupsConstants.REMOVE_POPUPS

  getAll: ->
    @state

  append: (popups) ->
    @state = update @state, $push: toArray(popups)

  remove: (popups) ->
    @state = _.without @state, toArray(popups)...

module.exports = Marty.register PopupsStore
