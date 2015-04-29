React = require 'react/addons'
Header = require './header'
Logo = require './logo'
Navigation = require './navigation'
Auth = require './auth'
CreateRating = require './create_rating'

CommonHeader = React.createClass
  displayName: 'CommonHeader'

  render: ->
    console.log 'render header'
    <Header>
      <Logo/>
      <Auth/>
      <CreateRating/>
      <Navigation/>
    </Header>

module.exports = CommonHeader
