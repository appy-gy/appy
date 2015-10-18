React = require 'react'
Header = require './header'
Logo = require './logo'
Validations = require './validations'
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
      <div className="header_rating-publish-info">
        <Validations/>
      </div>
      <RatingActions/>
    </Header>

module.exports = EditRatingHeader
