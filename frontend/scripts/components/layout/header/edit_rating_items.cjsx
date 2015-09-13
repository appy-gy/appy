_ = require 'lodash'
React = require 'react/addons'
tinycolor = require 'tinycolor2'
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

    color = rating.section?.color || 'white'
    sectionColor = tinycolor(color).setAlpha(.5).toString()

    <div className="header_rating-items" style={backgroundColor: sectionColor}>
      <a href="#" className="header_rating-title">
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

module.exports = EditRatingItems
