React = require 'react/addons'
{TestStorage} = require '../storages'

TestComp = React.createClass
  getInitialState: ->
    data = TestStorage.getData()
    { data }

  render: ->
    <div>
      <div>{@props.b}</div>
      <div>{@state.data.a.c}</div>
    </div>

module.exports = TestComp
