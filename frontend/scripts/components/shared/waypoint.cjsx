React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'

{PropTypes} = React

Waypoint = React.createClass
  displayName: 'Waypoint'

  mixins: [PureRendexMixin]

  propTypes:
    onChange: PropTypes.func
    children: PropTypes.element.isRequired

  getDefaultProps: ->
    onChange: ->

  componentDidMount: ->
    window.addEventListener 'scroll', @handleScroll
    @init()

  componentWillUnmount: ->
    window.removeEventListener 'scroll', @handleScroll

  init: ->
    @wasVisible = false
    @waypoint = ReactDOM.findDOMNode(@)

  handleScroll: ->
    {onChange} = @props

    elementTop = @waypoint.getBoundingClientRect().top
    elementBottom = @waypoint.getBoundingClientRect().bottom

    isVisible = @isVisible(elementTop, elementBottom)

    onChange() if @wasVisible != isVisible and isVisible

    @wasVisible = isVisible

  isVisible: (elementTop, elementBottom) ->
    middle = window.innerHeight / 2

    inCenter = elementTop <= middle && elementBottom >= middle

    inCenter

  render: ->
    {children} = @props

    children

module.exports = Waypoint
