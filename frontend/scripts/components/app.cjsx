_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'
Header = require './layout/header'

{RouteHandler} = Router

App = React.createClass
  render: ->
    <div className='layout'>
      <Header/>
      <div className='layout_body'>
        <RouteHandler/>
      </div>
    </div>

module.exports = App
