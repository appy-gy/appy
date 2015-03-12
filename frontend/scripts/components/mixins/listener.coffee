Listener =
  componentWillMount: ->
    @listeners = []

  componentWillUnmount: ->
    @disposeListeners()

  addListener: (listener) ->
    @listeners.push listener

  disposeListeners: ->
    @listeners?.each (listener) -> listener.dispose()
    @listeners = []

module.exports = Listener
