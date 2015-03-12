React = require 'react/addons'
Logo = require './header/logo'
Navigation = require './header/navigation'
# Auth = require './header/auth'
CreateRating = require './header/create_rating'

{PureRenderMixin} = React.addons

Header = React.createClass
  displayName: 'Header'

  mixins: [PureRenderMixin]

  render: ->
    <header className="site-header">
      <Logo/>
      <CreateRating/>
      <Navigation/>
    </header>

module.exports = Header
