React = require 'react/addons'
Header = require './header'
Logo = require './logo'
Auth = require './auth'
RatingItems = require './rating_items'

{PropTypes} = React

RatingHeader = React.createClass
  displayName: 'RatingHeader'

  render: ->
    <Header>
      <Logo/>
      <RatingItems/>
    </Header>

module.exports = RatingHeader
