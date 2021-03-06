_ = require 'lodash'
React = require 'react'
SideEffect = require 'react-side-effect'

{PropTypes} = React

HtmlStyle = React.createClass
  displayName: 'HtmlStyle'

  propTypes:
    style: PropTypes.object.isRequired

  render: ->
    null

reducePropsToState = (props) ->
  _.transform props, (result, {style}) ->
    _.merge result, style
  , {}

handleStateChangeOnClient = (style) ->
  html = document.querySelector('html')
  html.style.cssText = ''
  _.merge html.style, style

module.exports = SideEffect(reducePropsToState, handleStateChangeOnClient)(HtmlStyle)
