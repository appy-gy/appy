React = require 'react/addons'
Logo = require './header/logo'
Navigation = require './header/navigation'
# Auth = require './header/auth'
CreateRating = require './header/create_rating'

Header = React.createClass
  render: ->
    <header className="site-header">
      <Logo/>
      <CreateRating/>
      <Navigation/>
    </header>

module.exports = Header
