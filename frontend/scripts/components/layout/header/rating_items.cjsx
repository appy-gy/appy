_ = require 'lodash'
React = require 'react/addons'
tinycolor = require 'tinycolor2'
RatingItem = require './rating_item'
Nothing = require '../../shared/nothing'

{PropTypes} = React

RatingItems = React.createClass
  displayName: 'RatingItems'

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems} = @context

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    {rating} = @context

    sectionColor = tinycolor(rating.section.color).setAlpha(.5).toString()

    <div className="header_rating-items" style={backgroundColor: sectionColor}>
      <a href="#" className="header_rating-title" data-scroll>
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

module.exports = RatingItems
