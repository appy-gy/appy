React = require 'react/addons'

TestComp = React.createClass
  render: ->
    <div>{@props.a}</div>

module.exports = TestComp
