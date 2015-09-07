React = require 'react/addons'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  wasVisible: false

  callsCount: 0

  timer: 0
  lastPosition: null
  newPosition: 0

  propTypes:
    onEnter: PropTypes.func
    onLeave: PropTypes.func

  getDefaultProps: ->
    onEnter: ->
    onLeave: ->

  componentDidMount: ->
    window.addEventListener 'scroll', @handleScroll, false

  componentWillUnmount: ->
    window.removeEventListener 'scroll', @handleScroll, false

  handleScroll: ->
    return if @scrollSpeed() > 600
    # return unless @callsLimit()
    @calculateVisibility()

  callsLimit: ->
    @callsCount += 1
    @callsCount % 2 == 0

  scrollSpeed: ->
    @newPosition = window.scrollY

    delta = Math.abs(@newPosition - @lastPosition) if @lastPosition

    @lastPosition = @newPosition

    @timer && clearTimeout(@timer)
    @timer = setTimeout( ->
      @lastPosition = null
    , 30)

    delta

  calculateVisibility: ->
    isVisible = @isVisible()
    return if @wasVisible == isVisible

    if isVisible
      @props.onEnter()
    else
      @props.onLeave()

    @wasVisible = isVisible

  isVisible: ->
    waypoint = React.findDOMNode @
    elementTop = waypoint.getBoundingClientRect().top
    elementBottom = waypoint.getBoundingClientRect().bottom

    topVisible = elementTop >= 0 && elementTop <= window.innerHeight
    bottomVisible = elementBottom >= 0 && elementBottom <= window.innerHeight
    biggerThanViewport = elementBottom >= window.innerHeight && elementTop <= window.innerHeight

    (topVisible || bottomVisible) || biggerThanViewport

  render: ->
    <span>{@props.children}</span>

module.exports = Waypoint
