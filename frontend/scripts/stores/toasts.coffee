_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'

{update} = React.addons

class ToastsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_TOASTS
      remove: Constants.REMOVE_TOASTS

  getInitialState: ->
    []

  getAll: ->
    @state

  append: (toasts) ->
    @state = update @state, $push: toArray(toasts)

  remove: (toasts) ->
    @state = _.without @state, toArray(toasts)...

module.exports = ToastsStore
