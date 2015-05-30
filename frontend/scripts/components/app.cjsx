React = require 'react/addons'
Router = require 'react-router'

{RouteHandler} = Router

App = React.createClass
  displayName: 'App'

  render: ->
    <RouteHandler {...@props}/>

module.exports = App
