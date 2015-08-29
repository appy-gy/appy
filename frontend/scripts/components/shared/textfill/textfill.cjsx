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

  getDefaultProps: ->
    maxHeight: null

  componentDidMount: ->
    @updateFontSize()

  componentDidUpdate: ->
    @updateFontSize()

  findOptimalFontSize: (el, maxHeight, minFontSize, maxFontSize) ->
    return minFontSize if minFontSize >= maxFontSize - 1

    fontSize = Math.round (minFontSize + maxFontSize) / 2
    el.style.fontSize = fontSize + 'px'

    if el.scrollHeight > maxHeight
      @findOptimalFontSize el, maxHeight, minFontSize, fontSize
    else
      @findOptimalFontSize el, maxHeight, fontSize, maxFontSize

  updateFontSize: ->
    {minFontSize, maxFontSize, maxHeight} = @props

    el = @getDOMNode()
    maxHeight ||= el.clientHeight

    fontSize = @findOptimalFontSize el, maxHeight, minFontSize, maxFontSize
    el.style.fontSize = fontSize + 'px'

  render: ->
    {children} = @props

    children

module.exports = Textfill
