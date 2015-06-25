Marty = require 'marty'
Constants = require '../constants'

class LoaderVisibilityStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_LOADER_VISIBILITY

  getInitialState: ->
    visible: false

  get: ->
    @fetch
      id: 'get'
      locally: -> @state.visible

  set: (visible) ->
    @state = { visible }

module.exports = LoaderVisibilityStore
