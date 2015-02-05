_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'
Header = require './layout/header'

{RouteHandler} = Router

App = React.createClass
  render: ->
    <div className='layout'>
      <Header/>
      <div className='main site-main'>
        <div className='grid'>
          <RouteHandler/>
        </div>
      </div>
    </div>

module.exports = App
