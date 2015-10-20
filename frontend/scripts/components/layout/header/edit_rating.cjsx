React = require 'react'
Header = require './header'
Logo = require './logo'
RatingActions = require './rating_actions'
EditRatingItems = require './edit_rating_items'

{PropTypes} = React

EditRatingHeader = React.createClass
  displayName: 'EditRatingHeader'

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'header'

  render: ->
    <Header>
      <Logo/>
      <EditRatingItems/>
      <RatingActions/>
    </Header>

module.exports = EditRatingHeader
