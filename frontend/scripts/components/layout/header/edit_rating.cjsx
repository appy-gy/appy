React = require 'react/addons'
Header = require './header'
Logo = require './logo'
Auth = require './auth'
EditRatingItems = require './edit_rating_items'

{PropTypes} = React

EditRatingHeader = React.createClass
  displayName: 'EditRatingHeader'

  render: ->
    <Header>
      <Logo/>
      <Auth/>
      <EditRatingItems/>
    </Header>

module.exports = EditRatingHeader
