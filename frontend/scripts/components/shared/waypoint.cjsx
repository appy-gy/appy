React = require 'react/addons'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  wasVisible: false

  timer: 0
  lastPosition: null
  newPosition: 0

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

  componentWillUnmount: ->
    window.removeEventListener 'scroll', @handleScroll

  handleScroll: ->
    {onEnter, onLeave, onVisibilityChange} = @props

    isVisible = @isVisible()
    visibility = @calculateVisibility()

    if @wasVisible != isVisible
      if isVisible then onEnter() else onLeave()

    onVisibilityChange visibility if visibility != @prevVisibility

    @wasVisible = isVisible
    @prevVisibility = visibility

  calculateVisibility: ->
    waypoint = React.findDOMNode @
    windowTop = window.innerHeight * .2
    windowBottom = window.innerHeight * .8;
    elementTop = waypoint.getBoundingClientRect().top
    elementBottom = waypoint.getBoundingClientRect().bottom

    insideWindow = elementTop >= windowTop && elementBottom <= windowBottom
    biggerThanWindow = elementBottom >= windowBottom && elementTop <= windowTop

    if insideWindow || biggerThanWindow
      'inside'
    else
      'outside'

  isVisible: ->
    waypoint = React.findDOMNode @
    elementTop = waypoint.getBoundingClientRect().top
    elementBottom = waypoint.getBoundingClientRect().bottom

    topVisible = elementTop >= 0 && elementTop <= window.innerHeight
    bottomVisible = elementBottom >= 0 && elementBottom <= window.innerHeight
    biggerThanViewport = elementBottom >= window.innerHeight && elementTop <= window.innerHeight

    (topVisible || bottomVisible) || biggerThanViewport

  render: ->
    {children} = @props

    children

module.exports = Waypoint
