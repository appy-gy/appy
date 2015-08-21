_ = require 'lodash'
React = require 'react/addons'
RatingItem = require './edit_rating_item'

{PropTypes} = React

EditRatingItems = React.createClass
  displayName: 'EditRatingItems'

  contextTypes:
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    rating: PropTypes.object.isRequired

  ratingItems: ->
    {ratingItems} = @context

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    {rating} = @context
    sectionColor = _.get rating, 'section.color', '#fff'

    <div className="header_rating-items" style={backgroundColor: sectionColor}>
      <a href="#" className="header_rating-title">{rating.title}</a>
      {@ratingItems()}
    </div>

module.exports = EditRatingItems
