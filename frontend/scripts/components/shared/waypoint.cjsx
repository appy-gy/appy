React = require 'react'
ReactDOM = require 'react-dom'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  propTypes:
    onEnter: PropTypes.func
    onLeave: PropTypes.func
    onVisibilityChange: PropTypes.func
    children: PropTypes.element.isRequired

  getDefaultProps: ->
    onEnter: ->
    onLeave: ->
    onVisibilityChange: ->

  componentDidMount: ->
    window.addEventListener 'scroll', @handleScroll
    @init()

  componentWillUnmount: ->
    window.removeEventListener 'scroll', @handleScroll

  init: ->
    @wasVisible = false
    @timer = 0
    @lastPosition = null
    @newPosition = 0
    @waypoint = ReactDOM.findDOMNode(@)

  handleScroll: ->
    {onEnter, onLeave, onVisibilityChange} = @props

    elementTop = @waypoint.getBoundingClientRect().top
    elementBottom = @waypoint.getBoundingClientRect().bottom

    isVisible = @isVisible(elementTop, elementBottom)
    visibility = @calculateVisibility(elementTop, elementBottom, isVisible)

    if @wasVisible != isVisible
      if isVisible then onEnter(visibility) else onLeave()

    onVisibilityChange visibility if visibility != @prevVisibility

    @wasVisible = isVisible
    @prevVisibility = visibility

  isVisible: (elementTop, elementBottom) ->
    topVisible = elementTop >= 0 && elementTop <= window.innerHeight
    bottomVisible = elementBottom >= 0 && elementBottom <= window.innerHeight
    biggerThanViewport = elementBottom >= window.innerHeight && elementTop <= window.innerHeight

    (topVisible || bottomVisible) || biggerThanViewport

  calculateVisibility: (elementTop, elementBottom, isVisible) ->
    [topBorder, bottomBorder] = @getFrameBorders(window.innerHeight)

    insideWindow = elementTop >= topBorder && elementBottom <= bottomBorder
    biggerThanWindow = elementBottom >= bottomBorder && elementTop <= topBorder

    return 'full' if insideWindow || biggerThanWindow
    return 'partially' if isVisible

  getFrameBorders: (number, percent = .6) ->
    frameSize = number * percent
    topBorder = (number - frameSize) / 2
    bottomBorder = topBorder + frameSize
    [topBorder, bottomBorder]

  render: ->
    {children} = @props

    children

module.exports = Waypoint
