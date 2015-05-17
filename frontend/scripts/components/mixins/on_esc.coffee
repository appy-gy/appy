OnEsc =
  componentWillMount: ->
    @escListeners = []

  componentWillUnmount: ->
    @escListeners.each (listener) -> listener.dispose()

  onEsc: (cb) ->
    return unless document?

    document.body.addEventListener 'keydown', (event) ->
      return unless event.keyCode == 27
      cb event

    @escListeners.push dispose: ->
      document.body.removeEventListener 'keydown', cb

module.exports = OnEsc
