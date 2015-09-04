React = require 'react/addons'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  wasVisible: false
  callsCount: 0

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

  handleScroll: () ->
    @callsCount += 1
    return unless @callsCount % 2 == 0
    @calculateVisibility()

  calculateVisibility: () ->
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

    (elementTop > 0 && elementTop < window.innerHeight) || (elementBottom > 0 && elementBottom < window.innerHeight)

  render: ->
    <span>{@props.children}</span>

module.exports = Waypoint
