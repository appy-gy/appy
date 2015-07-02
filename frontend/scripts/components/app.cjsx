React = require 'react/addons'
Router = require 'react-router'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'

{RouteHandler} = Router
{DragDropContext} = ReactDnd

App = React.createClass
  displayName: 'App'

  render: ->
    <RouteHandler {...@props}/>

module.exports = DragDropContext(HTML5Backend)(App)
