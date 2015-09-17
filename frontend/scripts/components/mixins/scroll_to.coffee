ReactDOM = require 'react-dom'

ScrollTo =
  scrollTo: ->
    return ReactDOM.findDOMNode(@).scrollIntoView() if document.readyState == 'complete'
    document.addEventListener 'readystatechange', =>
      return unless document.readyState == 'complete'
      @scrollTo()

module.exports = ScrollTo
