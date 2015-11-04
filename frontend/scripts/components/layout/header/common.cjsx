React = require 'react'
Header = require './header'
Logo = require './logo'
Navigation = require './navigation'
Auth = require './auth'
CreateRatingButton = require './create_rating_button'

CommonHeader = React.createClass
  displayName: 'CommonHeader'

  render: ->
    <Header {...@props}>
      <Logo/>
      <Navigation/>
      <Auth/>
      <CreateRatingButton/>
    </Header>

module.exports = CommonHeader
