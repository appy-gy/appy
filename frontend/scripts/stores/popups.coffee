_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'

{update} = React.addons

class PopupsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_POPUPS
      remove: Constants.REMOVE_POPUPS

  getInitialState: ->
    []

  getAll: ->
    @state

  getOfType: (type) ->
    findInStore @, type, all: true, fields: ['type']

  append: (popups) ->
    @state = update @state, $push: toArray(popups)

  remove: (popups) ->
    @state = _.without @state, toArray(popups)...

module.exports = PopupsStore
