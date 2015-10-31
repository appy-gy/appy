_ = require 'lodash'
isClient = require '../../helpers/is_client'

escListeners = []

onEsc = (event) ->
  return unless event.keyCode == 27
  listeners = escListeners.filter ({use}) -> use event
  maxPriority = _.max(listeners, 'priority').priority
  listeners
    .filter ({priority}) -> priority == maxPriority
    .each ({cb}) -> cb event

document.body.addEventListener 'keydown', onEsc if isClient()

OnEsc =
  componentWillMount: ->
    @escListeners = []

  componentWillUnmount: ->
    @escListeners.each @cancelOnEsc

  onEsc: (listener) ->
    listener = cb: listener if _.isFunction listener
    listener = _.defaults {}, listener,
      use: -> true
      priority: 0

    @escListeners.push listener
    escListeners.push listener

    => @cancelOnEsc listener

  cancelOnEsc: (listener) ->
    _.remove escListeners, listener

module.exports = OnEsc
