ScrollTo =
  scrollTo: ->
    return @getDOMNode().scrollIntoView() if document.readyState == 'complete'
    document.addEventListener 'readystatechange', =>
      return unless document.readyState == 'complete'
      @scrollTo()

module.exports = ScrollTo
