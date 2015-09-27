_ = require 'lodash'
React = require 'react'
RatingItem = require './rating_item'

{PropTypes} = React

RatingItems = React.createClass
  displayName: 'RatingItems'

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems, rating} = @context

    sum = _.sum ratingItems, (ratingItem) -> Math.max ratingItem.mark, 0

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) =>
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} width={"#{@ratingItemWidth(sum, ratingItem.mark)}%"} sectionColor={rating.section.color}/>
      .value()

  ratingItemWidth: (sum, mark) ->
    return 0 if mark < 0
    (mark / sum) * 100

  render: ->
    {rating} = @context

    <div className="header_rating-items">
      <a href="#" className="header_rating-title" data-scroll>
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

module.exports = RatingItems
