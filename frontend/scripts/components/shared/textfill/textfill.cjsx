_ = require 'lodash'
React = require 'react/addons'

{PropTypes} = React

Textfill = React.createClass
  displayName: 'Textfill'

  propTypes:
    children: PropTypes.element.isRequired
    minFontSize: PropTypes.number.isRequired
    maxFontSize: PropTypes.number.isRequired
    maxHeight: PropTypes.number
    onFontSizeChange: PropTypes.func

  getDefaultProps: ->
    maxHeight: null
    onFontSizeChange: ->

  componentDidMount: ->
    @updateFontSize()

  componentDidUpdate: ->
    @updateFontSize()

  findOptimalFontSize: (el, maxHeight, minFontSize, maxFontSize) ->
    return minFontSize if minFontSize == maxFontSize

    fontSize = Math.floor (minFontSize + maxFontSize) / 2
    el.style.fontSize = fontSize + 'px'

    if el.scrollHeight > maxHeight
      return minFontSize if fontSize == maxFontSize
      @findOptimalFontSize el, maxHeight, minFontSize, fontSize
    else
      return fontSize if fontSize == minFontSize
      @findOptimalFontSize el, maxHeight, fontSize, maxFontSize

  updateFontSize: ->
    {minFontSize, maxFontSize, maxHeight, onFontSizeChange} = @props

    el = @getDOMNode()
    maxHeight ||= el.clientHeight

    fontSize = @findOptimalFontSize el, maxHeight, minFontSize, maxFontSize
    return if fontSize == @prevFontSize
    @prevFontSize = fontSize
    onFontSizeChange fontSize
    el.style.fontSize = fontSize + 'px'

  render: ->
    {children} = @props

    children

module.exports = Textfill
