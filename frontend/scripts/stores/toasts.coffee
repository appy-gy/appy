_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
ToastConstants = require '../constants/toasts'

{update} = React.addons

class ToastsStore extends Marty.Store
  @id: 'ToastsStore'

  constructor: ->
    super
    @state = []
    @handlers =
      append: ToastConstants.APPEND_TOASTS
      remove: ToastConstants.REMOVE_TOASTS

  getAll: ->
    @state

  append: (toasts) ->
    @state = update @state, $push: toArray(toasts)

  remove: (toasts) ->
    @state = _.without @state, toArray(toasts)...

module.exports = Marty.register ToastsStore
