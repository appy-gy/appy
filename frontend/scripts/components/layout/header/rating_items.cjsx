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

    marks = _.map ratingItems, 'mark'
    min = _.min marks
    max = _.max marks

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) =>
        width = (ratingItem.mark - min) / (max - min) * 100
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} width={width} sectionColor={rating.section.color}/>
      .value()

  render: ->
    {rating} = @context

    <div className="header_rating-items">
      <a href="#" className="header_rating-title" data-scroll>
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

module.exports = RatingItems
