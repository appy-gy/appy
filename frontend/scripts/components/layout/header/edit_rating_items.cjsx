_ = require 'lodash'
React = require 'react'
RatingItem = require './edit_rating_item'

{PropTypes} = React

EditRatingItems = React.createClass
  displayName: 'EditRatingItems'

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems} = @context

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem, index) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1}/>
      .value()

  render: ->
    {rating} = @context

    <div className="header_rating-items">
      <a href="#" className="header_rating-title">
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

module.exports = EditRatingItems
