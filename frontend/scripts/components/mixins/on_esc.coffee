_ = require 'lodash'
isClient = require '../../helpers/is_client'

escListeners = []

onEsc = (event) ->
  return unless event.keyCode == 27
  maxPriority = _(escListeners).filter(({use}) -> use event).map('priority').max()
  escListeners
    .filter ({use, priority}) -> priority == maxPriority and use(event)
    .each ({cb}) -> cb event

document.body.addEventListener 'keydown', onEsc if isClient()

OnEsc =
  componentWillMount: ->
    @escListeners = []

  componentWillUnmount: ->
    @escListeners.each (listener) -> _.remove escListeners, listener

  onEsc: (listener) ->
    listener = cb: listener if _.isFunction listener
    listener = _.defaults {}, listener,
      use: -> true
      priority: 0

    @escListeners.push listener
    escListeners.push listener

module.exports = OnEsc
