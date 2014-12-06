React = require 'react/addons'
Logo = require '../header/logo'
Navigation = require '../header/navigation'
Auth = require '../header/auth'

Header = React.createClass
  render: ->
    <div className="layout_header">
      <Logo/>
      <Navigation/>
      <Auth/>
    </div>

module.exports = Header
