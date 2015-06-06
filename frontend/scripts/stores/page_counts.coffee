Marty = require 'marty'
React = require 'react/addons'
Constants = require '../constants'

{update} = React.addons

class PageCountsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      set: Constants.SET_PAGES_COUNT

  getInitialState: ->
    {}

  get: (key) ->
    @state[key]

  set: (key, count) ->
    @state = update @state, "#{key}": { $set: count }

module.exports = PageCountsStore
