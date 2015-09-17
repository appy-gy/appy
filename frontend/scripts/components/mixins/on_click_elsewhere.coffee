ReactDOM = require 'react-dom'

OnClickElsewhere =
  componentWillMount: ->
    @elsewhereClickListeners = []

  componentWillUnmount: ->
    @elsewhereClickListeners.each (listener) -> listener.dispose()

  onClickElsewhere: (cb) ->
    return unless document?

    onBodyClick = (event) ->
      return if event.onComponent
      cb event

    onComponentClick = (event) ->
      event.onComponent = true

    document.body.addEventListener 'click', onBodyClick
    ReactDOM.findDOMNode(@).addEventListener 'click', onComponentClick

    @elsewhereClickListeners.push dispose: =>
      document.body.removeEventListener 'click', onBodyClick
      ReactDOM.findDOMNode(@).removeEventListener 'click', onComponentClick

module.exports = OnClickElsewhere
