React = require 'react/addons'
Logo = require './logo'
Navigation = require './navigation'
Auth = require './auth'
CreateRating = require './create_rating'

{PureRenderMixin} = React.addons

Header = React.createClass
  displayName: 'Header'

  mixins: [PureRenderMixin]

  render: ->
    <header className="site-header">
      <Logo/>
      <Auth/>
      <CreateRating/>
      <Navigation/>
    </header>

module.exports = Header
