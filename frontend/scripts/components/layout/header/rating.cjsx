React = require 'react'
Header = require './header'
Logo = require './logo'
Auth = require './auth'
RatingItems = require './rating_items'

{PropTypes} = React

RatingHeader = React.createClass
  displayName: 'RatingHeader'

  render: ->
    <Header {...@props}>
      <Logo/>
      <RatingItems/>
    </Header>

module.exports = RatingHeader
