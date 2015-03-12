_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'
Header = require './layout/header/header'
Popups = require './layout/popups/popups'

{RouteHandler} = Router

App = React.createClass
  displayName: 'App'

  render: ->
    <div className='layout'>
      <Header/>
      <main className='main site-main'>
        <div className='grid'>
          <RouteHandler {...@props}/>
        </div>
      </main>
      <Popups/>
    </div>

module.exports = App
