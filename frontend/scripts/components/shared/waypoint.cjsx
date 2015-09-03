React = require 'react/addons'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  wasVisible: false

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

  handleScroll: (event) ->
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

    elementTop >= 0 && elementBottom <= window.innerHeight

  render: ->
    <span>{@props.children}</span>

module.exports = Waypoint