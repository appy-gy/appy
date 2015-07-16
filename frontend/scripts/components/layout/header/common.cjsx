React = require 'react/addons'
Header = require './header'
Logo = require './logo'
Navigation = require './navigation'
Auth = require './auth'
CreateRatingButton = require './create_rating_button'

CommonHeader = React.createClass
  displayName: 'CommonHeader'

  render: ->
    <Header>
      <Navigation/>
      <Auth/>
      <CreateRatingButton/>
      <Logo/>
    </Header>

module.exports = CommonHeader
