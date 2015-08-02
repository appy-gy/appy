Marty = require 'marty'
Constants = require '../constants'

class RatingUpdateStatusStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_RATING_UPDATE_STATUS

  getInitialState: ->
    type: 'done'

  get: ->
    @fetch
      id: 'get'
      locally: -> @state

  set: (type) ->
    @state = { type }

module.exports = RatingUpdateStatusStore
