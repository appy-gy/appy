OnEsc =
  componentWillMount: ->
    @escListeners = []

  componentWillUnmount: ->
    @escListeners.each (listener) -> listener.dispose()

  onEsc: (cb) ->
    return unless document?

    onKeydown = (event) ->
      return unless event.keyCode == 27
      cb event

    document.body.addEventListener 'keydown', onKeydown

    @escListeners.push dispose: ->
      document.body.removeEventListener 'keydown', onKeydown

module.exports = OnEsc
